
//
//  LoginVc.swift
//  myJobCard
//  Created by Ondevice Solutions on 12/19/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import LocalAuthentication
import ODSFoundation
import FormsEngine
import mJCLib

class LoginVC: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate,XMLParserDelegate,UsernamePasswordProviderProtocol,ODSStoreDelegate, ODSStoreStatusDelegate,globalDataFetchCompleteDelegate,barcodeDelegate{

    //MARK:- Outlet..
    @IBOutlet weak var fingerPrintView: UIView!
    @IBOutlet weak var enterPin: UIButton!
    @IBOutlet weak var enterTouch: UIButton!
    @IBOutlet weak var loginViewWithFields: UIView!
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var logoLabelView: UIView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userNameUnderLineView: UIView!
    @IBOutlet var userNameUnderLineViewHieghtConst: NSLayoutConstraint!
    @IBOutlet var passWordTextField: UITextField!
    @IBOutlet var passWordUnderLineView: UIView!
    @IBOutlet var passWordUnderLineViewHeightConst: NSLayoutConstraint!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var applicationIdTextFiled: UITextField!
    @IBOutlet var applicationtextfileldlineview: UIView!
    @IBOutlet var applicationtexfiledlineheightConst: NSLayoutConstraint!
    @IBOutlet var resetPasswordButton: UIButton!
    @IBOutlet var resetDemoButton: UIButton!
    @IBOutlet var exitDemoButton: UIButton!
    @IBOutlet var resetUserDataButton: UIButton!
    @IBOutlet var shareLogsButton: UIButton!
    @IBOutlet weak var ServerDetailsButton: UIButton!
    @IBOutlet var portTextFieldLineView: UIView!
    @IBOutlet var serverIPTextFieldLineView: UIView!
    @IBOutlet var serverIPTextFieldLineHieghtConst: NSLayoutConstraint!
    @IBOutlet var portTextFieldLineHieghtConst: NSLayoutConstraint!
    @IBOutlet var blankView: UIView!
    @IBOutlet var alertView: UIView!
    @IBOutlet var demoButton: UIButton!
    @IBOutlet var cloudButton: UIButton!
    @IBOutlet var onPremiseButton: UIButton!
    @IBOutlet var serverDetailsScanButton: UIButton!
    @IBOutlet var alertDoneButton: UIButton!
    @IBOutlet var portTextfield: UITextField!
    @IBOutlet var serverIpTextField: UITextField!
    @IBOutlet var userNamePwdView: UIStackView!
    @IBOutlet var pswdShowHideButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var samlButton: UIButton!
    @IBOutlet weak var projectLogoHeightConst: NSLayoutConstraint!

    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var loginDisplayAlert = String()
    var pushsubscribe = String()
    var authenticationType = String()
    var storeCount = 0
    var newUser = Bool()
    var fromLogOut = false

    //MARK:- Life Cycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        portTextfield.delegate = self
        serverIpTextField.delegate = self
        if SHOW_DEMO_MODE == true{
            self.demoButton.isHidden = false
        }else{
            self.demoButton.isHidden = true
        }
        myAssetDataManager.autoConfigSettings()
        if isHttps{
            self.cloudButton.isSelected = true
        }else{
            self.cloudButton.isSelected = false
        }
        if authType == "SAML"{
            self.samlButton.isSelected=true
        }
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            let serverDetails = UserDefaults.standard.value(forKey:"login_Details") as! NSDictionary
            var https = "https"
            serverIP = (serverDetails.value(forKey :"serverIP") as? String)!
            portNumber = (serverDetails.value(forKey :"portNumber") as? Int) ?? 443
            ApplicationID = (serverDetails.value(forKey :"ApplicationId") as? String)!
            let username = serverDetails.value(forKey :"userName") as? String ?? ""
            let ConnectionId = serverDetails.value(forKey :"ApplicationConnectionId") as? String ?? ""
            authType = serverDetails.value(forKey :"authType") as? String ?? "Basic"
            if isHttps == false{
                https = "http"
            }
            serverURL = "\(https)://\(serverIP):\(portNumber)"
            self.setBasicDetails()
            if username == "" && ConnectionId == "" && authType == "SAML"{
                mJCLoader.startAnimating(status: self.loginDisplayAlert)
                self.userNamePwdView.isHidden = true
                let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
                if result == "ServerUp"{
                    mJCLoader.startAnimating(status: self.loginDisplayAlert)
                    loginAttempts = 0
                    self.loginDisplayAlert = loginAlert
                    self.registerUsertoSmpWithDetails()
                }else if result == "ServerDown"{
                    mJCLoader.stopAnimating()
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: ServerDownAlert, button: okay)
                }else{
                    mJCLoader.stopAnimating()
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: noInternetAlert, button: okay)
                }
            }else if username != "" && ConnectionId != "" && authType == "SAML"{
                self.userNamePwdView.isHidden = true
            }
            
            userNameTextField.text = serverDetails.value(forKey :"userName") as? String ?? ""
            passWordTextField.text = ""
            
            let demoMode = serverDetails.value(forKey :"DemoMode") as? Bool ?? false
            demoModeEnabled = demoMode
            blankView.isHidden = true
            alertView.isHidden = true
            if demoModeEnabled == true{
                self.resetDemoButton.isHidden = false
                self.exitDemoButton.isHidden = false
                self.resetUserDataButton.isHidden = true
                self.ServerDetailsButton.isHidden = true
                self.resetPasswordButton.isHidden = true
            }else{
                self.resetDemoButton.isHidden = true
                self.exitDemoButton.isHidden = true
                self.resetUserDataButton.isHidden = false
                self.ServerDetailsButton.isHidden = false
                self.resetPasswordButton.isHidden = false
                if  UserDefaults.standard.value(forKey: "touchIDEnable") != nil{
                    authenticationType = LAContext().biometricType.rawValue
                    let id = UserDefaults.standard.value(forKey: "touchIDEnable") as! Bool
                    if id == true{
                        self.fingerPrintView.isHidden = false
                        self.enterTouch.isHidden = false
                        self.enterPin.isHidden = false
                        ODSUIHelper.setBorderToView(view: self.enterPin)
                        ODSUIHelper.setBorderToView(view: self.enterTouch)
                        if authenticationType == "touchID"{
                            self.enterTouch.setTitle("Touch_ID".localized(), for: .normal)
                            authenticationMethod()
                        }else if authenticationType == "faceID"{
                            self.enterTouch.setTitle("Face_ID".localized(), for: .normal)
                            beginFaceID()
                        }else if authenticationType == "none"{
                            fingerPrintView.isHidden = true
                            if authType == "SAML"{
                                mJCLoader.startAnimating(status: loginSuccessAlert)
                                self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                            }
                        }
                    }else{
                        fingerPrintView.isHidden = true
                        if authType == "SAML"{
                            mJCLoader.startAnimating(status: loginSuccessAlert)
                            self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                        }
                    }
                }else{
                    fingerPrintView.isHidden = true
                    if authType == "SAML" && fromLogOut == false{
                        mJCLoader.startAnimating(status: loginSuccessAlert)
                        self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                    }
                }
            }
            loginDisplayAlert = loginSuccessAlert
        }else {
            loginDisplayAlert = loginAlert
            if autoConfig == true {
                if serverPopupRequired == true{
                    blankView.isHidden = false
                    alertView.isHidden = false
                    self.serverIpTextField.text = serverIP
                    self.portTextfield.text = "\(portNumber)"
                    if ("\(portNumber)".count == 3){
                        portTextfield.text = "0\(portNumber)"
                    }
                    self.applicationIdTextFiled.text = ApplicationID
                }else{
                    blankView.isHidden = true
                    alertView.isHidden = true
                    let dict = NSMutableDictionary()
                    var https = "https"
                    if isHttps == false{
                        https = "http"
                    }
                    serverURL = "\(https)://\(serverIP):\(portNumber)"
                    dict.setValue(serverIP, forKey: "serverIP")
                    dict.setValue(portNumber, forKey: "portNumber")
                    dict.setObject(ApplicationID, forKey: "ApplicationId" as NSCopying)
                    dict.setValue("", forKey: "userName")
                    dict.setValue("", forKey: "password")
                    dict.setValue("", forKey: "ApplicationConnectionId")
                    dict.setValue(false, forKey: "DemoMode")
                    UserDefaults.standard.setValue(dict, forKey: "login_Details")
                    if authType == "SAML"{
                        self.userNamePwdView.isHidden = true
                        self.registerUsertoSmpWithDetails()
                    }else{
                        self.userNamePwdView.isHidden = false
                        self.serverIpTextField.text = serverIP
                        self.portTextfield.text = "\(portNumber)"
                        if ("\(portNumber)".count == 3){
                            portTextfield.text = "0\(portNumber)"
                        }
                        self.applicationIdTextFiled.text = ApplicationID
                    }
                }
            }else{
                blankView.isHidden = false
                alertView.isHidden = false
                self.serverIpTextField.text = ""
                self.portTextfield.text = ""
                self.applicationIdTextFiled.text = ""
                self.resetDemoButton.isHidden = true
                self.exitDemoButton.isHidden = true
                self.resetUserDataButton.isHidden = false
            }
            alertView.layer.cornerRadius = 2.0
        }
        //Add TapGesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.handleTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
//        self.passWordTextField.text = "Ondevice@123"
    }
    func setBasicDetails(){
        var dict = Dictionary<String,Any>()
        dict["serverIPAddress"] = serverIP
        dict["serverPort"] = portNumber
        dict["serverURL"] = serverURL
        dict["applicationID"] = ApplicationID
        dict["loginDelegate"] = self
        dict["storeDelegate"] = self
        dict["ODSstoreDelegate"] = self
        dict["storeStatusDelegate"] = self
        dict["flushDelegate"] = myAssetDataManager.uniqueInstance
        dict["refreshDelegate"] = myAssetDataManager.uniqueInstance
        dict["Https"] = isHttps
        dict["DemoMode"] = demoModeEnabled
        AppDetailsClass.setAppBasicDetails(details: dict)
        var dict1 = Dictionary<String,Any>()
        dict1["Debug"] = false
        dict1["Error"] = false
        dict1["Warn"] = false
        dict1["Info"] = false
        dict1["printLog"] = false
        AppDetailsClass.setFwLogLevel(levelDict: dict1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidDisappear(_ animated: Bool) {
        ODSStoreHelper.ODSStoreFlushDelegate = myAssetDataManager.uniqueInstance
        ODSStoreHelper.ODSStoreRefreshDelegate = myAssetDataManager.uniqueInstance
        EventBased_Sync = ""
        if EventBased_Sync == "X"{
            mJCStoreHelper.configEventBasedSync(enable: true, syncType: EventBased_Sync_Type)
        }
        TimeBased_Sync = ""
        if TimeBased_Sync == "X"{
            //BG_SYNC_TIME_INTERVAL
            mJCStoreHelper.configTimeBasedBackGroundSync(syncType: TimeBased_Sync_Type, timeInterval: "180", retryCount: BG_SYNC_RETRY_COUNT, retryInterval: BG_SYNC_RETRY_INTERVAL )
        }
        if MasterData_BG_Refresh_Enable == true{
            mJCStoreHelper.configMasterDataBackGroundSync(refreshUnitHour: MasterData_BG_Refresh_Unit_In_Hours, timeInterval: MasterData_BG_Refresh_Interval_Value, retryCount: MasterData_BG_Refresh_Retry_Attempts, retryInterval: MasterData_BG_Refresh_Retry_Interval_In_Min)
        }
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: nil)
    }
    @objc func reachabilityChanged(note: Notification) {
        if let rech = note.object as? Reachability{
            if rech.reachabilityFlags().rawValue == 0{
                mJCLogger.log("Network connected - \(Date().localDate())", Type: "Debug")
                if TimeBased_Sync == "X"{
                    mJCStoreHelper.configTimeBasedBackGroundSync(syncType: TimeBased_Sync_Type, timeInterval: BG_SYNC_TIME_INTERVAL , retryCount: BG_SYNC_RETRY_COUNT, retryInterval: BG_SYNC_RETRY_INTERVAL )
                }
                if MasterData_BG_Refresh_Enable == true{
                    mJCStoreHelper.configMasterDataBackGroundSync(refreshUnitHour: MasterData_BG_Refresh_Unit_In_Hours, timeInterval: MasterData_BG_Refresh_Interval_Value, retryCount: MasterData_BG_Refresh_Retry_Attempts, retryInterval: MasterData_BG_Refresh_Retry_Interval_In_Min)
                }
            }else if rech.reachabilityFlags().rawValue == 2{
                mJCLogger.log("Network diconected - \(Date().localDate())", Type: "Debug")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- Demo Mode Password
    
    func getDemoModePassword() -> String{
        
        var passStr = String()
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let yearsub1 = swapCharacters(input: String("\(year)".prefix(2)), index1: 0, index2: 1)
        let yearsub2 = swapCharacters(input: String("\(year)".suffix(2)), index1: 0, index2: 1)
        var monthSubStr = String()
        monthSubStr = "\(month)"
        if month <= 9{
            monthSubStr = "0" + "\(month)"
            monthSubStr = swapCharacters(input: String(monthSubStr), index1: 0, index2: 1)
        }else{
            monthSubStr = swapCharacters(input: String(month), index1: 0, index2: 1)
        }
        passStr = "mjc_\(yearsub2)\(monthSubStr)\(yearsub1)"
        return passStr
    }
    func swapCharacters(input: String, index1: Int, index2: Int) -> String {
        var characters = Array(input)
        characters.swapAt(index1, index2)
        return String(characters)
    }
    //MARK:- Button Action..
    @IBAction func loginbuttonAction(sender: AnyObject){

        print("Loging Button Tapped --\(Date().localDate())")
        if demoModeEnabled == true{
            if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
                if (self.userNameTextField.text == "") {
                    mJCAlertHelper.showAlert(self, title: WarningAlert, message: loginUsernameBlankAlert, button: okay)
                }else if self.userNameTextField.text!.caseInsensitiveCompare("DEMOS1") != ComparisonResult.orderedSame{
                    mJCAlertHelper.showAlert(self, title: WarningAlert, message: "Please_Use_Valid_Demo_User_Name".localized(), button: okay)
                }else if(self.passWordTextField.text == "") {
                    mJCAlertHelper.showAlert(self, title: WarningAlert, message: loginPasswordBlankAlert, button: okay)
                }else if(self.getDemoModePassword() == passWordTextField.text){
                    mJCLoader.startAnimating(status: loginSuccessAlert)
                    self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                    if let serverDetails = UserDefaults.standard.value(forKey:"login_Details") as? NSDictionary{
                        let serverIP = serverDetails.value(forKey :"serverIP") as? String ?? ""
                        let portNumber = serverDetails.value(forKey :"portNumber") as? Int ?? 443
                        let ApplicationID = serverDetails.value(forKey :"ApplicationId") as? String ?? ""
                        UserDefaults.standard.removeObject(forKey: "login_Details")
                        let dict = NSMutableDictionary()
                        dict.setValue(serverIP, forKey: "serverIP")
                        dict.setValue(portNumber, forKey: "portNumber")
                        dict.setObject(ApplicationID, forKey: "ApplicationId" as NSCopying)
                        dict.setValue(self.userNameTextField.text, forKey: "userName")
                        dict.setValue(self.passWordTextField.text!, forKey: "password")
                        dict.setValue("", forKey: "ApplicationConnectionId")
                        dict.setValue(true, forKey: "DemoMode")
                        UserDefaults.standard.setValue(dict, forKey: "login_Details")
                    }
                }else{
                    mJCAlertHelper.showAlert(self, title: errorTitle, message: loginPasswordNotMatchAlert, button: okay)
                }
            }
        }else{
            if let userDetails = UserDefaults.standard.value(forKey:"login_Details") as? NSDictionary{
                let username = userDetails.value(forKey :"userName") as? String ?? ""
                let password = userDetails.value(forKey :"password") as? String ?? ""
                let ConnectionId = userDetails.value(forKey :"ApplicationConnectionId") as? String ?? ""
                if username == "" && password == "" && ConnectionId == ""{
                    if (self.userNameTextField.text == "") && authType == "Basic"{
                        mJCAlertHelper.showAlert(self, title: WarningAlert, message: loginUsernameBlankAlert, button: "OK")
                    }else if (userNameTextField.text?.count)! < 5 && authType == "Basic"{
                        mJCAlertHelper.showAlert(self, title: WarningAlert, message: loginUsernameShortAlert, button: okay)
                    }else if(self.passWordTextField.text == "") && authType == "Basic"{
                        mJCAlertHelper.showAlert(self, title: WarningAlert, message: loginPasswordBlankAlert, button: okay)
                    }else if (passWordTextField.text?.count)! < 5 && authType == "Basic"{
                        mJCAlertHelper.showAlert(self, title: WarningAlert, message: loginPasswordShortAlert, button: okay)
                    }else {
                        mJCLoader.startAnimating(status: self.loginDisplayAlert)
                        let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
                        if result == "ServerUp"{
                            mJCLoader.startAnimating(status: self.loginDisplayAlert)
                            loginAttempts = 0
                            self.loginDisplayAlert = loginAlert
                            self.registerUsertoSmpWithDetails()
                        }else if result == "ServerDown"{
                            mJCLoader.stopAnimating()
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: ServerDownAlert, button: okay)
                        }else{
                            mJCLoader.stopAnimating()
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: noInternetAlert, button: okay)
                        }
                    }
                }else{
                    if authType == "SAML"{
                        mJCLoader.startAnimating(status: loginSuccessAlert)
                        self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                    }else{
                        if username == userNameTextField.text {
                            let password = userDetails.value(forKey :"password") as! String
                            if(self.passWordTextField.text == "") && authType == "Basic"{
                                mJCAlertHelper.showAlert(self, title: WarningAlert, message: loginPasswordBlankAlert, button: okay)
                            }else if (passWordTextField.text?.count)! < 5 && authType == "Basic"{
                                mJCAlertHelper.showAlert(self, title: WarningAlert, message: loginPasswordShortAlert, button: okay)
                            }else if(password == passWordTextField.text) && authType == "Basic"{
                                mJCLoader.startAnimating(status: loginSuccessAlert)
                                self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                            }else {
                                self.passWordTextField.text = ""
                                mJCAlertHelper.showAlert(self, title: errorTitle, message: loginPasswordNotMatchAlert, button: okay)
                            }
                        }else {
                            if (self.userNameTextField.text == "") && authType == "Basic" {
                                mJCAlertHelper.showAlert(self, title: errorTitle, message: loginUsernameBlankAlert, button: okay)
                            }else if (userNameTextField.text?.count)! < 5 && authType == "Basic" {
                                mJCAlertHelper.showAlert(self, title: errorTitle, message: loginUsernameShortAlert, button: okay)
                            }else if(self.passWordTextField.text == "") && authType == "Basic" {
                                mJCAlertHelper.showAlert(self, title: errorTitle, message: loginPasswordBlankAlert, button: okay)
                            }else if (passWordTextField.text?.count)! < 5 && authType == "Basic" {
                                mJCAlertHelper.showAlert(self, title: errorTitle, message: loginPasswordShortAlert, button: okay)
                            }else {
                                let msg = username + " " + loginOtherUserAlert
                                let params = Parameters(
                                    title: "New_User".localized(),
                                    message: msg,
                                    cancelButton: Noalert,
                                    otherButtons: [Yesalert])
                                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                                    switch buttonIndex {
                                    case 0: break;
                                    case 1: self.clearUserData(newUser: true)
                                    default: break
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    @IBAction func resetPasswordButtonAction(sender: AnyObject) {
        mJCLogger.log("Reset Button Tapped".localized(), Type: "")
        let resetPassword = ScreenManager.getRequestDemoScreen()
        resetPassword.headerString = "Reset Password"
        resetPassword.modalPresentationStyle = .fullScreen
        self.present(resetPassword, animated: false, completion: {
        })
    }
    @IBAction func resetDemoButtonAction(sender: AnyObject) {
        if demoModeEnabled == true{
            if UserDefaults.standard.value(forKey: "StoreNames") != nil{
                let storeNames = UserDefaults.standard.value(forKey: "StoreNames") as! [String]
                let unFlushData = mJCStoreHelper.checkForUnflushedData(storeNameArr: storeNames)
            }
            do {
                let url = NSURL(fileURLWithPath: documentPath)
                let DemoPath = url.appendingPathComponent("DemoStores")?.path
                let items = try myAsset.fileManager.contentsOfDirectory(atPath: DemoPath!)
                for i in 0..<items.count{
                    let file = items[i]
                    let pppds = DemoPath! + "/\(file)"
                    try myAsset.fileManager.removeItem(atPath: pppds)
                }
                self.demoButtonAction(sender)
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Data_reset_successfully_please_restart_your_application".localized(), button: okay)
            }catch {
                print("Something went wrong")
            }
        }else{
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Demo_Data_not_available".localized(), button: okay)
        }
    }
    @IBAction func exitDemoButtonAction(sender: AnyObject) {
        if demoModeEnabled == true{
            do {
                let url = NSURL(fileURLWithPath: documentPath)
                let DemoPath = url.appendingPathComponent("DemoStores")?.path
                let items = try myAsset.fileManager.contentsOfDirectory(atPath: DemoPath!)
                for i in 0..<items.count{
                    let file = items[i]
                    let pppds = DemoPath! + "/\(file)"
                    try myAsset.fileManager.removeItem(atPath: pppds)
                }
                self.blankView.isHidden = false
                self.alertView.isHidden = false
                self.exitDemoButton.isHidden = true
                self.resetUserDataButton.isHidden = false
                self.resetDemoButton.isHidden = true
                self.resetUserDataButton.isHidden = false
                self.ServerDetailsButton.isHidden = false
                self.resetPasswordButton.isHidden = false
                self.userNameTextField.text = ""
                self.passWordTextField.text = ""
                demoModeEnabled = false
                UserDefaults.standard.removeObject(forKey: "login_Details")
                UserDefaults.standard.removeObject(forKey: "active_details")
                UserDefaults.standard.removeObject(forKey: "StoreNames")
                onPremiseButton.isSelected = false
                cloudButton.isSelected = false
                demoButton.isSelected = false
                self.serverIpTextField.text = ""
                self.portTextfield.text = ""
                self.applicationIdTextFiled.text = ""
                self.alertDoneButton.setTitle("Done".localized(), for: .normal)
                self.serverIpTextField.isUserInteractionEnabled = true
                self.portTextfield.isUserInteractionEnabled = true
                self.applicationIdTextFiled.isUserInteractionEnabled = true
                self.onPremiseButton.isUserInteractionEnabled = true
                self.cloudButton.isUserInteractionEnabled = true
                self.demoButton.isUserInteractionEnabled = true
                self.serverDetailsScanButton.isUserInteractionEnabled = true
            }catch {
                print("Something went wrong")
            }
        }else{
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Demo_Data_not_available".localized(), button: okay)
        }
    }
    @IBAction func resetUserDataButtonAction(sender: AnyObject) {
        if UserDefaults.standard.value(forKey: "StoreNames") != nil{
            self.alertDoneButton.setTitle("Done".localized(), for: .normal)
            self.serverIpTextField.isUserInteractionEnabled = true
            self.portTextfield.isUserInteractionEnabled = true
            self.applicationIdTextFiled.isUserInteractionEnabled = true
            self.onPremiseButton.isUserInteractionEnabled = true
            self.cloudButton.isUserInteractionEnabled = true
            self.demoButton.isUserInteractionEnabled = true
            self.serverDetailsScanButton.isUserInteractionEnabled = true
            myAssetDataManager.autoConfigSettings()
            if isHttps{
                self.cloudButton.isSelected = true
            }else{
                self.cloudButton.isSelected = false
            }
            if authType == "SAML"{
                self.samlButton.isSelected=true
            }
            mJCLogger.log("Reset User data Button Tapped".localized(), Type: "")
            mJCLoader.startAnimating(status: "Reseting_User_Data_Please_wait".localized())
            self.clearUserData(newUser: false)
        }else{
            mJCLoader.stopAnimating()
            UserDefaults.standard.removeObject(forKey: "login_Details")
            self.alertView.isHidden = false
            self.blankView.isHidden = false
            self.applicationIdTextFiled.text = ""
            self.portTextfield.text = ""
            self.serverIpTextField.text = ""
            self.userNameTextField.text = ""
            self.passWordTextField.text = ""
            self.serverIpTextField.becomeFirstResponder()
        }
    }
    @IBAction func ServerDetailsAction(_ sender: Any) {
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            let userDetails = UserDefaults.standard.value(forKey:"login_Details") as! NSDictionary
            let ConnectionId = userDetails.value(forKey :"ApplicationConnectionId") as! String
            let demo = userDetails.value(forKey :"DemoMode") as! Bool
            if authType == "Basic"{
                self.samlButton.isSelected = false
            }else if authType == "SAML"{
                self.samlButton.isSelected = true
            }
            if demo == true{
                onPremiseButton.isSelected = false
                cloudButton.isSelected = false
                demoButton.isSelected = true
                self.serverIpTextField.text = ""
                self.portTextfield.text = ""
                self.applicationIdTextFiled.text = ""
                self.alertDoneButton.setTitle("Close".localized(), for: .normal)
                self.serverIpTextField.isUserInteractionEnabled = false
                self.portTextfield.isUserInteractionEnabled = false
                self.applicationIdTextFiled.isUserInteractionEnabled = false
                self.onPremiseButton.isUserInteractionEnabled = false
                self.cloudButton.isUserInteractionEnabled = false
                self.demoButton.isUserInteractionEnabled = false
                self.serverDetailsScanButton.isUserInteractionEnabled = false
                self.samlButton.isSelected = false
            }else if ConnectionId != "" || demo == false{
                self.alertDoneButton.setTitle("Close".localized(), for: .normal)
                self.serverIpTextField.isUserInteractionEnabled = false
                self.portTextfield.isUserInteractionEnabled = false
                self.applicationIdTextFiled.isUserInteractionEnabled = false
                self.onPremiseButton.isUserInteractionEnabled = false
                self.cloudButton.isUserInteractionEnabled = false
                self.demoButton.isUserInteractionEnabled = false
                self.serverDetailsScanButton.isUserInteractionEnabled = false
                self.serverIpTextField.text = serverIP
                self.portTextfield.text = "\(portNumber)"
                self.applicationIdTextFiled.text = ApplicationID
            }else{
                self.alertDoneButton.setTitle("Done".localized(), for: .normal)
                self.serverIpTextField.text = serverIP
                self.portTextfield.text = "\(portNumber)"
                self.applicationIdTextFiled.text = ApplicationID
                self.serverIpTextField.isUserInteractionEnabled = true
                self.portTextfield.isUserInteractionEnabled = true
                self.applicationIdTextFiled.isUserInteractionEnabled = true
                self.onPremiseButton.isUserInteractionEnabled = true
                self.cloudButton.isUserInteractionEnabled = true
                self.demoButton.isUserInteractionEnabled = true
                self.serverDetailsScanButton.isUserInteractionEnabled = true
            }
            if (portTextfield.text?.count == 3) && portTextfield?.text == "443"{
                portTextfield.text = "0\(portTextfield.text ?? "0443")"
            }
        }else{
            self.alertDoneButton.setTitle("Done".localized(), for: .normal)
            self.serverIpTextField.isUserInteractionEnabled = true
            self.portTextfield.isUserInteractionEnabled = true
            self.applicationIdTextFiled.isUserInteractionEnabled = true
            self.onPremiseButton.isUserInteractionEnabled = true
            self.cloudButton.isUserInteractionEnabled = true
            self.demoButton.isUserInteractionEnabled = true
            self.serverDetailsScanButton.isUserInteractionEnabled = true
        }
        blankView.isHidden = false
        alertView.isHidden = false
    }
    @IBAction func shareButtonAction(_ sender: Any) {
        myAssetDataManager.uniqueInstance.shareLogFiles(sender: sender as! UIButton,screen: self,fwLogs: false, from: "Login", userId: "\(self.userNameTextField.text ?? "")")
    }
    @IBAction func serverDetailsScanButtonAction(sender: AnyObject) {
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "login", delegate: self, controller: self)
    }
    @IBAction func onPremiseButtonAction(sender: AnyObject) {
        serverDetailsScanButton.isHidden = false
        mJCLogger.log("SMP Button Tapped".localized(), Type: "")
        onPremiseButton.isSelected = true
        cloudButton.isSelected = false
        demoButton.isSelected = false
        isHttps = false
        demoModeEnabled = false
        self.serverIpTextField.text = ""
        self.portTextfield.text = ""
        self.applicationIdTextFiled.text = ""
        self.serverIpTextField.becomeFirstResponder()
        self.serverIpTextField.isUserInteractionEnabled = true
        self.portTextfield.isUserInteractionEnabled = true
        self.applicationIdTextFiled.isUserInteractionEnabled = true
        UserDefaults.standard.set(false, forKey: "isHttps")
    }
    @IBAction func cloudButtonAction(_ sender: Any) {
        mJCLogger.log("HCP Button Tapped", Type: "")
        serverDetailsScanButton.isHidden = false
        onPremiseButton.isSelected = false
        cloudButton.isSelected = true
        demoButton.isSelected = false
        isHttps = true
        demoModeEnabled = false
        self.serverIpTextField.text = ""
        self.portTextfield.text = ""
        self.applicationIdTextFiled.text = ""
        self.serverIpTextField.becomeFirstResponder()
        self.serverIpTextField.isUserInteractionEnabled = true
        self.portTextfield.isUserInteractionEnabled = true
        self.applicationIdTextFiled.isUserInteractionEnabled = true
        UserDefaults.standard.set(true, forKey: "isHttps")
    }
    @IBAction func demoButtonAction(_ sender: Any) {
        serverDetailsScanButton.isHidden = true
        onPremiseButton.isSelected = false
        cloudButton.isSelected = false
        demoButton.isSelected = true
        self.serverIpTextField.text = ""
        self.portTextfield.text = ""
        self.applicationIdTextFiled.text = ""
        self.serverIpTextField.isUserInteractionEnabled = false
        self.portTextfield.isUserInteractionEnabled = false
        self.applicationIdTextFiled.isUserInteractionEnabled = false
        isHttps = false
        demoModeEnabled = true
        UserDefaults.standard.set(false, forKey: "isHttps")
    }
    @IBAction func alertDoneButtonAction(sender: AnyObject) {
        if demoButton.isSelected == true{
            self.setDemoModeData()
            self.ServerDetailsButton.isHidden = true
        }else{
            if self.alertDoneButton.titleLabel?.text == "Close".localized(){
                self.alertView.isHidden = true
                self.blankView.isHidden = true
                return
            }
            self.serverIpTextField.isUserInteractionEnabled = true
            self.portTextfield.isUserInteractionEnabled = true
            self.applicationIdTextFiled.isUserInteractionEnabled = true
            self.resetDemoButton.isHidden = true
            self.exitDemoButton.isHidden = true
            UserDefaults.standard.removeObject(forKey: "login_Details")
            UserDefaults.standard.removeObject(forKey: "pushsubscribe")
            let resourcePath = Bundle.main.resourcePath! + "/Demo"
            do {
                let items = try myAsset.fileManager.contentsOfDirectory(atPath: resourcePath)
                let url = NSURL(fileURLWithPath: documentPath)
                let DemoPath = url.appendingPathComponent("DemoStores")?.path
                for i in 0..<items.count{
                    let file = items[i]
                    let paths = DemoPath! + "/\(file)"
                    try myAsset.fileManager.removeItem(atPath: paths)
                }
            }catch {
                print("Failed to remove file")
            }
            if self.alertDoneButton.titleLabel?.text == "Close".localized(){
                self.alertView.isHidden = true
                self.blankView.isHidden = true
            }else{
                let server_ip = serverIpTextField.text
                let port = portTextfield.text
                let validIpAddressRegex = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
                let validIpHostRegex = "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$"
                if cloudButton.isSelected == true{
                    if serverIpTextField.text != ""{
                        if serverIpTextField.text?.contains("https") ?? false  || serverIpTextField.text?.contains(find: "http") ?? false {
                            blankView.isHidden = false
                            alertView.isHidden = false
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_valid_ip_address".localized(), button: okay)
                        }else{
                            serverIP = server_ip!
                        }
                    }else{
                        blankView.isHidden = false
                        alertView.isHidden = false
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_valid_ip _address".localized(), button: okay)
                        return
                    }
                    if port?.count == 4 && (port?.range(of:validIpHostRegex, options:.regularExpression) != nil){
                        blankView.isHidden = true
                        alertView.isHidden = true
                        portNumber = Int(port!) ?? 0443
                        self.userNameTextField.becomeFirstResponder()
                    }else {
                        blankView.isHidden = false
                        alertView.isHidden = false
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_provide_valid_Port_Number".localized(), button: okay)
                        return
                    }
                    if applicationIdTextFiled.text == ""{
                        blankView.isHidden = false
                        alertView.isHidden = false
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_provide_valid_ApplicationID".localized(), button: okay)
                        return
                    }else{
                        blankView.isHidden = true
                        alertView.isHidden = true
                        ApplicationID = self.applicationIdTextFiled.text ?? ""
                    }
                }else{
                    if(server_ip?.range(of:validIpAddressRegex, options:.regularExpression) != nil) {}else{
                        alertView.isHidden = false
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_valid_ip _address".localized(), button: okay)
                        return
                    }
                    if port?.count == 4 && (port?.range(of:validIpHostRegex, options:.regularExpression) != nil){
                        blankView.isHidden = true
                        alertView.isHidden = true
                        portNumber = Int(port!) ?? 0443
                        self.userNameTextField.becomeFirstResponder()
                    }else {
                        blankView.isHidden = false
                        alertView.isHidden = false
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_provide_valid_Port_Number".localized(), button: okay)
                        return
                    }
                    if applicationIdTextFiled.text == ""{
                        blankView.isHidden = false
                        alertView.isHidden = false
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_provide_valid_ApplicationID".localized(), button: okay)
                        return
                    }else{
                        blankView.isHidden = true
                        alertView.isHidden = true
                        ApplicationID = self.applicationIdTextFiled.text ?? ""
                    }
                }
                var authTypeStr = String()
                if samlButton.isSelected == true{
                    authTypeStr = "SAML"
                }else{
                    authTypeStr = "Basic"
                }
                let dict = NSMutableDictionary()
                var https = "https"
                if isHttps == false{
                    https = "http"
                }
                serverURL = "\(https)://\(serverIP):\(portNumber)"
                dict.setValue(serverIP, forKey: "serverIP")
                dict.setValue(portNumber, forKey: "portNumber")
                dict.setObject(ApplicationID, forKey: "ApplicationId" as NSCopying)
                dict.setValue("", forKey: "userName")
                dict.setValue("", forKey: "password")
                dict.setValue("", forKey: "ApplicationConnectionId")
                dict.setValue(false, forKey: "DemoMode")
                dict.setValue(authTypeStr, forKey: "authType")
                UserDefaults.standard.setValue(dict, forKey: "login_Details")
                if authTypeStr == "SAML"{
                    self.userNamePwdView.isHidden = true
                    self.registerUsertoSmpWithDetails()
                }else{
                    self.userNamePwdView.isHidden = false
                }
                authType = authTypeStr
                mJCLogger.log("Login@@login_Details \(dict)",Type: "")
            }
        }
    }
    @IBAction func passwordHideButtonAction(_ sender: Any) {
        if let btn = sender as? UIButton{
            btn.isSelected = !btn.isSelected
            passWordTextField.isSecureTextEntry.toggle()
        }
    }
    @IBAction func enterPinButton(_ sender: Any) {
        self.fingerPrintView.isHidden = true
    }
    @IBAction func enterTouchIdButton(_ sender: Any) {
        authenticationMethod()
    }
    @IBAction func samlButtonAction(_ sender: UIButton) {
        samlButton.isSelected = !samlButton.isSelected
        if samlButton.isSelected == true{
            authType = "SAML"
        }else{
            authType = "Basic"
        }
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            if barCode.contains(find: "#P"){
                let trimCodeStr = barCode.replacingOccurrences(of: "#P", with: "").replacingOccurrences(of: "#A", with: "")
                let codeArray = trimCodeStr.components(separatedBy: [":"])
                if codeArray.count > 2 {
                    serverIpTextField.text = codeArray[0]
                    portTextfield.text = codeArray[1]
                    applicationIdTextFiled.text = codeArray[2]
                }
                self.dismiss(animated: true, completion: nil)
            }else{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Invalid_Server_Details".localized(), button: okay)
                serverIpTextField.text = ""
                portTextfield.text = ""
                applicationIdTextFiled.text = ""
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    //MARK:- UITextField Delegate..
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == userNameTextField){
            passWordUnderLineView.backgroundColor = UIColor.lightGray
            userNameUnderLineView.backgroundColor = appColor
            userNameUnderLineViewHieghtConst.constant = 2.0
        }else if (textField == passWordTextField) {
            userNameUnderLineViewHieghtConst.constant = 1.0
            passWordUnderLineViewHeightConst.constant = 2.0
            userNameUnderLineView.backgroundColor = UIColor.lightGray
            passWordUnderLineView.backgroundColor = appColor
        }
        if (textField == serverIpTextField) {
            portTextFieldLineView.backgroundColor = UIColor.lightGray
            applicationtextfileldlineview.backgroundColor = UIColor.lightGray
            serverIPTextFieldLineView.backgroundColor = appColor
            serverIPTextFieldLineHieghtConst.constant = 2.0
            portTextFieldLineHieghtConst.constant = 1.0
        }else if (textField == portTextfield) {
            serverIPTextFieldLineView.backgroundColor = UIColor.lightGray
            applicationtextfileldlineview.backgroundColor = UIColor.lightGray
            portTextFieldLineHieghtConst.constant = 2.0
            serverIPTextFieldLineHieghtConst.constant = 1.0
            portTextFieldLineView.backgroundColor = appColor
        }else if (textField == applicationIdTextFiled){
            portTextFieldLineView.backgroundColor = UIColor.lightGray
            serverIPTextFieldLineView.backgroundColor = UIColor.lightGray
            applicationtextfileldlineview.backgroundColor = appColor
            applicationtexfiledlineheightConst.constant = 2.0
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == userNameTextField){
            userNameTextField.resignFirstResponder()
            passWordTextField.becomeFirstResponder()
            userNameUnderLineViewHieghtConst.constant = 1.0
            passWordUnderLineViewHeightConst.constant = 2.0
            userNameUnderLineView.backgroundColor = UIColor.lightGray
            passWordUnderLineView.backgroundColor = appColor
        }else if (textField == passWordTextField){
            passWordTextField.resignFirstResponder()
            passWordUnderLineViewHeightConst.constant = 1.0
            passWordUnderLineView.backgroundColor = UIColor.lightGray
        }else if(textField == serverIpTextField) {
            serverIpTextField.resignFirstResponder()
            portTextfield.becomeFirstResponder()
            serverIPTextFieldLineHieghtConst.constant = 1.0
            portTextFieldLineHieghtConst.constant = 2.0
            serverIPTextFieldLineView.backgroundColor = UIColor.lightGray
            portTextFieldLineView.backgroundColor = appColor
        }else if (textField == portTextfield) {
            applicationIdTextFiled.becomeFirstResponder()
            portTextfield.resignFirstResponder()
            portTextFieldLineHieghtConst.constant = 1.0
            portTextFieldLineView.backgroundColor = UIColor.lightGray
        }else if (textField == applicationIdTextFiled){
            alertDoneButton.becomeFirstResponder()
            applicationIdTextFiled.resignFirstResponder()
        }
        return true
    }
    
    //MARK:- Registration With OData..
    func registerUsertoSmpWithDetails() {
        
        print("Registring user.. ")
        mJCLogger.log("Registring user..", Type: "")
        let httpConvMan = HttpConversationManager.init()
        let commonfig = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig.addUsernamePasswordProvider(self)
        }else if authType == "SAML"{
            commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
        commonfig.configureManager(httpConvMan)
        DispatchQueue.main.async {
            mJCLogger.log("login details : url ==>\(serverURL) username ==>\(self.userNameTextField.text!) password ==>\(self.passWordTextField.text!)", Type: "")
        }
        loginAttempts = 0
        mJCLoader.startAnimating(status: loginDisplayAlert)
        mJCLoginHelper.registerUser(with: httpConvMan, toServer: serverURL, andAppId: ApplicationID, completion: { data,response,error  in
            let httpResponse = response as? HTTPURLResponse
            let statusCode = httpResponse?.statusCode
            if statusCode == 201{
                if data != nil{
                    let xmlstr = String(decoding: data!, as: UTF8.self)
                    let jsonData = ODSFoundation.ODSXMLReader().convertString(toJson: xmlstr)
                    if jsonData != nil{
                        let jsondict = try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                        let entryDic = jsondict.value(forKeyPath: "entry") as! NSMutableDictionary
                        let contentdic = entryDic.value(forKeyPath: "content") as! NSMutableDictionary
                        let propertyDic = contentdic.value(forKeyPath: "m:properties")as! NSMutableDictionary
                        let UseridDic = propertyDic.value(forKeyPath: "d:UserName") as! NSMutableDictionary
                        let appConnid = propertyDic.value(forKeyPath: "d:ApplicationConnectionId") as! NSMutableDictionary
                        self.setBasicDetails()
                        mJCLoader.startAnimating(status: loginSuccessAlert)
                        UserDefaults.standard.removeObject(forKey: "login_Details")
                        let dict = NSMutableDictionary()
                        dict.setValue(serverIP, forKey: "serverIP")
                        dict.setValue(portNumber, forKey: "portNumber")
                        dict.setObject(ApplicationID, forKey: "ApplicationId" as NSCopying)
                        if authType == "SAML"{
                            if let userName = UseridDic["text"] as? String{
                                dict.setValue(userName, forKey: "userName")
                            }
                        }else{
                            dict.setValue(self.userNameTextField.text ?? "", forKey: "userName")
                            dict.setValue(self.passWordTextField.text ?? "", forKey: "password")
                        }

                        dict.setValue(false, forKey: "DemoMode")
                        dict.setValue(appConnid["text"] as? String ?? "", forKey: "ApplicationConnectionId")
                        dict.setValue(authType, forKey: "authType")
                        UserDefaults.standard.setValue(dict, forKey: "login_Details")
                        let arr = NSMutableArray()
                        arr.add("EntitySetKeysSet")
                        arr.add("AppStoreSet")
                        arr.add("WorkOrderStatusSet")
                        arr.add("ApplicationConfigSet")
                        arr.add("ApplicationFeatureSet")
                        arr.add("ScreenMappingSet")
                        arr.add("ServiceConfigSet")
                        arr.add("StatusCategorySet")
                        UserDefaults.standard.set(arr , forKey: "AppSettingDefineReq")
                        UserDefaults.standard.removeObject(forKey: "AppSettingDefineReq")
                        if UserDefaults.standard.value(forKey: "AppSettingDefineReq") != nil{
                            self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                        }else{
                            let httpConvMan1 = HttpConversationManager.init()
                            let commonfig1 = CommonAuthenticationConfigurator.init()
                            if authType == "Basic"{
                                commonfig1.addUsernamePasswordProvider(self)
                            }else if authType == "SAML"{
                                commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
                            }
                            commonfig1.configureManager(httpConvMan1)
                            let configSetResponse = ServiceConfigModel.getOnlineServcieConfigList(httpConvManager: httpConvMan1!)
                            if let status = configSetResponse["Status"] as? Int{
                                if status == 200{
                                    if let dict = configSetResponse["Response"] as? NSMutableDictionary{
                                        let formatedDict = formateHelperClass.getListInFormte(dictionary: dict, entityModelClassType: ServiceConfigModel.self)
                                        if let data = formatedDict["data"] as? [ServiceConfigModel]{
                                            let definereq = data.filter{$0.AppStoreName == "APLLICATIONSTORE"}
                                            if definereq.count > 0{
                                                if definereq.count > 0{
                                                    let arr = NSMutableArray()
                                                    for req in definereq{
                                                        var serviceUrl = req.ServiceURL
                                                        if serviceUrl != "" && !serviceUrl.contains(find: "ChangePasswordSet"){
                                                            if serviceUrl.contains(find: "\" + strUser + \""){
                                                                serviceUrl = serviceUrl.replacingOccurrences(of: "\" + strUser + \"", with: strUser)
                                                            }
                                                            arr.add(serviceUrl)
                                                        }
                                                    }
                                                    UserDefaults.standard.set(arr , forKey: "AppSettingDefineReq")
                                                    self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                                                }
                                            }else{
                                                mJCLoader.stopAnimating()
                                                mJCAlertHelper.showAlert(self, title: alerttitle, message: somethingwrongalert, button: okay)
                                            }
                                        }
                                    }
                                }else{
                                    mJCLoader.stopAnimating()
                                    mJCAlertHelper.showAlert(self, title: alerttitle, message: somethingwrongalert, button: okay)
                                }
                            }else{
                                mJCLoader.stopAnimating()
                                mJCAlertHelper.showAlert(self, title: alerttitle, message: somethingwrongalert, button: okay)
                            }
                        }
                    }
                }
            }else{
                mJCLoader.stopAnimating()
                mJCAlertHelper.showAlert(self, title: "Registration_failed".localized(), message: somethingwrongalert + " http Status Code \(statusCode ?? 0)", button: okay)
            }
        })
    }
    //MARK:- Handle TapGesture..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        userNameUnderLineView.backgroundColor = UIColor.lightGray
        passWordUnderLineView.backgroundColor = UIColor.lightGray
        userNameUnderLineViewHieghtConst.constant = 1.0
        passWordUnderLineViewHeightConst.constant = 1.0
        userNameTextField.resignFirstResponder()
        passWordTextField.resignFirstResponder()
    }
    func setDemoModeData() {
        if let path = Bundle.main.path(forResource: "mJCConfig", ofType: "plist") {
            if let configDict = NSDictionary(contentsOfFile: path){
                if let appConfigDetails =  configDict["AutoConfig"]{
                    if appConfigDetails as? Bool == true{
                        autoConfig = true
                    }else{
                        autoConfig = false
                    }
                }
                if let serverType = configDict["ServerType"]{
                    if serverType as? String == "Cloud"{
                        isHttps = true
                        self.cloudButton.isSelected = true
                    }else{
                        isHttps = false
                    }
                }
                if let ipaddress = configDict["DemoIP"] as? String{
                    serverIP = ipaddress
                }
                if let serverPort = configDict["DemoPort"] as? String{
                    portNumber = Int(serverPort) ?? 443
                }
                if  let applicationId = configDict["DemoAppID"] as? String{
                    ApplicationID = applicationId
                }
                if let serverPopup =  configDict["ServerPop"] as? Bool{
                    serverPopupRequired = serverPopup
                }
                if let authenticationType =  configDict["AuthenticationType"] as? String{
                    authType = authenticationType
                }else{
                    authType = "Basic"
                }
                if authType == "SAML"{
                    self.samlButton.isSelected=true
                }
                self.setBasicDetails()
                let arr = NSMutableArray()
                arr.add("EntitySetKeysSet")
                arr.add("AppStoreSet")
                arr.add("WorkOrderStatusSet")
                arr.add("ApplicationConfigSet")
                arr.add("ApplicationFeatureSet")
                arr.add("ScreenMappingSet")
                arr.add("ServiceConfigSet")
                arr.add("StatusCategorySet")
                UserDefaults.standard.set(arr , forKey: "AppSettingDefineReq")
                let serverdict = NSMutableDictionary()
                serverdict.setValue(serverIP, forKey: "serverIP")
                serverdict.setValue(portNumber, forKey: "portNumber")
                serverdict.setObject(ApplicationID, forKey: "ApplicationId" as NSCopying)
                mJCLogger.log("Login@@login_Details \(serverdict)",Type: "")
                UserDefaults.standard.set(serverdict, forKey: "login_Details")
            }
        }
        let resourcePath = Bundle.main.resourcePath! + "/Demo"
        do {
            let items = try myAsset.fileManager.contentsOfDirectory(atPath: resourcePath)
            let url = NSURL(fileURLWithPath: documentPath)
            let DemoPath = url.appendingPathComponent("DemoStores")?.path
            var fileExit = Bool()
            for i in 0..<items.count{
                let file = items[i]
                let filepath = resourcePath + "/\(file)"
                let paths = DemoPath! + "/\(file)"
                fileExit = false
                if !myAsset.fileManager.fileExists(atPath: paths){
                    try myAsset.fileManager.copyItem(atPath: filepath, toPath: paths)
                    fileExit = true
                }else{
                    fileExit = true
                }
            }
            if fileExit == true{
                let dict = NSMutableDictionary()
                dict.setValue(serverIP, forKey: "serverIP")
                dict.setValue(portNumber, forKey: "portNumber")
                dict.setValue(ApplicationID, forKey: "ApplicationId")
                dict.setValue("", forKey: "userName")
                dict.setValue("", forKey: "password")
                dict.setValue("", forKey: "appEndPoint")
                dict.setValue("", forKey: "appName")
                dict.setValue("", forKey: "ApplicationConnectionId")
                dict.setValue(true, forKey: "DemoMode")
                UserDefaults.standard.setValue(dict, forKey: "login_Details")
                mJCLogger.log("Login@@login_Details \(dict)",Type: "")
                UserDefaults.standard.set("YES", forKey: "pushsubscribe")
                self.blankView.isHidden = true
                self.alertView.isHidden = true
                self.resetDemoButton.isHidden = false
                self.exitDemoButton.isHidden = false
                self.resetUserDataButton.isHidden = true
                self.ServerDetailsButton.isHidden = true
                self.resetPasswordButton.isHidden = true
            }
        }catch{}
        demoModeEnabled = true
    }
    func gotoLandingpage(pagetitle : String){

        mJCLoader.stopAnimating()
        if pagetitle == "Dashboard"{
        }else if pagetitle == "WorkOrder"{
        }else if pagetitle == "Notification"{
        }else if pagetitle == "TimeSheet"{
        }else if pagetitle == "SupervisorWorkorder"{
            if isSupervisor == "X"{
            }else{
            }
        }else if pagetitle == "SupervisorTeam"{
            if isSupervisor == "X"{
            }else{
            }
        }
    }
    func setLandingPage() {
        DispatchQueue.main.async{
            currentMasterView = "Dashboard"
            let dashboard = ScreenManager.getDashBoardScreen()
            self.appDeli.window?.rootViewController = dashboard
            self.appDeli.window?.makeKeyAndVisible()
        }
    }
    func clearUserData(newUser:Bool) {
        mJCLogger.log("clearUserData Start".localized(), Type: "")
        self.newUser = newUser
        myAssetDataManager.uniqueInstance.resetUserData()
    }
    func resetCompleted(){
        if self.newUser == true{
            mJCLogger.log("\(self.newUser)", Type: "Debug")
            if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
                let serverDetails = UserDefaults.standard.value(forKey:"login_Details") as! NSDictionary
                let serverIP = (serverDetails.value(forKey :"serverIP") as? String)!
                let portNumber = (serverDetails.value(forKey :"portNumber") as? Int) ?? 443
                let ApplicationID = (serverDetails.value(forKey :"ApplicationId") as? String)!
                UserDefaults.standard.removeObject(forKey: "login_Details")
                let dict = NSMutableDictionary()
                dict.setValue(serverIP, forKey: "serverIP")
                dict.setValue(portNumber, forKey: "portNumber")
                dict.setObject(ApplicationID, forKey: "ApplicationId" as NSCopying)
                dict.setValue("", forKey: "userName")
                dict.setValue("", forKey: "password")
                dict.setValue("", forKey: "ApplicationConnectionId")
                dict.setValue(false, forKey: "DemoMode")
                UserDefaults.standard.setValue(dict, forKey: "login_Details")
                mJCLogger.log("Login@@login_Details \(dict)",Type: "")
            }
        }else{
            DispatchQueue.main.async {
                self.serverIpTextField.text = ""
                self.portTextfield.text = ""
                self.applicationIdTextFiled.text = ""
                mJCLoader.stopAnimating()
                UserDefaults.standard.removeObject(forKey: "login_Details")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Data_Reset_Completed".localized(), button: okay)
            }
        }
        self.loginDisplayAlert = loginSuccessAlert
        if self.newUser == false{
            DispatchQueue.main.async{
                self.userNameTextField.text = ""
                self.passWordTextField.text = ""

                if autoConfig == true{
                    if serverPopupRequired == true{
                        self.blankView.isHidden = false
                        self.alertView.isHidden = false
                    }else{
                        self.blankView.isHidden = true
                        self.alertView.isHidden = true
                    }
                    let serverdict = NSMutableDictionary()
                    serverdict.setValue(isHttps, forKey: "ServerType")
                    serverdict.setValue(serverIP, forKey: "serverIP")
                    serverdict.setValue(portNumber, forKey: "portNumber")
                    serverdict.setObject(ApplicationID, forKey: "ApplicationId" as NSCopying)
                    serverdict.setValue("", forKey: "ApplicationConnectionId")
                    serverdict.setValue("", forKey: "userName")
                    serverdict.setValue("", forKey: "password")
                    serverdict.setValue(false, forKey: "DemoMode")
                    UserDefaults.standard.set(serverdict, forKey: "login_Details")
                    mJCLogger.log("Login@@login_Details \(serverdict)",Type: "")
                }else{
                    self.blankView.isHidden = false
                    self.alertView.isHidden = false
                }
            }
        }
        if self.newUser == true{
            mJCLoader.startAnimating(status: self.loginDisplayAlert)
            loginAttempts = 0
            self.loginDisplayAlert = loginAlert
            self.registerUsertoSmpWithDetails()
        }

    }
    func registerforPushnotification(){
        
        mJCLogger.log("Push Subscription ## Start".localized(), Type: "")
        let defineReq  = PushNotificationSubscription
        mJCLogger.log("\(defineReq)", Type: "")
        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "ID")
        prop!.value = "1" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "user")
        prop!.value = strUser as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "title")
        prop!.value = strUser as NSObject
        property.add(prop!)
        
        var connectionID = String()
        var IPaddress = String()
        var PortNo = Int()
        
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            let userDetails = UserDefaults.standard.value(forKey:"login_Details") as! NSDictionary
            connectionID = userDetails.value(forKey :"ApplicationConnectionId") as! String
            IPaddress = userDetails.value(forKey :"serverIP") as! String
            PortNo = (userDetails.value(forKey :"portNumber") as? Int) ?? 443
        }
        
        prop = SODataPropertyDefault(name: "deliveryAddress")
        prop!.value = "http://\(IPaddress):\(PortNo)/Notification/\(connectionID)" as NSObject?
        mJCLogger.log("Push Subscription ## Delivery Address http://\(IPaddress):\(PortNo)/Notification/\(connectionID) ", Type: "")
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "persistNotifications")
        prop!.value = false as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "collection")
        prop!.value = "AppStoreSet" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "filter")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "select")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "changeType")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: PushNotificationSubscription_Entity)
        for prop in property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name ?? ""] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("........................")
        }
        let StoreArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "AppStoreSet"}
        if StoreArray.count > 0{
            var dict = Dictionary<String,Any>()
            dict["serverUrl"] = "\(serverURL)/odata/applications/v4/\(ApplicationID)"
            dict["conectionID"] = "\(connectionID)"
            dict["collectionPath"] = "\(defineReq)"
            if StoreArray[0].AppStoreName == "APLLICATIONSTORE"{
                dict["storeName"] = "\(ApplicationID)"
            }else{
                dict["storeName"] = "\(StoreArray[0].AppStoreName)"
            }
            if UserDefaults.standard.value(forKey: "DeviceToken") != nil{
                let token = UserDefaults.standard.value(forKey: "DeviceToken") as! String
                dict["deviceToken"] = "\(token)"
            }else{
                UserDefaults.standard.set("YES", forKey: "pushsubscribe")
                mJCLogger.log("Push Subscription ## Device token Not availble", Type: "")
                return
            }
            let httpcon = HttpConversationManager.init()
            let commonfig = CommonAuthenticationConfigurator.init()
            if authType == "Basic"{
                commonfig.addUsernamePasswordProvider(self)
            }else if authType == "SAML"{
                commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
            }
            commonfig.configureManager(httpcon)
            let httpConvHandler = SODataV4_HttpConversationHandler.init(manager: httpcon!)
            mjcPushHelper.regsterForPushSubscription(with: httpConvHandler, entity: entity!, options: dict, completionHandler: { (response, error) in
                if(error == nil) {
                    UserDefaults.standard.set("YES", forKey: "pushsubscribe")
                    ODSLogger.log("Push Subscription ## Successfull".localized(), Type: "")
                }else {
#if targetEnvironment(simulator)
#else
                    DispatchQueue.main.async {
                        print("Error : \(String(describing: error))")
                        ODSLogger.log("Push Subscription ## Error \(String(describing: error))", Type: "")
                    }
#endif
                }
            })
        }
    }
    // MARK:- TouchId Authentication
    func authenticationMethod(){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate_with_Touch_ID".localized()
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply:
                                    {(success, error) in
                if success {
                    self.fingerPrintLoginHandler()
                }else {
                    DispatchQueue.main.async {
                        self.enterTouch.isHidden = false
                        self.enterPin.isHidden = false
                        ODSUIHelper.setBorderToView(view: self.enterPin)
                        ODSUIHelper.setBorderToView(view: self.enterTouch)
                        mJCAlertHelper.showAlert(self, title: nil, message: "Authentication_failed".localized(), button: okay)
                    }
                }
            })
        }else {
            mJCAlertHelper.showAlert(self, title: nil, message: "Touch_ID_not_available".localized(), button: okay)
        }
    }
    //MARK:- FaceID Authentication
    func beginFaceID() {
        guard #available(iOS 8.0, *) else {
            return print("Not supported")
        }
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Face_ID_authentication".localized()
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason,reply: { success, error in
                if success {
                    self.fingerPrintLoginHandler()
                }else {
                    DispatchQueue.main.async {
                        self.enterTouch.isHidden = false
                        self.enterPin.isHidden = false
                        ODSUIHelper.setBorderToView(view: self.enterPin)
                        ODSUIHelper.setBorderToView(view: self.enterTouch)
                        mJCAlertHelper.showAlert(self, title: nil, message: "Authentication_failed".localized(), button: okay)
                    }
                }
            })
        }else{
            mJCAlertHelper.showAlert(self, title: nil, message: "Touch_ID_not_available".localized(), button: okay)
        }
    }
    func fingerPrintLoginHandler(){
        
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            let userDetails = UserDefaults.standard.value(forKey:"login_Details") as! NSDictionary
            let username = userDetails.value(forKey :"userName") as! String
            if username != "" {
                if authType == "SAML"{
                    DispatchQueue.main.async {
                        mJCLoader.startAnimating(status: loginSuccessAlert)
                        self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                    }
                }else{
                    let password = userDetails.value(forKey :"password") as! String
                    if(password != "") {
                        DispatchQueue.main.async {
                            mJCLoader.startAnimating(status: loginSuccessAlert)
                            self.openOfflineStore(storeName: ApplicationID, serviceName: ApplicationID)
                        }
                    }else {
                        mJCAlertHelper.showAlert(self, title: errorTitle, message: loginPasswordNotMatchAlert, button: okay)
                    }
                }
            }else {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "User_Data_is_not_found".localized(), button: okay)
            }
        }
    }
    //MARK:- Get store Define request
    func getStoreDefineRequsts(storeName:String)-> NSMutableArray {
        if storeName == ApplicationID{
            if UserDefaults.standard.value(forKey: "AppSettingDefineReq") != nil{
                let definerequest = UserDefaults.standard.value(forKey: "AppSettingDefineReq") as! NSArray
                return NSMutableArray(array: definerequest)
            }else{
                return NSMutableArray()
            }
        }else{
            let arr = NSMutableArray()
            let defineReqArray = offlinestoreDefineReqArray.filter{$0.AppStoreName == "\(storeName)"}
            if defineReqArray.count > 0{
                for req in defineReqArray{
                    var serviceUrl = req.ServiceURL
                    if serviceUrl != ""{
                        if serviceUrl.contains(find: "\" + strUser + \""){
                            serviceUrl = serviceUrl.replacingOccurrences(of: "\" + strUser + \"", with: strUser)
                        }
                        arr.add(serviceUrl)
                    }
                }
            }
            return arr
        }
    }
    //MARK: - Offline store Opening Methods
    func openOfflineStore(storeName:String,serviceName:String) {
        print("\(storeName) open Started --\(Date().localDate())")
        mJCLogger.log("\(storeName) open Started --\(Date().localDate())", Type: "")
        let httpConvMan = HttpConversationManager.init()
        let commonfig = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig.addUsernamePasswordProvider(self)
        }else if authType == "SAML"{
            commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
        commonfig.configureManager(httpConvMan)
        var optionDict = Dictionary<String,Any>()
        optionDict["Host"] = serverIP
        optionDict["port"] = portNumber
        optionDict["https"] = isHttps
        optionDict["httpManager"] = httpConvMan
        if demoModeEnabled == true{
            optionDict["demoMode"] = true
        }else{
            optionDict["demoMode"] = false
        }
        let defineRequestArray = self.getStoreDefineRequsts(storeName: storeName)
        mJCLogger.log("\(storeName) DefineReq -- \n \(defineRequestArray)", Type: "")
        optionDict["defineReq"] = defineRequestArray
        ODSStoreHelper.uniqueInstance.OpenOfflineStore(storeName: storeName, serviceName: serviceName, options: optionDict)
    }
    func offlineStoreOpenFailed(storeName: String, error: Error!) {
        print("\(storeName) open faild -- \(error)")
        mJCLogger.log("\(storeName) open faild --\(Date().localDate()) \n Error: \(error)", Type: "")
    }
    func ODSStoreStatus(storeStatus: String) {
        print(storeStatus)
    }
    func offlineStoreOpenFinished(storeName: String) {
        print("\(storeName) open finished --\(Date().localDate())")
        mJCLogger.log("\(storeName) open finished --\(Date().localDate())", Type: "")
        if storeName == ApplicationID{
            self.getAppstoreSetDetails()
        }else{
            storeCount =  storeCount + 1
            if storeCount != offlinestoreListArray.count {
                let storeDetail = offlinestoreListArray[storeCount]
                var service = storeDetail.AppStoreName
                if service ==  "USERSTORE"{
                    service = ApplicationID
                }else{
                    service = storeDetail.ServiceName
                }
                self.openOfflineStore(storeName: storeDetail.AppStoreName, serviceName: service)
            }else if storeCount == offlinestoreListArray.count{
                mJCLoader.stopAnimating()
                self.pushSubscrption()
                myAssetDataManager.uniqueInstance.dataFetchCompleteDelegate = self
                myAssetDataManager.uniqueInstance.getGlobalData()
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                UserDefaults.standard.removeObject(forKey: "DashFilter")
            }
        }
    }
    func pushSubscrption(){
        if UserDefaults.standard.object(forKey: "pushsubscribe") == nil{
            if ENABLE_PUSH_SUBCRIPTION == true{
                self.registerforPushnotification()
            }
        }
        UserDefaults.standard.setValue(Date().localDate(), forKey: "lastSyncDate")
        UserDefaults.standard.setValue(Date().localDate(), forKey: "lastSyncDate_Master")
    }
    func getAppstoreSetDetails(){

        let query = "$filter=(Active eq 'X')&$orderby=SyncSeq"
        AppStoreModel.getAppStoreList(filterQuery: query){ (response,error) in
            if error == nil{
                ODSStoreHelper.storeNameDictArray = (response["data"] as! [NSMutableDictionary])
                let formatedDict = formateHelperClass.getListInFormte(dictionary: response, entityModelClassType: AppStoreModel.self)
                if let responseArr = formatedDict["data"] as? [AppStoreModel]{
//                    for item in responseArr{
//                        if item.AppStoreName == "SUPERVISORSTORE"{
//                            item.SyncSeq = "6"
//                        }else if item.AppStoreName == "APLLICATIONSTORE"{
//                            item.SyncSeq = "0"
//                        }else if item.AppStoreName == "WMSTORE"{
//                            item.SyncSeq = "2"
//                        }else if item.AppStoreName == "USERSTORE"{
//                            item.SyncSeq = "1"
//                        }else if item.AppStoreName == "HIGHVOLUMESTORE"{
//                            item.SyncSeq = "5"
//                        }else if item.AppStoreName == "LOWVOLUMESTORE"{
//                            item.SyncSeq = "4"
//                        }else if item.AppStoreName == "FORMENGINESTORE"{
//                            item.SyncSeq = "3"
//                        }
//                    }
                    offlinestoreListArray = responseArr
                    mJCLib.storeListArray = responseArr
                    var storeNameArr = [String]()
                    for item in offlinestoreListArray{
                        storeNameArr.append(item.AppStoreName)
                    }
                    UserDefaults.standard.setValue(storeNameArr, forKey: "StoreNames")
                    offlinestoreListArray.sort {$0.SyncSeq < $1.SyncSeq }
                    self.getServiceConfigSetDetails()
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getServiceConfigSetDetails() {
        ServiceConfigModel.getServcieConfigList(modelClass: ServiceConfigModel.self){ (response,error) in
            if(error == nil) {
                offlinestoreDefineReqArray = response["data"] as! [ServiceConfigModel]
                mJCLib.storeDefineReqArray = offlinestoreDefineReqArray
                let storeArr = offlinestoreDefineReqArray.filter{$0.EntitySet == "\(formAssingmentSet)"}
                if storeArr.count > 0{
                    let store = storeArr[0]
                    FormsEngine.formStoreName = "\(store.AppStoreName)"
                }
                self.storeCount =  self.storeCount + 1
                self.getApplicationConfigurations()
            }else {
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    func getApplicationConfigurations(){
        
        ApplcationConfigModel.getapplcationConfigList(){ (response,error) in
            if(error == nil) {
                let formatedDict = formateHelperClass.getApplicationConfigurationsInformate(dictionary: response, from: "")
                //set Auto Notes On Status flags
                if let valuedict = formatedDict.value(forKey: "AUTO_NOTES_ON_STATUS") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if  value == "TRUE"{
                            AUTO_NOTES_ON_STATUS = true
                        }else{
                            AUTO_NOTES_ON_STATUS = false
                        }
                    }else{
                        AUTO_NOTES_ON_STATUS = false
                    }
                }else{
                    AUTO_NOTES_ON_STATUS = false
                }
                
                if let valuedict = formatedDict.value(forKey: "AUTO_NOTES_TEXT_LINE1") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        AUTO_NOTES_TEXT_LINE1 = value
                    }else{
                        AUTO_NOTES_TEXT_LINE1 = ""
                    }
                }else{
                    AUTO_NOTES_TEXT_LINE1 = ""
                }
                if let valuedict = formatedDict.value(forKey: "AUTO_NOTES_TEXT_LINE2") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        AUTO_NOTES_TEXT_LINE2 = value
                    }else{
                        AUTO_NOTES_TEXT_LINE2 = ""
                    }
                }else{
                    AUTO_NOTES_TEXT_LINE2 = ""
                }
                if let valuedict = formatedDict.value(forKey: "AUTO_NOTES_TEXT_LINE3") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        AUTO_NOTES_TEXT_LINE3 = value
                    }else{
                        AUTO_NOTES_TEXT_LINE3 = ""
                    }
                }else{
                    AUTO_NOTES_TEXT_LINE3 = ""
                }
                if let valuedict = formatedDict.value(forKey: "AUTO_NOTES_TEXT_LINE4") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        AUTO_NOTES_TEXT_LINE4 = value
                    }else{
                        AUTO_NOTES_TEXT_LINE4 = ""
                    }
                }else{
                    AUTO_NOTES_TEXT_LINE4 = ""
                }
                if let valuedict = formatedDict.value(forKey: "BackEndUser") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        strUser = value
                    }else{
                        strUser = ""
                    }
                }else{
                    strUser = ""
                }
                strUser = strUser.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? strUser
                if let valuedict = formatedDict.value(forKey: "ENABLE_POST_DEVICE_LOCATION_NOTES") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value  == "TRUE"{
                            ENABLE_POST_DEVICE_LOCATION_NOTES = true
                        }else{
                            ENABLE_POST_DEVICE_LOCATION_NOTES = false
                        }
                    }else{
                        ENABLE_POST_DEVICE_LOCATION_NOTES = false
                    }
                }else{
                    ENABLE_POST_DEVICE_LOCATION_NOTES = false
                }
                if let valuedict = formatedDict.value(forKey: "SERVER_PING_URL") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        SERVER_PING_URL = value
                    }else{
                        SERVER_PING_URL = "https://www.google.com/"
                    }
                }else{
                    SERVER_PING_URL = "https://www.google.com/"
                }
                ODSReachability.sharedInstance().serverPingURL = SERVER_PING_URL
                if let valuedict = formatedDict.value(forKey: "OPERATION_COMPLETE_TEXT") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        OPERATION_COMPLETE_TEXT = value
                    }else{
                        OPERATION_COMPLETE_TEXT = ""
                    }
                }else{
                    OPERATION_COMPLETE_TEXT = ""
                }
                if let valuedict = formatedDict.value(forKey: "ATT_TYPE_HOURS_OF_COSTING") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        ATT_TYPE_HOURS_OF_COSTING = value
                    }else{
                        ATT_TYPE_HOURS_OF_COSTING = ""
                    }
                }else{
                    ATT_TYPE_HOURS_OF_COSTING = ""
                }
                // background sync flags
                if let valuedict = formatedDict.value(forKey: "EventBased_Sync") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        EventBased_Sync = value
                    }else{
                        EventBased_Sync = ""
                    }
                }else{
                    EventBased_Sync = ""
                }
                if let valuedict = formatedDict.value(forKey: "TimeBased_Sync") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        TimeBased_Sync = value
                    }else{
                        TimeBased_Sync = ""
                    }
                }else{
                    TimeBased_Sync = ""
                }
                if let valuedict = formatedDict.value(forKey: "EventBased_Sync_Type") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        EventBased_Sync_Type = value
                    }else{
                        EventBased_Sync_Type = ""
                    }
                }else{
                    EventBased_Sync_Type = ""
                }
                if let valuedict = formatedDict.value(forKey: "TimeBased_Sync_Type") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        TimeBased_Sync_Type = value
                    }else{
                        TimeBased_Sync_Type = ""
                    }
                }else{
                    TimeBased_Sync_Type = ""
                }
                if let valuedict = formatedDict.value(forKey: "BG_SYNC_TIME_INTERVAL") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        BG_SYNC_TIME_INTERVAL = value
                    }else{
                        BG_SYNC_TIME_INTERVAL = ""
                    }
                }else{
                    BG_SYNC_TIME_INTERVAL = ""
                }
                if let valuedict = formatedDict.value(forKey: "BG_SYNC_RETRY_COUNT") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        BG_SYNC_RETRY_COUNT = value
                    }else{
                        BG_SYNC_RETRY_COUNT = ""
                    }
                }else{
                    BG_SYNC_RETRY_COUNT = ""
                }
                if let valuedict = formatedDict.value(forKey: "BG_SYNC_RETRY_INTERVAL") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        BG_SYNC_RETRY_INTERVAL = value
                    }else{
                        BG_SYNC_RETRY_INTERVAL = ""
                    }
                }else{
                    BG_SYNC_RETRY_INTERVAL = ""
                }
                // Enable Master Data refresh
                if let valuedict = formatedDict.value(forKey: "MasterData_BG_Refresh_Enable") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value == "TRUE"{
                            MasterData_BG_Refresh_Enable = true
                        }else{
                            MasterData_BG_Refresh_Enable = false
                        }
                    }else{
                        MasterData_BG_Refresh_Enable = false
                    }
                }else{
                    MasterData_BG_Refresh_Enable = false
                }
                if let valuedict = formatedDict.value(forKey: "MasterData_BG_Refresh_Unit_In_Hours") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value == "TRUE"{
                            MasterData_BG_Refresh_Unit_In_Hours = true
                        }else{
                            MasterData_BG_Refresh_Unit_In_Hours = false
                        }
                    }else{
                        MasterData_BG_Refresh_Unit_In_Hours = false
                    }
                }else{
                    MasterData_BG_Refresh_Unit_In_Hours = false
                }
                if let valuedict = formatedDict.value(forKey: "ENABLE_PUSH_SUBCRIPTION") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value == "TRUE"{
                            ENABLE_PUSH_SUBCRIPTION = true
                        }else{
                            ENABLE_PUSH_SUBCRIPTION = false
                        }
                    }else{
                        ENABLE_PUSH_SUBCRIPTION = false
                    }
                }else{
                    ENABLE_PUSH_SUBCRIPTION = false
                }
                if let valuedict = formatedDict.value(forKey: "MasterData_BG_Refresh_Interval_Value") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        MasterData_BG_Refresh_Interval_Value = value
                    }else{
                        MasterData_BG_Refresh_Interval_Value = ""
                    }
                }else{
                    MasterData_BG_Refresh_Interval_Value = ""
                }
                if let valuedict = formatedDict.value(forKey: "MasterData_BG_Refresh_Retry_Attempts") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        MasterData_BG_Refresh_Retry_Attempts = value
                    }else{
                        MasterData_BG_Refresh_Retry_Attempts = ""
                    }
                }else{
                    MasterData_BG_Refresh_Retry_Attempts = ""
                }
                if let valuedict = formatedDict.value(forKey: "MasterData_BG_Refresh_Retry_Interval_In_Min") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        MasterData_BG_Refresh_Retry_Interval_In_Min = value
                    }else{
                        MasterData_BG_Refresh_Retry_Interval_In_Min = ""
                    }
                }else{
                    MasterData_BG_Refresh_Retry_Interval_In_Min = ""
                }
                if let valuedict = formatedDict.value(forKey: "DEFAULT_PREMIUM_ID") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        DEFAULT_PREMIUM_ID = value
                    }else{
                        DEFAULT_PREMIUM_ID = ""
                    }
                }else{
                    DEFAULT_PREMIUM_ID = ""
                }
                if let valuedict = formatedDict.value(forKey: "DEFAULT_PREMIUM_NO") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        DEFAULT_PREMIUM_NO = value
                    }else{
                        DEFAULT_PREMIUM_NO = ""
                    }
                }else{
                    DEFAULT_PREMIUM_NO = ""
                }
                if let valuedict = formatedDict.value(forKey: "CREATE_WORKORDER_WITH_OPERATION") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value  == "TRUE"{
                            CREATE_WORKORDER_WITH_OPERATION = true
                        }else{
                            CREATE_WORKORDER_WITH_OPERATION = false
                        }
                    }else{
                        CREATE_WORKORDER_WITH_OPERATION = false
                    }
                }else{
                    CREATE_WORKORDER_WITH_OPERATION = false
                }
                if let valuedict = formatedDict.value(forKey: "FORM_ASSIGNMENT_TYPE") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        FORM_ASSIGNMENT_TYPE = value
                    }else{
                        FORM_ASSIGNMENT_TYPE = ""
                    }
                }else{
                    FORM_ASSIGNMENT_TYPE = ""
                }
                if let valuedict = formatedDict.value(forKey: "ENABLE_OPERATION_MEASUREMENTPOINT_READINGS") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value  == "TRUE"{
                            ENABLE_OPERATION_MEASUREMENTPOINT_READINGS = true
                        }else{
                            ENABLE_OPERATION_MEASUREMENTPOINT_READINGS = false
                        }
                    }else{
                        ENABLE_OPERATION_MEASUREMENTPOINT_READINGS = false
                    }
                }else{
                    ENABLE_OPERATION_MEASUREMENTPOINT_READINGS = false
                }
                if let valuedict = formatedDict.value(forKey: "GOOGLE_MAP_API_CALL_ENABLED") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value  == "TRUE"{
                            GOOGLE_MAP_API_CALL_ENABLED = true
                        }else{
                            GOOGLE_MAP_API_CALL_ENABLED = false
                        }
                    }else{
                        GOOGLE_MAP_API_CALL_ENABLED = false
                    }
                }else{
                    GOOGLE_MAP_API_CALL_ENABLED = false
                }
                if let valuedict = formatedDict.value(forKey: "ENABLE_SIGNATURE_CAPTURE_ON_COMPLETION") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value  == "TRUE"{
                            ENABLE_SIGNATURE_CAPTURE_ON_COMPLETION = true
                        }else{
                            ENABLE_SIGNATURE_CAPTURE_ON_COMPLETION = false
                        }
                    }else{
                        ENABLE_SIGNATURE_CAPTURE_ON_COMPLETION = false
                    }
                }else{
                    ENABLE_SIGNATURE_CAPTURE_ON_COMPLETION = false
                }
                if let valuedict = formatedDict.value(forKey: "WO_OBJS_DISPLAY") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        WO_OP_OBJS_DISPLAY = value
                    }else{
                        WO_OP_OBJS_DISPLAY = ""
                    }
                }else{
                    WO_OP_OBJS_DISPLAY = ""
                }
                if let valuedict = formatedDict.value(forKey: "AUTO_DISPLAY_ERROR_SCREEN") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value  == "TRUE"{
                            AUTO_DISPLAY_ERROR_SCREEN = true
                        }else{
                            AUTO_DISPLAY_ERROR_SCREEN = false
                        }
                    }else{
                        AUTO_DISPLAY_ERROR_SCREEN = false
                    }
                }else{
                    AUTO_DISPLAY_ERROR_SCREEN = false
                }
                if let valuedict = formatedDict.value(forKey: "DEVICE_LOG_FILE_SIZE") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        DEVICE_LOG_FILE_SIZE = value
                    }else{
                        DEVICE_LOG_FILE_SIZE = "1024"
                    }
                }else{
                    DEVICE_LOG_FILE_SIZE = "1024"
                }
                if let valuedict = formatedDict.value(forKey: "DEVICE_LOG_AUTO_DELETION_DAYS") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        DEVICE_LOG_AUTO_DELETION_DAYS = value
                    }else{
                        DEVICE_LOG_AUTO_DELETION_DAYS = ""
                    }
                }else{
                    DEVICE_LOG_AUTO_DELETION_DAYS = ""
                }
                // Workorder operation objects display
                if let valuedict = formatedDict.value(forKey: "OPR_INSP_ENABLE_STATUS") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        OPR_INSP_ENABLE_STATUS = value
                    }else{
                        OPR_INSP_ENABLE_STATUS = ""
                    }
                }else{
                    OPR_INSP_ENABLE_STATUS = ""
                }
                // Workorder operation objects display
                if let valuedict = formatedDict.value(forKey: "OPR_INSP_RESULT_RECORDED_STATUS") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        OPR_INSP_RESULT_RECORDED_STATUS = value
                    }else{
                        OPR_INSP_RESULT_RECORDED_STATUS = ""
                    }
                }else{
                    OPR_INSP_RESULT_RECORDED_STATUS = ""
                }
                // Workorder operation objects display
                if let valuedict = formatedDict.value(forKey: "TIMESHEET_FETCH_INTERVAL") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        TIMESHEET_FETCH_INTERVAL = value
                    }else{
                        TIMESHEET_FETCH_INTERVAL = ""
                    }
                }else{
                    TIMESHEET_FETCH_INTERVAL = ""
                }
                // Workorder operation objects display
                if let valuedict = formatedDict.value(forKey: "DOWNLOAD_CREATEDBY_WO") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        DOWNLOAD_CREATEDBY_WO = value
                    }else{
                        DOWNLOAD_CREATEDBY_WO = ""
                    }
                }else{
                    DOWNLOAD_CREATEDBY_WO = ""
                }
                // Workorder operation objects display
                if let valuedict = formatedDict.value(forKey: "DOWNLOAD_CREATEDBY_NOTIF") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        DOWNLOAD_CREATEDBY_NOTIF = value
                    }else{
                        DOWNLOAD_CREATEDBY_NOTIF = ""
                    }
                }else{
                    DOWNLOAD_CREATEDBY_NOTIF = ""
                }
                if let valuedict = formatedDict.value(forKey: "DEFAULT_STATUS_TO_CHANGE") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        DEFAULT_STATUS_TO_CHANGE = value
                    }else{
                        DEFAULT_STATUS_TO_CHANGE = "CRTD,ASGD"
                    }
                }else{
                    DEFAULT_STATUS_TO_CHANGE = "CRTD,ASGD"
                }
                if let valuedict = formatedDict.value(forKey: "DEFAULT_STATUS_TO_SEND") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        DEFAULT_STATUS_TO_SEND1 = value
                    }else{
                        DEFAULT_STATUS_TO_SEND1 = "MOBI"
                    }
                }else{
                    DEFAULT_STATUS_TO_SEND1 = "MOBI"
                }
                // Allow user to capture time for team members
                if let valuedict = formatedDict.value(forKey: "ENABLE_CAPTURE_TEAM_TIMESHEET") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value  == "TRUE"{
                            ENABLE_CAPTURE_TEAM_TIMESHEET = true
                        }else{
                            ENABLE_CAPTURE_TEAM_TIMESHEET = false
                        }
                    }else{
                        ENABLE_CAPTURE_TEAM_TIMESHEET = false
                    }
                }else{
                    ENABLE_CAPTURE_TEAM_TIMESHEET = false
                }
                if let valuedict = formatedDict.value(forKey: "SHOW_DEFAULT_TIMESHEET_ENTRY_IN_LIST") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if  value == "TRUE"{
                            SHOW_DEFAULT_TIMESHEET_ENTRY_IN_LIST = true
                        }else{
                            SHOW_DEFAULT_TIMESHEET_ENTRY_IN_LIST = false
                        }
                    }else{
                        SHOW_DEFAULT_TIMESHEET_ENTRY_IN_LIST = false
                    }
                }else{
                    SHOW_DEFAULT_TIMESHEET_ENTRY_IN_LIST = false
                }
                // Allow user to capture time for team members
                if let valuedict = formatedDict.value(forKey: "ENABLE_ONLINE_CHECK_IN_CREATE_WO_OR_NO") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value  == "TRUE"{
                            ENABLE_ONLINE_CHECK_IN_CREATE_WO_OR_NO = true
                        }else{
                            ENABLE_ONLINE_CHECK_IN_CREATE_WO_OR_NO = false
                        }
                    }else{
                        ENABLE_ONLINE_CHECK_IN_CREATE_WO_OR_NO = false
                    }
                }else{
                    ENABLE_ONLINE_CHECK_IN_CREATE_WO_OR_NO = false
                }
                if let valuedict = formatedDict.value(forKey: "NO_TASK_COMP_STATUS") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        NO_TASK_COMP_STATUS = value
                    }else{
                        NO_TASK_COMP_STATUS = ""
                    }
                }else{
                    NO_TASK_COMP_STATUS = ""
                }
                if let valuedict = formatedDict.value(forKey: "ENABLE_CAPTURE_DURATION") as? NSMutableDictionary{
                    if let value = valuedict.value(forKey: "Value") as? String{
                        if value  == "TRUE"{
                            ENABLE_CAPTURE_DURATION = true
                        }else{
                            ENABLE_CAPTURE_DURATION = false
                        }
                    }else{
                        ENABLE_CAPTURE_DURATION = false
                    }
                }else{
                    ENABLE_CAPTURE_DURATION = false
                }
                if let valueDict = formatedDict.value(forKey: "CATALOGCODE_DAMAGE") as? NSMutableDictionary{
                    if let value = valueDict.value(forKey: "Value") as? String{
                        CATALOGCODE_DAMAGE = value
                    }else{
                        CATALOGCODE_DAMAGE = "C"
                    }
                }else{
                    CATALOGCODE_DAMAGE = "C"
                }
                if let valueDict = formatedDict.value(forKey: "CATALOGCODE_CAUSE") as? NSMutableDictionary{
                    if let value = valueDict.value(forKey: "Value") as? String{
                        CATALOGCODE_CAUSE = value
                    }else{
                        CATALOGCODE_CAUSE = "5"
                    }
                }else{
                    CATALOGCODE_CAUSE = "5"
                }
                if let valueDict = formatedDict.value(forKey: "CATALOGCODE_ITEM") as? NSMutableDictionary{
                    if let value = valueDict.value(forKey: "Value") as? String{
                        CATALOGCODE_ITEM = value
                    }else{
                        CATALOGCODE_ITEM = "B"
                    }
                }else{
                    CATALOGCODE_ITEM = "B"
                }
                if let valueDict = formatedDict.value(forKey: "CATALOGCODE_ACTIVITY") as? NSMutableDictionary{
                    if let value = valueDict.value(forKey: "Value") as? String{
                        CATALOGCODE_ACTIVITY = value
                    }else{
                        CATALOGCODE_ACTIVITY = "A"
                    }
                }else{
                    CATALOGCODE_ACTIVITY = "A"
                }
                if let valueDict = formatedDict.value(forKey: "CATALOGCODE_TASK") as? NSMutableDictionary{
                    if let value = valueDict.value(forKey: "Value") as? String{
                        CATALOGCODE_TASK = value
                    }else{
                        CATALOGCODE_TASK = "2"
                    }
                }else{
                    CATALOGCODE_TASK = "2"
                }
                if let valueDict = formatedDict.value(forKey: "CATALOGCODE_SYMPTOM") as? NSMutableDictionary{
                    if let value = valueDict.value(forKey: "Value") as? String{
                        CATALOGCODE_SYMPTOM = value
                    }else{
                        CATALOGCODE_SYMPTOM = "D"
                    }
                }else{
                    CATALOGCODE_SYMPTOM = "D"
                }
                if self.storeCount < offlinestoreListArray.count{
                    let storeDetail = offlinestoreListArray[self.storeCount]
                    var service = storeDetail.AppStoreName
                    if service ==  "USERSTORE"{
                        service = ApplicationID
                    }else{
                        service = storeDetail.ServiceName
                    }
                    self.openOfflineStore(storeName: storeDetail.AppStoreName, serviceName: service)
                }else{
                    mJCLoader.stopAnimating()
                    mJCLogger.log("Something went wrong", Type: "Debug")
                }
            }
            else {
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    // password Delegate methods
    func provideUsernamePassword(forAuthChallenge authChallenge: URLAuthenticationChallenge!, completionBlock: username_password_provider_completion_t!) {
        
        if let dict =  UserDefaults.standard.value(forKey:"login_Details") as? NSDictionary{
            let username = dict.value(forKey :"userName") as! String
            let password = dict.value(forKey :"password") as! String
            if username != "" && password != ""{
                mJCLogger.log("Login@@login_Details 91 \(username)-\(password.cString(using: .init(rawValue: 14)) ?? [])",Type: "")
                let credential = URLCredential(user: username, password: password, persistence: .forSession)
                print("Login@@login_Details 91 \(username)-\(password.cString(using: .init(rawValue: 14)) ?? [])")
                completionBlock(credential, nil)
            }else{
                loginAttempts = loginAttempts + 1
                print("loginAttempt -\(loginAttempts)")
                if loginAttempts > 2{
                    mJCLogger.log("Login@@loginAttempt \(loginAttempts) \(dict)",Type: "")
                    completionBlock(nil, nil)
                }else{
                    DispatchQueue.main.async {
                        let username = self.userNameTextField.text!
                        let userPassWord = self.passWordTextField.text!
                        mJCLogger.log("Login@@login_Details 104\(username)-\(userPassWord.cString(using: .init(rawValue: 14)) ?? [])",Type: "")
                        let credential = URLCredential(user: username, password: userPassWord, persistence: .forSession)
                        print("Login@@login_Details 104\(username)-\(userPassWord.cString(using: .init(rawValue: 14)) ?? [])")
                        completionBlock(credential, nil)
                    }
                }
            }
        }else{
            loginAttempts = loginAttempts + 1
            print("loginAttempt -\(loginAttempts)")
            if loginAttempts > 2{
                mJCLogger.log("Login@@login_Details \(loginAttempts)",Type: "")
                completionBlock(nil, nil)
            }else{
                let username = self.userNameTextField.text!
                let userPassWord = self.passWordTextField.text!
                mJCLogger.log("Login@@login_Details \(username)-\(userPassWord)",Type: "")
                let credential = URLCredential(user: username, password: userPassWord, persistence: .forSession)
                print("Login@@login_Details 121\(username)-\(userPassWord)")
                completionBlock(credential, nil)
            }
        }
    }
    func globalDataFetchCompleteCompleted() {

        if UserDefaults.standard.value(forKey: "touchIDEnable") == nil{
            authenticationType = LAContext().biometricType.rawValue
            if authenticationType != "none"{
                var str = ""
                if authenticationType == "touchID"{
                    str = "Touch_ID".localized()
                }else if authenticationType == "faceID"{
                    str = "Face_ID".localized()
                }
                let msg = "Would_you_like_to_use".localized() + " " + str + " " + "for_signing_in_to_MyJobcard".localized()  + ". " + "can_be_enabled_or_Disabled_at_any_time_in_the_Settings_Self_Service_Authentication_Options".localized()
                DispatchQueue.main.async {
                    let params = Parameters(
                        title: alerttitle,
                        message: msg,
                        cancelButton: "Don't_Use".localized(),
                        otherButtons: [okay])
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0: UserDefaults.standard.set(false, forKey: "touchIDEnable")
                            self.setLandingPage()
                        case 1: UserDefaults.standard.set(true, forKey: "touchIDEnable")
                            self.setLandingPage()
                        default: break
                        }
                    }
                }
            }else{
                self.setLandingPage()
            }
        }else{
            self.setLandingPage()
        }
    }
    // Unused methods
    func copyHighVolume(){
        let resourcePath = Bundle.main.resourcePath! + "/HighVolume"
        do {
            let items = try myAsset.fileManager.contentsOfDirectory(atPath: resourcePath)
            let url = NSURL(fileURLWithPath: documentPath)
            let DemoPath = url.appendingPathComponent("Stores")?.path
            for i in 0..<items.count{
                let file = items[i]
                let filepath = resourcePath + "/\(file)"
                let paths = DemoPath! + "/\(file)"
                if !myAsset.fileManager.fileExists(atPath: paths){
                    try myAsset.fileManager.copyItem(atPath: filepath, toPath: paths)
                }else{
                }
            }
        }catch{
            
        }
    }
    //...END...//
}
