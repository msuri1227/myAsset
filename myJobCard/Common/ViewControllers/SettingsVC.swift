//
//  SettingsVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 27/01/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class SettingsVC: UIViewController, UITableViewDelegate,UITableViewDataSource, CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate {
    
    @IBOutlet var settingsTableView: UITableView!
    
    let sectionTitles = ["User_Info".localized(), "Application_Connection_Details".localized(), "App_Health".localized(), "Self_Service".localized()]
    var UserInfoContentTitle = ["First_Name".localized(),"Personal_Number".localized(),"WorkCenter".localized(),"Plant".localized(),"SMP_Registration_ID".localized()]
   // "Push_Token".localized()
    var applicationTitle = ["App_Name".localized(),"App_Version".localized(),"Server_IP".localized(),"Change_Logs".localized()]
    var appHealthTitle = ["List_of_Stores".localized()]
   // "Push_status".localized(),"Background_Sync_Status".localized()
    var selfServiceTitle = ["Change_Theme".localized(),"Change_Language".localized(), "Authentication_Options".localized(), "Action_Confirmation".localized(), "Upload_Framework_Logs".localized(), "Log_level_for_Device_Logs".localized(), "Share_Device_Logs".localized()]
    //"Change_Password".localized() "Help_&_Support".localized()
    var selectedIndx = -1
    var thereIsCellTapped = false
    var detailsStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            self.settingsTableView.sectionHeaderTopPadding = 0
        }
        mJCLogger.log("Starting", Type: "info")
        let headerNib = UINib.init(nibName: "SettingTableViewCell", bundle: Bundle.main)
        settingsTableView.register(headerNib, forCellReuseIdentifier: "SettingTableViewCell")
        let nib = UINib(nibName: "ExpandableTableViewCell", bundle: nil)
        settingsTableView.register(nib, forCellReuseIdentifier: "ExpandableTableViewCell")
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        mJCLogger.log("Starting", Type: "info")
        
        let headerView = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as! SettingTableViewCell
        headerView.settingTitleLabel.text = self.sectionTitles[section]
        headerView.contentView.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        ODSUIHelper.setCornerRadiusToView(view: headerView.cellBGView, cornerRadius: 8.0)
        if DeviceType == iPad{
            headerView.settingTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        }
        if section == selectedIndx && thereIsCellTapped{
            headerView.sideArrImg.image = UIImage.init(named: "DownArrow")
        }else {
            headerView.sideArrImg.image = UIImage.init(named: "next_arrow")
        }
        headerView.expandButton.tag = section
        headerView.expandButton.addTarget(self, action: #selector(self.btnSectionClick(sender:)), for: .touchUpInside)
        headerView.isUserInteractionEnabled = true
        mJCLogger.log("Ended", Type: "info")
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if DeviceType == iPad {
            return 65
        }else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == selectedIndx && thereIsCellTapped{
            if DeviceType == iPad {
                if UserInfoContentTitle[indexPath.row] == "Push_Token".localized(){
                    return  UITableView.automaticDimension
                }else{
                    return 55
                }
            }else {
                return 45
            }
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return UserInfoContentTitle.count
        }else if section == 1{
            return applicationTitle.count
        }else if section == 2{
            return appHealthTitle.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let contentCell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell") as! ExpandableTableViewCell
        ODSUIHelper.setCornerRadiusToView(view: contentCell.cellBGView, cornerRadius: 6.0)
        contentCell.sideArrowImg.isHidden = true
        contentCell.switchBtn.isHidden = true
        contentCell.selectionButton.isHidden = true
        
        var userDetails = NSDictionary()
        var serverIpStr = String()
        var conIDStr = String()
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            userDetails = UserDefaults.standard.value(forKey:"login_Details") as! NSDictionary
            if demoModeEnabled == true{
                serverIpStr = ""
            }else{
                serverIpStr = (userDetails["serverIP"] as? String)!
            }
            conIDStr = (userDetails["ApplicationConnectionId"] as? String)!
        }
        if DeviceType == iPad{
            contentCell.settingTextLable.font = UIFont.systemFont(ofSize: 18)
            contentCell.settingTitle.font = UIFont.systemFont(ofSize: 18)
        }
        switch (indexPath.section){
        case 0:
            contentCell.settingTitle.text = UserInfoContentTitle[indexPath.row]
            if contentCell.settingTitle.text == "First_Name".localized() {
                contentCell.settingTextLable.text = userDisplayName
            }
            else if contentCell.settingTitle.text == "Personal_Number".localized() {
                contentCell.settingTextLable.text = userPersonnelNo
            }
            else if contentCell.settingTitle.text == "WorkCenter".localized() {
                contentCell.settingTextLable.text = userWorkcenter
            }
            else if contentCell.settingTitle.text == "Plant".localized() {
                contentCell.settingTextLable.text = userPlant
            }
            else if contentCell.settingTitle.text == "SMP_Registration_ID".localized() {
                contentCell.settingTextLable.text = conIDStr
            }else if contentCell.settingTitle.text == "Push_Token".localized() {
                if UserDefaults.standard.value(forKey: "DeviceToken") != nil{
                    contentCell.settingTextLable.text = UserDefaults.standard.value(forKey: "DeviceToken") as? String ?? ""
                }
            }
        case 1:
            contentCell.settingTitle.text = applicationTitle[indexPath.row]
            if contentCell.settingTitle.text == "App_Name".localized() {
                contentCell.settingTextLable.text = "Application_Title".localized()
            }else if contentCell.settingTitle.text == "App_Version".localized(){
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                let buildversion  = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
                contentCell.settingTextLable.text = "\(version ?? "")(\(buildversion ?? ""))"
            }else if contentCell.settingTitle.text == "Server_IP".localized() {
                contentCell.settingTextLable.text = serverIpStr
            }
            else{
                contentCell.settingTextLable.text = ""
            }
        case 2:
            contentCell.settingTitle.text = appHealthTitle[indexPath.row]
            if indexPath.row == 0 {
                contentCell.sideArrowImg.isHidden = false
            }else if indexPath.row == 1 || indexPath.row == 2{
                contentCell.switchBtn.isHidden = true
            }
            contentCell.settingTitle.text = appHealthTitle[indexPath.row]
            contentCell.settingTextLable.text = ""
        default:
            contentCell.settingTitle.text = ""
            contentCell.settingTextLable.text = ""
        }
        mJCLogger.log("Ended", Type: "info")
        return contentCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        if selectedIndx == 2 {
            if indexPath.row == 0 {
                let storesStatusVC = ScreenManager.getStoreStatusScreen()
                storesStatusVC.modalPresentationStyle = .fullScreen
                self.present(storesStatusVC, animated: false, completion: nil)
            }
        }else if selectedIndx == 1{
            if indexPath.row == 3{
                DispatchQueue.main.async{
                    let lotPopUp = Bundle.main.loadNibNamed("ChangeLogsView", owner: self, options: nil)?.last as! ChangeLogsView
                    let windows = UIApplication.shared.windows
                    let firstWindow = windows.first
                    lotPopUp.loadNibView()
                    lotPopUp.frame = UIScreen.main.bounds
                    firstWindow?.addSubview(lotPopUp)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func btnSectionClick(sender:UIButton!){
        mJCLogger.log("Starting", Type: "info")
        if sender.tag == 3 {
            let settingsDetailsVC = ScreenManager.getSettingsDetailsScreen()
            settingsDetailsVC.detailsArr = selfServiceTitle
            settingsDetailsVC.detailsStr = self.sectionTitles[sender.tag]
            settingsDetailsVC.modalPresentationStyle = .fullScreen
            self.present(settingsDetailsVC, animated: false, completion: nil)
        }else {
            if selectedIndx != sender.tag {
                self.thereIsCellTapped = true
                self.selectedIndx = sender.tag
            }else {
                self.thereIsCellTapped = false
                self.selectedIndx = -1
            }
            settingsTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backBtnAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad {
            self.dismiss(animated: false, completion: nil)
        }else {
            if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.remove(at: myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count - 1)
            }
            myAssetDataManager.uniqueInstance.navigationController?.popViewController(animated: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
        
    }
}
