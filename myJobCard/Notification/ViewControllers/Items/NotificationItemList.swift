//
//  NotificationItemList.swift
//  myJobCard
//
//  Created by Rover Software on 27/03/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class NotificationItemList: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate,CreateUpdateDelegate{
    
    @IBOutlet weak var NotificationItemsListTable: UITableView!
    @IBOutlet weak var NotificationItemstotalLabel: UILabel!
    @IBOutlet weak var NoDataLabel: UILabel!
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = Int()
    var did_DeSelectedCell = Int()
    var isfrom = String()
    var itemActivity = Bool()
    var selectedTask = String()
    var selectedActivity = String()
    var selectedItemCauses = String()
    var isfromItem = Bool()
    var notifListViewModel = NotifItemListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.removeObserver(self)
        self.NoDataLabel.isHidden = true
        notifListViewModel.vc = self
        if onlineSearch != true {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(NotificationItemList.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"Reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "Reload"), object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if isfrom == "Items"{
            if onlineSearch == false {
                self.notifListViewModel.getNotificationItemsData()
            }
        }else if  isfrom == "Activities"{
            self.notifListViewModel.getNotificationActivityData()
        }else if isfrom == "Tasks"{
            self.notifListViewModel.getNotificationTasksData()
        }else if isfrom == "ItemCauses"{
            self.notifListViewModel.getNotificationItemsCausesData()
        }else if isfrom == "ItemTasks"{
            self.notifListViewModel.getNotificationItemTasksData()
        }else if isfrom == "ItemActivities"{
            self.notifListViewModel.getNotificationItemActivityData()
        }else{
            if onlineSearch == true { }
            else {
                self.notifListViewModel.getNotificationItemsData()
            }
        }
    }
    func updateItemScreenUI(){
        DispatchQueue.main.async {
            if self.notifListViewModel.totalItemArray.count > 0{
                self.NotificationItemstotalLabel?.text = "Total_Items".localized() + "\(self.notifListViewModel.totalItemArray.count)"
                self.NotificationItemstotalLabel?.isHidden = false
                self.NotificationItemsListTable.reloadData()
                self.NoDataLabel.isHidden = true
                self.NoDataLabel.text = ""
            }else{
                self.NoDataLabel.isHidden = false
                self.NoDataLabel.text = "No_Item_Data_Available".localized()
            }
        }
    }
    func updateTaskScreenUI(){
        DispatchQueue.main.async {
            if(self.notifListViewModel.totalItemArray.count > 0) {
                self.NotificationItemstotalLabel?.text = "Total_Task".localized() + " \(self.notifListViewModel.totalItemArray.count)"
                TaskCount = "\(self.notifListViewModel.totalItemArray.count)"
                self.NotificationItemstotalLabel?.isHidden = false
                self.NotificationItemsListTable.reloadData()
                self.NoDataLabel.isHidden = true
            }else{
                self.NoDataLabel.isHidden = false
                self.NoDataLabel.text = "No_Task_Data_Available".localized()
                TaskCount = ""
            }
        }
    }
    func updateItemTaskScreenUI(){
        DispatchQueue.main.async {
            if(self.notifListViewModel.totalItemArray.count > 0) {
                self.NotificationItemstotalLabel?.text = "Total_Item_Task".localized() + " \(self.notifListViewModel.totalItemArray.count)"
                self.NotificationItemsListTable.reloadData()
                self.NoDataLabel.isHidden = true
                self.NotificationItemstotalLabel?.isHidden = false
                ItemTaskCount = "\(self.notifListViewModel.totalItemArray.count)"
            }else{
                self.NoDataLabel.isHidden = false
                self.NoDataLabel.text = "No_Item_Task_Data_Available".localized()
                ItemTaskCount = ""
            }
        }
    }
    func updateActivityScreenUI(){
        DispatchQueue.main.async {
            if(self.notifListViewModel.totalItemArray.count > 0) {
                self.NotificationItemstotalLabel?.text = "Total_Activities".localized() + " \(self.notifListViewModel.totalItemArray.count)"
                self.NotificationItemsListTable.reloadData()
                self.NotificationItemstotalLabel?.isHidden = false
                ActvityCount = "\(self.notifListViewModel.totalItemArray.count)"
                self.NoDataLabel.isHidden = true
            }else{
                self.NoDataLabel.isHidden = false
                self.NoDataLabel.text = "No_Activity_Data_Available".localized()
                ActvityCount = ""
            }    }
    }
    func updateItemActivityScreenUI(){
        DispatchQueue.main.async {
            if(self.notifListViewModel.totalItemArray.count > 0) {
                self.NotificationItemstotalLabel?.text = "Total_item_Activities".localized() + " \(self.notifListViewModel.totalItemArray.count)"
                self.NotificationItemstotalLabel?.isHidden = false
                self.NotificationItemsListTable?.reloadData()
                ItemActvityCount = "\(self.notifListViewModel.totalItemArray.count)"
                self.NoDataLabel.isHidden = true
            }else{
                self.NoDataLabel.isHidden = false
                self.NoDataLabel.text = "No_Item_Activity_Data_Available".localized()
                ItemActvityCount = ""
            }
        }
    }

    func updateItemCauseScreenUI(){
        DispatchQueue.main.async {
            if(self.notifListViewModel.totalItemArray.count > 0) {
                self.NotificationItemstotalLabel?.text = "Total_item_Causes".localized() + " \(self.notifListViewModel.totalItemArray.count)"
                self.NotificationItemsListTable.reloadData()
                self.NotificationItemstotalLabel?.isHidden = false
                self.NoDataLabel.isHidden = true
                ItemCauseCount = "\(self.notifListViewModel.totalItemArray.count)"
            }else{
                self.NoDataLabel.isHidden = false
                self.NoDataLabel.text = "No_Item_Cause_Data_Available".localized()
                ItemCauseCount = ""
            }
        }
    }
    func EntityCreated(){
        if isfrom == "Items"{
            self.notifListViewModel.getNotificationItemsData()
        }else if  isfrom == "Activities"{
            self.notifListViewModel.getNotificationActivityData()
        }else if isfrom == "Tasks"{
            self.notifListViewModel.getNotificationTasksData()
        }else if isfrom == "ItemCauses"{
            self.notifListViewModel.getNotificationItemsCausesData()
        }else if isfrom == "ItemTasks"{
            self.notifListViewModel.getNotificationItemTasksData()
        }else if isfrom == "ItemActivities"{
            self.notifListViewModel.getNotificationItemActivityData()
        }
    }
    @objc func loadList(notification:Notification){
        if isfromItem == false{
            if tabScrollingIndex == 1{
                isfrom = "Items"
                currentsubView = "Items"
            }else if tabScrollingIndex == 2{
                currentsubView = "Activities"
                isfrom = "Activities"
            }else if tabScrollingIndex == 3{
                isfrom = "Tasks"
                currentsubView = "Tasks"
            }
        }
        self.viewWillAppear(true)
    }
    @objc func storeFlushAndRefreshDone(notification: NSNotification) {
        if isfrom == "Items"{
            self.notifListViewModel.getNotificationItemsData()
        }else if  isfrom == "Activities"{
            self.notifListViewModel.getNotificationActivityData()
        }else if isfrom == "Tasks"{
            self.notifListViewModel.getNotificationTasksData()
        }else if isfrom == "ItemCauses"{
            self.notifListViewModel.getNotificationItemsCausesData()
        }else if isfrom == "ItemTasks"{
            self.notifListViewModel.getNotificationItemTasksData()
        }else if isfrom == "ItemActivities"{
            self.notifListViewModel.getNotificationItemActivityData()
        }
    }
    //MARK:- UITableView Delegates And DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifListViewModel.totalItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationActivityCell = tableView.dequeueReusableCell(withIdentifier: "NotificationActivityCell") as! NotificationActivityCell
        if self.notifListViewModel.totalItemArray.count != 0 {
            notificationActivityCell.isfrom = isfrom
            if isfrom == "Items"{
                let notificationItemsClass = self.notifListViewModel.totalItemArray[indexPath.row] as? NotificationItemsModel
                notificationActivityCell.indexPath = indexPath
                notificationActivityCell.notifItemListViewModel = notifListViewModel
                notificationActivityCell.notificationItemListModelClass = notificationItemsClass
            }else if isfrom == "Activities" || isfrom == "ItemActivities"{
                let notificationItemsClass = self.notifListViewModel.totalItemArray[indexPath.row] as? NotificationActivityModel
                notificationActivityCell.indexPath = indexPath
                notificationActivityCell.notifItemListViewModel = notifListViewModel
                notificationActivityCell.notificationActivityModel = notificationItemsClass
                notificationActivityCell.notificationActivityViewModel.totalActivityArray = self.notifListViewModel.totalItemArray as! [NotificationActivityModel]
            }else if isfrom == "Tasks" || isfrom == "ItemTasks"{
                let notificationItemsClass = self.notifListViewModel.totalItemArray[indexPath.row] as? NotificationTaskModel
                notificationActivityCell.indexPath = indexPath
                notificationActivityCell.notifItemListViewModel = notifListViewModel
                notificationActivityCell.notificationItemTaskModelClass = notificationItemsClass
            }else if isfrom == "ItemCauses"{
                let notificationItemsClass = self.notifListViewModel.totalItemArray[indexPath.row] as? NotificationItemCauseModel
                notificationActivityCell.indexPath = indexPath
                notificationActivityCell.notifItemListViewModel = notifListViewModel
                notificationActivityCell.notificationItemCausesModelClass = notificationItemsClass
            }
            return notificationActivityCell
        }else {
            return notificationActivityCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isfrom == "Items"{
            ItemCount = ""
            ActvityCount = ""
            TaskCount = ""
            let mainViewController = ScreenManager.getNotificationItemMainScreen()
            mainViewController.notificationFrom = self.notifListViewModel.notificationFrom
            mainViewController.isfromItem = true
            let notificationItemsClass = self.notifListViewModel.totalItemArray[indexPath.row] as! NotificationItemsModel
            selectedItem = notificationItemsClass.Item
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "NotificationItems"
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Overview".localized(),"Activities".localized(), "Tasks".localized(), "Causes".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "OverView"),#imageLiteral(resourceName: "RecordPonits"),#imageLiteral(resourceName: "TasksNF"),#imageLiteral(resourceName: "ic_waterBlack")]
            myAssetDataManager.uniqueInstance.addViewControllerToSelectionDelegate(mainController: mainViewController)
        }else if isfrom == "Activities" || isfrom == "ItemActivities"{
            let cell = tableView.cellForRow(at: indexPath) as! NotificationActivityCell
            let notificationActivityVC = ScreenManager.getNotificationActivityScreen()
            notificationActivityVC.isFrom = self.isfrom
            notificationActivityVC.notificationActivityViewModel.didSelectedCell = indexPath.row
            if let actnum = cell.notificationActivityNumberLabel.text{
                notificationActivityVC.notificationActivityViewModel.selectedActivity = actnum
            }
            notificationActivityVC.selectedItemNum = selectedItem
            notificationActivityVC.notificationFrom = self.notifListViewModel.notificationFrom
            notificationActivityVC.isFrom = isfrom
            notificationActivityVC.modalPresentationStyle = .fullScreen
            self.present(notificationActivityVC, animated: false, completion: nil)
        }else if isfrom == "Tasks" || isfrom == "ItemTasks" {
            let NotificationMainTaskVC = ScreenManager.getNotificationMainTaskScreen()
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Overview".localized(),"Attachments".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "OverView"),#imageLiteral(resourceName: "AttachementsNF")]
            myAssetDataManager.uniqueInstance.addViewControllerToSelectionDelegate(mainController: NotificationMainTaskVC)
            let cell = tableView.cellForRow(at: indexPath) as! NotificationActivityCell
            if let taskNum = cell.notificationActivityNumberLabel.text{
                NotificationMainTaskVC.selectedTaskNum = taskNum
                selectedTask = taskNum
            }
            NotificationMainTaskVC.itemNum = selectedItem
            NotificationMainTaskVC.isFromScreen = isfrom
            NotificationMainTaskVC.notificationFrom = self.notifListViewModel.notificationFrom
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(NotificationMainTaskVC, animated: true)
        }else if isfrom == "ItemCauses"{
            let cell = tableView.cellForRow(at: indexPath) as! NotificationActivityCell
            var actNo = String()
            if let actnum = cell.notificationActivityNumberLabel.text{
                actNo = actnum
            }
            menuDataModel.uniqueInstance.presentNotificationItemCausesScreen(vc: self, isFromScrn: "ItemCause", selectedItemCauses: actNo)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
