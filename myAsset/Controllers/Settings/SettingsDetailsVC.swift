//  SettingsDetailsVC.swift
//  SettingsScreenDemo
//
//  Created by Ondevice Solutions on 24/01/20.
//  Copyright © 2020 Rover Software. All rights reserved.
//

import UIKit
import LocalAuthentication
import ODSFoundation
import mJCLib


class SettingsDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var settingsDetailsTableView: UITableView!
    @IBOutlet var settingsTitleLbl: UILabel!
    
    var modes = ["Dark".localized(), "Light".localized(), "Default".localized()]
    var actionConfirmation = ["Deletion".localized(), "Logout".localized()]
    var LogActions = ["Error".localized(),"Warn".localized(),"Info".localized(),"Debug".localized()]
    var languages = [String]()
    var detailsArr = [String]()
    var detailsStr = String()
    var selectedIndx = -1
    var selectedTitle = String()
    var thereIsCellTapped = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            self.settingsDetailsTableView.sectionHeaderTopPadding = 0
        }
        mJCLogger.log("Starting", Type: "info")
        let headerNib = UINib.init(nibName: "ExpandableTableViewCell", bundle: Bundle.main)
        self.settingsDetailsTableView.register(headerNib, forCellReuseIdentifier: "ExpandableTableViewCell")
        let settingsNib = UINib.init(nibName: "SettingTableViewCell", bundle: Bundle.main)
        settingsDetailsTableView.register(settingsNib, forCellReuseIdentifier: "SettingTableViewCell")
        self.settingsTitleLbl.text = detailsStr
        self.languages = self.getLanguages()
        if self.detailsArr.count != 0 {
            self.settingsDetailsTableView.delegate = self
            self.settingsDetailsTableView.dataSource = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
    }
    //MARK:- UITableView DataSource & Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if detailsStr == "Self_Service".localized() {
            if self.selectedTitle == "Change_Theme".localized(){
                return self.modes.count
            }else if self.selectedTitle == "Change_Language".localized() {
                return self.languages.count
            }else if self.selectedTitle == "Authentication_Options".localized() {
                return 1
            }else if self.selectedTitle == "Action_Confirmation".localized() {
                return self.actionConfirmation.count
            }else if self.selectedTitle == "Log_level_for_Device_Logs".localized(){
                return self.LogActions.count
            }else {
                return 0
            }
        }else {
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.detailsArr.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        mJCLogger.log("Starting", Type: "info")
        let headerView = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell") as! ExpandableTableViewCell
        headerView.settingTitle.text = self.detailsArr[section]
        if DeviceType == iPad{
            headerView.settingTitle.font = UIFont.boldSystemFont(ofSize: 20)
        }
        headerView.cellBGView.layer.cornerRadius = 8
        headerView.cellBGView.layer.masksToBounds = true
        headerView.sideArrowImg.isHidden = true
        
        if section == selectedIndx && thereIsCellTapped{
            headerView.sideArrowImg.image = UIImage.init(named: "DownArrow")
        }else {
            headerView.sideArrowImg.image = UIImage.init(named: "next_arrow")
        }
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
        if  detailsStr == "User_Info".localized() {
            headerView.selectionButton.isHidden = true
            if section == 0 {
                headerView.settingTextLable.text = userDisplayName
            }else if section == 1 {
                headerView.settingTextLable.text = userPersonnelNo
            }else if section == 2 {
                headerView.settingTextLable.text = userWorkcenter
            }else if section == 3 {
                headerView.settingTextLable.text = userPlant
            }else if section == 4 {
                headerView.settingTextLable.text = conIDStr
            }else if section == 5 {
                if UserDefaults.standard.value(forKey: "DeviceToken") != nil{
                    headerView.settingTextLable.text = UserDefaults.standard.value(forKey: "DeviceToken") as? String ?? ""
                }
            }
        }else if detailsStr == "Application_Connection_Details".localized() {
            headerView.selectionButton.isHidden = true
            if section == 0 {
                headerView.settingTextLable.text = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
            }else if section == 1 {
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                let buildversion  = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
                headerView.settingTextLable.text = "\(version ?? "")(\(buildversion ?? ""))"
            }else if section == 2 {
                headerView.settingTextLable.text = serverIpStr
            }
        }else if detailsStr == "Self_Service".localized(){
            if detailsArr.indices.contains(section){
                let title = detailsArr[section]
                if title == "Change_Theme".localized() || title == "Authentication_Options".localized() || title == "Action_Confirmation".localized() || title == "Log_level_for_Device_Logs".localized(){
                    headerView.sideArrowImg.isHidden = false
                }
            }
        }else if detailsStr == "App_Health".localized() {
            headerView.selectionButton.tag = section
            headerView.selectionButton.isHidden = true
            if section == 0 {
                headerView.sideArrowImg.isHidden = false
                headerView.selectionButton.isHidden = false
            }else {
                headerView.switchBtn.isHidden = false
            }
        }
        headerView.selectionButton.tag = section
        headerView.selectionButton.addTarget(self, action: #selector(self.sectionSelectionClick(sender:)), for: .touchUpInside)
        headerView.isUserInteractionEnabled = true
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if DeviceType == iPad {
            return 60
        }else {
            if self.detailsArr[section] == "Push_Token".localized() {
                return 60
            }else{
                return 50
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == selectedIndx && thereIsCellTapped{
            if DeviceType == iPad {
                return 55
            }else {
                return 45
            }
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        mJCLogger.log("Starting", Type: "info")
        let customCell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        customCell.cellBGView.layer.cornerRadius = 6
        customCell.cellBGView.layer.masksToBounds = true
        customCell.sideArrImg.isHidden = true
        customCell.settingsSwitch.isHidden = true
        customCell.expandButton.isHidden = true
        
        if DeviceType == iPad {
            customCell.settingTitleLabel.font = UIFont.systemFont(ofSize: 18.0)
        }else{
            customCell.settingTitleLabel.font = UIFont.systemFont(ofSize: 13.0)
        }
        if detailsStr == "Self_Service".localized() {
            if self.selectedTitle == "Change_Theme".localized() {
                customCell.settingsSwitch.isHidden = false
                customCell.settingTitleLabel.text = self.modes[indexPath.row]
                customCell.settingsSwitch.tag = indexPath.row
                customCell.settingsSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                customCell.settingsSwitch.isOn = false
                let mode = UserDefaults.standard.value(forKey: "theme") as? String ?? ""
                if mode != ""{
                    if mode  == "dark"{
                        if indexPath.row == 0 {
                            customCell.settingsSwitch.isOn = true
                        }
                    }else if mode == "light"{
                        if indexPath.row == 1 {
                            customCell.settingsSwitch.isOn = true
                        }
                    }else{
                        if indexPath.row == 2 {
                            customCell.settingsSwitch.isOn = true
                        }
                    }
                }
            }else if self.selectedTitle == "Change_Language".localized() {
                customCell.settingTitleLabel.text = self.languages[indexPath.row]
            }else if self.selectedTitle == "Authentication_Options".localized() {
                customCell.settingsSwitch.isHidden = false
                if LAContext().biometricType.rawValue == "touchID"{
                    customCell.settingTitleLabel.text = "Touch_ID".localized()
                }else if LAContext().biometricType.rawValue == "faceID"{
                    customCell.settingTitleLabel.text = "Face_ID".localized()
                }else{
                    customCell.settingTitleLabel.text = "Authentication_Not_Available".localized()
                    customCell.settingsSwitch.isHidden = true
                }
                customCell.settingsSwitch.tag = indexPath.row
                customCell.settingsSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                if((UserDefaults.standard.value(forKey:"touchIDEnable")) != nil){
                    let id = UserDefaults.standard.value(forKey:"touchIDEnable") as! Bool
                    if id == true{
                        if indexPath.row == 0 {
                            customCell.settingsSwitch.isOn = true
                        }else {
                            customCell.settingsSwitch.isOn = false
                        }
                    }else{
                        customCell.settingsSwitch.isOn = false
                    }
                }else{
                    customCell.settingsSwitch.isOn = false
                }
            }else if self.selectedTitle == "Action_Confirmation".localized() {
                customCell.settingsSwitch.isHidden = false
                customCell.settingTitleLabel.text = self.actionConfirmation[indexPath.row]
                customCell.settingsSwitch.tag = indexPath.row
                customCell.settingsSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                if indexPath.row == 0 {
                    if((UserDefaults.standard.value(forKey:"Deletion")) != nil){
                        let status = UserDefaults.standard.value(forKey:"Deletion") as! Bool
                        if status == true {
                            customCell.settingsSwitch.isOn = true
                        }else {
                            customCell.settingsSwitch.isOn = false
                        }
                    }else {
                        customCell.settingsSwitch.isOn = false
                    }
                }else if indexPath.row == 1 {
                    if((UserDefaults.standard.value(forKey:"Logout")) != nil){
                        let status = UserDefaults.standard.value(forKey:"Logout") as! Bool
                        if status == true {
                            customCell.settingsSwitch.isOn = true
                        }else {
                            customCell.settingsSwitch.isOn = false
                        }
                    }else {
                        customCell.settingsSwitch.isOn = true
                    }
                }
            }else if self.selectedTitle == "Log_level_for_Device_Logs".localized(){
                customCell.settingsSwitch.isHidden = false
                customCell.settingTitleLabel.text = self.LogActions[indexPath.row]
                customCell.settingsSwitch.tag = indexPath.row
                customCell.settingsSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                if indexPath.row == 0 {
                    if((UserDefaults.standard.value(forKey:"ErrorLogLevel")) != nil){
                        let status = UserDefaults.standard.value(forKey:"ErrorLogLevel") as! Bool
                        if status == true {
                            customCell.settingsSwitch.isOn = true
                        }else {
                            customCell.settingsSwitch.isOn = false
                        }
                    }else {
                        customCell.settingsSwitch.isOn = false
                    }
                }else if indexPath.row == 1{
                    if((UserDefaults.standard.value(forKey:"WarnLogLevel")) != nil){
                        let status = UserDefaults.standard.value(forKey:"WarnLogLevel") as! Bool
                        if status == true {
                            customCell.settingsSwitch.isOn = true
                        }else {
                            customCell.settingsSwitch.isOn = false
                        }
                    }else {
                        customCell.settingsSwitch.isOn = false
                    }
                    
                }else if indexPath.row == 2{
                    if((UserDefaults.standard.value(forKey:"InfoLogLevel")) != nil){
                        let status = UserDefaults.standard.value(forKey:"InfoLogLevel") as! Bool
                        if status == true {
                            customCell.settingsSwitch.isOn = true
                        }else {
                            customCell.settingsSwitch.isOn = false
                        }
                    }else{
                        customCell.settingsSwitch.isOn = false
                    }
                }else if indexPath.row == 3{
                    if((UserDefaults.standard.value(forKey:"DebugLogLevel")) != nil){
                        let status = UserDefaults.standard.value(forKey:"DebugLogLevel") as! Bool
                        if status == true {
                            customCell.settingsSwitch.isOn = true
                        }else {
                            customCell.settingsSwitch.isOn = false
                        }
                    }else{
                        customCell.settingsSwitch.isOn = false
                    }
                }
            }
        }else if detailsStr == "Action_Confirmation".localized() {
            customCell.settingsSwitch.isHidden = false
        }
        return customCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndx == 1{
            if indexPath.row == 3{
                print("changelogs")
                changeLogs()
            }
        }
    }
    func changeLogs(){
        DispatchQueue.main.async{
            let lotPopUp = Bundle.main.loadNibNamed("ChangeLogsView", owner: self, options: nil)?.last as! ChangeLogsView
            let windows = UIApplication.shared.windows
            let firstWindow = windows.first
            lotPopUp.loadNibView()
            lotPopUp.frame = UIScreen.main.bounds
            firstWindow?.addSubview(lotPopUp)
        }
    }
    @objc func switchChanged(_ sender : UISwitch!){
        mJCLogger.log("Starting", Type: "info")
        if self.selectedTitle == "Authentication_Options".localized() && sender.tag == 0 {
            if sender.isOn == true{
                UserDefaults.standard.set(true, forKey: "touchIDEnable")
            }else{
                UserDefaults.standard.set(false, forKey: "touchIDEnable")
            }
        }else if detailsStr == "Self_Service".localized() {
            if self.selectedTitle == "Change_Theme".localized() {
                if sender.tag == 0 {
                    if sender.isOn == true{
                        sender.setOn(sender.isOn, animated: true)
                        UserDefaults.standard.setValue("dark", forKey: "theme")
                        UIApplication.shared.windows.forEach { window in
                            if #available(iOS 13.0, *) {
                                window.overrideUserInterfaceStyle = .dark
                            }
                        }
                    }else{
                        sender.setOn(!sender.isOn, animated: true)
                    }
                }else if sender.tag == 1 {
                    if sender.isOn == true{
                        sender.setOn(sender.isOn, animated: true)
                        UserDefaults.standard.setValue("light", forKey: "theme")
                        UIApplication.shared.windows.forEach { window in
                            if #available(iOS 13.0, *) {
                                window.overrideUserInterfaceStyle = .light
                            }
                        }
                    }else{
                        sender.setOn(!sender.isOn, animated: true)
                    }
                }else if sender.tag == 2{
                    if sender.isOn == true{
                        sender.setOn(sender.isOn, animated: true)
                        UserDefaults.standard.setValue("default", forKey: "theme")
                        UIApplication.shared.windows.forEach { window in
                            if #available(iOS 13.0, *) {
                                if UITraitCollection.current.userInterfaceStyle == .dark {
                                    window.overrideUserInterfaceStyle = .dark
                                }else {
                                    window.overrideUserInterfaceStyle = .light
                                }
                            }
                        }
                    }else{
                        sender.setOn(!sender.isOn, animated: true)
                    }
                }
            }else if self.selectedTitle == "Action_Confirmation".localized() {
                if sender.tag == 0 {
                    if sender.isOn == true {
                        UserDefaults.standard.setValue(true, forKey: "Deletion")
                        deletionValue = true
                    }else {
                        sender.isOn = false
                        UserDefaults.standard.setValue(false, forKey: "Deletion")
                        deletionValue = false
                    }
                }else if sender.tag == 1 {
                    if sender.isOn == true {
                        UserDefaults.standard.setValue(true, forKey: "Logout")
                        logoutValue = true
                    }else {
                        sender.isOn = false
                        UserDefaults.standard.setValue(false, forKey: "Logout")
                        logoutValue = false
                    }
                }
            }else if self.selectedTitle == "Log_level_for_Device_Logs".localized(){
                if sender.tag == 0 {
                    if sender.isOn == true {
                        UserDefaults.standard.setValue(true, forKey: "ErrorLogLevel")
                    }else {
                        sender.isOn = false
                        UserDefaults.standard.setValue(false, forKey: "ErrorLogLevel")
                    }
                }else if sender.tag == 1 {
                    if sender.isOn == true {
                        UserDefaults.standard.setValue(true, forKey: "WarnLogLevel")
                    }else {
                        sender.isOn = false
                        UserDefaults.standard.setValue(false, forKey: "WarnLogLevel")
                    }
                }
                if sender.tag == 2 {
                    if sender.isOn == true {
                        UserDefaults.standard.setValue(true, forKey: "InfoLogLevel")
                    }else {
                        sender.isOn = false
                        UserDefaults.standard.setValue(false, forKey: "InfoLogLevel")
                    }
                }else if sender.tag == 3{
                    if sender.isOn == true {
                        UserDefaults.standard.setValue(true, forKey: "DebugLogLevel")
                    }else {
                        sender.isOn = false
                        UserDefaults.standard.setValue(false, forKey: "DebugLogLevel")
                    }
                }
            }
            self.settingsDetailsTableView.reloadData()
        }
    }
    
    @objc func sectionSelectionClick(sender:UIButton!){
        mJCLogger.log("Starting", Type: "info")
        if selectedIndx != sender.tag {
            if detailsStr == "App_Health".localized() {
                if sender.tag == 0 {
                    let storesStatusVC = ScreenManager.getStoreStatusScreen()
                    storesStatusVC.modalPresentationStyle = .fullScreen
                    self.present(storesStatusVC, animated: false, completion: nil)
                }
            }else if detailsStr == "Self_Service".localized() {
                
                if detailsArr.indices.contains(sender.tag){
                    let selectedItem = detailsArr[sender.tag]
                    if selectedItem == "Change_Password".localized() {
                        let changePasswordVc = ScreenManager.getChangePasswordScreen()
                        changePasswordVc.modalPresentationStyle = .fullScreen
                        self.present(changePasswordVc, animated: false, completion: nil)
                    }else if selectedItem == "Change_Language".localized(){
                        let params = Parameters(
                            title: "",
                            message: "Are_you_sure_You_want_to_change_Language".localized(),
                            cancelButton: "Cancel".localized(),
                            otherButtons: ["Continue".localized()]
                        )
                        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                            switch buttonIndex {
                            case 0: break
                            case 1:
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    if UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        UserDefaults.standard.removeObject(forKey: "DashFilter")
                                    }
                                }
                            default: break
                            }
                        }
                    }else if selectedItem == "Upload_Framework_Logs".localized() {
                        if demoModeEnabled == true{
                            mJCLogger.log("We_have_limited_features_enabled_in_Demo_mode".localized(), Type: "Debug")
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "We_have_limited_features_enabled_in_Demo_mode".localized(), button: okay)
                        }else{
                            var urlStr = ""
                            var userDetails = NSDictionary()
                            if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
                                userDetails = UserDefaults.standard.value(forKey:"login_Details") as! NSDictionary
                            }
                            let serverID = userDetails["serverIP"] as! String
                            let portID = userDetails["portNumber"] as? Int ?? 443
                            if isHttps == true{
                                urlStr = "https://" + "\(serverID)" + ":" + "\(portID)" + "/clientlogs"
                            }else{
                                urlStr = "http://" + "\(serverID)" + ":" + "\(portID)" + "/clientlogs"
                            }
                            if let logUrl =  URL.init(string: urlStr) {
                                var urlRequest = URLRequest.init(url: logUrl)
                                if let connectionID = userDetails["ApplicationConnectionId"] as? String {
                                    urlRequest.setValue(connectionID, forHTTPHeaderField: "X-SMP-APPCID")
                                }
                                let httpConvMan = HttpConversationManager.init()
                                let commonfig = CommonAuthenticationConfigurator.init()
                                if authType == "Basic"{
                                    commonfig.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
                                }else if authType == "SAML"{
                                    commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
                                }
                                commonfig.configureManager(httpConvMan)
                                let supportabilityUploader : SupportabilityUploader = SupportabilityUploader.init(httpConversationManager: httpConvMan, urlRequest: (urlRequest as! NSMutableURLRequest))
                                SAPSupportabilityFacade.sharedManager()?.getClientLogManager().uploadClientLogs(supportabilityUploader) { error in
                                    if error == nil {
                                        print("Log_upload_succesfully".localized())
                                    } else {
                                        print("Log_upload_failed:".localized() + "%@", error?.localizedDescription as Any)
                                    }
                                }
                            }
                        }
                    }else if  selectedItem == "Share_Device_Logs".localized(){
                        myAssetDataManager.uniqueInstance.shareLogFiles(sender: sender,screen: self,fwLogs: false,from: "",userId: strUser)
                    }else if selectedItem == "Help_&_Support".localized() {
                        if DeviceType == iPhone{
                            let loginPageView =  self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
                            loginPageView.modalPresentationStyle = .fullScreen
                            self.present(loginPageView, animated: true, completion: nil)
                        }
                    }else {
                        if selectedItem  == "Change_Theme".localized() || selectedItem  == "Change_Language".localized() || selectedItem == "Authentication_Options".localized() || selectedItem == "Action_Confirmation".localized() || selectedItem == "Log_level_for_Device_Logs".localized() {
                            self.thereIsCellTapped = true
                            self.selectedIndx = sender.tag
                            self.selectedTitle = detailsArr[sender.tag]
                        }
                    }
                }
            }
        }else {
            self.thereIsCellTapped = false
            self.selectedIndx = -1
            self.selectedTitle = ""
        }
        settingsDetailsTableView.reloadData()
    }
    func getLanguages() -> [String] {
        mJCLogger.log("Starting", Type: "info")
        languages = Bundle.main.localizations as [String]
        if let index = languages.firstIndex(of: "Base") {
            languages.remove(at: index)
        }
        mJCLogger.log("Ended", Type: "info")
        return languages
    }
    @IBAction func backBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
}
