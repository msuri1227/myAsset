//
//  TeamMasterVC.swift
//  test
//
//  Created by Rover Software on 06/06/17.
//  Copyright © 2017 Rover Software. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class TeamMasterVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate, SlideMenuControllerSelectDelegate {
    
    @IBOutlet var profileView: UIView!
    @IBOutlet var totalWorkOrderLabel: UILabel!
    @IBOutlet var profilePetNameLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var tableViewSuperView: UIView!
    @IBOutlet var techniciantable: UITableView!
    @IBOutlet var iPhoneHeader: UIView!
    var techname = String()
    var techid = String()
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var teamMastViewModel = TeamMasterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mJCLogger.log("Starting", Type: "info")
        teamMastViewModel.vc = self
        if DeviceType == iPad{
            ODSUIHelper.setCornerRadiusToImgView(imageView: self.profileImage, cornerRadius: self.profileImage.frame.size.width / 2)
            if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
                self.profileNameLabel.text = userDisplayName
                self.profilePetNameLabel.text = userSystemID.lowercased()
            }
        }else{
            let view = CustomNavHeader_iPhone.init(viewcontroller: self,backButton: true, leftMenu: true, leftTitle: "Team_Members".localized(), NewJobButton: true, refresButton: true, threedotmenu: false,leftMenuType:"")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
        }
        self.teamMastViewModel.getSupervisorWorkOrderList()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            self.updateSlideMenu()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: "Team_Members".localized)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone {
            let view = CustomNavHeader_iPhone.init(viewcontroller: self,backButton: true, leftMenu: true, leftTitle: "Team_Members".localized(), NewJobButton: true, refresButton: true, threedotmenu: false,leftMenuType:"")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            self.updateSlideMenu()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    private func updateSlideMenu() {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Workorder"
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.last
        }
        myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Job_Location".localized(), "Work_Orders".localized(), "Notifications".localized(), "Time_Sheet".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(),"Error_Logs".localized(),"Log_Out".localized()]
        myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "wo.png"),#imageLiteral(resourceName: "notifi.png"),#imageLiteral(resourceName: "timesht.png"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "assetmap.png"),#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        if !applicationFeatureArrayKeys.contains("Timesheet"){
            if let index =  myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Time_Sheet".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("WO_LIST_MAP_NAV"){
            if let index =  myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Job_Location".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alltechnicianListArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        mJCLogger.log("Starting", Type: "info")
        let cell = techniciantable.dequeueReusableCell(withIdentifier: "TeamViewCell") as! WorkOrderCell
        let alltechclass = alltechnicianListArray[indexPath.row]
        cell.indexpath = indexPath
        cell.teamMastViewModel = self.teamMastViewModel
        cell.teamMastModelClass = alltechclass
        mJCLogger.log("Ended", Type: "info")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        mJCLogger.log("Starting", Type: "info")
        let cell = tableView.cellForRow(at: indexPath) as! WorkOrderCell
        cell.transperentView.backgroundColor = selectionBgColor
        cell.isSelectedCellView.backgroundColor = appColor
        let techclass = alltechnicianListArray[indexPath.row]
        techid = techclass.Technician
        techname = techclass.Name
        if DeviceType == iPad{
            self.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
        }else{
            let mainViewController = ScreenManager.getTeamDetailsScreen()
            currentMasterView = "Team"
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Workorder"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            mainViewController.technname = techname
            mainViewController.techid =  techid
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        let cell = tableView.cellForRow(at: indexPath) as! WorkOrderCell
        cell.transperentView.backgroundColor = UIColor.white
        cell.isSelectedCellView.backgroundColor = UIColor.white
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            return 100
        }else{
            return 100
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        mJCLogger.log("Starting", Type: "info")
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! TeamDetailsVC
            controller.technname = techname
            controller.techid =  techid
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- CustomNavigation Delegate iPhone
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        openLeft()
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateJobScreen(vc: self)
            }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
            }else{
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                mJCLogger.log("WorkFlowError".localized(), Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
    }
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        if title == "Supervisor_View".localized() {
            let mainViewController = ScreenManager.getSupervisorMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Word_Orders".localized() {
            currentMasterView = "WorkOrder"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Notifications".localized() {
            currentMasterView = "Notification"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Job_Location".localized() {
            ASSETMAP_TYPE = ""
            currentMasterView = "MapSplitViewController"
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            let mainViewController = ScreenManager.getMapDeatilsScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Asset_Map".localized() {
            ASSETMAP_TYPE = "ESRIMAP"
            if DeviceType == iPad{
               assetmapVC.openmappage(id: "")
            }else{
                currentMasterView = "WorkOrder"
                selectedworkOrderNumber = ""
                selectedNotificationNumber = ""
                let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                self.present(assetMapDeatilsVC, animated: true, completion: nil)
            }
        }else if title == "Time_Sheet".localized() {
            currentMasterView = "TimeSheet"
            let mainViewController = ScreenManager.getTimeSheetScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Settings".localized() {
            menuDataModel.uniqueInstance.presentSettingsScreen(vc: self)
        }else if title == "Error_Logs".localized() {
            myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
    }
}


