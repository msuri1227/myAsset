//
//  ChangePasswordVC.swift
//  SettingsScreenDemo
//
//  Created by Ondevice Solutions on 27/01/20.
//  Copyright © 2020 Rover Software. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class ChangePasswordVC: UIViewController {
  
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var oldPasswordTF: UITextField!
    
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var oldPasswordBtn: UIButton!
    @IBOutlet weak var newPasswordBtn: UIButton!
    @IBOutlet weak var confirmPasswordBtn: UIButton!
    var property = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        self.saveBtn.layer.cornerRadius = 8
        self.saveBtn.layer.masksToBounds = true
        ODSUIHelper.setTextfiledLayout(textfield: self.oldPasswordTF,borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setTextfiledLayout(textfield: self.newPasswordTF,borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setTextfiledLayout(textfield: self.confirmPasswordTF,borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
           myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
  
    @IBAction func saveBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if self.oldPasswordTF.text == "" {
            mJCLogger.log("Please_Enter_Old_Password".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Enter_Old_Password".localized(), button: okay)
        }
        else if self.newPasswordTF.text == "" {
            mJCLogger.log("Please_Enter_New_Password".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Enter_New_Password".localized(), button: okay)
        }
        else if self.confirmPasswordTF.text == "" {
            mJCLogger.log("Please_Confirm_New_Password".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Confirm_New_Password".localized(), button: okay)
        }
        else if self.newPasswordTF.text != ""{
            
            if self.newPasswordTF.text == self.confirmPasswordTF.text {
                self.UpdatePassword(oldPass: self.oldPasswordTF.text!, NewPass: self.newPasswordTF.text!)
            }else{
                mJCLogger.log("Please_Confirm_New_Password".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Confirm_New_Password".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    func UpdatePassword(oldPass:String,NewPass:String){
        mJCLogger.log("Starting", Type: "info")

        let httpConvMan2 = HttpConversationManager.init()
        let commonfig2 = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig2.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
        }else if authType == "SAML"{
            commonfig2.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
            commonfig2.configureManager(httpConvMan2)
        
        let respDict = ChangePasswordModel.getEntitySetDetails(httpcon: httpConvMan2!)

        
        if let status = respDict["Status"] as? String{
            if status == "Success"{
                
                if let entityset = respDict["Response"] as? SODataV4_EntitySet{
                   
                    var entityval :  SODataV4_EntityValue?
                   
                    let entitype = entityset.entityType
                        entityval =  SODataV4_EntityValue.ofType(entitype)
                    var propety = SODataV4_Property.new()
                    propety = entitype.getProperty("UserName")
                    propety.setString(entityval!, "\(strUser)")
                    propety = entitype.getProperty("OldPassword")
                    propety.setString(entityval!, oldPass)
                    propety = entitype.getProperty("NewPassword")
                    propety.setString(entityval!, NewPass)
                    
                    let Dict = ChangePasswordModel.updatePasswordEntity(httpcon: httpConvMan2!, entityValue: entityval!)
                    
                    if let status = Dict["Status"] as? String{
                        if status == "Success"{
                            mJCLoader.stopAnimating()
                            mJCLogger.log("Password_Updated".localized(), Type: "Debug")
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Password_Updated".localized(), button: okay)
                           
                            if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
                                     
                                let serverDetails = UserDefaults.standard.value(forKey:"login_Details") as! NSDictionary
                                
                                    let serverIP = (serverDetails.value(forKey :"serverIP") as? String)!
                                    let portNumber = (serverDetails.value(forKey :"portNumber")  as? Int) ?? 443
                                    let ApplicationID = (serverDetails.value(forKey :"ApplicationId") as? String)!
                                    let userName = (serverDetails.value(forKey :"userName") as? String)!
                                    let userPassWord = (serverDetails.value(forKey :"password") as? String)!
                                    let ApplicationConnectionId = (serverDetails.value(forKey :"ApplicationConnectionId") as? String)!
                                        
                                    UserDefaults.standard.removeObject(forKey: "login_Details")
                                           
                                    let dict = NSMutableDictionary()
                                        dict.setValue(serverIP, forKey: "serverIP")
                                        dict.setValue(portNumber, forKey: "portNumber")
                                        dict.setObject(ApplicationID, forKey: "ApplicationId" as NSCopying)
                                        dict.setValue(userName, forKey: "userName")
                                        dict.setValue(NewPass, forKey: "password")
                                        dict.setValue(ApplicationConnectionId, forKey: "ApplicationConnectionId")
                                    UserDefaults.standard.setValue(dict, forKey: "login_Details")
                                    strUser = userName.uppercased()

                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }else{
                            mJCLoader.stopAnimating()
                            mJCLogger.log(somethingwrongalert, Type: "Error")
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
                        }
                    }else{
                        mJCLoader.stopAnimating()
                        mJCLogger.log(somethingwrongalert, Type: "Error")
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
                    }
                    
                }else{
                    mJCLogger.log(somethingwrongalert, Type: "Error")
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
                }
              
            }else if status == "-1"{
                mJCLogger.log(somethingwrongalert, Type: "Error")
                mJCLoader.stopAnimating()
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
            }
        }else{
            mJCLogger.log(somethingwrongalert, Type: "Error")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }

    
    @IBAction func canCelBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func passwordHideShowActions(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        (sender as! UIButton).isSelected =  !(sender as! UIButton).isSelected
        if (sender as! UIButton).tag == 1 {
            self.oldPasswordTF.isSecureTextEntry =  !self.oldPasswordTF.isSecureTextEntry
        }else if (sender as AnyObject).tag == 2 {
            self.newPasswordTF.isSecureTextEntry =  !self.newPasswordTF.isSecureTextEntry
        }else if (sender as AnyObject).tag == 3 {
            self.confirmPasswordTF.isSecureTextEntry =  !self.confirmPasswordTF.isSecureTextEntry
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func changeButtonImage(btn : UIButton, textField : UITextField) {
        mJCLogger.log("Starting", Type: "info")
        if (btn.currentImage!.isEqual(UIImage.init(named: "hidePswd"))) {
            
            btn.setImage(UIImage.init(named: "showPswd"), for: .normal)
            textField.isSecureTextEntry = false
            
        }
        else if (btn.currentImage?.isEqual(UIImage.init(named: "showPswd")))! {
            
            btn.setImage(UIImage.init(named: "hidePswd"), for: .normal)
            textField.isSecureTextEntry = true

        }
        mJCLogger.log("Ended", Type: "info")
    }
    
}



