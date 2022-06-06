//
//  NotificationMainVC.swift
//  myJobCard
//
//  Created by Rover Software on 27/03/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib

class NotificationMainVC: UIViewController,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate {
    
     @IBOutlet weak var mainHolderView: UIView!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Notification_No".localized() + ". \(selectedNotificationNumber)", NewJobButton: true, refresButton: true, threedotmenu: true,leftMenuType:"")
        self.view.addSubview(view)
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
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func backButtonClicked(_ sender: UIButton?){
        
    }

}
