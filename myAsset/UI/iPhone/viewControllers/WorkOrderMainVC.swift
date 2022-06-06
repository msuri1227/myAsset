//
//  WorkOrderMainVC.swift
//  myJobCard
//
//  Created by Rover Software on 22/03/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class WorkOrderMainVC: UIViewController,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate {

    @IBOutlet weak var mainHolderView: UIView!
    
    var operationsVC : OperationListVC?
    var seletectedMenu = String()
    let menudropDown = DropDown()

    let appDeli = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            title =  "\(selectedworkOrderNumber)"+"/"+"\(selectedOperationNumber)"

        }else{
            title = "\(selectedworkOrderNumber)"

        }
        
        let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Work_Order_No".localized() + ". \(selectedworkOrderNumber)", NewJobButton: true, refresButton: true, threedotmenu: true, leftMenuType: "")
      
        self.view.addSubview(view)
        if flushStatus == true{
            view.refreshBtn.showSpin()
        }
        view.delegate = self
        self.SlideMenuSelected(index: 0, title: "Overview".localized(), menuType: "")

    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()

         self.SlideMenuSelected(index: 0, title: seletectedMenu, menuType: "")
    }
    
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
       
        if title == "Work_Orders".localized() {
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
        }else if title == "Overview".localized() {
            
            seletectedMenu = "Overview".localized()
            if currentMasterView == "Notification"{
                let notificationOverViewVC = ScreenManager.getNotificationOverViewScreen()
                addChild(notificationOverViewVC)
                notificationOverViewVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
                self.mainHolderView.addSubview(notificationOverViewVC.view)
                notificationOverViewVC.didMove(toParent: self)
                
            }else if currentMasterView == "WorkOrder"{
                let overviewVC = ScreenManager.getWorkOrderOverViewScreen()
                addChild(overviewVC)
                overviewVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
                self.mainHolderView.addSubview(overviewVC.view)
                overviewVC.didMove(toParent: self)
            }
 
        }else if title == "Operations".localized() {
            seletectedMenu = "Operations".localized()
            operationsVC = ScreenManager.getOperationListScreen()
            addChild(operationsVC!)
            operationsVC?.isfrom = "Operations"
            operationsVC?.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(operationsVC!.view)
            operationsVC?.didMove(toParent: self)
            
        }else if title == "Attachments".localized() {
            seletectedMenu = "Attachments".localized()
            let woAttachVC = ScreenManager.getWorkOrderAttachmentScreen()
            addChild(woAttachVC)
            woAttachVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(woAttachVC.view)
            woAttachVC.didMove(toParent: self)
        }else if title == "Checklists".localized() {
            seletectedMenu = "Checklists".localized()
            let checkSheetListVC = ScreenManager.getCheckSheetListScreen()
            checkSheetListVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(checkSheetListVC.view)
            checkSheetListVC.didMove(toParent: self)
        }else if title == "Objects".localized() {
            seletectedMenu = "Objects".localized()
            let objectVC = ScreenManager.getObjectScreen()
            objectVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(objectVC.view)
            objectVC.didMove(toParent: self)
            
        }
    }
    //MARK:- custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        openLeft()
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NO", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                    createNotificationVC.isFromEdit = false
                    createNotificationVC.modalPresentationStyle = .fullScreen
                    self.present(createNotificationVC, animated: false) {}
                }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                    myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
                }else{
                        myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                }
            }
    }
    func refreshButtonClicked(_ sender: UIButton?){
        
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        
        var menuarr = [String]()
        var imgArray = [UIImage]()
        
        if currentsubView == "Operations"{
            menuarr = ["Add_Operation".localized()]
            imgArray = [#imageLiteral(resourceName: "addIcon")]
        }else if currentsubView == "Components"{
            menuarr = ["Add_Component".localized()]
            imgArray = [#imageLiteral(resourceName: "addIcon")]
        }else{
            menuarr = ["Create_Notification".localized(),"Edit_WorkOrder".localized()]
            imgArray = [#imageLiteral(resourceName: "addIcon"),#imageLiteral(resourceName: "editIcon")]
            if !applicationFeatureArrayKeys.contains("WO_EDIT_WO_OPTION"){
                
                if let index =  menuarr.firstIndex(of: "Edit_WorkOrder".localized()){
                    menuarr.remove(at: index)
                    imgArray.remove(at: index)
                }
            }
        }
        if !applicationFeatureArrayKeys.contains("OPR_ADD_OPR_OPTION"){
            
            if let index =  menuarr.firstIndex(of: "Add_Operation".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("COMP_ADD_COMP_OPTION"){
            
            if let index =  menuarr.firstIndex(of: "Add_Component".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        if menuarr.count == 0{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Options_Available".localized(), button: okay)
        }
        menudropDown.dataSource = menuarr
        self.customizeDropDown(imgArry: imgArray)
        menudropDown.anchorView = sender
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        
        
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "Create_Notification".localized() {
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NO", orderType: "X",from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    if workFlowObj.ActionType == "Screen" {
                        let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                        createNotificationVC.isFromEdit = false
                        createNotificationVC.modalPresentationStyle = .fullScreen
                        self.present(createNotificationVC, animated: false) {}
                    }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                        myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
                    }else{
                        myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                    }
                }
            }
            else if item == "Edit_Workorder".localized(){
                let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                createWorkOrderVC.isFromEdit = true
                self.present(createWorkOrderVC, animated: false) {}
            }else if item == "Add_Operation".localized() {
                
                if isActiveWorkOrder == true {
                    if self.operationsVC!.totalOprationArray.count > 0 {
                        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_OP", orderType: "X",from:"WorkOrder")
                        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                            if workFlowObj.ActionType == "Screen" {
                                let addOperationVC = ScreenManager.getCreateOperationScreen()
                                addOperationVC.isFromScreen = "Operation"
                                addOperationVC.isFromEdit = false
                                addOperationVC.singleOperationClass = self.operationsVC?.singleOperationArray[0] ?? WoOperationModel()
                                addOperationVC.modalPresentationStyle = .fullScreen
                                self.present(addOperationVC, animated: false) {}
                            }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
                            }else{
                                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                            }
                        }
                    }
                }else {
                    
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                    }else{
                        mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                    }
                }
            }
        }
    }
    
    func customizeDropDown(imgArry: [UIImage]) {
        mJCLogger.log("Starting", Type: "info")
        menudropDown.showImage = true
        menudropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownWithImageCell else { return }
            cell.logoImageView.image = imgArry[index]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func backButtonClicked(_ sender: UIButton?){
        
    }


}
