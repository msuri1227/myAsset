//
//  ObjectsVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/23/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class ObjectsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //MARK:- Outlets..
    @IBOutlet var mainView: UIView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var headerLabelView: UIView!
    @IBOutlet var objectTableView: UITableView!
    @IBOutlet var noDataLabel: UILabel!
    
    //MARK:- Declared Variables.
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var woObjectViewModel = WorkOrderObjectsViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            var title = String()
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title =  "\(selectedworkOrderNumber)"+"/"+"\(selectedOperationNumber)"
            }else{
                title = "\(selectedworkOrderNumber)"
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: title)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ObjectsVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        self.objectTableView.delegate = self
        self.objectTableView.dataSource = self
        self.objectTableView.estimatedRowHeight = 100.0
        self.objectTableView.separatorStyle = .none
        ScreenManager.registerObjectsTableViewCell(tableView: self.objectTableView)
        woObjectViewModel.vc = self
        self.objectSelected()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        }
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func objectSelected(){
        woObjectViewModel.getObjectlist()
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        woObjectViewModel.getObjectlist()
        mJCLogger.log("Ended", Type: "info")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func updateObjectUIData() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("Response :\(self.woObjectViewModel.objectListArray.count)", Type: "Debug")
            if self.woObjectViewModel.objectListArray.count > 0 && selectedworkOrderNumber != ""{
                self.headerLabelView.isHidden = false
                self.objectTableView.isHidden = false
                self.noDataLabel.isHidden = true
                self.headerLabel.text = "Total".localized() + " : \(self.woObjectViewModel.objectListArray.count)"
                self.objectTableView.reloadData()
            }else{
                self.headerLabelView.isHidden = false
                self.headerLabel.text = "Total".localized() + " : \(self.woObjectViewModel.objectListArray.count)"
                self.objectTableView.isHidden = true
                self.noDataLabel.isHidden = false
                self.noDataLabel.text = "No_object_is_available".localized()
                self.noDataLabel.textAlignment = NSTextAlignment.center
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return woObjectViewModel.objectListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let objectsTableViewCell = ScreenManager.getObjectsTableViewCell(tableView: tableView)
        objectsTableViewCell.indexpath = indexPath
        objectsTableViewCell.woObjectViewModel = woObjectViewModel
        objectsTableViewCell.woObjectModel = woObjectViewModel.objectListArray[indexPath.row]
        mJCLogger.log("Ended", Type: "info")
        return objectsTableViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if DeviceType == iPad{
            return UITableView.automaticDimension
        }else{
            return 184.0
        }
    }
    func updateUIObjectNotificationButton(tagValue: Int) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            mJCLogger.log("Response :\(self.woObjectViewModel.objectListArray.count)", Type: "Debug")
            let objectCls = woObjectViewModel.objectListArray[tagValue]
            if objectCls.Notification != ""{
                menuDataModel.uniqueInstance.presentSingleNotificationScreen(vc: self, selectedNONumber: objectCls.Notification)
            }else{
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Notification_data_not_available".localized(), button: okay)
            }
        }else{
            mJCLogger.log("Response :\(self.woObjectViewModel.objectListArray.count)", Type: "Debug")
            let objectCls = woObjectViewModel.objectListArray[tagValue]
            if objectCls.Notification != ""{
                NotificationModel.getWoNotificationDetailsWith(NotifNum: objectCls.Notification) {(response, error)  in
                    if error == nil{
                        if let responseArr = response["data"] as? [NotificationModel]{
                            mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                            if responseArr.count > 0 {
                                DispatchQueue.main.async {
                                    singleNotification = responseArr[0]
                                    currentMasterView = "Notification"
                                    UserDefaults.standard.removeObject(forKey: "ListFilter")
                                    selectedNotificationNumber = objectCls.Notification
                                    isSingleNotification = true
                                    isSingleNotifFromOperation = true
                                    let mainViewController = ScreenManager.getMasterListDetailScreen()
                                    mainViewController.workorderNotification = true
                                    myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: mainViewController, menuType: "")
                                }
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Notification_data_not_available".localized(), button: okay)
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                            mJCAlertHelper.showAlert(self, title:alerttitle, message: "Notification_data_not_available".localized(), button: okay)
                        }
                    }else{
                        mJCAlertHelper.showAlert(self, title:alerttitle, message: "Notification_data_not_available".localized(), button: okay)
                        mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }else{
                mJCAlertHelper.showAlert(self, title:alerttitle, message: "Notification_data_not_available".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
