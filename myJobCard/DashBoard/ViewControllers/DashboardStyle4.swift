//
//  DashboardStyle3.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/05/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class DashboardStyle4: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,ChartViewDelegate,CustomNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,CreateUpdateDelegate{
   
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var userTitlelabel: UILabel!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var logoutButton: UIButton!
    
    @IBOutlet var workOrderFilterButton: UIButton!
    @IBOutlet var notificationFilterButton: UIButton!
    @IBOutlet var supervisorFilterButton: UIButton!
    @IBOutlet var timeSheetFilterButton: UIButton!

    @IBOutlet var firstDropDownTxtField: UITextField!
    @IBOutlet var secondDropDownTxtField: UITextField!
    @IBOutlet var thirdDropDownTxtField: UITextField!
    @IBOutlet var fourthDropDownTxtField: UITextField!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var activeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var TotalLabel: UILabel!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var colourView: UIView!
    
    @IBOutlet weak var filterCriteriaLabel: UILabel!
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var newpieChartView: PieChartView!
    @IBOutlet weak var filterCountView: UIView!
    
    @IBOutlet weak var woNoTitleLabel: UILabel!
    @IBOutlet weak var filterSegment: UISegmentedControl!
    
    @IBOutlet weak var colectionMenuView: UIView!
    
    @IBOutlet weak var tableWOtitleLabel: UILabel!
    @IBOutlet weak var tableTechView: UIView!
    @IBOutlet weak var tableTechButton: UIButton!
    
    @IBOutlet weak var techViewWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var completedWoPieChart: PieChartView!
    
    @IBOutlet weak var totalMaintenanceWoLabel: UILabel!
    
    @IBOutlet weak var horizonatalchartView: UIView!
    
    @IBOutlet weak var completionText: UILabel!
    @IBOutlet weak var horizonatalchart: LinearProgressBar!
    @IBOutlet weak var statusCollectionView: UICollectionView!
    
    var filterTitle = String()
    let menudropDown = DropDown()
    let multiDropDown = DropDown()
    var menuarr = [String]()
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
    var priorityListArray = NSMutableArray()
    var workCentersListArray = [String]()
    var MainActivityTypeArray = NSMutableArray()
    weak var valueFormatter: IValueFormatter?
    
    var cellTapped  = Bool()
    var currentRow = Int()

    let dropDown = DropDown()
    var dropDownSelectString = String()
  
    
    var WorkOrderArray = Array<WoHeaderModel>()
    var NotificationArray = Array<NotificationModel>()
    var SupervisorArray = Array<WoHeaderModel>()
    var FilterDict : [String: String] = [:]
    var FirstDropDownArr = Array<String>()
    var SecondDropDownArr = Array<String>()
    var ThirdDropDownArr = Array<String>()
    var FourthDropDownArr = Array<String>()
    var userStatusListArr = Array<String>()
    var userStatusArr = Array<StatusCategoryModel>()
    var selectedChartArr = Array<Any>()
    var finalFiltervalues : [String: Array<Any>] = [:]
    var dateDropArray = ["Planned_For_Tomorrow".localized(),"Planned_for_Next_Week".localized(),"Overdue_For_Last_2_days".localized(),"Overdue_for_a_Week".localized(),"All_Overdue".localized()]
    var WoFilterArray = ["Priority".localized(),"User_Status".localized(),"WorkCenter".localized(),"Mant.Activity_Type".localized(),"Date".localized()]
    var NoFilterArray = ["Priority".localized(),"User_Status".localized(),"WorkCenter".localized(),"Work_order_Conversion".localized(),"Date".localized()]
    
    var typeArray = ["Assigned_To_Me".localized(),"Created_By_Me".localized()]
    var colorArray = ["#f68b1f","#0083ca","#72bf44","#FFCDD2","#ab218e","#b21212","#FFECB3","#004990","#008a3b","#f68b1f","#52247f","#cb4d2c","#f0ab00","#00a1e4","#808080","#b2b2b2"]
    var dashBoardArray = ["DASH_ASSET_HIE_TILE","ASSET_HIERARCHY","DASH_TIMESHEET_TILE","DASH_GENERAL_FORM_TILE","DASH_ONLINE_SEARCH_TILE"]
    //Count
    var confirmOperationList = Array<String>()
    var OperationArr = Array<WoOperationModel>()
    var woAttachmentArr = Array<AttachmentModel>()
    var woUploadAttachmentArr = Array<UploadedAttachmentsModel>()
    var ComponentArr = Array<WoComponentModel>()
    var formsAssignArray = Array<FormAssignDataModel>()
    var mendatoryFormCount = Int()
    var formsResponseArr = Array<FormResponseCaptureModel>()
    var NoUploadAttachmentArr = Array<UploadedAttachmentsModel>()
    var NoAttachmentArr = Array<AttachmentModel>()
    var finalpoints = Array<MeasurementPointModel>()
    var currentpoints = Array<MeasurementPointModel>()
    var NoCompIdArr = [String]()
    var filterObject =  Dictionary<String, [WoHeaderModel]>()
    var filterTitleArray = [String]()
    var filterArray = [WoHeaderModel]()
    var filterSelectedIndex = Int()
    var techciandict = NSMutableDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if isSupervisor == "X"{
            self.getTechnicianName()
        }else{
            self.getWorkorderData(from: "")
        }
       // if isSupervisor == "X"{
            dashBoardArray.append("ODS_MYPLANNER")
      //  }
        self.userTitlelabel.text = userDisplayName + " (\(Role_ID)) "
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DashboardStyle3.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DashboardStyle3.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        isSupervisor = "X"
        if isSupervisor == "X"{
            self.tableTechView.isHidden = false
            self.techViewWidthConstant.constant = 130.0
        }else{
            self.tableTechView.isHidden = true
            self.techViewWidthConstant.constant = 0
        }
        ScreenManager.registerDBStyle4ListCell(tableView: self.detailsTableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true{
            if DeviceType == iPad{
                self.refreshButton.showSpin()
            }
        }
    }
    func EntityCreated(){
        if currentMasterView == "WorkOrder"{
            self.getWorkorderData(from: "")
        }else if currentMasterView == "Notification"{
            self.GetNotificationData()
        }
    }
    func getWorkorderData(from:String){
        
        var defineQuery = String()
        var headerSet = String()
        if from == "Super"{
          
            WoHeaderModel.getSuperVisorWorkorderList(){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                        if responseArr.count > 0 {
                            self.WorkOrderArray.removeAll()
                            self.WorkOrderArray = responseArr
                            self.getCompletedWorkorder(from: "Today")
                        }else{
                            self.applyCustomeFilter()
                        }
                    }else{
                        self.applyCustomeFilter()
                    }
                }else{
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
            
        }else{
            headerSet = "WoHeaderSet"
            defineQuery = "WoHeaderSet?$orderby=CreatedOn,Priority,WorkOrderNum asc"
            WoHeaderModel.getWorkorderList(){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                        if responseArr.count > 0 {
                            self.WorkOrderArray.removeAll()
                            self.WorkOrderArray = responseArr
                            self.getCompletedWorkorder(from: "Today")
                        }else{
                            self.applyCustomeFilter()
                        }
                    }else{
                        self.applyCustomeFilter()
                    }
                }else{
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
       
    }
    
    func getCompletedWorkorder(from:String){
        
        if from == "Today"{
            
            let filterdate = ODSDateHelper.getDateFromString(dateString:  Date().toString(format: .custom(localDateFormate)) , dateFormat: localDateFormate)
            
            let namePredicate = NSPredicate(format: "SELF.SchdFnshDate == %@",filterdate as CVarArg);
            let namePredicate1 = NSPredicate(format: "SELF.TechCompletionDate == %@ and SELF.UserStatus == %@",filterdate as CVarArg,"COMP");
            let workorderfortoday = self.WorkOrderArray.filter{ namePredicate.evaluate(with: $0)}
            let todaycompletedwoarry = self.WorkOrderArray.filter{namePredicate1.evaluate(with: $0)}
             
            DispatchQueue.main.async{
                if workorderfortoday.count > 0{
                    self.horizonatalchart.isHidden = false
                    let percent = (todaycompletedwoarry.count * 100) / workorderfortoday.count
                    self.horizonatalchart.progressValue = 30.0
                    self.horizonatalchart.capType = 1
                    self.totalMaintenanceWoLabel.text = "Today's completed Work orders : 30%"
                    self.completionText.isHidden = true
                }else{
                    self.horizonatalchart.isHidden = true
                    self.completionText.isHidden = false
                    self.totalMaintenanceWoLabel.text = "Today's completed Work orders : 0 %"
                }
                self.horizonatalchart.isHidden = false
              //  let percent = (todaycompletedwoarry.count * 100) / workorderfortoday.count
                self.horizonatalchart.progressValue = 30.0
                self.horizonatalchart.capType = 1
                self.totalMaintenanceWoLabel.text = "Today's completed Work orders : 30%"
                self.completionText.isHidden = true
            }
            
         
        }else if from == "Overall"{
            
            let namePredicate = NSPredicate(format: "SELF.UserStatus == %@","COMP");
            let completedArray = self.WorkOrderArray.filter{namePredicate.evaluate(with: $0)}
             
            DispatchQueue.main.async{
                if self.WorkOrderArray.count > 0{
                    self.horizonatalchart.isHidden = false
                    let percent = (completedArray.count * 100) / self.WorkOrderArray.count
                    self.horizonatalchart.progressValue = CGFloat(percent)
                    self.horizonatalchart.capType = 1
                    self.totalMaintenanceWoLabel.text = "Overall completed Work orders : \(percent)%"
                    self.completionText.isHidden = true
                }else{
                    self.horizonatalchart.isHidden = true
                    self.completionText.isHidden = false
                    self.totalMaintenanceWoLabel.text = "Today's completed Work orders : 0 %"
                }
            }
                
        }else{
            self.horizonatalchart.isHidden = true
            self.completionText.isHidden = false
            self.totalMaintenanceWoLabel.text = "Today's completed Work orders : 0 %"
            
        }
 
    }
    
    func createCompletedchartData(Countarr: Array<Int>,Legendstr: Array<String>,ColorArr: Array<UIColor>,chart:PieChartView){
              
        var entries = [PieChartDataEntry]()
            if Countarr.count != Legendstr.count{
                  return
            }
            if Countarr.count == Legendstr.count {
                for i in 0..<Countarr.count{
                      let entry = PieChartDataEntry()
                      entry.x = Double(i)
                      entry.y = Double(Countarr[i])
                      entry.label = Legendstr[i]
                      entry.data = Legendstr[i]
                      entries.append( entry)
                  }
              }
        let set = PieChartDataSet( entries: entries, label: " ")
            set.colors = ColorArr
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
            
            chart.noDataText = "Data not available"
            chart.data = data
            chart.chartDescription?.enabled = false;
            chart.drawEntryLabelsEnabled = false
            chart.delegate = self
            chart.rotationEnabled = false
            if Countarr.count > 0{
               
            }else{
                chart.clear()
            }
            
        }
        self.setupChartView(chart: chart)
    }

    func GetNotificationData(){
        
        NotificationModel.getNotificationList(){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationModel]{
                    if responseArr.count > 0 {
                        self.NotificationArray = responseArr
                        DispatchQueue.main.async{
                            if self.FirstDropDownArr.count > 0{
                                self.firstDropDownTxtField.text = self.FirstDropDownArr[0]
                                var arr = self.FirstDropDownArr
                                arr.remove(at:0)
                                self.SecondDropDownArr = arr
                                self.FilterDict["First"] = "Priority".localized()
                                self.FilterDict["Second"] = "User_Status".localized()
                                self.setPriority()
                                self.secondDropDownTxtField.text = "User_Status".localized().localized()
                                self.finalFiltervalues.removeAll()
                                self.ApplyDashBoardFilter()
                                DispatchQueue.main.async{
                                    self.detailsTableView.reloadData()
                                }
                            }
                        }
                    }else{
                        DispatchQueue.main.async{
                            if self.FirstDropDownArr.count > 0{
                                self.firstDropDownTxtField.text = self.FirstDropDownArr[0]
                                let arr = self.FirstDropDownArr
                                self.SecondDropDownArr = arr
                                self.FilterDict["First"] = "Priority".localized()
                                self.FilterDict["Second"] = "User_Status".localized()
                                self.setPriority()
                                self.secondDropDownTxtField.text = "User_Status".localized().localized()
                                self.finalFiltervalues.removeAll()
                                self.ApplyDashBoardFilter()
                            }
                            
                        }
                    }
                }else{
                    DispatchQueue.main.async{
                        if self.FirstDropDownArr.count > 0{
                            self.firstDropDownTxtField.text = self.FirstDropDownArr[0]
                            let arr = self.FirstDropDownArr
                            self.SecondDropDownArr = arr
                            self.FilterDict["First"] = "Priority".localized()
                            self.FilterDict["Second"] = "User_Status".localized()
                            self.setPriority()
                            self.secondDropDownTxtField.text = "User_Status".localized().localized()
                            self.finalFiltervalues.removeAll()
                            self.ApplyDashBoardFilter()
                        }
                        
                    }
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        
    }
    func getOperationData()
    {
        WoPriorityArr.removeAll()
        WoPriorityStr.removeAll()
        WoColorCodeArray.removeAll()
        let colorArr = [UIColor.red,UIColor.green,UIColor.black,UIColor.purple,UIColor.yellow,UIColor.gray,UIColor.blue,UIColor.lightGray,UIColor.cyan,UIColor.darkGray,UIColor.darkGray]
        let statusArr = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: WORKORDER_ASSIGNMENT_TYPE, ObjectType: "X")
        if statusArr.count > 0{
            for i in 0..<statusArr.count{
                let statclass = statusArr[i]
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
    @IBAction func ApplyFilter(_ sender: Any) {
        
        self.newpieChartView.clear()
        if let header = FilterDict["Header"]{
            if header == ""{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please select header", button: okay)
                return
            }
        }
        if let first = FilterDict["First"]{
            
            if first != "" ||  first != selectStr{
                if let third = FilterDict["Third"]{
                    if third == "" || third == selectStr{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please select \(first) filter", button: okay)
                        return
                    }
                }else{
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please select \(first) filter", button: okay)
                    return
                }
            }
        }
        if let second = FilterDict["Second"]{
            
            if second != "" ||  second != selectStr{
                if let fourth = FilterDict["Fourth"]{
                    if (fourth == "" || fourth == selectStr) {
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please select \(second) filter", button: okay)
                        return
                    }
                }
            }
        }
        
        self.finalFiltervalues.removeAll()
        self.ApplyDashBoardFilter()
        
    }

    @IBAction func resetButtonAction(_ sender: Any) {
        if applicationFeatureArrayKeys.contains("DASH_WO_TILE"){
            workOrderFilterButton.isHidden = false
            workOrderFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
            notificationFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            supervisorFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            
            FilterDict["Header"] = "WorkOrder"
            FirstDropDownArr = WoFilterArray
            self.workOrderFilterButton.backgroundColor = UIColor.init(red: 212.0/255.0, green: 227.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.notificationFilterButton.backgroundColor = UIColor.clear
            self.supervisorFilterButton.backgroundColor = UIColor.clear
            
            if applicationFeatureArrayKeys.contains("WO_LIST_NEW_WO_OPTION"){
                self.addButton.isHidden = false
            }else{
                self.addButton.isHidden = true
            }
            self.FilterDict["First"] = "Priority".localized()
            self.FilterDict["Second"] = "User_Status".localized()
            self.setPriority()
            self.ApplyDashBoardFilter()
        }else{
            workOrderFilterButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("DASH_NOTI_TILE"){
            workOrderFilterButton.isHidden = false
            if let _ = FilterDict["Header"]{
            }else{
                notificationFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
                workOrderFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
                supervisorFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
                
                FilterDict["Header"] = "Notification"
                FirstDropDownArr = NoFilterArray
                self.workOrderFilterButton.backgroundColor = UIColor.clear
                self.notificationFilterButton.backgroundColor = UIColor.init(red: 212.0/255.0, green: 227.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                self.supervisorFilterButton.backgroundColor = UIColor.clear
                if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
                    self.addButton.isHidden = false
                }else{
                    self.addButton.isHidden = true
                }
                self.FilterDict["First"] = "Priority".localized()
                self.FilterDict["Second"] = "User_Status".localized()
                self.setPriority()
                self.ApplyDashBoardFilter()
            }
        }else{
            notificationFilterButton.isHidden = true
        }
        if applicationFeatureArrayKeys.contains("DASH_SUP_TILE"){
            workOrderFilterButton.isHidden = false
            if let _ = FilterDict["Header"]{
            }else{
                supervisorFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
                notificationFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
                workOrderFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
                FilterDict["Header"] = "Supervisor"
                FirstDropDownArr = ["Priority".localized(),"User_Status".localized(),"WorkCenter".localized(),"Date".localized(),"PersonNo"]
                self.workOrderFilterButton.backgroundColor = UIColor.clear
                self.notificationFilterButton.backgroundColor = UIColor.clear
                self.supervisorFilterButton.backgroundColor = dbfilterBgColor
                self.addButton.isHidden = true
            }
             
        }else{
            supervisorFilterButton.isHidden = true
        }
        
    }
    func applyCustomeFilter(){
         
        let UserStatusArr = self.WorkOrderArray.unique{$0.UserStatus}
             for pr in UserStatusArr{
                 if pr.UserStatus != ""{
                      self.userStatusListArr.append(pr.UserStatus)
                 }
             }
        
       
        for item in self.userStatusListArr{
            let filterarray = self.WorkOrderArray.filter{$0.UserStatus == item}
            self.filterObject[item] = filterarray
        }
        self.filterTitleArray.removeAll()
        self.filterObject["All"] = self.WorkOrderArray
        
        self.filterTitleArray.append("All")
        
        for i in self.userStatusListArr{
            if self.userStatusListArr.contains("MOBI") && !self.filterTitleArray.contains("MOBI"){
                self.filterTitleArray.append("MOBI")
            }else if self.userStatusListArr.contains("ACCP") && !self.filterTitleArray.contains("ACCP"){
                self.filterTitleArray.append("ACCP")
            }else if self.userStatusListArr.contains("ENRT") && !self.filterTitleArray.contains("ENRT"){
                self.filterTitleArray.append("ENRT")
            }else if self.userStatusListArr.contains("ARRI") && !self.filterTitleArray.contains("ARRI"){
                self.filterTitleArray.append("ARRI")
            }else if self.userStatusListArr.contains("STRT") && !self.filterTitleArray.contains("STRT"){
                self.filterTitleArray.append("STRT")
            }else if self.userStatusListArr.contains("HOLD") && !self.filterTitleArray.contains("HOLD"){
                self.filterTitleArray.append("HOLD")
            }else if self.userStatusListArr.contains("SUSP") && !self.filterTitleArray.contains("SUSP"){
                self.filterTitleArray.append("SUSP")
            }else if self.userStatusListArr.contains("COMP") && !self.filterTitleArray.contains("COMP"){
                self.filterTitleArray.append("COMP")
            }else if self.userStatusListArr.contains("TRNS") && !self.filterTitleArray.contains("TRNS"){
                self.filterTitleArray.append("TRNS")
            }
        }
        
        filterSelectedIndex = 0
        DispatchQueue.main.async {
            self.filterArray.removeAll()
            self.filterArray = self.filterObject["All"]!
            self.detailsTableView.reloadData()
            self.statusCollectionView.reloadData()
        }
    }
    func sortWithKeys(_ dict: [String: Any]) -> [String: Any] {
        let sorted = dict.sorted(by: { $0.key < $1.key })
        var newDict: [String: Any] = [:]
        for sortedDict in sorted {
            newDict[sortedDict.key] = sortedDict.value
        }
        return newDict
    }
    func ApplyDashBoardFilter(){
        
        if let header = FilterDict["Header"]{
           var firstFilterItem = String()
           var secondFilterItem = String()
           var thirdFilterArr = Array<String>()
           var fourthFilterArr = Array<String>()
                
            if let first = FilterDict["First"]{
                
                if first == "Priority".localized(){
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = "Priority".localized()
                    }
                }else if first == "WorkCenter".localized(){
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = "WorkCenter".localized()
                    }
                }else if first == "User_Status".localized(){
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = "User_Status".localized()
                    }
                }else if first == "Date".localized(){
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = "Date".localized()
                    }
                }else if first == "Mant.Activity_Type".localized(){
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = "Mant.Activity_Type".localized()
                    }
                }else if first == "Work_order_Conversion".localized(){
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = "Work_order_Conversion".localized()
                    }
                }else if first == "Created_or_Assigned".localized(){
                    if let arr = FilterDict["Third"]?.components(separatedBy: ";"){
                        thirdFilterArr = arr
                        firstFilterItem = "Created_or_Assigned".localized()
                    }
                }
                if thirdFilterArr.last == ""{
                    thirdFilterArr.removeLast()
                }
            }
            if let second = FilterDict["Second"]{
                if second == "Priority".localized(){
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = "Priority".localized()
                    }
                }else if second == "WorkCenter".localized(){
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = "WorkCenter".localized()
                    }
                }else if second == "User_Status".localized(){
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = "User_Status".localized()
                    }
                }else if second == "Date".localized(){
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = "Date".localized()
                    }
                }else if second == "Mant.Activity_Type".localized(){
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = "Mant.Activity_Type".localized()
                    }
                }else if second == "Work_order_Conversion".localized(){
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = "Work_order_Conversion".localized()
                    }
                }else if second == "Created_or_Assigned".localized(){
                    if let arr = FilterDict["Fourth"]?.components(separatedBy: ";"){
                        fourthFilterArr = arr
                        secondFilterItem = "Created_or_Assigned".localized()
                    }
                }
                
                if fourthFilterArr.last == ""{
                    fourthFilterArr.removeLast()
                }
            }
            if header == "WorkOrder"{
                
                if thirdFilterArr.count > 0 && fourthFilterArr.count > 0{
                 
                    var countarr = Array<Int>()
                    var colorArr = Array<UIColor>()
                    var legendArr = Array<String>()
                    
                    for thirdFilterItem in thirdFilterArr{
                       
                        for fourthFilterItem in fourthFilterArr{
                            
                            if firstFilterItem == "Priority".localized(){
                                
                                let prioritycls = globalPriorityArray.filter{ $0.PriorityText == thirdFilterItem}
                                
                                if secondFilterItem == "User_Status".localized(){
                                    
                                    let filterarray = WorkOrderArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.UserStatus == "\(fourthFilterItem)"}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                        finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                       
                                    let filterarray = WorkOrderArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                        finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else  if secondFilterItem == "Mant.Activity_Type".localized(){
                                       
                                    let filterarray = WorkOrderArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                        finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "Created_or_Assigned".localized(){
                                    if fourthFilterItem == "Assigned_To_Me".localized(){
                                        let filterarray = WorkOrderArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.PersonResponsible == "\(userPersonnelNo)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                            finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }else if fourthFilterItem == "Created_By_Me".localized(){
                                        let filterarray = WorkOrderArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.EnteredBy == "\(userDisplayName)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                            finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }
                                }
                                else if secondFilterItem == "Date".localized(){
                                    
                                    if fourthFilterItem == "Planned_For_Tomorrow".localized(){
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let  filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.Priority == %@ and SELF.BasicStrtDate == %@", prioritycls[0].Priority,filterdate as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(prioritycls[0].PriorityText) - PFT")
                                                finalFiltervalues["\(prioritycls[0].PriorityText) - PFT"] = filterarray
                                            }
                                    }else if fourthFilterItem == "Planned_for_Next_Week".localized(){
                                           
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                       
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        
                                        let namePredicate = NSPredicate(format: "SELF.Priority == %@ and (SELF.BasicStrtDate >= %@ and SELF.BasicStrtDate <= %@)", prioritycls[0].Priority,filterdate1 as CVarArg,filterdate2 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(prioritycls[0].PriorityText) - PFNW")
                                                finalFiltervalues["\(prioritycls[0].PriorityText) - PFNW"] = filterarray
                                            }
                                        }else if fourthFilterItem == "Overdue_For_Last_2_days".localized(){
                                            
                                            let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                            let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                            let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let namePredicate = NSPredicate(format: "SELF.Priority == %@ and (SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)", prioritycls[0].Priority,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                            let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                               if (filterarray.count > 0){
                                                   countarr.append(filterarray.count)
                                                   colorArr.append(self.setColor(count: colorArr.count))
                                                   legendArr.append("\(prioritycls[0].PriorityText) - ODFT")
                                                   finalFiltervalues["\(prioritycls[0].PriorityText) - ODFT"] = filterarray
                                               }
                                        }else if fourthFilterItem == "Overdue_for_a_Week".localized(){
                                           
                                            let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                            let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                            let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let namePredicate = NSPredicate(format: "SELF.Priority == %@ and (SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)", prioritycls[0].Priority,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                            let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                   countarr.append(filterarray.count)
                                                   colorArr.append(self.setColor(count: colorArr.count))
                                                   legendArr.append("\(prioritycls[0].PriorityText) - ODW")
                                                   finalFiltervalues["\(prioritycls[0].PriorityText) - ODW"] = filterarray
                                            }
                                        }else if fourthFilterItem == "All_Overdue".localized(){
                                            let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                            let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    
                                            let namePredicate = NSPredicate(format: "SELF.Priority == %@ and SELF.BasicFnshDate < %@", prioritycls[0].Priority,filterdate1 as CVarArg);
                                            let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(prioritycls[0].PriorityText) - All Overdue")
                                                finalFiltervalues["\(prioritycls[0].PriorityText) - All Overdue"] = filterarray
                                            }
                                        }
                                    }
                            }else if firstFilterItem == "User_Status".localized(){
                                
                                if secondFilterItem == "Priority".localized(){
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    let filterarray = WorkOrderArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.UserStatus == "\(thirdFilterItem)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(prioritycls[0].PriorityText)")
                                        }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                        
                                    let filterarray = WorkOrderArray.filter{ $0.UserStatus == "\(thirdFilterItem)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                                        if (filterarray.count > 0){
                                             countarr.append(filterarray.count)
                                             colorArr.append(self.setColor(count: colorArr.count))
                                             legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                             finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                         }
                                }else if secondFilterItem == "Mant.Activity_Type".localized(){
                                    
                                    let filterarray = WorkOrderArray.filter{ $0.UserStatus == "\(thirdFilterItem)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                                        if (filterarray.count > 0){
                                             countarr.append(filterarray.count)
                                             colorArr.append(self.setColor(count: colorArr.count))
                                             legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                             finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                         }
                                }else if secondFilterItem == "Created_or_Assigned".localized(){
                                        if fourthFilterItem == "Assigned_To_Me".localized(){
                                        let filterarray = WorkOrderArray.filter{ $0.UserStatus == "\(thirdFilterItem)" && $0.PersonResponsible == "\(userPersonnelNo)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                            finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }else if fourthFilterItem == "Created_By_Me".localized(){
                                        let filterarray = WorkOrderArray.filter{ $0.UserStatus == "\(thirdFilterItem)" && $0.EnteredBy == "\(userDisplayName)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                            finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }
                                }else if secondFilterItem == "Date".localized(){
                                                                        
                                    if fourthFilterItem == "Planned_For_Tomorrow".localized(){
                                        
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                       
                                        let filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and SELF.BasicStrtDate == %@",thirdFilterItem,filterdate as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - PFT")
                                                finalFiltervalues["\(thirdFilterItem) - PFT"] = filterarray
                                            }
                                    }else if fourthFilterItem == "Planned_for_Next_Week".localized(){
                                        
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and (SELF.BasicStrtDate >= %@ and SELF.BasicStrtDate <= %@)", thirdFilterItem,filterdate1 as CVarArg,filterdate2 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - PFNW")
                                                finalFiltervalues["\(thirdFilterItem) - PFNW"] = filterarray
                                             }
                                    }else if fourthFilterItem == "Overdue_For_Last_2_days".localized(){
                                         
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and (SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)", thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - ODFT")
                                                finalFiltervalues["\(thirdFilterItem) - ODFT"] = filterarray
                                             }
                                    }else if fourthFilterItem == "Overdue_for_a_Week".localized(){
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and (SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)", thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - ODW")
                                                finalFiltervalues["\(thirdFilterItem) - ODW"] = filterarray
                                             }
                                    }else if fourthFilterItem == "All_Overdue".localized(){
                                       
                                         let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                       
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and SELF.BasicFnshDate < %@", thirdFilterItem,filterdate1 as CVarArg);
                                            let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                          if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - All Overdue")
                                                finalFiltervalues["\(thirdFilterItem) - All Overdue"] = filterarray
                                         }
                                     }
                                 }
                            }else if firstFilterItem == "WorkCenter".localized(){
                                    
                                if secondFilterItem == "Priority".localized(){
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    let filterarray = WorkOrderArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.MainWorkCtr == "\(thirdFilterItem)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(prioritycls[0].PriorityText) ")
                                            finalFiltervalues["\(thirdFilterItem) - \(prioritycls[0].PriorityText) "] = filterarray
                                        }
                                    }else if secondFilterItem == "User_Status".localized(){
                                        let filterarray = WorkOrderArray.filter{ $0.UserStatus == "\(fourthFilterItem)" && $0.MainWorkCtr == "\(thirdFilterItem)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                            finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }else if secondFilterItem == "Mant.Activity_Type".localized(){
                                        let filterarray = WorkOrderArray.filter{ $0.MaintActivityTypeText == "\(fourthFilterItem)" && $0.MainWorkCtr == "\(thirdFilterItem)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                            finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }else if secondFilterItem == "Date".localized(){
                                                                       
                                        if fourthFilterItem == "Planned_For_Tomorrow".localized(){
                                       
                                            let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                            let filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            
                                            let namePredicate = NSPredicate(format: "SELF.MainWorkCtr == %@ and SELF.BasicStrtDate == %@",thirdFilterItem,filterdate as CVarArg)
                                        
                                            let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                        
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - PFT")
                                                finalFiltervalues["\(thirdFilterItem) - PFT"] = filterarray
                                            }
                                        }else if fourthFilterItem == "Planned_for_Next_Week".localized(){
                                                                           
                                            let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                            let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                            let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let namePredicate = NSPredicate(format: "SELF.MainWorkCtr == %@ and (SELF.BasicStrtDate >= %@ and SELF.BasicStrtDate <= %@)", thirdFilterItem,filterdate1 as CVarArg,filterdate2 as CVarArg);
                                            let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - PFNW")
                                                finalFiltervalues["\(thirdFilterItem) - PFNW"] = filterarray
                                            }
                           
                                        }else if fourthFilterItem == "Overdue_For_Last_2_days".localized(){
                                                                            
                                            let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                            let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                            let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let namePredicate = NSPredicate(format: "SELF.MainWorkCtr == %@ and (SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)",thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                            let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                        
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - ODFT")
                                                finalFiltervalues["\(thirdFilterItem) - ODFT"] = filterarray
                                           }
                                        }else if fourthFilterItem == "Overdue_for_a_Week".localized(){
                                            let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                            let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                            let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let namePredicate = NSPredicate(format: "SELF.MainWorkCtr == %@ and (SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)", thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                            let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                             
                                                if (filterarray.count > 0){
                                                    countarr.append(filterarray.count)
                                                    colorArr.append(self.setColor(count: colorArr.count))
                                                    legendArr.append("\(thirdFilterItem) - ODW")
                                                    finalFiltervalues["\(thirdFilterItem) - ODW"] = filterarray
                                                }
                                        }else if fourthFilterItem == "All_Overdue".localized(){
                                       
                                            let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                            let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        
                                            let namePredicate = NSPredicate(format: "SELF.MainWorkCtr == %@ and SELF.BasicFnshDate < %@", thirdFilterItem,filterdate1 as CVarArg);
                                           let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                         
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - All Overdue")
                                                finalFiltervalues["\(thirdFilterItem) - All Overdue"] = filterarray
                                            }
                                        }
                                    }else if secondFilterItem == "Created_or_Assigned".localized(){
                                            if fourthFilterItem == "Assigned_To_Me".localized(){
                                            let filterarray = WorkOrderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.PersonResponsible == "\(userPersonnelNo)"}
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                                finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                            }
                                        }else if fourthFilterItem == "Created_By_Me".localized(){
                                            let filterarray = WorkOrderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.EnteredBy == "\(userDisplayName)"}
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                                finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                            }
                                        }
                                    }
                            }else if firstFilterItem == "Mant.Activity_Type".localized(){
                                
                                if secondFilterItem == "Priority".localized(){
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    let filterarray = WorkOrderArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.MaintActivityTypeText == "\(thirdFilterItem)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(prioritycls[0].PriorityText)")
                                         }
                                }else if secondFilterItem == "User_Status".localized(){
                                    let filterarray = WorkOrderArray.filter{ $0.UserStatus == "\(fourthFilterItem)" && $0.MaintActivityTypeText == "\(thirdFilterItem)"}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                        finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                    let workCenterCls = globalWorkCtrArray.filter{ $0.WorkCenter == fourthFilterItem}
                                    let filterarray = WorkOrderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.MainWorkCtr == "\(workCenterCls[0].WorkCenter)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(workCenterCls[0].WorkCenter)")
                                            finalFiltervalues["\(thirdFilterItem) - \(workCenterCls[0].WorkCenter)"] = filterarray
                                         }
                                }else if secondFilterItem == "Date".localized(){
                                                                        
                                    if fourthFilterItem == "Planned_For_Tomorrow".localized(){
                                        
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                       
                                        let namePredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@ and SELF.BasicStrtDate == %@",thirdFilterItem,filterdate as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - PFT")
                                                finalFiltervalues["\(thirdFilterItem) - PFT"] = filterarray
                                            }
                                    }else if fourthFilterItem == "Planned_for_Next_Week".localized(){
                                        
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@ and (SELF.BasicStrtDate >= %@ and SELF.BasicStrtDate <= %@)", thirdFilterItem,filterdate1 as CVarArg,filterdate2 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                             if (filterarray.count > 0){
                                                 countarr.append(filterarray.count)
                                                 colorArr.append(self.setColor(count: colorArr.count))
                                                 legendArr.append("\(thirdFilterItem) - PFNW")
                                                 finalFiltervalues["\(thirdFilterItem) - PFNW"] = filterarray
                                             }
                            
                                    }else if fourthFilterItem == "Overdue_For_Last_2_days".localized(){
                                         
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@ and (SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)", thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                         
                                             if (filterarray.count > 0){
                                                 countarr.append(filterarray.count)
                                                 colorArr.append(self.setColor(count: colorArr.count))
                                                 legendArr.append("\(thirdFilterItem) - ODFT")
                                                 finalFiltervalues["\(thirdFilterItem) - ODFT"] = filterarray
                                             }
                                    }else if fourthFilterItem == "Overdue_for_a_Week".localized(){
                                    
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@ and (SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)", thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - ODW")
                                                finalFiltervalues["\(thirdFilterItem) - ODW"] = filterarray
                                             }
                                     }else if fourthFilterItem == "All_Overdue".localized(){
                                       
                                         let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        
                                         let namePredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@ and SELF.BasicFnshDate < %@", thirdFilterItem,filterdate1 as CVarArg);
                                            let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                          if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - All Overdue")
                                                finalFiltervalues["\(thirdFilterItem) - All Overdue"] = filterarray
                                         }
                                     }
                                 }else if secondFilterItem == "Created_or_Assigned".localized(){
                                    
                                    if fourthFilterItem == "Assigned_To_Me".localized(){
                                         let filterarray = WorkOrderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.PersonResponsible == "\(userPersonnelNo)"}
                                         if (filterarray.count > 0){
                                             countarr.append(filterarray.count)
                                             colorArr.append(self.setColor(count: colorArr.count))
                                             legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                             finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                         }
                                     }else if fourthFilterItem == "Created_By_Me".localized(){
                                         let filterarray = WorkOrderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.EnteredBy == "\(userDisplayName)"}
                                         if (filterarray.count > 0){
                                             countarr.append(filterarray.count)
                                             colorArr.append(self.setColor(count: colorArr.count))
                                             legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                             finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                         }
                                     }
                                 }
                            }else if firstFilterItem == "Date".localized(){
                                    
                                    let arr = NSMutableArray()
                                    var str = String()
                                    
                                    if thirdFilterItem == "Planned_For_Tomorrow".localized(){
                                        
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    
                                        let namePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@",filterdate as CVarArg)
                                         arr.add(namePredicate)
                                         str =  "PFT"

                                    }else if thirdFilterItem == "Planned_for_Next_Week".localized(){
                                                                                    
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicStrtDate <= %@)",filterdate1 as CVarArg,filterdate2 as CVarArg);
                                        
                                        arr.add(namePredicate)
                                        str =  "PFNW"
        
                                    }else if thirdFilterItem == "Overdue_For_Last_2_days".localized(){
                                                                                     
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                       
                                        arr.add(namePredicate)
                                        str =  "ODFT"
                                    }else if thirdFilterItem == "Overdue_for_a_Week".localized(){
                                                    
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        arr.add(namePredicate)
                                        str =  "ODW"
                                    }else if thirdFilterItem == "All_Overdue".localized(){
                                                    
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                       
                                        let namePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",filterdate1 as CVarArg);
                                        arr.add(namePredicate)
                                        str =  "All_Overdue".localized()
                                    }
                                
                                if secondFilterItem == "Priority".localized(){
                                           
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    let namePredicate = NSPredicate(format: "SELF.Priority == %@","\(prioritycls[0].Priority)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(prioritycls[0].PriorityText)")
                                            finalFiltervalues["\(str) - \(prioritycls[0].PriorityText)"] = filterarray
                                    }
                                        
                                }else if secondFilterItem == "User_Status".localized(){
                                  
                                    let namePredicate = NSPredicate(format: "SELF.UserStatus == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate =    NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(fourthFilterItem)")
                                            finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                        }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                        
                                    let namePredicate = NSPredicate(format: "SELF.MainWorkCtr == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(str) - \(fourthFilterItem)")
                                        finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "Mant.Activity_Type".localized(){
                                      
                                    let namePredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate =    NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(fourthFilterItem)")
                                            finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                        }
                                }else if secondFilterItem == "Created_or_Assigned".localized(){
                                        
                                        if fourthFilterItem == "Assigned_To_Me".localized(){
                                           
                                            let namePredicate = NSPredicate(format: "SELF.PersonResponsible == %@","\(userPersonnelNo)");
                                                arr.add(namePredicate)
                                            
                                            let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                            let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                                    
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(str) - \(fourthFilterItem)")
                                                finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                            }
                                    }else if fourthFilterItem == "Created_By_Me".localized(){
                                            let namePredicate =  NSPredicate(format: "SELF.EnteredBy == %@","\(userDisplayName)");
                                                arr.add(namePredicate)
                                            let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                            let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                                    
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(str) - \(fourthFilterItem)")
                                                finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                            }
                                    }
                                }
                            }else if firstFilterItem == "Created_or_Assigned".localized(){
                                let arr = NSMutableArray()
                                var str = String()
                                
                                if thirdFilterItem == "Assigned_To_Me".localized(){
                                    let namePredicate = NSPredicate(format: "SELF.PersonResponsible == %@","\(userPersonnelNo)");
                                        arr.add(namePredicate)
                                        str = "Assigned_To_Me".localized()
                                }else if thirdFilterItem == "Created_By_Me".localized(){
                                    let namePredicate = NSPredicate(format: "SELF.EnteredBy == %@","\(userDisplayName)");
                                        arr.add(namePredicate)
                                        str = "Created_By_Me".localized()
                                }
                                if secondFilterItem == "Priority".localized(){
                                           
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    let namePredicate = NSPredicate(format: "SELF.Priority == %@","\(prioritycls[0].Priority)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(prioritycls[0].PriorityText)")
                                            finalFiltervalues["\(str) - \(prioritycls[0].PriorityText)"] = filterarray
                                    }
                                        
                                }else if secondFilterItem == "User_Status".localized(){
                                  
                                    let namePredicate = NSPredicate(format: "SELF.UserStatus == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate =    NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(fourthFilterItem)")
                                            finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                        }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                        
                                    let namePredicate = NSPredicate(format: "SELF.MainWorkCtr == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(str) - \(fourthFilterItem)")
                                        finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "Mant.Activity_Type".localized(){
                                      
                                    let namePredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate =    NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(fourthFilterItem)")
                                            finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                        }
                                }else if secondFilterItem == "Date".localized(){
                                  
                                    var str1 = String()
                                    if fourthFilterItem == "Planned_For_Tomorrow".localized(){
                                                                           
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    
                                        let namePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@",filterdate as CVarArg)
                                            arr.add(namePredicate)
                                            str1 =  "PFT"
                                    }else if fourthFilterItem == "Planned_for_Next_Week".localized(){
                                        
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicStrtDate <= %@)",filterdate1 as CVarArg,filterdate2 as CVarArg);
                                            
                                            arr.add(namePredicate)
                                            str1 =  "PFNW"
                                           
                                    }else if fourthFilterItem == "Overdue_For_Last_2_days".localized(){
                                                                               
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                            arr.add(namePredicate)
                                            str1 =  "ODFT"
                                    }else if fourthFilterItem == "Overdue_for_a_Week".localized(){
                                        
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                            arr.add(namePredicate)
                                            str1 =  "ODW"
                                    }else if fourthFilterItem == "All_Overdue".localized(){
                                                                                       
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                       
                                        let namePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",filterdate1 as CVarArg);
                                             arr.add(namePredicate)
                                             str1 =  "All_Overdue".localized()
                                    }
                                   
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate =    NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.WorkOrderArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(str1)")
                                            finalFiltervalues["\(str) - \(str1)"] = filterarray
                                        }
                                    
                                }
                                
                            }
                        }
                    }
                        var count = Int()
                        for i in 0..<countarr.count{
                            count += countarr[i]
                        }
                        self.TotalLabel.text = "Total_Workorders".localized()+": \(self.WorkOrderArray.count)"
                        self.countLabel.text = "\(countarr)"

                        self.createchartData(Countarr: countarr, Legendstr: legendArr, ColorArr: colorArr, chart: self.newpieChartView)
                        
                }else if fourthFilterArr.count == 0{
                       
                        var countarr = Array<Int>()
                        var colorArr = Array<UIColor>()
                        var legendArr = Array<String>()
                     
                        if firstFilterItem == "Priority".localized(){
                            
                            for pri in thirdFilterArr{
                             
                                let prioritycls = globalPriorityArray.filter{ $0.PriorityText == pri}
                                let filterarray = WorkOrderArray.filter{ $0.Priority == prioritycls[0].Priority}
                                if (filterarray.count > 0){
                                    countarr.append(filterarray.count)
                                    colorArr.append(self.setColor(count: colorArr.count))
                                    legendArr.append("\(prioritycls[0].PriorityText)")
                                    finalFiltervalues["\(prioritycls[0].PriorityText)"] = filterarray
                                    
                                }
                            }
                        }else if firstFilterItem == "User_Status".localized(){
                            
                            for status in thirdFilterArr{
                                
                                let filterarray = WorkOrderArray.filter{ $0.UserStatus == status}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(status)")
                                        finalFiltervalues["\(status)"] = filterarray
                                }
                            }
                        }else if firstFilterItem == "WorkCenter".localized(){
                            
                            for workcenter in thirdFilterArr{
                                let filterarray = WorkOrderArray.filter{ $0.MainWorkCtr == workcenter}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(workcenter)")
                                        finalFiltervalues["\(workcenter)"] = filterarray
                                 }
                            }
                        }else if firstFilterItem == "Mant.Activity_Type".localized(){
                            
                            for activityType in thirdFilterArr{
                                 let filterarray = WorkOrderArray.filter{ $0.MaintActivityTypeText == activityType}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(activityType)")
                                        finalFiltervalues["\(activityType)"] = filterarray
                                 }
                            }
                        }else if firstFilterItem == "Date".localized(){
                            
                            for thirdFilterItem in thirdFilterArr{
                                if thirdFilterItem == "Planned_For_Tomorrow".localized(){
                                    
                                    let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                    let filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                   
                                    let namePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@",filterdate as CVarArg)
                                    let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                    
                                        if (filterarray.count > 0){
                                             countarr.append(filterarray.count)
                                             colorArr.append(self.setColor(count: colorArr.count))
                                             legendArr.append("PFT")
                                             finalFiltervalues["PFT"] = filterarray
                                         }
                                }else if thirdFilterItem == "Planned_for_Next_Week".localized(){
                                                                        
                                    let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                    let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let namePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicStrtDate <= %@)",filterdate1 as CVarArg,filterdate2 as CVarArg);
                                    let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                    
                                         if (filterarray.count > 0){
                                             countarr.append(filterarray.count)
                                             colorArr.append(self.setColor(count: colorArr.count))
                                             legendArr.append("PFNW")
                                             finalFiltervalues["PFNW"] = filterarray
                                         }
                                }else if thirdFilterItem == "Overdue_For_Last_2_days".localized(){
                                                                             
                                    let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                    let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let namePredicate = NSPredicate(format: "(SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                    let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                        
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("ODFT")
                                            finalFiltervalues["ODFT"] = filterarray
                                        }
                                }else if thirdFilterItem == "Overdue_for_a_Week".localized(){
                                    let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                    let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let namePredicate = NSPredicate(format: "(SELF.BasicFnshDate >= %@ and SELF.BasicFnshDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                    let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("ODW")
                                            finalFiltervalues["ODW"] = filterarray
                                        }
                                }else if thirdFilterItem == "All_Overdue".localized(){
                                    let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    
                                    let namePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",filterdate1 as CVarArg);
                                    let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("All_Overdue".localized())
                                            finalFiltervalues["All_Overdue".localized()] = filterarray
                                        }
                                }
                            }
                        }else if firstFilterItem == "Created_or_Assigned".localized(){
                            
                                for type in thirdFilterArr{
                                    if type == "Assigned_To_Me".localized() {
                                        let filterarray = WorkOrderArray.filter{ $0.PersonResponsible == userPersonnelNo}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(type)")
                                            finalFiltervalues[type] = filterarray
                                            
                                        }
                                }else if type == "Created_By_Me".localized() {
                                 
                                    let filterarray = WorkOrderArray.filter{ $0.EnteredBy == userDisplayName}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(type)")
                                        finalFiltervalues[type] = filterarray
                                        
                                    }
                                }
                            }
                        }
                         var count = Int()
                         for i in 0..<countarr.count{
                            count += countarr[i]
                         }
                        self.TotalLabel.text = "Total_Workorders".localized()+": \(self.WorkOrderArray.count)"
                        self.createchartData(Countarr: countarr, Legendstr: legendArr, ColorArr: colorArr, chart: self.newpieChartView)
                        
                            self.countLabel.text = "\(countarr)"
                        
                }
            }else if header == "Notification"{
                
                if thirdFilterArr.count > 0 && fourthFilterArr.count > 0{
                    var countarr = Array<Int>()
                    var colorArr = Array<UIColor>()
                    var legendArr = Array<String>()
                            
                    for thirdFilterItem in thirdFilterArr{
                                
                        for fourthFilterItem in fourthFilterArr{
                            
                            if firstFilterItem == "Priority".localized(){
                                
                                let prioritycls = globalPriorityArray.filter{ $0.PriorityText == thirdFilterItem}
                                if secondFilterItem == "User_Status".localized(){
                                           
                                    let filterarray = NotificationArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.UserStatus == "\(fourthFilterItem)"}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                        finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                          
                                    let filterarray = NotificationArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.WorkCenter == "\(fourthFilterItem)"}
                                    if (filterarray.count > 0){
                                       countarr.append(filterarray.count)
                                       colorArr.append(self.setColor(count: colorArr.count))
                                       legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                       finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "Work_order_Conversion".localized(){
                                   
                                    var filterarray = Array<NotificationModel>()
                                    
                                    if fourthFilterItem == "Work_order_Created".localized(){
                                         filterarray = NotificationArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.WorkOrderNum != ""}
                                    }else if fourthFilterItem == "Work_order_Not_Created".localized(){
                                         filterarray = NotificationArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.WorkOrderNum == ""}
                                    }

                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                        finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "Date".localized(){
                               
                                    if fourthFilterItem == "Planned_For_Tomorrow".localized(){
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                       
                                        let namePredicate = NSPredicate(format: "SELF.Priority == %@ and SELF.RequiredStartDate == %@", prioritycls[0].Priority,filterdate as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                                
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(prioritycls[0].PriorityText) - PFT")
                                                finalFiltervalues["\(prioritycls[0].PriorityText) - PFT"] = filterarray
                                            }
                                      }else if fourthFilterItem == "Planned_for_Next_Week".localized(){
                                               
                                            let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                            let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                            let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        
                                            let namePredicate = NSPredicate(format: "SELF.Priority == %@ and (SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", prioritycls[0].Priority,filterdate1 as CVarArg,filterdate2 as CVarArg);
                                            let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                               
                                                if (filterarray.count > 0){
                                                    countarr.append(filterarray.count)
                                                    colorArr.append(self.setColor(count: colorArr.count))
                                                    legendArr.append("\(prioritycls[0].PriorityText) - PFNW")
                                                    finalFiltervalues["\(prioritycls[0].PriorityText) - PFNW"] = filterarray
                                                }
                                        }else if fourthFilterItem == "Overdue_For_Last_2_days".localized(){
                                            
                                            let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                            let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                            let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                            let namePredicate = NSPredicate(format: "SELF.Priority == %@ and (SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", prioritycls[0].Priority,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                            let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                                
                                                if (filterarray.count > 0){
                                                    countarr.append(filterarray.count)
                                                    colorArr.append(self.setColor(count: colorArr.count))
                                                    legendArr.append("\(prioritycls[0].PriorityText) - ODFT")
                                                    finalFiltervalues["\(prioritycls[0].PriorityText) - ODFT"] = filterarray
                                                }
                                            }else if fourthFilterItem == "Overdue_for_a_Week".localized(){
                                                let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                                let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                                let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                                let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                                let namePredicate = NSPredicate(format: "SELF.Priority == %@ and (SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", prioritycls[0].Priority,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                                let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                                 
                                                    if (filterarray.count > 0){
                                                       countarr.append(filterarray.count)
                                                       colorArr.append(self.setColor(count: colorArr.count))
                                                       legendArr.append("\(prioritycls[0].PriorityText) - ODW")
                                                       finalFiltervalues["\(prioritycls[0].PriorityText) - ODW"] = filterarray
                                                   }
                                            }else if fourthFilterItem == "All_Overdue".localized(){
                                                let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                                let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                                  let namePredicate = NSPredicate(format: "SELF.Priority == %@ and  SELF.RequiredEndDate < %@", prioritycls[0].Priority,filterdate1 as CVarArg);
                                                let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                                if (filterarray.count > 0){
                                                       countarr.append(filterarray.count)
                                                       colorArr.append(self.setColor(count: colorArr.count))
                                                       legendArr.append("\(prioritycls[0].PriorityText) - All Overdue")
                                                       finalFiltervalues["\(prioritycls[0].PriorityText) - All Overdue"] = filterarray
                                                   }
                                                }
                                    }else if secondFilterItem == "Created_or_Assigned".localized(){
                                        if fourthFilterItem == "Assigned_To_Me".localized(){
                                            let filterarray = NotificationArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.Partner == "\(Decimal(string:userPersonnelNo) ?? 0)"}
                                        if (filterarray.count > 0){
                                           countarr.append(filterarray.count)
                                           colorArr.append(self.setColor(count: colorArr.count))
                                           legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                           finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }else if fourthFilterItem == "Created_By_Me".localized(){
                                        let filterarray = NotificationArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.EnteredBy == "\(userDisplayName)"}
                                        if (filterarray.count > 0){
                                           countarr.append(filterarray.count)
                                           colorArr.append(self.setColor(count: colorArr.count))
                                           legendArr.append("\(prioritycls[0].PriorityText) - \(fourthFilterItem)")
                                           finalFiltervalues["\(prioritycls[0].PriorityText) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }
                                }
                            }else if firstFilterItem == "User_Status".localized(){
                                    
                                if secondFilterItem == "Priority".localized(){
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    let filterarray = NotificationArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.UserStatus == "\(thirdFilterItem)"}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(prioritycls[0].PriorityText) - \(thirdFilterItem)")
                                            finalFiltervalues["\(prioritycls[0].PriorityText) - \(thirdFilterItem)"] = filterarray
                                        }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                       
                                    let filterarray = NotificationArray.filter{ $0.UserStatus == "\(thirdFilterItem)" && $0.WorkCenter == "\(fourthFilterItem)"}
                                       if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                            finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                }else if secondFilterItem == "Work_order_Conversion".localized(){
                                       
                                    var filterarray = Array<NotificationModel>()
                                        if fourthFilterItem == "Work_order_Created".localized(){
                                            filterarray = NotificationArray.filter{ $0.UserStatus == "\(thirdFilterItem)" && $0.WorkOrderNum != ""}
                                        }else if fourthFilterItem == "Work_order_Not_Created".localized(){
                                            filterarray = NotificationArray.filter{ $0.UserStatus == "\(thirdFilterItem)" && $0.WorkOrderNum == ""}
                                        }
                                   
                                       if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                            finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                }else if secondFilterItem == "Date".localized(){
                                        
                                    if fourthFilterItem == "Planned_For_Tomorrow".localized(){
                                        
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                         let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and SELF.RequiredStartDate == %@", thirdFilterItem,filterdate as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                                 
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - PFT")
                                            finalFiltervalues["\(thirdFilterItem) - PFT"] = filterarray
                                        }
                                    }else if fourthFilterItem == "Planned_for_Next_Week".localized(){
                                                
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and (SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", thirdFilterItem,filterdate1 as CVarArg,filterdate2 as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                                
                                        if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - PFNW")
                                                finalFiltervalues["\(thirdFilterItem) - PFNW"] = filterarray
                                        }
                                    
                                    }else if fourthFilterItem == "Overdue_For_Last_2_days".localized(){
                                                 
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and (SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - ODFT")
                                                finalFiltervalues["\(thirdFilterItem) - ODFT"] = filterarray
                                            }
                                    }else if fourthFilterItem == "Overdue_for_a_Week".localized(){
                                        
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and (SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - ODW")
                                            finalFiltervalues["\(thirdFilterItem) - ODW"] = filterarray
                                        }
                                    }else if fourthFilterItem == "All_Overdue".localized(){
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@ and SELF.RequiredEndDate < %@", thirdFilterItem,filterdate1 as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(thirdFilterItem) - All Overdue")
                                            finalFiltervalues["\(thirdFilterItem) - All Overdue"] = filterarray
                                        }
                                    }
                                                    
                                }else if secondFilterItem == "Created_or_Assigned".localized(){
                                        if fourthFilterItem == "Assigned_To_Me".localized(){
                                            let filterarray = NotificationArray.filter{ $0.UserStatus == "\(thirdFilterItem)" && $0.Partner == "\(Decimal(string:userPersonnelNo) ?? 0)"}
                                        if (filterarray.count > 0){
                                           countarr.append(filterarray.count)
                                           colorArr.append(self.setColor(count: colorArr.count))
                                           legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                           finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }else if fourthFilterItem == "Created_By_Me".localized(){
                                        let filterarray = NotificationArray.filter{ $0.UserStatus == "\(thirdFilterItem)" && $0.EnteredBy == "\(userDisplayName)"}
                                        if (filterarray.count > 0){
                                           countarr.append(filterarray.count)
                                           colorArr.append(self.setColor(count: colorArr.count))
                                           legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                           finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }
                                }
                            }else if firstFilterItem == "WorkCenter".localized(){
                                
                                if secondFilterItem == "Priority".localized(){
                                   let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                   let filterarray = NotificationArray.filter{ $0.Priority == "\(prioritycls[0].Priority)" && $0.WorkCenter == "\(thirdFilterItem)"}
                                        if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(prioritycls[0].PriorityText) - \(thirdFilterItem)")
                                                finalFiltervalues["\(prioritycls[0].PriorityText) - \(thirdFilterItem)"] = filterarray
                                            }
                                }else if secondFilterItem == "User_Status".localized(){
                                    let filterarray = NotificationArray.filter{ $0.UserStatus == "\(fourthFilterItem)" && $0.WorkCenter == "\(thirdFilterItem)"}
                                    if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(fourthFilterItem) - \(thirdFilterItem)")
                                                finalFiltervalues["\(fourthFilterItem) - \(thirdFilterItem)"] = filterarray
                                     }
                                }else if secondFilterItem == "Work_order_Conversion".localized(){
                                   
                                    var filterarray = Array<NotificationModel>()
                                    
                                    if fourthFilterItem == "Work_order_Created".localized(){
                                        filterarray = NotificationArray.filter{ $0.WorkOrderNum != "" && $0.WorkCenter == "\(thirdFilterItem)"}
                                    }else if fourthFilterItem == "Work_order_Not_Created".localized(){
                                        filterarray = NotificationArray.filter{ $0.WorkOrderNum == "" && $0.WorkCenter == "\(thirdFilterItem)"}
                                    }
                                    
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(fourthFilterItem) - \(thirdFilterItem)")
                                        finalFiltervalues["\(fourthFilterItem) - \(thirdFilterItem)"] = filterarray
                                     }
                                }else if secondFilterItem == "Date".localized(){
                                    
                                    if fourthFilterItem == "Planned_For_Tomorrow".localized(){
                                                
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let filterdate = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    
                                        let namePredicate = NSPredicate(format: "SELF.WorkCenter == %@ and SELF.RequiredStartDate == %@", thirdFilterItem,filterdate  as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                                 
                                                 if (filterarray.count > 0){
                                                     countarr.append(filterarray.count)
                                                     colorArr.append(self.setColor(count: colorArr.count))
                                                     legendArr.append("\(thirdFilterItem) - PFT")
                                                     finalFiltervalues["\(thirdFilterItem) - PFT"] = filterarray
                                                 }
                                    }else if fourthFilterItem == "Planned_for_Next_Week".localized(){
                                                
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.WorkCenter == %@ and (SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", thirdFilterItem,filterdate1 as CVarArg,filterdate2 as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                            
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - PFNW")
                                                finalFiltervalues["\(thirdFilterItem) - PFNW"] = filterarray
                                            }
                                    
                                    }else if fourthFilterItem == "Overdue_For_Last_2_days".localized(){
                                                 
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.WorkCenter == %@ and (SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - ODFT")
                                                finalFiltervalues["\(thirdFilterItem) - ODFT"] = filterarray
                                            }
                                    }else if fourthFilterItem == "Overdue_for_a_Week".localized(){
                                            
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.WorkCenter == %@ and (SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", thirdFilterItem,filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - ODW")
                                                finalFiltervalues["\(thirdFilterItem) - ODW"] = filterarray
                                            }
                                    }else if fourthFilterItem == "All_Overdue".localized(){
                                                
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                       
                                        let namePredicate = NSPredicate(format: "SELF.WorkCenter == %@ and SELF.RequiredEndDate < %@", thirdFilterItem,filterdate1 as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                            
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(thirdFilterItem) - All Overdue")
                                                finalFiltervalues["\(thirdFilterItem) - All Overdue"] = filterarray
                                            }
                                        }
                                }else if secondFilterItem == "Created_or_Assigned".localized(){
                                        if fourthFilterItem == "Assigned_To_Me".localized(){
                                        let filterarray = NotificationArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.Partner == "\(Decimal(string:userPersonnelNo) ?? 0)"}
                                        if (filterarray.count > 0){
                                           countarr.append(filterarray.count)
                                           colorArr.append(self.setColor(count: colorArr.count))
                                           legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                           finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }else if fourthFilterItem == "Created_By_Me".localized(){
                                        let filterarray = NotificationArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.EnteredBy == "\(userDisplayName)"}
                                        if (filterarray.count > 0){
                                           countarr.append(filterarray.count)
                                           colorArr.append(self.setColor(count: colorArr.count))
                                           legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                           finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                        }
                                    }
                                }
                            }else if firstFilterItem == "Work_order_Conversion".localized(){
                               
                                let arr = NSMutableArray()
                                var str = String()
                                                
                                if thirdFilterItem == "Work_order_Created".localized(){
                                    let namePredicate = NSPredicate(format: "SELF.WorkOrderNum != %@","")
                                        arr.add(namePredicate)
                                        str =  thirdFilterItem
                                }else if thirdFilterItem == "Work_order_Not_Created".localized(){
                                                                                                        
                                    let namePredicate = NSPredicate(format: "SELF.WorkOrderNum == %@","");
                                        arr.add(namePredicate)
                                        str =  thirdFilterItem
                            
                                }
                                                
                                if secondFilterItem == "Priority".localized(){
                                                               
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    let namePredicate = NSPredicate(format: "SELF.Priority == %@","\(prioritycls[0].Priority)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(prioritycls[0].PriorityText)")
                                            finalFiltervalues["\(str) - \(prioritycls[0].PriorityText)"] = filterarray
                                        }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                            
                                    let namePredicate = NSPredicate(format: "SELF.WorkCenter == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                            
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(str) - \(fourthFilterItem)")
                                        finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "User_Status".localized(){
                                              
                                        let namePredicate = NSPredicate(format: "SELF.UserStatus == %@","\(fourthFilterItem)");
                                            arr.add(namePredicate)
                                        let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                        let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                        let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(fourthFilterItem)")
                                            finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                        }
                                }else if secondFilterItem == "Date".localized(){
                                   
                                   
                                    var str1 = String()
                                                        
                                    if thirdFilterItem == "Planned_For_Tomorrow".localized(){
                                        
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@",filterdate1 as CVarArg)
                                                arr.add(namePredicate)
                                                str1 =  "PFT"
                                    }else if thirdFilterItem == "Planned_for_Next_Week".localized(){
                                         
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredStartDate <= %@)",filterdate1 as CVarArg,filterdate2 as CVarArg);
                                                
                                            arr.add(namePredicate)
                                            str1 =  "PFNW"
                                    
                                    }else if thirdFilterItem == "Overdue_For_Last_2_days".localized(){
                                                   
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.RequiredEndDate >= %@ and SELF.RequiredEndDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                               
                                            arr.add(namePredicate)
                                            str1 =  "ODFT"
                                    }else if thirdFilterItem == "Overdue_for_a_Week".localized(){
                                                                                
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.RequiredEndDate >= %@ and SELF.RequiredEndDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                            arr.add(namePredicate)
                                            str1 =  "ODW"
                                    }else if thirdFilterItem == "All_Overdue".localized(){
                                                                                
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        
                                        let namePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",filterdate1 as CVarArg);
                                            arr.add(namePredicate)
                                            str1 =  "All_Overdue".localized()
                                    }
                                    
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(str) - \(str1)")
                                        finalFiltervalues["\(str) - \(str1)"] = filterarray
                                    }
                                }else if secondFilterItem == "Created_or_Assigned".localized(){
                                        if fourthFilterItem == "Assigned_To_Me".localized(){
                                            let filterarrayList = NSPredicate(format: "SELF.Partner == %@","\(Decimal(string:userPersonnelNo) ?? 0)");
                                                arr.add(filterarrayList)
                                            let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                            let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                                    
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(str) - \(fourthFilterItem)")
                                                finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                            }
                                    }else if fourthFilterItem == "Created_By_Me".localized(){
                                            let filterarrayList = NSPredicate(format: "SELF.EnteredBy == %@","\(userDisplayName)");
                                                
                                                arr.add(filterarrayList)
                                            let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                            let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                                    
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(str) - \(fourthFilterItem)")
                                                finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                            }
                                    }
                                }
                            }else if firstFilterItem == "Date".localized(){
                                    let arr = NSMutableArray()
                                    var str = String()
                                
                                if thirdFilterItem == "Planned_For_Tomorrow".localized(){
                                    
                                    let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                   
                                    let namePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@",filterdate1 as CVarArg)
                                        arr.add(namePredicate)
                                        str =  "PFT"
                                }else if thirdFilterItem == "Planned_for_Next_Week".localized(){
                                                                                        
                                    let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                    let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let namePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredStartDate <= %@)",filterdate1 as CVarArg,filterdate2 as CVarArg);
                                            
                                        arr.add(namePredicate)
                                        str =  "PFNW"
            
                                }else if thirdFilterItem == "Overdue_For_Last_2_days".localized(){
                                                                                         
                                    let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                    let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let namePredicate = NSPredicate(format: "(SELF.RequiredEndDate >= %@ and SELF.RequiredEndDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                           
                                        arr.add(namePredicate)
                                        str =  "ODFT"
                                }else if thirdFilterItem == "Overdue_for_a_Week".localized(){
                                                        
                                    let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                    let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                    let namePredicate = NSPredicate(format: "(SELF.RequiredEndDate >= %@ and SELF.RequiredEndDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        arr.add(namePredicate)
                                        str =  "ODW"
                                }else if thirdFilterItem == "All_Overdue".localized(){
                                                        
                                    let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                   
                                    let namePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",filterdate1 as CVarArg);
                                        arr.add(namePredicate)
                                        str =  "All_Overdue".localized()
                                 }
                                
                                if secondFilterItem == "Priority".localized(){
                                               
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    let namePredicate = NSPredicate(format: "SELF.Priority == %@","\(prioritycls[0].Priority)");
                                        arr.add(namePredicate)
                                    
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(prioritycls[0].PriorityText)")
                                            finalFiltervalues["\(str) - \(prioritycls[0].PriorityText)"] = filterarray
                                        }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                            
                                    let namePredicate = NSPredicate(format: "SELF.WorkCenter == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                            
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(str) - \(fourthFilterItem)")
                                        finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "User_Status".localized(){
                                          
                                    let namePredicate = NSPredicate(format: "SELF.UserStatus == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(str) - \(fourthFilterItem)")
                                        finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "Work_order_Conversion".localized(){
                                                    
                                    if fourthFilterItem == "Work_order_Created".localized(){
                                        let namePredicate = NSPredicate(format: "SELF.WorkOrderNum != %@","")
                                            arr.add(namePredicate)
                                    }else if fourthFilterItem == "Work_order_Not_Created".localized(){
                                        let namePredicate = NSPredicate(format: "SELF.WorkOrderNum == %@","");
                                            arr.add(namePredicate)
                                    }
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(str) - \(fourthFilterItem)")
                                        finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                    }
                                }
                                else if secondFilterItem == "Created_or_Assigned".localized(){
                                        if fourthFilterItem == "Assigned_To_Me".localized(){
                                            let filterarrayList = NSPredicate(format: "SELF.Partner == %@","\(Decimal(string:userPersonnelNo) ?? 0)");
                                                 arr.add(filterarrayList)
                                            let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                            let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                                    
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(str) - \(fourthFilterItem)")
                                                finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                            }
                                    }else if fourthFilterItem == "Created_By_Me".localized(){
                                            let filterarrayList = NSPredicate(format: "SELF.EnteredBy == %@","\(userDisplayName)");
                                            
                                                 arr.add(filterarrayList)
                                            let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                            let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                                    
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("\(str) - \(fourthFilterItem)")
                                                finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                            }
                                    }
                                }
                            }else if firstFilterItem == "Created_or_Assigned".localized(){
                                let arr = NSMutableArray()
                                var str = String()
                                
                                if thirdFilterItem == "Assigned_To_Me".localized(){
                                    let namePredicate =  NSPredicate(format: "SELF.Partner == %@","\(Decimal(string:userPersonnelNo) ?? 0)");
                                        arr.add(namePredicate)
                                        str = "Assigned_To_Me".localized()
                                }else if thirdFilterItem == "Created_By_Me".localized(){
                                    let namePredicate = NSPredicate(format: "SELF.EnteredBy == %@","\(userDisplayName)");
                                        arr.add(namePredicate)
                                        str = "Created_By_Me".localized()
                                }
                                if secondFilterItem == "Priority".localized(){
                                           
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    let namePredicate = NSPredicate(format: "SELF.Priority == %@","\(prioritycls[0].Priority)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(prioritycls[0].PriorityText)")
                                            finalFiltervalues["\(str) - \(prioritycls[0].PriorityText)"] = filterarray
                                    }
                                        
                                }else if secondFilterItem == "User_Status".localized(){
                                  
                                    let namePredicate = NSPredicate(format: "SELF.UserStatus == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate =    NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(fourthFilterItem)")
                                            finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                        }
                                }else if secondFilterItem == "WorkCenter".localized(){
                                        
                                    let namePredicate = NSPredicate(format: "SELF.WorkCenter == %@","\(fourthFilterItem)");
                                        arr.add(namePredicate)
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(str) - \(fourthFilterItem)")
                                        finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "Work_order_Conversion".localized(){
                                                    
                                    if fourthFilterItem == "Work_order_Created".localized(){
                                        let namePredicate = NSPredicate(format: "SELF.WorkOrderNum != %@","")
                                            arr.add(namePredicate)
                                    }else if fourthFilterItem == "Work_order_Not_Created".localized(){
                                        let namePredicate = NSPredicate(format: "SELF.WorkOrderNum == %@","");
                                            arr.add(namePredicate)
                                    }
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(str) - \(fourthFilterItem)")
                                        finalFiltervalues["\(str) - \(fourthFilterItem)"] = filterarray
                                    }
                                }else if secondFilterItem == "Date".localized(){
                                    var str1 = String()
                                    
                                    if fourthFilterItem == "Planned_For_Tomorrow".localized(){
                                                            
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        
                                        let namePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@",filterdate1 as CVarArg)
                                                arr.add(namePredicate)
                                                str1 =  "PFT"
                                    }else if fourthFilterItem == "Planned_for_Next_Week".localized(){
                                         
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredStartDate <= %@)",filterdate1 as CVarArg,filterdate2 as CVarArg);
                                                                    
                                            arr.add(namePredicate)
                                            str1 =  "PFNW"
                                    
                                    }else if fourthFilterItem == "Overdue_For_Last_2_days".localized(){
                                        
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.RequiredEndDate >= %@ and SELF.RequiredEndDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                                        
                                                arr.add(namePredicate)
                                                str1 =  "ODFT"
                                    }else if fourthFilterItem == "Overdue_for_a_Week".localized(){
                                                                                
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.RequiredEndDate >= %@ and SELF.RequiredEndDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                            arr.add(namePredicate)
                                            str1 =  "ODW"
                                    }else if fourthFilterItem == "All_Overdue".localized(){
                                                                                
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        
                                        let namePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",filterdate1 as CVarArg);
                                            arr.add(namePredicate)
                                            str1 =  "All_Overdue".localized()
                                    }
                                    
                                    let finalPredicateArray : [NSPredicate] = arr as NSArray as! [NSPredicate]
                                    let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                    let filterarray = self.NotificationArray.filter{compound.evaluate(with: $0)}
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(str) - \(str1)")
                                            finalFiltervalues["\(str) - \(str1)"] = filterarray
                                        }
                                }
                                
                            }
                        }
                    }
                     
                            var count = Int()
                            for i in 0..<countarr.count{
                                count += countarr[i]
                            }
                            self.TotalLabel.text = "Total_Notifications".localized() + ": \(self.NotificationArray.count)"
                            self.createchartData(Countarr: countarr, Legendstr: legendArr, ColorArr: colorArr, chart: self.newpieChartView)
                            self.countLabel.text = "\(countarr)"

                            
                }else if fourthFilterArr.count == 0{
                           
                    var countarr = Array<Int>()
                    var colorArr = Array<UIColor>()
                    var legendArr = Array<String>()
                        
                        if firstFilterItem == "Priority".localized(){
                                
                                for pri in thirdFilterArr{
                                 
                                    let prioritycls = globalPriorityArray.filter{ $0.PriorityText == pri}
                                    let filterarray = NotificationArray.filter{ $0.Priority == prioritycls[0].Priority}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(prioritycls[0].PriorityText)")
                                        finalFiltervalues["\(prioritycls[0].PriorityText)"] = filterarray
                                    }
                                }
                        }else if firstFilterItem == "User_Status".localized(){
                            
                            for status in thirdFilterArr{
                                
                                let filterarray = NotificationArray.filter{ $0.UserStatus == status}
                                    if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("\(status)")
                                            finalFiltervalues["\(status)"] = filterarray
                                    }
                                }
                        }else if firstFilterItem == "WorkCenter".localized(){
                            
                            for workcenter in thirdFilterArr{
                                  
                                let filterarray = NotificationArray.filter{ $0.WorkCenter == workcenter}
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("\(workcenter)")
                                        finalFiltervalues["\(workcenter)"] = filterarray
                                     }
                                }
                        }else if firstFilterItem == "Work_order_Conversion".localized(){
                           
                            for thirdFilterItem in thirdFilterArr{
                               
                                if thirdFilterItem == "Work_order_Created".localized(){
                                       
                                    let namePredicate = NSPredicate(format: "SELF.WorkOrderNum != %@","")
                                    let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                        
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append(thirdFilterItem)
                                        finalFiltervalues[thirdFilterItem] = filterarray
                                    }
                                }else if thirdFilterItem == "Work_order_Not_Created".localized(){
                                                                                                            
                                    let namePredicate = NSPredicate(format: "SELF.WorkOrderNum == %@","");
                                    let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                        
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append(thirdFilterItem)
                                        finalFiltervalues[thirdFilterItem] = filterarray
                                    }
                                
                                }
                            }
                            
                                            
                            
                           
                        }else if firstFilterItem == "Date".localized(){
                               
                                for thirdFilterItem in thirdFilterArr{
                                        
                                    if thirdFilterItem == "Planned_For_Tomorrow".localized(){
                                                
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                      
                                        let namePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", filterdate1 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("PFT")
                                                finalFiltervalues["PFT"] = filterarray
                                            }
                
                                    }else if thirdFilterItem == "Planned_for_Next_Week".localized(){
                                                
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 1, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : 7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        
                                        let namePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)",filterdate1 as CVarArg,filterdate2 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("PFNW")
                                                finalFiltervalues["PFNW"] = filterarray
                                            }
                                    }else if thirdFilterItem == "Overdue_For_Last_2_days".localized(){
                                                 
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -2, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = NotificationArray.filter{namePredicate.evaluate(with: $0) }
                                            if (filterarray.count > 0){
                                                countarr.append(filterarray.count)
                                                colorArr.append(self.setColor(count: colorArr.count))
                                                legendArr.append("ODFT")
                                                finalFiltervalues["ODFT"] = filterarray
                                            }
                                    }else if thirdFilterItem == "Overdue_for_a_Week".localized(){
                                        let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                        let futureDate = Calendar.current.date(byAdding: .day, value : -7, to: Date())
                                        let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let filterdate2 = ODSDateHelper.getDateFromString(dateString:  futureDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                        let namePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)",filterdate2 as CVarArg,filterdate1 as CVarArg);
                                        let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                                  
                                        if (filterarray.count > 0){
                                            countarr.append(filterarray.count)
                                            colorArr.append(self.setColor(count: colorArr.count))
                                            legendArr.append("ODW")
                                            finalFiltervalues["ODW"] = filterarray
                                        }
                                }else if thirdFilterItem == "All_Overdue".localized(){
                                               
                                    let currentDate = Calendar.current.date(byAdding: .day, value : 0, to: Date())
                                    let filterdate1 = ODSDateHelper.getDateFromString(dateString:  currentDate?.toString(format: .custom(localDateFormate)) ?? "", dateFormat: localDateFormate)
                                
                                    let namePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",filterdate1 as CVarArg);
                                    let filterarray = WorkOrderArray.filter{namePredicate.evaluate(with: $0) }
                                                  
                                    if (filterarray.count > 0){
                                        countarr.append(filterarray.count)
                                        colorArr.append(self.setColor(count: colorArr.count))
                                        legendArr.append("All_Overdue".localized())
                                        finalFiltervalues["All_Overdue".localized()] = filterarray
                                    }
                                }
                            }
                    }else if firstFilterItem == "Created_or_Assigned".localized(){
                            
                        
                            for type in thirdFilterArr{
                             if type == "Assigned_To_Me".localized() {
                                let filterarray = NotificationArray.filter{ $0.Partner == "\(Decimal(string:userPersonnelNo) ?? 0)"}
                                if (filterarray.count > 0){
                                    countarr.append(filterarray.count)
                                    colorArr.append(self.setColor(count: colorArr.count))
                                    legendArr.append("\(type)")
                                    finalFiltervalues[type] = filterarray
                                    
                                }
                            }else if type == "Created_By_Me".localized() {
                             
                                let filterarray = NotificationArray.filter{ $0.EnteredBy == userDisplayName}
                                if (filterarray.count > 0){
                                    countarr.append(filterarray.count)
                                    colorArr.append(self.setColor(count: colorArr.count))
                                    legendArr.append("\(type)")
                                    finalFiltervalues[type] = filterarray
                                    
                                }
                            }
                        }
                        
                    }
                            var count = Int()
                            for i in 0..<countarr.count{
                                count += countarr[i]
                            }
                            self.TotalLabel.text = "Total_Notifications".localized() + ": \(self.NotificationArray.count)"
                            self.createchartData(Countarr: countarr, Legendstr: legendArr, ColorArr: colorArr, chart: self.newpieChartView)
                            self.countLabel.text = "\(countarr)"

                }
            }
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if sender.tag == 800{
            if sender.selectedSegmentIndex == 0{
                self.filterObject.removeAll()
                self.applyCustomeFilter()
                filterSegment.selectedSegmentIndex = 0
            }else{
                filterSegment.selectedSegmentIndex = 1
                var PriorityListArr = Array<String>()
                let priorityArr = self.WorkOrderArray.unique{$0.Priority}
                    for pr in priorityArr{
                        if pr.Priority != ""{
                            PriorityListArr.append(pr.Priority)
                        }
                    }
                self.filterObject.removeAll()
                self.filterObject["All"] = self.WorkOrderArray
                self.filterTitleArray.removeAll()
                self.filterTitleArray.append("All")
               for item in PriorityListArr{
                   let filterarray = self.WorkOrderArray.filter{$0.Priority == item}
                    if item == "1"{
                        self.filterObject["Very High"] = filterarray
                    }else if item == "2"{
                        self.filterObject["High"] = filterarray
                    }else if item == "3"{
                        self.filterObject["Medium"] = filterarray
                    }else if item == "4"{
                        self.filterObject["Low"] = filterarray
                    }else{
                        self.filterObject["Very Low"] = filterarray
                    }
                   
               }
                for i in PriorityListArr{
                    if PriorityListArr.contains("1") && !self.filterTitleArray.contains("Very High"){
                        self.filterTitleArray.append("Very High")
                    }else if PriorityListArr.contains("2") && !self.filterTitleArray.contains("High"){
                        self.filterTitleArray.append("High")
                    }else if PriorityListArr.contains("3") && !self.filterTitleArray.contains("Medium"){
                        self.filterTitleArray.append("Medium")
                    }else if PriorityListArr.contains("4") && !self.filterTitleArray.contains("Low"){
                        self.filterTitleArray.append("Low")
                    }else{
                        self.filterTitleArray.append("Very Low")
                    }
                }
                
               filterSelectedIndex = 0
                
               DispatchQueue.main.async {
                   self.filterArray.removeAll()
                   self.filterArray = self.filterObject["All"]!
                   self.detailsTableView.reloadData()
                   self.statusCollectionView.reloadData()
               }
            }
        }else if sender.tag == 810{
            if sender.selectedSegmentIndex == 0{
                self.getCompletedWorkorder(from: "Today")
            }else{
                self.getCompletedWorkorder(from: "Overall")
            }
        }else{
            
            if sender.selectedSegmentIndex == 0{
                DispatchQueue.main.async {
                    self.tableWOtitleLabel.text = "WO NUMBER"
                    self.woNoTitleLabel.text = "WORK ORDER DASH BOARD"
                }
                currentMasterView = "WorkOrder"
                listButton.setImage(UIImage(named: "wo"), for: .normal)
                FilterDict["Header"] = "WorkOrder"
                FirstDropDownArr = WoFilterArray
                self.FilterDict["First"] = "Priority".localized()
                self.FilterDict["Second"] = "User_Status".localized()
                self.TotalLabel.text = "Total_Workorders".localized()+": \(self.WorkOrderArray.count)"
                let arr = self.FirstDropDownArr
                self.SecondDropDownArr = arr
                self.setPriority()
                self.finalFiltervalues.removeAll()
                self.firstDropDownTxtField.text = "Priority".localized()
                self.secondDropDownTxtField.text = "User_Status".localized()
                if applicationFeatureArrayKeys.contains("WO_LIST_NEW_WO_OPTION"){
                    self.addButton.isHidden = false
                }else{
                    self.addButton.isHidden = true
                }
                ApplyDashBoardFilter()
                
                self.workOrderFilterButton.backgroundColor = dbfilterBgColor
                self.notificationFilterButton.backgroundColor = UIColor.clear
                self.supervisorFilterButton.backgroundColor = UIColor.clear
                }else if sender.selectedSegmentIndex == 1{
                DispatchQueue.main.async {
                    self.tableWOtitleLabel.text = "NO NUMBER"
                    self.woNoTitleLabel.text = "NOTIFICATION DASH BOARD"
                }
                currentMasterView = "Notification"
                listButton.setImage(UIImage(named: "notifi"), for: .normal)
                FilterDict["Header"] = "Notification"
                FirstDropDownArr = NoFilterArray
                self.FilterDict["First"] = "Priority".localized()
                self.FilterDict["Second"] = "User_Status".localized()
                self.firstDropDownTxtField.text = "Priority".localized()
                self.secondDropDownTxtField.text = "User_Status".localized()
                self.TotalLabel.text = "Total_Notifications".localized() + " : \(self.NotificationArray.count)"
                let arr = self.FirstDropDownArr
                self.SecondDropDownArr = arr
                self.setPriority()
                self.finalFiltervalues.removeAll()
                ApplyDashBoardFilter()
                if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
                    self.addButton.isHidden = false
                }else{
                    self.addButton.isHidden = true
                }
                self.workOrderFilterButton.backgroundColor = UIColor.clear
                self.notificationFilterButton.backgroundColor = dbfilterBgColor
                self.supervisorFilterButton.backgroundColor = UIColor.clear
            }
        }
    }
    @objc func orderTypeSelectionButton(btn: UIButton){
        btn.isSelected = !btn.isSelected
        
        if btn.tag == 0 {
            currentMasterView = "WorkOrder"
            listButton.setImage(UIImage(named: "wo"), for: .normal)
            workOrderFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
            notificationFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            supervisorFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            timeSheetFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            FilterDict["Header"] = "WorkOrder"
            FirstDropDownArr = WoFilterArray
            self.FilterDict["First"] = "Priority".localized()
            self.FilterDict["Second"] = "User_Status".localized()
            self.TotalLabel.text = "Total_Workorders".localized()+": \(self.WorkOrderArray.count)"
            let arr = self.FirstDropDownArr
            self.SecondDropDownArr = arr
            self.setPriority()
            self.finalFiltervalues.removeAll()
            self.firstDropDownTxtField.text = "Priority".localized()
            self.secondDropDownTxtField.text = "User_Status".localized()
            
            if applicationFeatureArrayKeys.contains("WO_LIST_NEW_WO_OPTION"){
                self.addButton.isHidden = false
            }else{
                self.addButton.isHidden = true
            }
            ApplyDashBoardFilter()
            
            self.workOrderFilterButton.backgroundColor = dbfilterBgColor
            self.notificationFilterButton.backgroundColor = UIColor.clear
            self.supervisorFilterButton.backgroundColor = UIColor.clear
            
        }else if btn.tag == 1 {
            currentMasterView = "Notification"
            listButton.setImage(UIImage(named: "notifi"), for: .normal)
            workOrderFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            supervisorFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            timeSheetFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            notificationFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
            FilterDict["Header"] = "Notification"
            FirstDropDownArr = NoFilterArray
            self.FilterDict["First"] = "Priority".localized()
            self.FilterDict["Second"] = "User_Status".localized()
            self.firstDropDownTxtField.text = "Priority".localized()
            self.secondDropDownTxtField.text = "User_Status".localized()
            self.TotalLabel.text = "Total_Notifications".localized() + " : \(self.NotificationArray.count)"
            let arr = self.FirstDropDownArr
            self.SecondDropDownArr = arr
            self.setPriority()
            self.finalFiltervalues.removeAll()
            ApplyDashBoardFilter()
            if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
                self.addButton.isHidden = false
            }else{
                self.addButton.isHidden = true
            }
            self.workOrderFilterButton.backgroundColor = UIColor.clear
            self.notificationFilterButton.backgroundColor = dbfilterBgColor
            self.supervisorFilterButton.backgroundColor = UIColor.clear
        }else if btn.tag == 2 {
            currentMasterView = "Supervisor"
            notificationFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            workOrderFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            timeSheetFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            supervisorFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
            FilterDict["Header"] = "Supervisor"
            FirstDropDownArr = ["Priority".localized(),"User_Status".localized(),"WorkCenter".localized(),"Date".localized(),"PersonNo"]
            self.TotalLabel.text = "Total_Count".localized() + " : \(self.SupervisorArray.count)"
            var arr = self.FirstDropDownArr
            if arr.count > 0{
                self.SecondDropDownArr = arr
                self.FilterDict["First"] = self.FirstDropDownArr[0]
                self.firstDropDownTxtField.text = self.FirstDropDownArr[0]
                self.setPriority()
                self.secondDropDownTxtField.text = selectStr
                self.fourthDropDownTxtField.text = selectStr
                self.finalFiltervalues.removeAll()
                self.addButton.isHidden = true
                ApplyDashBoardFilter()
                self.workOrderFilterButton.backgroundColor = UIColor.clear
                self.notificationFilterButton.backgroundColor = UIColor.clear
                self.supervisorFilterButton.backgroundColor = dbfilterBgColor
            }
        }else if btn.tag == 3 {
            currentMasterView = "Timesheet"
            notificationFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            supervisorFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            workOrderFilterButton.setImage(UIImage(named: "ic_Circle_empty"), for: .normal)
            timeSheetFilterButton.setImage(UIImage(named: "ic_Circle_fill"), for: .normal)
            FilterDict["Header"] = "Timesheet"
            
        }
    }
    
    @IBAction func firstDropDownButtonAction(_ sender: Any) {
        menudropDown.dataSource = self.FirstDropDownArr
        menudropDown.anchorView = sender as? UIButton
        menudropDown.cellHeight = 40.0
        menudropDown.width = 220.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        self.dropDownSelectString = "First"
            menudropDown.show()
    }

    @IBAction func secondDropDownButtonAction(_ sender: Any) {
        
        menudropDown.dataSource = self.SecondDropDownArr
        menudropDown.anchorView = sender as? UIButton
        menudropDown.cellHeight = 40.0
        menudropDown.width = 220.0
        self.dropDownSelectString = "Second"
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        
        
    }
    
    @IBAction func thirdDropDownButtonAction(_ sender: Any) {
       
        if firstDropDownTxtField.text == "Priority".localized(){
            priorityListArray.removeAllObjects()
            self.setPriority()
            multiDropDown.dataSource = self.priorityListArray as! [String]
        }else if firstDropDownTxtField.text == "User_Status".localized(){
            self.setUserStatusList()
            multiDropDown.dataSource = self.userStatusListArr
        }else if firstDropDownTxtField.text == "WorkCenter".localized(){
             self.setWorkCentersList()
             multiDropDown.dataSource = self.workCentersListArray
        }else if firstDropDownTxtField.text == "Date".localized(){
            multiDropDown.dataSource = self.dateDropArray
        }else if firstDropDownTxtField.text == "Mant.Activity_Type".localized(){
            self.setMaintActivityType()
            multiDropDown.dataSource = self.MainActivityTypeArray as! [String]
        }else if firstDropDownTxtField.text == "Technician".localized(){
            
        }else if firstDropDownTxtField.text == "Work_order_Conversion".localized(){
            let arr = ["Work_order_Created".localized(),"Work_order_Not_Created".localized()]
            multiDropDown.dataSource = arr
        }else if firstDropDownTxtField.text == "Created_or_Assigned".localized(){
            multiDropDown.dataSource = self.typeArray
        }
        
        self.dropDownSelectString = "Third"
        multiDropDown.showCheckBox = true
        multiDropDown.anchorView = sender as? UIButton
        multiDropDown.cellHeight = 40.0
        multiDropDown.width = 220.0
        multiDropDown.backgroundColor = UIColor.white
        multiDropDown.textColor = appColor
        multiDropDown.show()
    }
    @IBAction func fourthDropDownButtonAction(_ sender: Any) {
           
        if secondDropDownTxtField.text == selectStr{
            
            return
        }
        
        if secondDropDownTxtField.text == "Priority".localized(){
           
            priorityListArray.removeAllObjects()
            self.setPriority()
            multiDropDown.dataSource = self.priorityListArray as! [String]
            
            
        }else if secondDropDownTxtField.text == "WorkCenter".localized(){
            
             self.workCentersListArray.removeAll()
             self.setWorkCentersList()
            multiDropDown.dataSource = self.workCentersListArray
        }else if secondDropDownTxtField.text == "User_Status".localized(){
            
             self.setUserStatusList()
             multiDropDown.dataSource = self.userStatusListArr

        }else if secondDropDownTxtField.text == "Date".localized(){
            
            multiDropDown.dataSource = self.dateDropArray
         
        }else if secondDropDownTxtField.text == "Mant.Activity_Type".localized(){
            self.setMaintActivityType()
            multiDropDown.dataSource = self.MainActivityTypeArray as! [String]
        }else if secondDropDownTxtField.text == "Technician".localized(){
            
        }else if secondDropDownTxtField.text == "Work_order_Conversion".localized(){
            let arr = ["Work_order_Created".localized(),"Work_order_Not_Created".localized()]
            multiDropDown.dataSource = arr
        }
        else if secondDropDownTxtField.text == "Created_or_Assigned".localized(){
            multiDropDown.dataSource = self.typeArray
        }
        self.dropDownSelectString = "Fourth"
        multiDropDown.showCheckBox = true
        multiDropDown.anchorView = sender as? UIButton
        multiDropDown.cellHeight = 40.0
        multiDropDown.width = 220.0
        multiDropDown.backgroundColor = UIColor.white
        multiDropDown.textColor = appColor
        multiDropDown.show()

    }
    
    //MARK: - TableView Delegate and Datasource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1100{
           return self.filterArray.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if tableView.tag == 1100{
            return 50
        }else{
            if indexPath.row == currentRow {
                if cellTapped{
                    return 190
                } else {
                    return 135
                }
            }
            return 135
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView.tag == 1100{
            let cell = ScreenManager.getDBStyle4ListCell(tableView: tableView)
            if filterArray.count > 0{
                let  selectedclass = filterArray[indexPath.row]
                cell.woNumLabel.text = selectedclass.WorkOrderNum
                cell.descriptionLabel.text = selectedclass.ShortText
                if selectedclass.BasicFnshDate != nil{
                    let date =  selectedclass.BasicFnshDate!.toString(format: .custom(localDateFormate))
                    cell.dateLabel.text = date
                    
                }else{
                    cell.dateLabel.text = ""
                }
                let priority = selectedclass.Priority
                cell.priorityImg.image = myAssetDataManager.getPriorityImage(priority: selectedclass.Priority)
                if priority == "1" || priority == "" {
                    cell.priorityLabel.text = "Very High"
                }else if priority == "2" {
                    cell.priorityLabel.text = "High"
                }else if priority == "3" {
                    cell.priorityLabel.text = "Medium"
                }else if priority == "4" {
                    cell.priorityLabel.text = "Low"
                }
                isSupervisor = "X"
                if isSupervisor == "X"{
                    cell.technicianLable.isHidden = false
                    cell.techWidthConstant.constant = 130.0
                    if selectedclass.Technician != ""{
                        if let techname = self.techciandict.value(forKey: selectedclass.Technician) as? String{
                            
                            cell.technicianLable.text = techname
                            
                        }
                    }
                }else{
                    cell.technicianLable.isHidden = true
                    cell.techWidthConstant.constant = 0.0
                }
                
                cell.TypeLabel.text = selectedclass.OrderType
                //                        cell.locationLabel.text = selectedclass.PostalCode
                //                        if selectedclass.OperationDuration == ""{
                //                            cell.plannedHoursLabel.text = "0 H"
                //                        }else{
                //                            cell.plannedHoursLabel.text = "\(selectedclass.OperationDuration) H"
                //                        }
                //
                return cell
                
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1100{
            
            if let selected = filterArray[indexPath.row] as? WoHeaderModel{
                totalWorkorders.removeAllObjects()
                filterWorkorders.removeAllObjects()
                currentMasterView = "WorkOrder"
                totalWorkorders.addObjects(from: self.WorkOrderArray)
                filterWorkorders.add(selected)
                singleWorkOrder = selected
                selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
            }
            menuDataModel.uniqueInstance.presentListSplitScreen()
        }
    }
        
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//            cellTapped = !cellTapped
//           self.detailsTableView.reloadData()
    }
    
    func createBatchRequestForTransactionCount(ObjectClass: AnyObject){
        
        if let workorder = ObjectClass as? WoHeaderModel {
            
            let ConfOpr = "\(woConfirmationSet)?$filter=(WorkOrderNum eq '\(workorder.WorkOrderNum)' and Complete eq 'X')&$select=OperationNum,WorkOrderNum"
            let incompleteOpr = DefineRequestModelClass.uniqueInstance.getOperationsDefineRequest(type: "List", workorderNum: workorder.WorkOrderNum, oprNum: "", from: "") as String
            let  inCompleteComponent = DefineRequestModelClass.uniqueInstance.getComponentsDefineRequest(type: "GetComponentCount", workorderNum: workorder.WorkOrderNum, componentNum: "", operationNum: "", from: "") as String
            let attachemts = "\(woAttachmentSet)?$filter=(endswith(ObjectKey, '" + workorder.WorkOrderNum + "') eq true)"
            let uploadAttachments = "\(uploadWOAttachmentContentSet)?$select=WorkOrderNum,DocID,FILE_NAME,BINARY_FLG&$filter=(WorkOrderNum%20eq%20%27" + (workorder.WorkOrderNum) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
            
            let currentReadings = measurementPointReadingSet
            
            
            
            let batchArr = NSMutableArray()
            
            batchArr.add(ConfOpr)
            batchArr.add(incompleteOpr)
            batchArr.add(inCompleteComponent)
            batchArr.add(attachemts)
            batchArr.add(uploadAttachments)
            batchArr.add(currentReadings)
            
            let batchRequest = SODataRequestParamBatchDefault.init()
            
            for obj in batchArr {
                
                let str = obj as! String
                let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
                reqParam?.customTag = str
                batchRequest.batchItems.add(reqParam!)
                
            }
            BatchRequestModel.getExecuteTransactionBatchRequest(batchRequest: batchRequest){ (response, error)  in
                
                if error == nil {
                    
                    if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                        
                        let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                        
                        for key in responseDic.allKeys{
                            
                            let resourcePath = key as! String
                            if resourcePath == woConfirmationSet {
                                
                                self.confirmOperationList.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                
                                let dict = mJCHelperClass.getConfirmationOpeartionlist(dictionary: dictval)
                                self.confirmOperationList = dict["data"] as! [String]
                                
                            }else if resourcePath == woOperationSet{
                                
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                self.OperationArr.removeAll()
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: WoOperationModel.self)
                                if  let oprarray = dict["data"] as? [WoOperationModel]{
                                    if oprarray.count > 0{
                                        self.OperationArr = oprarray
                                        
                                    }
                                }
                                
                            }else if resourcePath == woComponentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: WoComponentModel.self)
                                self.ComponentArr.removeAll()
                                if  let comparray = dict["data"] as? [WoComponentModel]{
                                    
                                    if(comparray.count > 0) {
                                        self.ComponentArr = comparray
                                    }else{
                                        cmpCount = ""
                                    }
                                }
                            }else if resourcePath == uploadWOAttachmentContentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                                self.woUploadAttachmentArr.removeAll()
                                if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                    
                                    if(uploadattacharray.count > 0) {
                                        self.woUploadAttachmentArr = uploadattacharray
                                    }else{
                                        
                                    }
                                }
                            }else if resourcePath == woAttachmentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                                self.woAttachmentArr.removeAll()
                                if  let Woattacharray = dict["data"] as? [AttachmentModel]{
                                    
                                    if(Woattacharray.count > 0) {
                                        self.woAttachmentArr = Woattacharray
                                    }
                                }
                            }else if resourcePath == "MeasurementPointReadingSet"{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: MeasurementPointModel.self)
                                self.finalpoints.removeAll()
                                self.currentpoints.removeAll()
                                if  let pointArray = dict["data"] as? [MeasurementPointModel]{
                                    if(pointArray.count > 0) {
                                        self.currentpoints = pointArray.filter{$0.WOObjectNum == workorder.ObjectNumber}
                                        let allEP = pointArray.filter({$0.Equipment == "\(workorder.EquipNum)" && $0.WOObjectNum == "" && $0.OpObjectNumber == ""})
                                        let allFP = pointArray.filter({$0.FunctionalLocation == "\(workorder.FuncLocation)" && $0.WOObjectNum == "" && $0.OpObjectNumber == ""})
                                        self.finalpoints.append(contentsOf: allEP)
                                        self.finalpoints.append(contentsOf: allFP)
                                        
                                    }
                                }
                            }
                        }
                        self.createBatchRequestForFormsCount(ObjectClass: ObjectClass)
                        
                    }
                }
            }
            
            
        }
        if let notification = ObjectClass as? NotificationModel{
            
            let itemList = DefineRequestModelClass.uniqueInstance.getNotificationItems(type: "deleteList", notificationNum: notification.Notification, itemNum: "", notificationFrom: "") as String
            let ActivityList = DefineRequestModelClass.uniqueInstance.getNotificationActivity(type: "List", notificationNum: notification.Notification, activityNum: "",notificationFrom: "", ItemNum: "0000") as String
            let taskList = DefineRequestModelClass.uniqueInstance.getNotificationTask(type: "List", notificationNum: notification.Notification, taskNum: "", notificationFrom: "", ItemNum: "0000") as String
            let NoUploadList = uploadNOAttachmentContentSet + "?$filter=(Notification%20eq%20%27" + (notification.Notification) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME&$select=Notification,DocID,FILE_NAME";
            let NoAttachList = "NOAttachmentSet" + "?$filter=(endswith(ObjectKey, '\(notification.Notification)') eq true)"
            
            let batchArr = NSMutableArray()
            
            batchArr.add(itemList)
            batchArr.add(ActivityList)
            batchArr.add(taskList)
            batchArr.add(NoUploadList)
            batchArr.add(NoAttachList)
            
            
            let batchRequest = SODataRequestParamBatchDefault.init()
            
            for obj in batchArr {
                
                let str = obj as! String
                let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
                reqParam?.customTag = str
                batchRequest.batchItems.add(reqParam!)
                
            }
            
            BatchRequestModel.getExecuteTransactionBatchRequest(batchRequest: batchRequest){ (response, error)  in
                if error == nil {
                    
                    if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                        
                        let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                        for key in responseDic.allKeys{
                            
                            let resourcePath = key as! String
                            if resourcePath == "NotificationActivitySet" {
                                
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationActivityModel.self)
                                if  let NoActivityArr = dict["data"] as? [NotificationActivityModel]{
                                    if NoActivityArr.count > 0{
                                        ActvityCount = "\(NoActivityArr.count)"
                                    }else{
                                        ActvityCount = ""
                                    }
                                }
                                
                            }else if resourcePath == notificationItemSet{
                                
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationItemsModel.self)
                                if  let NoItemArr = dict["data"] as? [NotificationItemsModel]{
                                    if NoItemArr.count > 0{
                                        ItemCount = "\(NoItemArr.count)"
                                    }else{
                                        ItemCount = ""
                                    }
                                }
                            }else if resourcePath == "NotificationTaskSet"{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: NotificationTaskModel.self)
                                if  let NoTaskArr = dict["data"] as? [NotificationTaskModel]{
                                    if NoTaskArr.count > 0{
                                        TaskCount = "\(NoTaskArr.count)"
                                    }else{
                                        TaskCount = ""
                                    }
                                }
                            }else if resourcePath == uploadWOAttachmentContentSet{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: UploadedAttachmentsModel.self)
                                self.NoUploadAttachmentArr.removeAll()
                                if  let uploadattacharray = dict["data"] as? [UploadedAttachmentsModel]{
                                    
                                    if(uploadattacharray.count > 0) {
                                        self.NoUploadAttachmentArr = uploadattacharray
                                    }
                                }
                            }else if resourcePath == "NOAttachmentSet"{
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: AttachmentModel.self)
                                self.NoAttachmentArr.removeAll()
                                if  let Noattacharray = dict["data"] as? [AttachmentModel]{
                                    
                                    if(Noattacharray.count > 0) {
                                        self.NoAttachmentArr = Noattacharray
                                    }
                                }
                                if  let Noattacharray = dict["CompID"] as? [String]{
                                    
                                    if(Noattacharray.count > 0) {
                                        self.NoCompIdArr = Noattacharray
                                    }
                                }
                                
                            }
                        }
                        self.setNoAttachementCount(Notification: notification)
                        DispatchQueue.main.async {
                            self.detailsTableView.reloadData()
                        }
                    }
                }
            }
            
        }
    }
    func createBatchRequestForFormsCount(ObjectClass: AnyObject){
        
        if let workorder = ObjectClass as? WoHeaderModel {
            
            //FormAssingmentSet
            let formAssignment = "FormAssingmentSet?$filter=(ControlKey%20eq%20%27%27%20and%20OrderType%20eq%20%27\( workorder.OrderType)%27)"
            let responseCapture = "ResponseCaptureSet?$filter=(CreatedBy%20eq%20%27\(strUser)%27 and (WoNum%20eq%20%27\(workorder.WorkOrderNum)%27) and (IsDraft%20ne%20%27X%27))&$select=FormID"
            
            
            let batchArr = NSMutableArray()
            batchArr.add(formAssignment)
            batchArr.add(responseCapture)
            
            
            let batchRequest = SODataRequestParamBatchDefault.init()
            
            for obj in batchArr {
                
                let str = obj as! String
                let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
                reqParam?.customTag = str
                batchRequest.batchItems.add(reqParam!)
                
            }
            FormsBatchRequestModel.getExecuteFormsBatchRequest(batchRequest: batchRequest){ (response, error)  in
                if error == nil {
                    
                    if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                        
                        let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                        for key in responseDic.allKeys{
                            
                            let resourcePath = key as! String
                            if resourcePath == "FormAssingmentSet" {
                                
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                self.formsAssignArray.removeAll()
                                self.mendatoryFormCount = Int()
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormAssignDataModel.self)
                                if  let formsassignarray = dict["data"] as? [FormAssignDataModel]{
                                    if formsassignarray.count > 0{
                                        self.formsAssignArray = formsassignarray
                                    }
                                }
                                if  let mcount = dict["mendatoryCount"] as? Int{
                                    self.mendatoryFormCount = mcount
                                }
                                
                            }else if resourcePath == "ResponseCaptureSet"{
                                self.formsResponseArr.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: FormResponseCaptureModel.self)
                                if  let formresparray = dict["data"] as? [FormResponseCaptureModel]{
                                    if formresparray.count > 0{
                                        self.formsResponseArr = formresparray
                                    }
                                }
                            }
                            
                        }
                        
                        self.setOperationCount(workorder:workorder)
                        self.setComponentCount(workorder:workorder)
                        self.setWoAttachementCount(workorder:workorder)
                        self.setFormCount(workorder: workorder)
                        self.setRecordpointCount(workorder: workorder)
                        
                        if  workorder.InspectionLot != "000000000000"{
                            self.createBatchRequestForInspectionCount(ObjectClass: workorder)
                        }
                        DispatchQueue.main.async {
                            self.detailsTableView.reloadData()
                        }
                    }
                }
            }
            
        }
        
    }
    func createBatchRequestForInspectionCount(ObjectClass: AnyObject){
        
        if let workorder = ObjectClass as? WoHeaderModel {
            
            // inspection operation
            let inspectionOprQuery = "InspectionOperSet?$filter=(InspectionLot%20eq%20%27\(workorder.InspectionLot)%27)&$orderby=Operation"
            let inspectionPointQuery = "InspectionPointSet?$filter=(InspLot eq '\(workorder.InspectionLot)')&$orderby=InspPoint"
            let inspectionCharQuery = "InspectionCharSet?$filter=(InspLot eq '\(workorder.InspectionLot)')&$orderby=InspChar"
            let insepctionResultQuery = "InspectionResultsGetSet?$filter=(InspLot eq '\(workorder.InspectionLot)')"
            
            
            let batchArr = NSMutableArray()
            batchArr.add(inspectionOprQuery)
            batchArr.add(inspectionPointQuery)
            batchArr.add(inspectionCharQuery)
            batchArr.add(insepctionResultQuery)
            
            let batchRequest = SODataRequestParamBatchDefault.init()
            
            for obj in batchArr {
                
                let str = obj as! String
                let reqParam = SODataRequestParamSingleDefault.init(mode: SODataRequestModeRead, resourcePath: str)
                reqParam?.customTag = str
                batchRequest.batchItems.add(reqParam!)
                
            }
            BatchRequestModel.getExecuteQmBatchRequest(batchRequest: batchRequest){ (response, error)  in
                if error == nil {
                    
                    if let soDataRequest = response.value(forKey:"data") as? SODataRequestExecution {
                        
                        let responseDic = mJCOfflineHelper.SODataRequestToNSMutableDictionary(SODataRequest: soDataRequest)
                        var inspOprArray = Array<InspectionOperationModel>()
                        var inspPointArray = Array<InspectionPointModel>()
                        var inspCharArray = Array<InspectionCharModel>()
                        var inspResultArray = Array<InspectionResultModel>()
                        
                        for key in responseDic.allKeys{
                            
                            let resourcePath = key as! String
                            if resourcePath == "InspectionOperSet" {
                                
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionOperationModel.self)
                                if  let inspOprArr = dict["data"] as? [InspectionOperationModel]{
                                    inspOprArray = inspOprArr
                                }
                                
                            }else if resourcePath == "InspectionPointSet"{
                                self.formsResponseArr.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionPointModel.self)
                                if  let insppointarray = dict["data"] as? [InspectionPointModel]{
                                    inspPointArray = insppointarray
                                }
                            }else if resourcePath == "InspectionCharSet"{
                                self.formsResponseArr.removeAll()
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionCharModel.self)
                                if  let inspcharArray = dict["data"] as? [InspectionCharModel]{
                                    inspCharArray = inspcharArray
                                }
                                
                            }else if resourcePath == "InspectionResultsGetSet"{
                                
                                let dictval = responseDic.value(forKey: resourcePath) as! [String:Any]
                                let dict = ODSHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: dictval), entityModelClassType: InspectionResultModel.self)
                                if  let inspresult = dict["data"] as? [InspectionResultModel]{
                                    inspResultArray = inspresult
                                }
                            }
                            
                        }
                        
                        self.setinspectionCount(workorder: workorder, inspOprArr: inspOprArray, inspPointArray: inspPointArray, inspcharArray: inspCharArray, inspResultArray: inspResultArray)
                        
                    }
                }
            }
            
        }
        
    }
    func setOperationCount(workorder: WoHeaderModel) {
           
           var count = Int()
        for itemCount in 0..<self.OperationArr.count {
            
                let oprCls = self.OperationArr[itemCount]
                let opr = oprCls.OperationNum
                    if !self.confirmOperationList.contains(opr) {
                        count+=1
                    }
               
           }
           DispatchQueue.main.async {

               if count == 0 {
                   OprCount = "\(self.OperationArr.count)"
                   OprColor = appColor
                    if self.ComponentArr.count == 0{
                        OprCount = ""
                    }
               }
               else {
                   OprCount = "\(count)"
                   OprColor = UIColor.red

               }
           }
    }
    func setComponentCount(workorder:WoHeaderModel){
        
        let filterarray = self.ComponentArr.filter{$0.WithdrawalQty == 0}
            if self.ComponentArr.count == filterarray.count {
                if workorder.OrderType != ""{
                    if let featurelist =  orderTypeFeatureDict.value(forKey: workorder.OrderType){
                        if (featurelist as! NSMutableArray).contains("COMPONENT"){
                                cmpColor = UIColor.red
                        }else{
                                cmpColor = filledCountColor
                        }
                    }else{
                                cmpColor = filledCountColor
                    }
                }
                cmpCount =  "\(filterarray.count)"
            }
            else{
                if filterarray.count > 0 {
                    if let featurelist =  orderTypeFeatureDict.value(forKey: workorder.OrderType){
                        if (featurelist as! NSMutableArray).contains("COMPONENT"){
                            cmpColor = UIColor.red
                        }
                        else{
                            cmpColor = filledCountColor
                        }
                    }
                    else{
                            cmpColor = filledCountColor
                    }
                    cmpCount = "\(filterarray.count)"
                }
                else {
                    var incompleteWithdrawnCount = Int()
                    var totalWithdrawnCount = Int()

                    for item in filterarray {
                        
                        let reqQty = item.ReqmtQty
                        let WithdrawalQty = item.WithdrawalQty
                        if WithdrawalQty == reqQty {
                            totalWithdrawnCount+=1
                        }
                    }
                 if incompleteWithdrawnCount == 0 {
                        cmpCount = "\(totalWithdrawnCount)"
                        cmpColor = appColor
                }else {
                        cmpCount = "\(incompleteWithdrawnCount)"
                        cmpColor = filledCountColor
                    }
                }
            }
       
    }
    func setWoAttachementCount(workorder:WoHeaderModel){
       
        let totalAttachmentCount = self.woUploadAttachmentArr.count + self.woAttachmentArr.count
        
        DispatchQueue.main.async {
            
             if (totalAttachmentCount > 0) {
                    attchmentCount = "\(totalAttachmentCount)"
                if self.woUploadAttachmentArr.count == 0{
                    
                        if workorder.OrderType != ""{
                            if let featurelist =  orderTypeFeatureDict.value(forKey: workorder.OrderType){
                                if (featurelist as! NSMutableArray).contains("ATTACHMENT"){
                                    if self.woAttachmentArr.count != 0 {
                                        attchmentColor = UIColor.red
                                    }
                                    else{
                                        attchmentCount = "!"
                                        attchmentColor = UIColor.red
                                    }
                                }else{
                                    if totalAttachmentCount > 0{
                                        attchmentCount = "\(totalAttachmentCount)"
                                    
                                    }else{
                                        attchmentCount = ""
                                    }
                                   
                                }
                            }else{
                                if totalAttachmentCount > 0{
                                    attchmentCount = "\(totalAttachmentCount)"
                                
                                }else{
                                    attchmentCount = ""
                                }
                              
                            }
                        }
                }
            }
            else {
                    attchmentCount = "!"
                    attchmentColor = UIColor.red
                
                if self.woUploadAttachmentArr.count == 0{
                    
                    if workorder.OrderType != ""{
                        if let featurelist =  orderTypeFeatureDict.value(forKey: workorder.OrderType) as? NSMutableArray {
                            if featurelist.contains("ATTACHMENT"){
                                    attchmentCount = "!"
                                    attchmentColor = UIColor.red
                            }else{
                                if totalAttachmentCount > 0{
                                        attchmentCount = "\(totalAttachmentCount)"
                                     
                                }else{
                                        attchmentCount = ""
                                }
                                 
                            }
                            
                        }
                        
                    }
                    
                }
            }
        }
    }
    func setFormCount(workorder: WoHeaderModel) {
        
        if self.mendatoryFormCount > 0 {
            
            let filteraarr = self.formsAssignArray.filter{$0.Mandatory == "X" && $0.filledFormCount == 0}
            
            if filteraarr.count > 0{
               formCount = "\(filteraarr.count)"
               formColor = UIColor.red
            }else{
              
                let filteraarr = self.formsAssignArray.filter{$0.filledFormCount == 0}

                if filteraarr.count > 0{
                    formCount = "\(filteraarr.count)"
                    formColor = filledCountColor
                }else{
                    formCount = "\(self.formsAssignArray.count)"
                    formColor = appColor
                }
            }
           
        }else{
            let filteraarr = self.formsAssignArray.filter{$0.filledFormCount == 0}
            if filteraarr.count > 0{
                formCount = "\(filteraarr.count)"
                formColor = filledCountColor
            }else{
                formCount = "\(self.formsAssignArray.count)"
                formColor = filledCountColor
            }
        }
    
    }
    func setRecordpointCount(workorder: WoHeaderModel){
        
        if self.finalpoints.count > 0 {
            if self.currentpoints.count > 0 {
                    let count = self.finalpoints.count - self.currentpoints.count

                    if count == 0 {
                            rpCount = "\(self.finalpoints.count)"
                            rpColor = appColor
                    }
                    else {
                            rpCount = "\(count)"
                            rpColor = filledCountColor
                    }
                }
                else {
                        rpCount = "\(self.finalpoints.count)"
                        rpColor = UIColor.red
                    if workorder.OrderType != ""{
                        
                        if let featurelist = orderTypeFeatureDict.value(forKey: workorder.OrderType){
                            
                            if (featurelist as! NSMutableArray).contains("RECORD_POINT"){
                                    rpColor = UIColor.red
                            }else{
                                    rpColor = filledCountColor
                            }
                        }else{
                                rpColor = filledCountColor
                        }
                    }
                }
            }
            else {
                rpCount = ""
            }
    }
    func setNoAttachementCount(Notification:NotificationModel){
       
        if self.NoAttachmentArr.count > 0{
            var uploadedAttachementCount = self.NoUploadAttachmentArr.count
                for item in self.NoUploadAttachmentArr{
                    let filename = item.FILE_NAME
                        if NoCompIdArr.contains(filename){
                            uploadedAttachementCount -= 1
                        }
                    }
            let totalAttchmentCount = self.NoCompIdArr.count + uploadedAttachementCount
                if (totalAttchmentCount > 0) {
                    attchmentCount = "\(totalAttchmentCount)"
                }
                else {
                    attchmentCount = ""
                }
                   
        }else{
            let uploadedAttachementCount = NoUploadAttachmentArr.count

            if (uploadedAttachementCount > 0) {
               attchmentCount = "\(uploadedAttachementCount)"
            }
            else {
                attchmentCount = ""
            }
        }
    }
    func setinspectionCount(workorder: WoHeaderModel,inspOprArr:Array<InspectionOperationModel>,inspPointArray:Array<InspectionPointModel>,inspcharArray:Array<InspectionCharModel>,inspResultArray:Array<InspectionResultModel>){
        
        var finalCharArray = Int()
        var finalResultArray = Int()
        if inspOprArr.count > 0{
            for item in inspOprArr{
                let pointArray = inspPointArray.filter{$0.InspOper == "\(item.Operation)"}
                if pointArray.count > 0{
                    for item1 in pointArray{
                        let chararry = inspcharArray.filter{$0.InspPoint == "\(item1.InspPoint)"}
                        if chararry.count > 0{
                            finalCharArray = finalCharArray + chararry.count
                            for item3 in chararry{
                                
                                let resultarray = inspResultArray.filter{$0.InspOper == "\(item3.InspOper)" && $0.InspSample == "\(item3.InspPoint)" && $0.InspChar == "\(item3.InspChar)"}
                                    finalResultArray = finalResultArray + resultarray.count
                            }
                            
                        }
                        
                    }
                    
                }
            }
        }
      
        if finalCharArray == finalResultArray{
            inspCount = "\(finalCharArray)"
            InspColor = appColor
        }else{
            let remaincount = finalCharArray - finalResultArray
            inspCount = "\(remaincount)"
            if let featurelist = orderTypeFeatureDict.value(forKey: workorder.OrderType){
                
                if (featurelist as! NSMutableArray).contains("INSPECTION"){
                    InspColor = UIColor.red
                }else{
                    InspColor = filledCountColor
                }
            }
        }
        DispatchQueue.main.async {
            self.detailsTableView.reloadData()
        }
        
    }
    //MARK: - Button Actions..
    @objc func downButtonTapped(sender: AnyObject){
            cellTapped = !cellTapped
            currentRow = sender.tag
            self.detailsTableView.reloadData()
    }
    @IBAction func refreshButtonAction(_ sender: AnyObject) {
        
        mJCLogger.log("Refresh Button Tapped".localized(), Type: "")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        
    }
    
    @IBAction func logoutButtonAction(_ sender: AnyObject) {
       
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "LOGOUT", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    myAssetDataManager.uniqueInstance.logOutApp()
                    mJCLogger.log("Logout Button Tapped".localized(), Type: "")
                }
            }
    }
    func setMaintActivityType(){
    
        if let header = FilterDict["Header"]{
           if header == "WorkOrder"{
            self.MainActivityTypeArray.removeAllObjects()
            let MaintActivityArr = self.WorkOrderArray.unique{$0.MaintActivityTypeText }
               for cls in MaintActivityArr{
                    if cls.MaintActivityTypeText != ""{
                        self.MainActivityTypeArray.add(cls.MaintActivityTypeText)
                    }
               }
           }
        }
    }
    
    func setPriority(){

        self.priorityListArray.removeAllObjects()
        if let header = FilterDict["Header"]{
           if header == "WorkOrder"{
            let priortyArr = self.WorkOrderArray.unique{$0.Priority}.sorted{$0.Priority.compare($1.Priority) == .orderedAscending }
               for pr in priortyArr{
                    if pr.Priority != ""{
                        let prclsArr = globalPriorityArray.filter{$0.Priority == pr.Priority}
                        if prclsArr.count == 1{
                            let prcls = prclsArr[0]
                            self.priorityListArray.add(prcls.PriorityText)
                        }
                    }
               }
           }else if header == "Notification"{
            let priortyArr = self.NotificationArray.unique{$0.Priority }
                    for pr in priortyArr{
                        if pr.Priority != ""{
                            let prclsArr = globalPriorityArray.filter{$0.Priority == pr.Priority}
                            if prclsArr.count == 1{
                                let prcls = prclsArr[0]
                                self.priorityListArray.add(prcls.PriorityText)
                            }
                        }
                    }
           }
        }
        
        if  self.FilterDict["First"] == "Priority".localized(){
            var str = String()
            for item in self.priorityListArray{
                if (item as! String) != selectStr{
                    str =  (item as! String) + ";" + str
                }
            }
            self.FilterDict["Third"] = str
            self.thirdDropDownTxtField.text = str
           self.setUserStatusList()
        }else{
            self.fourthDropDownTxtField.text = self.priorityListArray[0] as? String
        }
        
    }
   
    func setWorkCentersList() {
          
         self.workCentersListArray.removeAll()
        if let header = FilterDict["Header"]{
           if header == "WorkOrder"{
            let wrkctrArr = self.WorkOrderArray.unique{$0.MainWorkCtr }
               for wrkctr in wrkctrArr{
                    if wrkctr.MainWorkCtr != ""{
                        self.workCentersListArray.append(wrkctr.MainWorkCtr)
                    }
                }
           }else if header == "Notification"{
            let wrkctrArr = self.NotificationArray.unique{$0.WorkCenter }
                 for wrkctr in wrkctrArr{
                    if wrkctr.WorkCenter != ""{
                        self.workCentersListArray.append(wrkctr.WorkCenter)
                    }
                 }
           }
        }
        
          if globalWorkCtrArray.count > 0 {

             for item in globalWorkCtrArray {
                let dispStr = item.WorkCenter + " - " + item.ShortText
                self.workCentersListArray.append(dispStr)
            }
          }
      }
    func setUserStatusList() {
        
        self.userStatusListArr.removeAll()
    
        if let header = FilterDict["Header"]{
           if header == "WorkOrder"{
            let UserStatusArr = self.WorkOrderArray.unique{$0.UserStatus }
                for pr in UserStatusArr{
                    if pr.UserStatus != ""{
                         self.userStatusListArr.append(pr.UserStatus)
                    }
                }
           }else if header == "Notification"{
            let UserStatusArr = self.NotificationArray.unique{$0.UserStatus }
                for pr in UserStatusArr{
                    if pr.UserStatus != ""{
                        self.userStatusListArr.append(pr.UserStatus)
                    }
                }
           }
        }

        if self.FilterDict["Second"] == "User_Status".localized(){
            var str = String()
                for item in self.userStatusListArr{
                    if item != selectStr{
                        str =  item  + ";" + str
                    }
                }
                self.FilterDict["Fourth"] = str
                self.fourthDropDownTxtField.text = str
        }
  
    }
    func setColor(count:Int) -> UIColor{
           var counter = count
           if counter >= 16{
               counter = counter - 16
           }
           let color = self.colorArray[counter]
           return UIColor.init(hexString: color)
       }
    func createchartData(Countarr: Array<Int>,Legendstr: Array<String>,ColorArr: Array<UIColor>,chart:PieChartView){
              
        var entries = [PieChartDataEntry]()
            if Countarr.count != Legendstr.count{
                  return
            }
            if Countarr.count == Legendstr.count {
                for i in 0..<Countarr.count{
                      let entry = PieChartDataEntry()
                      entry.x = Double(i)
                      entry.y = Double(Countarr[i])
                      entry.label = Legendstr[i]
                      entry.data = Legendstr[i]
                      entries.append( entry)
                  }
              }
        let set = PieChartDataSet( entries: entries, label: " ")
            set.colors = ColorArr
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
            
            chart.noDataText = ""
            chart.data = data
          //  chart.setExtraOffsets(left: -10 , top: -10, right: -10, bottom: -10)
            chart.chartDescription?.enabled = false;
            chart.drawEntryLabelsEnabled = false
            chart.delegate = self
            chart.rotationEnabled = false
            
            if Countarr.count > 0{
               self.listButton.center = chart.centerCircleBox
               self.listButton.frame.origin.x = self.listButton.frame.origin.x + 5
                self.listButton.frame.origin.y = self.listButton.frame.origin.y + 3
               chart.highlightValue(x: 0, dataSetIndex: 0)
              
            }else{
                chart.clear()
            }
        }
        self.setupChartView(chart: chart)
    }
    
    func setupChartView(chart:PieChartView){
        var chartLegend = Legend()
        chartLegend = chart.legend
        chartLegend.horizontalAlignment = .right
        chartLegend.verticalAlignment = .center
    
        chartLegend.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
        chartLegend.wordWrapEnabled = true
        chartLegend.orientation = .vertical
        chartLegend.drawInside = false
        chart.notifyDataSetChanged()
        mJCLoader.stopAnimating()
        
    }
    
    @objc func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight){
        
        let legend = entry.data as! String
       // self.filterTitleLabel.text = legend
        filterTitle = legend
       if let dataSet = chartView.data?.dataSets[ highlight.dataSetIndex] {
            let Index: Int = dataSet.entryIndex( entry: entry)
            self.colourView.backgroundColor = dataSet.colors[Index]
        }

        if let arr = self.finalFiltervalues[legend]{
            self.countLabel.text = "Count : \(arr.count)"
            self.filterCriteriaLabel.text  = "Criteria : \(legend)"
            self.selectedChartArr.removeAll()
            self.selectedChartArr.append(contentsOf: arr)
            self.detailsTableView.reloadData()
        }

    }
    @objc func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    
    @IBAction func RightMenuButtonAction(_ sender: Any) {
        if self.colectionMenuView.isHidden == true{
            self.view.bringSubviewToFront(self.colectionMenuView)
            self.colectionMenuView.isHidden = false
            var transition: CATransition? = nil
                transition = CATransition()
                transition?.duration = 0.7
                transition?.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                transition?.type = .moveIn
                transition?.subtype = .fromRight
            if let transition = transition {
                self.colectionMenuView.layer.add(transition, forKey: nil)
            }
          }else{
            UIView.transition(with: self.colectionMenuView, duration: 0.5,
                              options: .curveEaseIn,
                              animations: {
                                self.colectionMenuView.isHidden = true
                              })
          }

    }
    @IBAction func tableviewTechButtonAction(_ sender: Any) {
        currentMasterView = "Team"
        let newSplit = ScreenManager.getTeamSplitScreen()
        self.appDeli.window?.rootViewController = newSplit
        self.appDeli.window?.makeKeyAndVisible()
    }
    
    //MARK:- CollectionView Delegate
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView.tag == 900{
            return dashBoardArray.count
        }
        else{
            return self.filterTitleArray.count
        }
        
    }
 
     public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        var cell = DashboardCollectionViewCell()
        if collectionView.tag == 901{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashBoardFilter", for: indexPath as IndexPath) as! dashboardfilterCell
            if indexPath.row >= self.filterObject.count - 1{
                  cell.sideView.isHidden = true
            }
            if indexPath.row == filterSelectedIndex{
                cell.bottomView.isHidden = false
                cell.titleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            }else{
                cell.bottomView.isHidden = true
                cell.titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            }
            cell.titleButton.tag = indexPath.row
            cell.titleButton.addTarget(self, action: #selector(self.filterUpdated(sender:)), for: .touchUpInside)
            var text = String()
            var count = Int()
            if filterSegment.selectedSegmentIndex == 0{
                
                text =  ""
                    count = self.filterObject["\(self.filterTitleArray[indexPath.row])"]?.count ?? 0
            }else{
                text  = self.filterTitleArray[indexPath.row]
                count = self.filterObject["\(self.filterTitleArray[indexPath.row])"]?.count ?? 0
            }
        
              cell.titleButton.setTitle("\(text) (\(count))", for: .normal)
              cell.bottomView.layer.cornerRadius = cell.bottomView.bounds.height / 2
              return cell
        }else if collectionView.tag == 900{
           
            if dashBoardArray[indexPath.row] == "DASH_WO_TILE" || dashBoardArray[indexPath.row] == "DASH_NOTI_TILE" {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
            }else{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath as IndexPath) as! DashboardCollectionViewCell
                cell.workOrderSearchBtn.isHidden = true
            }
            cell.layer.cornerRadius = 4
            if DeviceType == iPad{
                cell.AddImage.layer.cornerRadius = 15
            }else{
                cell.AddImage.layer.cornerRadius = 20
            }
            if dashBoardArray[indexPath.row] == "DASH_WO_TILE"
            {
                cell.TitleLabel.text = "Work_Orders".localized()
                cell.centerImage.image = UIImage(named: "wo.png")
                cell.AddImage.isHidden = false
                cell.bringSubviewToFront(cell.AddImage)
                cell.addButton.tag = 1000
                cell.addButton.addTarget(self, action: #selector(DashboardStyle2.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                cell.addButton.isHidden = false
                cell.pieChartView.tag = 111
                cell.CenterButton.tag = 1000
                
                cell.CenterButton.addTarget(self, action: #selector(DashboardStyle2.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
            }
            else if dashBoardArray[indexPath.row] == "DASH_NOTI_TILE"
            {
                cell.TitleLabel.text = "Notifications".localized()
                cell.centerImage.image = UIImage(named: "notifi.png")
                cell.AddImage.isHidden = false
                cell.bringSubviewToFront(cell.AddImage)
                cell.addButton.tag = 1001
                cell.addButton.addTarget(self, action: #selector(DashboardStyle2.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                cell.pieChartView.tag = 112
                cell.CenterButton.tag = 1001
                cell.CenterButton.addTarget(self, action: #selector(DashboardStyle2.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
            } else if dashBoardArray[indexPath.row] == "DASH_SUP_TILE" {
                
                cell.TitleLabel.text = "Supervisor_View".localized()
                cell.centerImage.image = UIImage(named: "sup.png")
                cell.pieChartView.tag = 113
                cell.CenterButton.tag = 1002
                cell.CenterButton.addTarget(self, action: #selector(DashboardStyle2.Centerbuttontapped(sender:)), for: UIControl.Event.touchUpInside)
                cell.addButton.isHidden = true
                cell.AddImage.isHidden = true

                
            } else if dashBoardArray[indexPath.row] == "ASSET_HIERARCHY"{
               
                cell.TitleLabel.text = "Hierarchy".localized()
                cell.centerImage.image = UIImage(named: "asset_hierarchy.png")
                cell.AddImage.isHidden = true
                cell.bringSubviewToFront(cell.AddImage)
                cell.addButton.isHidden = true
            }else if dashBoardArray[indexPath.row] == "ODS_MYPLANNER"{
                cell.TitleLabel.text = "Planner Tool".localized()
                cell.centerImage.image = UIImage(named: "PlannerTool")
                cell.AddImage.isHidden = true
                cell.bringSubviewToFront(cell.AddImage)
                cell.addButton.isHidden = true
            }else if dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"{
                
                    cell.TitleLabel.text = "Time_Sheet".localized()
                    cell.addButton.setImage(UIImage.init(named: "add_icon.png"), for: .normal)
                    cell.centerImage.image = UIImage(named: "timesht.png")
                    cell.workOrderSearchBtn.isHidden = true
                    cell.AddImage.isHidden = false
                    cell.bringSubviewToFront(cell.AddImage)
                    cell.addButton.tag = 1004
                    cell.addButton.addTarget(self, action: #selector(DashboardStyle2.Addbuttontapped(sender:)), for: UIControl.Event.touchUpInside)

            }
            else if dashBoardArray[indexPath.row] == "DASH_ASSET_HIE_TILE"
            {
                    cell.TitleLabel.text = "Asset_Map".localized()
                    cell.centerImage.image = UIImage(named: "assetmap.png")
                    cell.AddImage.isHidden = true
                    cell.workOrderSearchBtn.isHidden = true
            }
            else  if dashBoardArray[indexPath.row] == "DASH_ONLINE_SEARCH_TILE"
            {
                cell.TitleLabel.text = "Search".localized()
                cell.addButton.isHidden = true
                cell.workOrderSearchBtn.isHidden = true
                cell.AddImage.isHidden = true
                cell.centerImage.image = UIImage(named: "search_icon.png")
                if applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_TILE"){
                    cell.workOrderSearchBtn.tag = 1006
                    cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
                    cell.addButton.isHidden = false
                    cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
                     cell.addButton.tag = 1007
                     cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
                    cell.workOrderSearchBtn.isHidden = false
                }
                if applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_WO"){
                    cell.workOrderSearchBtn.tag = 1006
                    cell.workOrderSearchBtn.addTarget(self, action: #selector(self.searchWorkOrders(sender:)), for: .touchUpInside)
                    cell.addButton.isHidden = false
                }
                if applicationFeatureArrayKeys.contains("DASH_ONLINE_SEARCH_NO"){
                     cell.addButton.setImage(UIImage.init(named: "notifi.png"), for: .normal)
                     cell.addButton.tag = 1007
                     cell.addButton.addTarget(self, action: #selector(self.searchNotifications(sender:)), for: .touchUpInside)
                    cell.workOrderSearchBtn.isHidden = false
                }
            }else  if dashBoardArray[indexPath.row] == "DASH_GENERAL_FORM_TILE"
            {
                
                    cell.TitleLabel.text = "General_Form".localized()
                    cell.centerImage.image = UIImage(named: "document.png")
                    cell.workOrderSearchBtn.isHidden = true
                    cell.addButton.isHidden = true
                    cell.AddImage.isHidden = true
            }

            return cell
        }

        return cell
    }
    
      public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView.tag == 901{

        }else if collectionView.tag == 900{
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
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_DB_SUP", orderType: "X",from:"WorkOrder")
                if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                    if workFlowObj.ActionType == "Screen" {
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
            }
            else if dashBoardArray[indexPath.row] == "DASH_TIMESHEET_TILE"
            {
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_DB_TIME", orderType: "X",from:"WorkOrder")
                    if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                        if workFlowObj.ActionType == "Screen" {
                            currentMasterView = "TimeSheet"
                            if DeviceType == iPad {
                                menuDataModel.uniqueInstance.presentTimeSheetScreen()
                            }else {
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
            }
            else if dashBoardArray[indexPath.row] == "DASH_ASSET_HIE_TILE"
            {
                 
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_DB_ASSTMAP", orderType: "X",from:"WorkOrder")
                      if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                            if workFlowObj.ActionType == "Screen" {
                                if DeviceType == iPad{
                                    ASSETMAP_TYPE = "ESRIMAP"
                                   assetmapVC.openmappage(id: "")
                                }else{
                                    ASSETMAP_TYPE = "ESRIMAP"
                                    currentMasterView = "WorkOrder"
                                    selectedworkOrderNumber = ""
                                    selectedNotificationNumber = ""
                                    let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                                        assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                                    self.present(assetMapDeatilsVC, animated: true, completion: nil)
                                }

                            }
                        }

            }else if dashBoardArray[indexPath.row] == "ODS_MYPLANNER"{
                let url = URL(string: "ODSmyPlanner:")
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                        print("Open url : \(success)")
                    })
                }
            }else if dashBoardArray[indexPath.row] == "ASSET_HIERARCHY"{
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_DB_HIRCHY", orderType: "X",from:"WorkOrder")
                    if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                        if workFlowObj.ActionType == "Screen" {
                            let assetHierarchyVC = ScreenManager.getAssetHierarchyScreen()
                                assetHierarchyVC.modalPresentationStyle = .fullScreen
                                self.present(assetHierarchyVC, animated: false, completion: nil)
                        }
                    }
            }else if dashBoardArray[indexPath.row] == "DASH_GENERAL_FORM_TILE"{
                let generalCheckSheetVC = ScreenManager.getGeneralCheckSheetScreen()
                    generalCheckSheetVC.modalPresentationStyle = .fullScreen
                self.present(generalCheckSheetVC, animated: false, completion: nil)
            }
        }
        
    }
    @objc func filterUpdated(sender : UIButton){
        
        filterSelectedIndex = sender.tag
        DispatchQueue.main.async {
            self.filterArray.removeAll()
            self.filterArray = self.filterObject[self.filterTitleArray[self.filterSelectedIndex]]!
            self.detailsTableView.reloadData()
            self.statusCollectionView.reloadData()
        }
    }
    
    
    @objc func searchWorkOrders(sender : UIButton){
        
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ONLINE_SEARCH", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    mJCLogger.log("search WorkOrders".localized(), Type: "")
                    if demoModeEnabled == true{
                        onlineSearch = false
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "We have limited features enabled in Demo mode", button: okay)
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
            }
    }
    @objc func searchNotifications(sender : UIButton){
      
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_NO_ONLINE_SEARCH", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    if sender.tag == 1007 {
                        mJCLogger.log("Search Notifications".localized(), Type: "")
                        if demoModeEnabled == true{
                            onlineSearch = false
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "We have limited features enabled in Demo mode", button: okay)
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
        
        if sender.tag == 1000
        {
            
            if self.WoPriorityArr.count == 0 {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Work orders not found", button: okay)
                
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
        else if sender.tag == 1001
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
        else if sender.tag == 1002
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
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "User is not Supervisor !", button: okay)
            }
        }
        
    }

    @objc func Addbuttontapped(sender : UIButton) {
        if sender.tag == 1000
        {
            menuDataModel.presentCreateWorkorderScreen(vc: self, isScreen: "WorkOrder", delegateVC: self)
        }else if sender.tag == 1001{
            menuDataModel.presentCreateJobScreen(vc: self)
        }else if sender.tag == 1004{
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_DB_TIME", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    menuDataModel.presentCreateTimeSheetScreen(vc: self, isFromScrn: "AddTimeSheet")
                }
            }
        }
    }
    @IBAction func allListButtonAction(_ sender: Any) {
        totalWorkorders.removeAllObjects()
        filterWorkorders.removeAllObjects()
        currentMasterView = "WorkOrder"
        menuDataModel.uniqueInstance.presentListSplitScreen()
    }
    
    @IBAction func plannerButtonAction(_ sender: Any) {
        
    }
    @IBAction func ActiveButtonAction(_ sender: Any) {
    }
    @IBAction func AddButtonAction(_ sender: Any) {
        
        if let header = FilterDict["Header"]{
             
            if header == "WorkOrder"{
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_DB_WO", orderType: "X",from:"WorkOrder")
                    if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                        if workFlowObj.ActionType == "Screen" {
                            menuDataModel.presentCreateWorkorderScreen(vc: self, isScreen: "WorkOrder", delegateVC: self)
                        }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                            myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
                        }else{
                            myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                        }
                    }
                
            }else if header == "Notification"{
                let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_DB_NO", orderType: "X",from:"WorkOrder")
                    if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                        if workFlowObj.ActionType == "Screen" {
                            menuDataModel.presentCreateJobScreen(vc: self, delegate: true)
                        }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                            myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
                        }else{
                            myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                        }
                    }
                }
            }
    }
    
    @IBAction func DasgBoardAction(_ sender: Any) {
        let dashboard = ScreenManager.getDashBoardScreen()
        self.appDeli.window?.rootViewController = dashboard
        self.appDeli.window?.makeKeyAndVisible()
    }
    //MARK:- Show@objc  Alert..
    
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
//        mJCLoader.stopAnimating()
        print("Store Flush And Refresh Done..")
        
        self.getWorkorderData(from: "")
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

    @IBAction func filterNavigationButtonAction(_ sender: Any) {
      
       // guard let legend = filterTitle else { return }
            if let arr = self.finalFiltervalues[filterTitle]{
               if let header = FilterDict["Header"]{
                  if header == "WorkOrder"{
                        totalWorkorders.removeAllObjects()
                        filterWorkorders.removeAllObjects()
                        totalWorkorders.addObjects(from: self.WorkOrderArray)
                        filterWorkorders.addObjects(from: arr)
                  }else if header == "Notification"{
                        totalNotifications.removeAllObjects()
                        filterNotifications.removeAllObjects()
                        totalNotifications.addObjects(from: self.NotificationArray)
                        filterNotifications.addObjects(from: arr)
                  }
                }
            }
        
        
        if let header = FilterDict["Header"]{
            if header == "WorkOrder"{
             if self.finalFiltervalues.count > 0{
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
             }else{
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "No workorders", button: okay)
             }
            }else if header == "Notification"{
           
            if self.finalFiltervalues.count > 0{
                 selectedworkOrderNumber = ""
                 selectedNotificationNumber = ""
                 currentMasterView = "Notification"
                 UserDefaults.standard.removeObject(forKey: "ListFilter")
             if DeviceType == iPad{
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
             }else{
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "No Notifications", button: okay)
             }
             
            }
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
    
    // MARK:- Supervisor
    func getTechnicianName(){
        
        mJCLogger.log("getTechnicianName start".localized(), Type: "")
        
        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "SupervisorTechnicianSet"}
        
        SupervisorTechnicianModel.getSupervisorTechncianDetails(){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [SupervisorTechnicianModel]{
                    self.techciandict.removeAllObjects()
                    for item in responseArr  {
                        let techid = item.Technician
                        self.techciandict[techid] = item.Name
                    }
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
}

