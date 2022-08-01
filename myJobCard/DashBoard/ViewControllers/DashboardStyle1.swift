//
//  DashboardStyle1.swift
//  testgrid
//
//  Created by Rover Software on 23/05/17.
//  Copyright © 2017 Rover Software. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib


class DashboardStyle1: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,ChartViewDelegate,CustomNavigationBarDelegate, CreateUpdateDelegate {
    

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var userTitlelabel: UILabel!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var logoutButton: UIButton!
   
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    
    var NotiPriorityArr = Array<Int>()
    var supervisorArr   = Array<Int>()
    var WoPriorityArr = Array<Int>()
    
    var NotiPriorityStr = Array<String>()
    var supervisorStr   = Array<String>()
    var WoPriorityStr   = Array<String>()
    
    var NotiColorCodeArray = Array<UIColor>()
    var supervisorColorCodeArray  = Array<UIColor>()
    var WoColorCodeArray = Array<UIColor>()
        
    weak var valueFormatter: IValueFormatter?
    
    var dashBoardArray = ["DASH_WO_TILE","DASH_NOTI_TILE","DASH_SUP_TILE","DASH_TIMESHEET_TILE","DASH_ASSET_HIE_TILE","DASH_ONLINE_SEARCH_TILE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.removeObject(forKey: "seletedTab_Wo")
        onlineSearch = Bool()
        onlineSearchArray.removeAll()
        fromSupervisorWorkOrder = false
        
        if DeviceType == iPhone{
            
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: false, leftTitle: userDisplayName, NewJobButton: false, refresButton: true, threedotmenu: true,leftMenuType:"")
            self.view.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
                    
        }else{
            self.userTitlelabel.text = userDisplayName
        }
        
        DispatchQueue.main.async {
            mJCLoader.startAnimating(status: loginSuccessAlert)
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    self.getOperationData()
            }else{
                self.getWorkorderData()
            }
            
            self.getNotificationData()
            self.getSupervisorData()
           
        }
        NotificationCenter.default.addObserver(self, selector: #selector(DashboardStyle1.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(DashboardStyle1.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        
//        if (UserDefaults.standard.value(forKey:"isCreateNotification") != nil) {
//
//           let isCreateWorkOrder = UserDefaults.standard.value(forKey:"isCreateNotification") as! Bool
//                  if isCreateWorkOrder == true {
//
//                   myAssetDataManager.uniqueInstance.getAllOperations(isfrom: "")
//                    UserDefaults.standard.removeObject(forKey: "isCreateNotification")
//                  }
//        }
        
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true{
            if DeviceType == iPad{
                self.refreshButton.showSpin()
            }
        }
        
    }
    // Mark:- IntialData
    
    func EntityCreated() {
        myAssetDataManager.uniqueInstance.getAllWorkorders(from: "")
    }
    func getOperationData(){
        WoPriorityArr.removeAll()
        WoPriorityStr.removeAll()
        WoColorCodeArray.removeAll()
        let colorArr = [UIColor.red,UIColor.green,UIColor.black,UIColor.purple,UIColor.yellow,UIColor.gray,UIColor.blue,UIColor.lightGray,UIColor.cyan,UIColor.darkGray,UIColor.darkGray]
        let statusArr = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "", StatuscCategory: WORKORDER_ASSIGNMENT_TYPE, ObjectType: "X")
        
        if statusArr.count > 0{
            for i in 0..<statusArr.count{
                let statclass = statusArr[i] as! StatusCategoryModel
                let newoprArray = allOperationsArray.filter{ $0.UserStatus == statclass.StatusCode}
                if newoprArray.count > 0{
                    self.WoPriorityArr.append(newoprArray.count)
                    self.WoPriorityStr.append(statclass.StatusCode)
                    self.WoColorCodeArray.append(colorArr[i])
                }
            }
            
        }
        
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
       
    }
    func getWorkorderData(){
        
        let defineQuery = "WoHeaderSet?$orderby=CreatedOn,Priority,WorkOrderNum asc"
        
        WoHeaderModel.getWorkorderList(){ (responseDict, error)  in
            if error == nil{
                self.WoPriorityArr.removeAll()
                self.WoPriorityStr.removeAll()
                self.WoColorCodeArray.removeAll()
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        var array = responseArr.filter{$0.Priority == "1"}
                        if (array.count > 0){
                            self.WoPriorityArr.append(array.count)
                            self.WoPriorityStr.append("Very_High".localized())
                            let veryhigh = UIColor(red: CGFloat(149.0/255.0), green: CGFloat(45.0/255.0), blue: CGFloat(152.0/255.0), alpha: 1.0)
                            self.WoColorCodeArray.append(veryhigh)
                        }
                        array = responseArr.filter{$0.Priority == "2"}
                        if (array.count > 0){
                            self.WoPriorityArr.append(array.count)
                            self.WoPriorityStr.append("High".localized())
                            let high = UIColor(red: CGFloat(227.0/255.0), green: CGFloat(114.0/255.0), blue: CGFloat(34.0/255.0),        alpha: 1.0)
                            self.WoColorCodeArray.append(high)
                        }
                        array = responseArr.filter{$0.Priority == "3"}
                        if (array.count > 0){
                            self.WoPriorityArr.append(array.count)
                            self.WoPriorityStr.append("Medium".localized())
                            let medium = UIColor(red: CGFloat(28.0/255.0), green: CGFloat(190.0/255.0), blue: CGFloat(202.0/255.0), alpha: 1.0)
                            self.WoColorCodeArray.append(medium)
                        }
                        array = responseArr.filter{$0.Priority == "4"}
                        if (array.count > 0){
                            self.WoPriorityArr.append(array.count)
                            self.WoPriorityStr.append("Low".localized())
                            let low = UIColor(red: CGFloat(214.0/255.0), green: CGFloat(224.0/255.0), blue: CGFloat(61.0/255.0),        alpha: 1.0)
                            self.WoColorCodeArray.append(low)
                        }
                        array = responseArr.filter{$0.Priority == ""}
                        if (array.count > 0){
                            self.WoPriorityArr.append(array.count)
                            self.WoPriorityStr.append("No Priority")
                            let low = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(0.0/255.0),        alpha: 1.0)
                            self.WoColorCodeArray.append(low)
                        }
                        
                    }else{
                        
                    }
                    DispatchQueue.main.async{
                        self.collectionView.reloadData()
                    }
                }else{
                    
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        
    }
    func getNotificationData(){
        
        NotificationModel.getNotificationList(){ (responseDict, error)  in
            if error == nil{
                self.NotiPriorityArr.removeAll()
                self.NotiPriorityStr.removeAll()
                self.NotiColorCodeArray.removeAll()
                if let responseArr = responseDict["data"] as? [NotificationModel]{
                    
                    if responseArr.count > 0 {
                        
                        var array = responseArr.filter{$0.Priority == "1"}
                        if (array.count > 0){
                            self.NotiPriorityArr.append(array.count)
                            self.NotiPriorityStr.append("Very_High".localized())
                            let veryhigh = UIColor(red: CGFloat(149.0/255.0), green: CGFloat(45.0/255.0), blue: CGFloat(152.0/255.0), alpha: 1.0)
                            self.NotiColorCodeArray.append(veryhigh)
                        }
                        array = responseArr.filter{$0.Priority == "2"}
                        if (array.count > 0){
                            self.NotiPriorityArr.append(array.count)
                            self.NotiPriorityStr.append("High".localized())
                            let high = UIColor(red: CGFloat(227.0/255.0), green: CGFloat(114.0/255.0), blue: CGFloat(34.0/255.0),        alpha: 1.0)
                            self.NotiColorCodeArray.append(high)
                        }
                        array = responseArr.filter{$0.Priority == "3"}
                        if (array.count > 0){
                            self.NotiPriorityArr.append(array.count)
                            self.NotiPriorityStr.append("Medium".localized())
                            let medium = UIColor(red: CGFloat(28.0/255.0), green: CGFloat(190.0/255.0), blue: CGFloat(202.0/255.0), alpha: 1.0)
                            self.NotiColorCodeArray.append(medium)
                        }
                        array = responseArr.filter{$0.Priority == "4"}
                        if (array.count > 0){
                            self.NotiPriorityArr.append(array.count)
                            self.NotiPriorityStr.append("Low".localized())
                            let low = UIColor(red: CGFloat(214.0/255.0), green: CGFloat(224.0/255.0), blue: CGFloat(61.0/255.0),        alpha: 1.0)
                            self.NotiColorCodeArray.append(low)
                        }
                        
                        DispatchQueue.main.async{
                            self.collectionView.reloadData()
                        }
                        
                    }else{
                        
                    }
                }else{
                    
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }

    }
    func getSupervisorData(){
        
        WoHeaderModel.getSuperVisorWorkorderList(){ (responseDict, error)  in
            if error == nil{
                self.supervisorArr.removeAll()
                self.supervisorStr.removeAll()
                self.supervisorColorCodeArray.removeAll()
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        var array = responseArr.filter{$0.Priority == "1"}
                        if (array.count > 0){
                            self.supervisorArr.append(array.count)
                            self.supervisorStr.append("Very_High".localized())
                            let veryhigh = UIColor(red: CGFloat(149.0/255.0), green: CGFloat(45.0/255.0), blue: CGFloat(152.0/255.0), alpha: 1.0)
                            self.supervisorColorCodeArray.append(veryhigh)
                        }
                        array = responseArr.filter{$0.Priority == "2"}
                        if (array.count > 0){
                            self.supervisorArr.append(array.count)
                            self.supervisorStr.append("High".localized())
                            let high = UIColor(red: CGFloat(227.0/255.0), green: CGFloat(114.0/255.0), blue: CGFloat(34.0/255.0), alpha: 1.0)
                            self.supervisorColorCodeArray.append(high)
                        }
                        array = responseArr.filter{$0.Priority == "3"}
                        if (array.count > 0){
                            self.supervisorArr.append(array.count)
                            self.supervisorStr.append("Medium".localized())
                            let medium = UIColor(red: CGFloat(28.0/255.0), green: CGFloat(190.0/255.0), blue: CGFloat(202.0/255.0), alpha: 1.0)
                            self.supervisorColorCodeArray.append(medium)
                        }
                        array = responseArr.filter{$0.Priority == "4"}
                        if (array.count > 0){
                            self.supervisorArr.append(array.count)
                            self.supervisorStr.append("Low".localized())
                            let low = UIColor(red: CGFloat(214.0/255.0), green: CGFloat(224.0/255.0), blue: CGFloat(61.0/255.0), alpha: 1.0)
                            self.supervisorColorCodeArray.append(low)
                        }
                        array = responseArr.filter{$0.Priority == ""}
                        if (array.count > 0){
                            self.supervisorArr.append(array.count)
                            self.supervisorStr.append("No Priority")
                            let low = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(0.0/255.0), alpha: 1.0)
                            self.supervisorColorCodeArray.append(low)
                        }
                        
                    }else{
                        
                    }
                    DispatchQueue.main.async{
                        self.collectionView.reloadData()
                    }
                }else{
                    
                }
                
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        
    }
    
    func createchartData(type:String,Priorityarr: Array<Int>,Prioritystr: Array<String>,chart:PieChartView){
        
        var entries = [PieChartDataEntry]()
        
        
        if Priorityarr.count != Prioritystr.count{
            return
        }
        
        if Priorityarr.count == Prioritystr.count {
            
            for i in 0..<Priorityarr.count{
                let entry = PieChartDataEntry()
                entry.x = Double(i)
                entry.y = Double(Priorityarr[i])
                
                entry.label = Prioritystr[i]
                entries.append( entry)
            }
            
        }
        
        let set = PieChartDataSet( entries: entries, label: " ")
        
        
        if chart.tag == 112{
            
            set.colors = self.NotiColorCodeArray
        }
        if chart.tag  == 111
        {
            set.colors = self.WoColorCodeArray
            
        }
        if chart.tag == 113
        {
            set.colors = self.supervisorColorCodeArray
        }

        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1.0
        pFormatter.percentSymbol = ""
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueTextColor(UIColor.white)
        data.setValueFont(UIFont(name: "HelveticaNeue-Bold", size: 14.0)!)
        DispatchQueue.main.async{
            chart.noDataText = "No_Data_Available".localized()
            chart.data = data
            chart.chartDescription?.enabled = false;
            chart.drawEntryLabelsEnabled = false
            chart.delegate = self
            chart.rotationEnabled = false
        }
        self.setupChartView(type:type,chart: chart)
    }
    func setupChartView(type:String,chart:PieChartView){
        
        var chartLegend = Legend()
        
        chartLegend = chart.legend
        
        chartLegend.horizontalAlignment = .left
        chartLegend.verticalAlignment = .bottom
        
        if DeviceType == iPad{
//            chartLegend.yOffset = 5.0
            chartLegend.xOffset = 5.0
            chartLegend.font = UIFont(name: "HelveticaNeue-Light", size: 11.0)!
        }else{
           // chartLegend.yOffset = 3.0
            chartLegend.xOffset = 5.0
            chartLegend.font = UIFont(name: "HelveticaNeue-Light", size: 8.0)!
        }

       
        chartLegend.wordWrapEnabled = true
        chartLegend.orientation = .vertical
        chartLegend.drawInside = false

       
    }
    @objc func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight){
        
        let tag = chartView.tag
        var priority = String()
        var priorityStr = String()
        
        let selectedPriorityArray = NSMutableArray()
        let selectedStatusArray = NSMutableArray()
        let selectedOrderTypeArray = NSMutableArray()
        let selectedWorkCenterArray = NSMutableArray()
        let plantArr = NSMutableArray()
        let controlkeyArr = NSMutableArray()
      
        
        
        if tag == 111 {
            
            //Workorder
            
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                priority = self.WoPriorityStr[Int(entry.x)]
                selectedStatusArray.add(priority)
            }else{
                priority = self.WoPriorityStr[Int(entry.x)]
                if priority == "Very_High".localized(){
                    priorityStr = "1"
                }else if priority == "High".localized(){
                    priorityStr = "2"
                }else if priority == "Medium".localized(){
                    priorityStr = "3"
                }else if priority == "Low".localized(){
                    priorityStr = "4"
                }
                selectedPriorityArray.add(priorityStr)
            }

        }else if tag == 112{
            //Notification
            priority = self.NotiPriorityStr[Int(entry.x)]
            if priority == "Very_High".localized(){
                priorityStr = "1"
            }else if priority == "High".localized(){
                priorityStr = "2"
            }else if priority == "Medium".localized(){
                priorityStr = "3"
            }else if priority == "Low".localized(){
                priorityStr = "4"
            }
            selectedPriorityArray.add(priorityStr)
        }else if tag == 113{
            //supervisor
            priority = self.supervisorStr[Int(entry.x)]
            if priority == "Very_High".localized(){
                priorityStr = "1"
            }else if priority == "High".localized(){
                priorityStr = "2"
            }else if priority == "Medium".localized(){
                priorityStr = "3"
            }else if priority == "Low".localized(){
                priorityStr = "4"
            }

            selectedPriorityArray.add(priorityStr)
        }
        
        
        if tag == 112 || tag == 111{
            
        let dict = NSMutableDictionary()
            
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        if tag == 112{
            currentMasterView = "Notification"
            let dict = NSMutableDictionary()
            dict.setValue(selectedPriorityArray, forKey: "Priority")
            dict.setValue(selectedStatusArray, forKey: "Status")
            dict.setValue(selectedOrderTypeArray, forKey: "OrderType")
            UserDefaults.standard.removeObject(forKey: "ListFilter")
            UserDefaults.standard.set(dict, forKey: "ListFilter")
        }else if tag == 111{
            currentMasterView = "WorkOrder"
            
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    dict.setValue(selectedStatusArray, forKey: "Status")
                    dict.setValue(plantArr, forKey: "Plant")
                    dict.setValue(selectedWorkCenterArray, forKey: "WorkCenter")
                    dict.setValue(controlkeyArr, forKey: "ControleKey")
                    
                }else{
                   dict.setValue(selectedPriorityArray, forKey: "Priority")
                   dict.setValue(selectedStatusArray, forKey: "Status")
                   dict.setValue(selectedOrderTypeArray, forKey: "OrderType")
                   dict.setValue(selectedWorkCenterArray, forKey: "WorkCenter")
                }
            if tag == 113{
                dict.setValue(NSMutableArray(), forKey: "TeamMember")
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                UserDefaults.standard.set(dict, forKey: "ListFilter")
                
            }else{
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                UserDefaults.standard.set(dict, forKey: "ListFilter")
            }
                
               
        }
        
            if DeviceType == iPad{
                menuDataModel.uniqueInstance.presentListSplitScreen()
            }else{
                
                let mainViewController = ScreenManager.getMasterListScreen()
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                
                let dashboard = ScreenManager.getDashBoardScreen()
                let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                nvc.isNavigationBarHidden = true
                myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                
                myAssetDataManager.uniqueInstance.navigationController = nvc
                myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                
                self.appDeli.window?.makeKeyAndVisible()
                
            }
  
        }else {
            let dict = NSMutableDictionary()
            
            let selectedTeamMemberArray = NSMutableArray()
            dict.setValue(selectedPriorityArray, forKey: "Priority")
            dict.setValue(selectedStatusArray, forKey: "Status")
            dict.setValue(selectedTeamMemberArray, forKey: "TeamMember")
            
            UserDefaults.standard.set(dict, forKey: "ListFilter")
        
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            currentMasterView = "Supervisor"
            if DeviceType == iPad{
                menuDataModel.uniqueInstance.presentSupervisorSplitScreen()
            }else{
                
                let mainViewController = ScreenManager.getSupervisorMasterListScreen()
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                
                let dashboard = ScreenManager.getDashBoardScreen()
                let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                nvc.isNavigationBarHidden = true
                myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                
                myAssetDataManager.uniqueInstance.navigationController = nvc
                myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                
                self.appDeli.window?.makeKeyAndVisible()
                
                
            }
            
    
        }

    }
    
    
    @IBAction func refreshButtonAction(_ sender: AnyObject) {
        
        mJCLogger.log("Refresh Button Tapped".localized(), Type: "")
        
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        
    }
    
    @IBAction func logoutButtonAction(_ sender: AnyObject) {
       
        mJCLogger.log("Logout Button Tapped".localized(), Type: "")

        myAssetDataManager.uniqueInstance.logOutApp()
        
    }
   
    //MARK:- CollectionView Delegate
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if DeviceType == iPad{
            return dashBoardArray.count
        }else{
            if isSupervisor == "X"{
                return 6
            }else{
                return 5
            }
            
        }
        
    }
 
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
//    {
//        DispatchQueue.main.async {
//            mJCLoader.stopAnimating()
//
//        }
//
//        var cell = DashboardCollectionViewCell()
//
//        if dashBoardArray[indexPath.row] == "DASH_WO_TILE" || dashBoardArray[indexPath.row] == "DASH_NOTI_TILE" {
//
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
//
//
//
//        }else if dashBoardArray[indexPath.row] == "DASH_SUP_TILE"{
//
//            if isSupervisor == "X"{
//
//                     cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
//
//
//            }else{
//                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
//                    cell.workOrderSearchBtn.isHidden = true
//
//
//
//            }
//
//        }else if dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE" || dashBoardArray[indexPath.row] == "DASH_ASSET_HIE_TILE" || dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"{
//
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
//            cell.workOrderSearchBtn.isHidden = true
//
//        }
//
//
////        if indexPath.row == 0 ||  indexPath.row == 1 {
////
////            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
////
////
////        }else if indexPath.row == 2{
////            if isSupervisor == "X"{
////               cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
////
////            }else{
////                 cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
////
//////                if DeviceType == iPad{
////                    cell.workOrderSearchBtn.isHidden = true
//////                }
////            }
////
////        }else{
////
////                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
//////                if DeviceType == iPad{
////                    cell.workOrderSearchBtn.isHidden = true
//////                }
////
////
////        }
//        cell.layer.cornerRadius = 4
//
//        cell.AddImage.layer.cornerRadius = 20
//
//        cell.addButton.tag = indexPath.row
//
//
//        if indexPath.row == 0
//        {
//            cell.TitleLabel.text = "Work Orders".localized()
//            cell.centerImage.image = UIImage(named: "wo.png")
//            cell.AddImage.isHidden = false
//            cell.bringSubviewToFront(cell.AddImage)
//            cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//            cell.addButton.isHidden = false
//
//                cell.pieChartView.tag = 111
//                cell.CenterButton.tag = indexPath.row
//                cell.CenterButton.addTarget(self, action: #selector(DashboardStyle1.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//                DispatchQueue.main.async{
//                    self.createchartData(type: "WoStatus", Priorityarr: self.WoPriorityArr, Prioritystr: self.WoPriorityStr, chart: cell.pieChartView)
//                }
//
//        }
//        else if indexPath.row == 1
//        {
//            cell.TitleLabel.text = "Notifications".localized()
//            cell.centerImage.image = UIImage(named: "notifi.png")
//            cell.AddImage.isHidden = false
//            cell.bringSubviewToFront(cell.AddImage)
//            cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//
//            cell.pieChartView.tag = 112
//            cell.CenterButton.tag = indexPath.row
//            cell.CenterButton.addTarget(self, action: #selector(DashboardStyle1.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//            DispatchQueue.main.async{
//            self.createchartData(type: "Notification", Priorityarr: self.NotiPriorityArr, Prioritystr: self.NotiPriorityStr, chart: cell.pieChartView)
//            }
//        }
//        else if indexPath.row == 2
//        {
//            if DeviceType == iPhone{
//                if isSupervisor == "X"{
//                    cell.TitleLabel.text = "Supervisor View".localized()
//                    cell.centerImage.image = UIImage(named: "sup.png")
////                    cell.AddImage.isHidden = true
//
//
//
//                    cell.pieChartView.tag = 113
//                    cell.CenterButton.tag = indexPath.row
//                    cell.CenterButton.addTarget(self, action: #selector(DashboardStyle1.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//                    DispatchQueue.main.async{
//                        self.createchartData(type: "Supervisor", Priorityarr: self.supervisorArr, Prioritystr: self.supervisorStr, chart: cell.pieChartView)
//                    }
//
//                    cell.addButton.isHidden = true
//                    cell.AddImage.isHidden = true
//
//                }else{
//                    cell.TitleLabel.text = "Time Sheet".localized()
//                    cell.centerImage.image = UIImage(named: "timesht.png")
//                    cell.AddImage.isHidden = false
//                    cell.bringSubviewToFront(cell.AddImage)
//                    cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//                }
//            }else{
//
//                if isSupervisor == "X"{
//                    cell.TitleLabel.text = "Supervisor View".localized()
//                    cell.centerImage.image = UIImage(named: "sup.png")
//                    cell.AddImage.isHidden = true
//                    cell.addButton.isHidden = true
//
//                    cell.pieChartView.tag = 113
//                    cell.CenterButton.tag = indexPath.row
//                    cell.CenterButton.addTarget(self, action: #selector(DashboardStyle1.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//                    DispatchQueue.main.async{
//                        self.createchartData(type: "Supervisor", Priorityarr: self.supervisorArr, Prioritystr: self.supervisorStr, chart: cell.pieChartView)
//                    }
//                }else{
//                      cell.TitleLabel.text = "Supervisor View".localized()
//                      cell.centerImage.image = UIImage(named: "sup.png")
//                      cell.addButton.isHidden = true
//                      cell.AddImage.isHidden = true
//
//                }
//            }
//
//
//        }
//        else if indexPath.row == 3
//        {
//            if DeviceType == iPhone{
//
//                if isSupervisor == "X"{
//                    cell.TitleLabel.text = "Time Sheet".localized()
//                    cell.centerImage.image = UIImage(named: "timesht.png")
////                    cell.AddImage.isHidden = false
//
//                    cell.bringSubviewToFront(cell.AddImage)
//                    cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//                }else{
//                    cell.TitleLabel.text = "Asset Map".localized()
//                    cell.centerImage.image = UIImage(named: "assetmap.png")
//                    cell.AddImage.isHidden = true
//                    cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//                }
//            }else{
//                cell.TitleLabel.text = "Time Sheet".localized()
//                cell.addButton.setImage(UIImage.init(named: "add_icon.png"), for: .normal)
//                cell.centerImage.image = UIImage(named: "timesht.png")
//                cell.workOrderSearchBtn.isHidden = true
//                cell.AddImage.isHidden = false
//                cell.bringSubviewToFront(cell.AddImage)
//                cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//
//            }
//
//        }
//        else if indexPath.row == 4
//        {
//
//            if DeviceType == iPad {
//
//                cell.TitleLabel.text = "Asset Map".localized()
//                cell.centerImage.image = UIImage(named: "assetmap.png")
//                cell.AddImage.isHidden = true
//  //            if DeviceType == iPad{
//                    cell.workOrderSearchBtn.isHidden = true
//  //            }
//
//                cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
//            }
//            else {
//
//                if isSupervisor == "X" {
//
//                    cell.TitleLabel.text = "Asset Map".localized()
//                    cell.centerImage.image = UIImage(named: "assetmap.png")
//                    cell.AddImage.isHidden = true
//                    cell.addButton.isHidden = true
//                    cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
//                    cell.workOrderSearchBtn.isHidden = true
//                    cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
//                    cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
//
//                }
//                else {
//
//                    cell.TitleLabel.text = "Search".localized()
//                    cell.centerImage.image = UIImage(named: "search_icon.png")
//                    cell.AddImage.isHidden = true
//                    cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
//                    cell.workOrderSearchBtn.isHidden = false
//                    cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
//                    cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
//
//                }
//
//
//                if DeviceType == iPad {
//
//                    cell.addButton.isHidden = false
//
//                }
//
//            }
//
//        }
//        else if indexPath.row == 5
//        {
//            cell.TitleLabel.text = "Search".localized()
//            cell.centerImage.image = UIImage(named: "search_icon.png")
//            cell.AddImage.isHidden = true
//            cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
//            cell.workOrderSearchBtn.isHidden = false
//            cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
//            cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
//
//            if DeviceType == iPad {
//
//                cell.addButton.isHidden = false
//
//            }
//
//        }
//
//        return cell
//
//    }
     public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
            DispatchQueue.main.async {
                mJCLoader.stopAnimating()

            }

            var cell = DashboardCollectionViewCell()

            if dashBoardArray[indexPath.row] == "DASH_WO_TILE" || dashBoardArray[indexPath.row] == "DASH_NOTI_TILE" {

                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell

            }else if dashBoardArray[indexPath.row] == "DASH_SUP_TILE"{

                if isSupervisor == "X"{

                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell

                }else{

                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
                    cell.workOrderSearchBtn.isHidden = true


                }

            }else if dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE" || dashBoardArray[indexPath.row] == "DASH_ASSET_HIE_TILE" || dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"{

                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
                cell.workOrderSearchBtn.isHidden = true

            }

            cell.layer.cornerRadius = 4

            cell.AddImage.layer.cornerRadius = 20

            cell.addButton.tag = indexPath.row


            if dashBoardArray[indexPath.row] == "DASH_WO_TILE"
            {
                cell.TitleLabel.text = "Work_Orders".localized()
                cell.centerImage.image = UIImage(named: "wo.png")
                cell.AddImage.isHidden = false
                cell.bringSubviewToFront(cell.AddImage)
                cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                cell.addButton.isHidden = false

                    cell.pieChartView.tag = 111
                    cell.CenterButton.tag = indexPath.row
                    cell.CenterButton.addTarget(self, action: #selector(DashboardStyle1.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                    DispatchQueue.main.async{
                        self.createchartData(type: "WoStatus", Priorityarr: self.WoPriorityArr, Prioritystr: self.WoPriorityStr, chart: cell.pieChartView)
                    }

            }
            else if dashBoardArray[indexPath.row] == "DASH_NOTI_TILE"
            {
                cell.TitleLabel.text = "Notifications".localized()
                cell.centerImage.image = UIImage(named: "notifi.png")
                cell.AddImage.isHidden = false
                cell.bringSubviewToFront(cell.AddImage)
                cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)

                cell.pieChartView.tag = 112
                cell.CenterButton.tag = indexPath.row
                cell.CenterButton.addTarget(self, action: #selector(DashboardStyle1.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                DispatchQueue.main.async{
                self.createchartData(type: "Notification", Priorityarr: self.NotiPriorityArr, Prioritystr: self.NotiPriorityStr, chart: cell.pieChartView)
                }
            }
            else if dashBoardArray[indexPath.row] == "DASH_SUP_TILE"
            {
                 if DeviceType == iPhone{

                    if isSupervisor == "X"{
                        cell.TitleLabel.text = "Supervisor_View".localized()
                        cell.centerImage.image = UIImage(named: "sup.png")
    //                    cell.AddImage.isHidden = true

                        cell.pieChartView.tag = 113
                        cell.CenterButton.tag = indexPath.row
                        cell.CenterButton.addTarget(self, action: #selector(DashboardStyle1.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                        DispatchQueue.main.async{
                            self.createchartData(type: "Supervisor", Priorityarr: self.supervisorArr, Prioritystr: self.supervisorStr, chart: cell.pieChartView)
                        }

                        cell.addButton.isHidden = true
                        cell.AddImage.isHidden = true

                    }else{
                        cell.TitleLabel.text = "Time_Sheet".localized()
                        cell.centerImage.image = UIImage(named: "timesht.png")
                        cell.AddImage.isHidden = false
                        cell.bringSubviewToFront(cell.AddImage)
                        cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                    }
                }else{

                    if isSupervisor == "X"{
                        cell.TitleLabel.text = "Supervisor_View".localized()
                        cell.centerImage.image = UIImage(named: "sup.png")
                        cell.AddImage.isHidden = true
                        cell.addButton.isHidden = true

                        cell.pieChartView.tag = 113
                        cell.CenterButton.tag = indexPath.row
                        cell.CenterButton.addTarget(self, action: #selector(DashboardStyle1.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                        DispatchQueue.main.async{
                            self.createchartData(type: "Supervisor", Priorityarr: self.supervisorArr, Prioritystr: self.supervisorStr, chart: cell.pieChartView)
                        }
                    }else{
                          cell.TitleLabel.text = "Supervisor_View".localized()
                          cell.centerImage.image = UIImage(named: "sup.png")
                          cell.addButton.isHidden = true
                          cell.AddImage.isHidden = true

                    }
                }


            }
            else if dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"
            {
                if DeviceType == iPhone{

                    if isSupervisor == "X"{
                        cell.TitleLabel.text = "Time_Sheet".localized()
                        cell.centerImage.image = UIImage(named: "timesht.png")
    //                    cell.AddImage.isHidden = false

                        cell.bringSubviewToFront(cell.AddImage)
                        cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                    }else{
                        cell.TitleLabel.text = "Asset_Map".localized()
                        cell.centerImage.image = UIImage(named: "assetmap.png")
                        cell.AddImage.isHidden = true
                        cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                    }
                }else{
                    cell.TitleLabel.text = "Time_Sheet".localized()
                    cell.addButton.setImage(UIImage.init(named: "add_icon.png"), for: .normal)
                    cell.centerImage.image = UIImage(named: "timesht.png")
                    cell.workOrderSearchBtn.isHidden = true
                    cell.AddImage.isHidden = false
                    cell.bringSubviewToFront(cell.AddImage)
                    cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)

                }

            }
            else if dashBoardArray[indexPath.row] == "DASH_ASSET_HIE_TILE"
            {

                if DeviceType == iPad {

                    cell.TitleLabel.text = "Asset_Map".localized()
                    cell.centerImage.image = UIImage(named: "assetmap.png")
                    cell.AddImage.isHidden = true
      //            if DeviceType == iPad{
                        cell.workOrderSearchBtn.isHidden = true
      //            }

                    cell.addButton.addTarget(self, action: #selector(DashboardStyle1.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                }
                else {

                    if isSupervisor == "X" {

                        cell.TitleLabel.text = "Asset_Map".localized()
                        cell.centerImage.image = UIImage(named: "assetmap.png")
                        cell.AddImage.isHidden = true
                        cell.addButton.isHidden = true
                        cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
                        cell.workOrderSearchBtn.isHidden = true
                        cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
                        cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)

                    }
                    else {

                        cell.TitleLabel.text = "Search".localized()
                        cell.centerImage.image = UIImage(named: "search_icon.png")
                        cell.AddImage.isHidden = true
                        cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
                        cell.workOrderSearchBtn.isHidden = false
                        cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
                        cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)

                    }


                    if DeviceType == iPad {

                        cell.addButton.isHidden = false

                    }

                }

            }
            else  if dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE"
            {
                cell.TitleLabel.text = "Search".localized()
                cell.centerImage.image = UIImage(named: "search_icon.png")
                cell.AddImage.isHidden = true
                cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
                cell.workOrderSearchBtn.isHidden = false
                cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
                cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)

                if DeviceType == iPad {

                    cell.addButton.isHidden = false

                }

            }

            return cell

        }
      public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        onlineSearch = Bool()

        if dashBoardArray[indexPath.row] == "DASH_WO_TILE"
        {
            
           
            selectedNotificationNumber = ""
            currentMasterView = "WorkOrder"
            UserDefaults.standard.removeObject(forKey: "ListFilter")
           
            if DeviceType == iPad{
                menuDataModel.uniqueInstance.presentListSplitScreen()
            }else{
                
                let mainViewController = ScreenManager.getMasterListScreen()
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                onlineSearch = false
                
               
                    let dashboard = ScreenManager.getDashBoardScreen()
                    let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                    nvc.isNavigationBarHidden = true
                    myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                    
                    myAssetDataManager.uniqueInstance.navigationController = nvc
                    myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                
                self.appDeli.window?.makeKeyAndVisible()
                
            }
     
        }
        else if dashBoardArray[indexPath.row] == "DASH_NOTI_TILE"
        {
            if DeviceType == iPad{
          
            
                selectedworkOrderNumber = ""
                selectedNotificationNumber = ""
                currentMasterView = "Notification"
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                menuDataModel.uniqueInstance.presentListSplitScreen()
            }else{
                onlineSearch = false
                
                currentMasterView = "Notification"
                let mainViewController = ScreenManager.getMasterListScreen()
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                
                    let dashboard = ScreenManager.getDashBoardScreen()
                    let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                    nvc.isNavigationBarHidden = true
                    myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                    
                    myAssetDataManager.uniqueInstance.navigationController = nvc
                    myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                
                self.appDeli.window?.makeKeyAndVisible()
            
            }

        }
        else if dashBoardArray[indexPath.row] == "DASH_SUP_TILE"
        {
            if isSupervisor == "X"{
                
                if DeviceType == iPad{
                    menuDataModel.uniqueInstance.presentSupervisorSplitScreen()
                }else{
                    let mainViewController = ScreenManager.getSupervisorMasterListScreen()
                    myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                     
                    let dashboard = ScreenManager.getDashBoardScreen()
                    let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                    nvc.isNavigationBarHidden = true
                    myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                    
                    myAssetDataManager.uniqueInstance.navigationController = nvc
                    myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                    myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                    self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                    
                    self.appDeli.window?.makeKeyAndVisible()
                    
                }
               
            }
            else{
                if DeviceType == iPad {
                    if isSupervisor == "X"{
                        menuDataModel.uniqueInstance.presentTimeSheetScreen()
                    }else{
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "User_is_not_Supervisor".localized(), button: okay)
                    }
      
                }
                else {
                    
                    let mainViewController = ScreenManager.getTimeSheetScreen()
                    myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                    
                    
                        let dashboard = ScreenManager.getDashBoardScreen()
                        let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                        nvc.isNavigationBarHidden = true
                        myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                        
                        myAssetDataManager.uniqueInstance.navigationController = nvc
                    myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                        myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                    myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                    self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                    
                    self.appDeli.window?.makeKeyAndVisible()
                    
                    
                }
            }
  
        }
        else if dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"
        {
            if isSupervisor == "X" {
          
                currentMasterView = "TimeSheet"
            
            if DeviceType == iPad {
                menuDataModel.uniqueInstance.presentTimeSheetScreen()
            }
            else {
                
                let mainViewController = ScreenManager.getTimeSheetScreen()
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                
                    let dashboard = ScreenManager.getDashBoardScreen()
                    let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                    nvc.isNavigationBarHidden = true
                    myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                    
                    myAssetDataManager.uniqueInstance.navigationController = nvc
                    myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                
                self.appDeli.window?.makeKeyAndVisible()
                
                
            }
            }else{
                ASSETMAP_TYPE = "ESRIMAP"
                
                if DeviceType == iPad{
                    if isSupervisor == "X" {
                       assetmapVC.openmappage(id: "")
                    }else{
                        menuDataModel.uniqueInstance.presentTimeSheetScreen()
                    }
                    
                }else{
                    currentMasterView = "WorkOrder"
                    selectedworkOrderNumber = ""
                    selectedNotificationNumber = ""
                    let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                    assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                    self.present(assetMapDeatilsVC, animated: true, completion: nil)
                    
                }
            }
  
        }
        else if dashBoardArray[indexPath.row] == "DASH_ASSET_HIE_TILE"
        {
             
            if DeviceType == iPad{
                ASSETMAP_TYPE = "ESRIMAP"
                 assetmapVC.openmappage(id: "")
            }else{
                
                
                if isSupervisor == "X" {
                    ASSETMAP_TYPE = "ESRIMAP"
                   currentMasterView = "WorkOrder"
                   selectedworkOrderNumber = ""
                   selectedNotificationNumber = ""
                   let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                   assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                   self.present(assetMapDeatilsVC, animated: true, completion: nil)
                }
            }

        } else if dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE"
        {

           
        }
    }
    
    @objc func searchWorkOrders(sender : UIButton){
        
        print("search WorkOrders")
        mJCLogger.log("search WorkOrders".localized(), Type: "")
        if demoModeEnabled == true{
            onlineSearch = false
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "We_have_limited_features_enabled_in_Demo_mode", button: okay)
        }else{
            DispatchQueue.main.async {
                onlineSearch = true
                let onlineSearchVC = ScreenManager.getOnlineSearchScreen()
                    searchType = "WorkOrders"
                onlineSearchVC.modalPresentationStyle = .fullScreen
                self.present(onlineSearchVC, animated: true) {}
            }
        }
    }
    
    @objc func searchNotifications(sender : UIButton){
        
        if DeviceType == iPad {
            
            if sender.tag == 5 {
                
                print("Search Notifications")
                mJCLogger.log("Search Notifications".localized(), Type: "")
                if demoModeEnabled == true{
                    onlineSearch = false
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "We_have_limited_features_enabled_in_Demo_mode", button: okay)
                }else{
                    DispatchQueue.main.async {
                        onlineSearch = true
                        let onlineSearchVC = ScreenManager.getOnlineSearchScreen()
                        searchType = "Notifications"
                        onlineSearchVC.modalPresentationStyle = .fullScreen
                        self.present(onlineSearchVC, animated: true) {}
                    }
                }
            }
            
        }
        else {
            
            if isSupervisor == "X" {
                
                if sender.tag == 5 {
                    
                    print("Search Notifications")
                    mJCLogger.log("Search Notifications".localized(), Type: "")
                    if demoModeEnabled == true{
                        onlineSearch = false
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "We_have_limited_features_enabled_in_Demo_mode", button: okay)
                    }else{
                        DispatchQueue.main.async {
                            onlineSearch = true
                            let onlineSearchVC = ScreenManager.getOnlineSearchScreen()
                            searchType = "Notifications"
                            onlineSearchVC.modalPresentationStyle = .fullScreen
                            self.present(onlineSearchVC, animated: true) {}
                        }
                    }
                                      
                }
            }
            else if sender.tag == 4 {
                
                print("Search Notifications")
                mJCLogger.log("Search Notifications".localized(), Type: "")
                if demoModeEnabled == true{
                    onlineSearch = false
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "We_have_limited_features_enabled_in_Demo_mode", button: okay)
                }else{
                    DispatchQueue.main.async {
                        onlineSearch = true
                        let onlineSearchVC = ScreenManager.getOnlineSearchScreen()
                        searchType = "Notifications"
                        onlineSearchVC.modalPresentationStyle = .fullScreen
                        self.present(onlineSearchVC, animated: true) {}
                    }
                }
            }
        }
        
        
    }
    
    //MARK:- Button Action Methods
    
    @objc func hierachyButtonTapped(sender : UIButton){
        print("hierachyButtonTapped")
        mJCLogger.log("hierachyButtonTapped".localized(), Type: "")
    }
    @objc func assetMapButtonTapped(sender : UIButton){
        menuDataModel.uniqueInstance.presentMapSplitScreen()
    }
     @objc func Centerbuttontapped(sender : UIButton) {
        
        if sender.tag == 0
        {
            
            if self.WoPriorityArr.count == 0 {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Work_Orders_not_found", button: okay)
                
                return
                
            }
           
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            currentMasterView = "WorkOrder"
            UserDefaults.standard.removeObject(forKey: "ListFilter")
            if DeviceType == iPad{
                menuDataModel.uniqueInstance.presentListSplitScreen()
            }else{
                
                let mainViewController = ScreenManager.getMasterListScreen()
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                
                  let dashboard = ScreenManager.getDashBoardScreen()
                    let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                    nvc.isNavigationBarHidden = true
                    myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                    
                    myAssetDataManager.uniqueInstance.navigationController = nvc
                myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                
                self.appDeli.window?.makeKeyAndVisible()
                
            }
           
        }
        else if sender.tag == 1
        {
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            currentMasterView = "Notification"
            
            UserDefaults.standard.removeObject(forKey: "ListFilter")
            if DeviceType == iPad{
                menuDataModel.uniqueInstance.presentListSplitScreen()
            }else{
                
                let mainViewController = ScreenManager.getMasterListScreen()
                myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                    let dashboard = ScreenManager.getDashBoardScreen()
                    let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                    nvc.isNavigationBarHidden = true
                    myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                    
                    myAssetDataManager.uniqueInstance.navigationController = nvc
                myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                
                self.appDeli.window?.makeKeyAndVisible()
                
            }
           
        }
        else if sender.tag == 2
        {
            if isSupervisor == "X"{
                
                selectedworkOrderNumber = ""
                selectedNotificationNumber = ""
                currentMasterView = "Supervisor"
                UserDefaults.standard.removeObject(forKey: "ListFilter")
                if DeviceType == iPad{
                    menuDataModel.uniqueInstance.presentSupervisorSplitScreen()
                }else{
                    let mainViewController = ScreenManager.getSupervisorMasterListScreen()
                    myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
                    
                    let dashboard = ScreenManager.getDashBoardScreen()
                    let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
                    nvc.isNavigationBarHidden = true
                    myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
                    
                    myAssetDataManager.uniqueInstance.navigationController = nvc
                myAssetDataManager.uniqueInstance.navigationController?.addChild(mainViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
                    myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
                    myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
                    self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
                    
                    self.appDeli.window?.makeKeyAndVisible()
                
                }
                
             
            }
            else{
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "User_is_not_Supervisor", button: okay)
            }
            
        }
        
    }

    @objc func Addbuttontapped(sender : UIButton) {
        
        if sender.tag == 0
        {
            menuDataModel.presentCreateWorkorderScreen(vc: self, isScreen: "WorkOrder", delegateVC: self)
        }else if sender.tag == 1{
            menuDataModel.presentCreateJobScreen(vc: self, delegate: true)
        }else if sender.tag == 2{
            menuDataModel.presentCreateTimeSheetScreen(vc: self, isFromScrn: "AddTimeSheet")
        }else if sender.tag == 3{
            menuDataModel.presentCreateTimeSheetScreen(vc: self, isFromScrn: "AddTimeSheet")
        }
    }
    
   
    //MARK:- Show@objc  Alert..
    
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLoader.stopAnimating()
        print("Store Flush And Refresh Done..")
        
         if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            self.getOperationData()
         }else{
           self.getWorkorderData()
        }
        self.getNotificationData()
        self.getSupervisorData()
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }
        mJCLogger.log("Store Flush And Refresh Done..".localized(), Type: "")
        
    }
    //Set form Bg sync started..
    @objc func backGroundSyncStarted(notification : NSNotification) {
           if DeviceType == iPad{
             self.refreshButton.showSpin()
           }
    }


    //MARK:- CustomNavigation Delegate iPhone
    func leftMenuButtonClicked(_ sender: UIButton?){
        openLeft()
    }
    
    func NewJobButtonClicked(_ sender: UIButton?){
        menuDataModel.presentCreateJobScreen(vc: self, delegate: true)
    }
    
    func refreshButtonClicked(_ sender: UIButton?){
        self.refreshButtonAction(sender!)
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        
        let dashboard = ScreenManager.getDashBoardScreen()
        let nvc: UINavigationController = UINavigationController(rootViewController: dashboard)
        nvc.isNavigationBarHidden = true
        myAssetDataManager.uniqueInstance.leftViewController.mainViewController = nvc
        
        myAssetDataManager.uniqueInstance.navigationController = nvc
        
        self.logoutButtonAction(sender!)
        
    }

    func backButtonClicked(_ sender: UIButton?){
        
    }

}
extension DashboardStyle1: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "\(Int(value))"
    }
}
