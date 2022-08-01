//
//  NotificationMainVC.swift
//  myJobCard
//
//  Created by Rover Software on 27/03/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class NotificationMainVC: UIViewController,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate {
    
    @IBOutlet weak var mainHolderView: UIView!
    @IBOutlet var iPhoneHeader: UIView!
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Notification_No".localized() + ". \(selectedNotificationNumber)", NewJobButton: true, refresButton: true, threedotmenu: true,leftMenuType:"")
        self.iPhoneHeader.addSubview(view)
        if flushStatus == true{
            view.refreshBtn.showSpin()
        }
        view.delegate = self
        self.SlideMenuSelected(index: 1, title: "Overview".localized() ,menuType: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        
    }
    func SlideMenuSelected(index: Int, title: String,menuType: String){
        if title == "Items".localized() {
            let mainViewController = ScreenManager.getMasterListDetailScreen()
            currentMasterView = "Notification"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Overview".localized() {
            for view in self.mainHolderView.subviews{
                view.removeFromSuperview()
            }
            let notificationItemVC = ScreenManager.getNotificationItemScreen()
            addChild(notificationItemVC)
            notificationItemVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(notificationItemVC.view)
            notificationItemVC.didMove(toParent: self)
        }else if title == "Activities".localized() {
            for view in self.mainHolderView.subviews{
                view.removeFromSuperview()
            }
            let notificationActivityVC = ScreenManager.getNotificationActivityScreen()
            addChild(notificationActivityVC)
            notificationActivityVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(notificationActivityVC.view)
            notificationActivityVC.didMove(toParent: self)
        }else if title == "Tasks".localized() {
            for view in self.mainHolderView.subviews{
                view.removeFromSuperview()
            }
            let taskVC = ScreenManager.getNotificationTaskScreen()
            addChild(taskVC)
            taskVC.view.frame = CGRect(x: 0, y: 0, width: self.mainHolderView.frame.size.width, height: self.mainHolderView.frame.size.height)
            self.mainHolderView.addSubview(taskVC.view)
            taskVC.didMove(toParent: self)
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
                menuDataModel.presentCreateNotificationScreen(vc: self)
            }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
            }else{
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
            }
        }
    }
    func refreshButtonClicked(_ sender: UIButton?){}
    func threedotmenuButtonClicked(_ sender: UIButton?){}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func backButtonClicked(_ sender: UIButton?){}
}
