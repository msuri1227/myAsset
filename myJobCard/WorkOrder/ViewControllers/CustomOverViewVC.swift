//
//  OverViewVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/28/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class CustomOverViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CreateUpdateDelegate{
    
    //MARK:- Outlets..
    @IBOutlet var gotoTableView: UITableView!
    @IBOutlet var overViewTablView: UITableView!
    @IBOutlet var overviewButtonView: UIStackView!
    @IBOutlet var addNotificationButton: UIButton!
    @IBOutlet var editWorkOrderButton: UIButton!
    @IBOutlet var noteListButton: UIButton!
    @IBOutlet var workOrderDeleteButton: UIButton!
    @IBOutlet weak var onlineTransferBtn: UIButton!
    @IBOutlet var followonWoCreateButton: UIButton!
    @IBOutlet var sideTableViewView: UIView!
    @IBOutlet var nodataLabel: UIView!
    @IBOutlet weak var OverViewnewNoHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var OverViewEditWoHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var OverViewDeleteWoHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var OverViewNoteHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var NotesButtoniPhone: UIButton!
    @IBOutlet weak var topViewHightConstant: NSLayoutConstraint!
    @IBOutlet weak var ActiveView: UIView!
    @IBOutlet weak var actionTitleView: UIView!
    @IBOutlet weak var actionTitle: UILabel!
    @IBOutlet weak var QuickActioncView: UIView!
    @IBOutlet weak var RequiredActionView: UIView!
    @IBOutlet weak var quickActionsTableView: UITableView!
    @IBOutlet weak var ActionsRequiredTableView: UITableView!
    
    
    //MARK:- Declard Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var gotoArray = NSMutableArray()
    var singleWorkOrderArray = [WoHeaderModel]()
    var singleWorkOrderDictionary = NSMutableDictionary()
    var isfrom = String()
    var notificationArray = NSMutableArray()
    var personResponsibleArray = NSMutableArray()
    var isTranformHidden = true
    var AllowedFollOnObjTypArray = Array<AllowedFollowOnObjectTypeModel>()
    var hiddenSections = Set<Int>()
    var requiredActionsArray = Array<String>()
    var QuickActionsArray = ["Complete all operations","Issue all components","Capture Attachment","Upload Document"]
    var selectedbutton = String()
    var confirmOperationList = [String]()
    var selectedOperationArray = [WoOperationModel]()
    var selectedComponentArray = [WoComponentModel]()
    var property = NSMutableArray()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DeviceType == iPad{
            
            ODSUIHelper.setButtonLayout(button: self.addNotificationButton, cornerRadius: self.addNotificationButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.editWorkOrderButton, cornerRadius: self.editWorkOrderButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.noteListButton, cornerRadius: self.noteListButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.workOrderDeleteButton, cornerRadius: self.workOrderDeleteButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.onlineTransferBtn, cornerRadius: self.onlineTransferBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.followonWoCreateButton, cornerRadius: self.followonWoCreateButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            actionTitleView.layer.cornerRadius = 5.0
            NotificationCenter.default.addObserver(self, selector: #selector(CustomOverViewVC.reloadRequiredAction(notification:)), name:NSNotification.Name(rawValue:"reloadRequiredAction"), object: nil)
            self.gotoTableView.separatorStyle = .none
            self.gotoTableView.estimatedRowHeight = 50
            self.topViewHightConstant.constant = 300.0
            self.gotoTableView.delegate = self
            self.gotoTableView.dataSource = self
            self.gotoTableView.allowsSelection = true
            self.gotoTableView.bounces = false
            if isfrom == "Supervisor"{
                overviewButtonView.isHidden = true
            }else{
                overviewButtonView.isHidden = false
            }
            if onlineSearch == true {
                self.onlineTransferBtn.isHidden = false
            }else {
                self.onlineTransferBtn.isHidden = true
            }
            self.overViewTablView.estimatedRowHeight = 1000
            overViewTablView.rowHeight = UITableView.automaticDimension
            if !applicationFeatureArrayKeys.contains("Create_FollowUp_WO"){
                self.followonWoCreateButton.isHidden = true
            }else{
                self.getAllowedFollowOnObjectType()
                self.followonWoCreateButton.isHidden = false
            }
        }else{
            ODSUIHelper.setButtonLayout(button: self.NotesButtoniPhone, cornerRadius: self.NotesButtoniPhone.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            self.getNotificationList()
            NotificationCenter.default.addObserver(self, selector: #selector(CustomOverViewVC.StatusUpdated(notification:)), name:NSNotification.Name(rawValue:"StatusUpdated"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
            if isfrom == "Supervisor"
            {
                self.NotesButtoniPhone.isHidden = true
            }        }
        self.getPersonResponsibleList()
        self.gotoArray = ["Customer_Info_And_Overview".localized(),"Asset_And_Dates".localized(),"Additional_Data".localized()]
        self.overViewTablView.separatorStyle = .none
        overViewTablView.isScrollEnabled = true
        self.overViewTablView.delegate = self
        self.overViewTablView.dataSource = self
        ScreenManager.registerWorkOrderCell(tableView: self.overViewTablView)
        let headerNib = UINib.init(nibName: "ExpandableTableViewCell", bundle: Bundle.main)
        self.overViewTablView.register(headerNib, forCellReuseIdentifier: "ExpandableTableViewCell")
        self.viewWillAppear(false)
        self.setRemainsTaskText()
    }
    func setRemainsTaskText() {
        
        self.requiredActionsArray.removeAll()
        var orderType = String()
        if currentMasterView == "WorkOrder" {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                orderType = singleOperation.OrderType
            }else{
                orderType = singleWorkOrder.OrderType
            }
            if let featurs =  orderTypeFeatureDict.value(forKey: orderType){
                let featurelist = featurs as! NSMutableArray
                if featurelist.contains("OPERATION") && (WORKORDER_ASSIGNMENT_TYPE != "2" || WORKORDER_ASSIGNMENT_TYPE != "4"){
                    self.requiredActionsArray.append("Operations")
                }
                if  featurelist.contains("COMPONENT"){
                    self.requiredActionsArray.append("Components")
                }
                if isAttachmentDone == false && featurelist.contains("ATTACHMENT"){
                    self.requiredActionsArray.append("Attachments")
                }
                if featurelist.contains("RECORD_POINT"){
                    self.requiredActionsArray.append("Record Points")
                }
                if formColor == UIColor.red{
                    self.requiredActionsArray.append("Forms")
                }
                if singleWorkOrder.InspectionLot != "" && singleWorkOrder.InspectionLot != "000000000000" && featurelist.contains("INSPECTIONLOT") {
                    self.requiredActionsArray.append("Inspection Lot")
                }
            }
            if nil != self.ActionsRequiredTableView {
                DispatchQueue.main.async {
                    self.ActionsRequiredTableView.reloadData()
                }
            }
        }
    }
    @objc func StatusUpdated(notification : NSNotification) {
        self.overViewTablView.reloadData()
    }
    @objc func reloadRequiredAction(notification : NSNotification) {
        DispatchQueue.main.async {
            self.ActionsRequiredTableView.reloadData()
        }
    }
    func EntityCreated() {
        DispatchQueue.main.async {
            self.overViewTablView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if (selectedworkOrderNumber != "") {
            self.singleWorkOrderArray.append(singleWorkOrder)
        }
        if DeviceType == iPad{
            if selectedworkOrderNumber == ""{
                self.sideTableViewView.isHidden = true
                self.overViewTablView.isHidden = true
                self.nodataLabel.isHidden = false
                overviewButtonView.isHidden = true
            }else{
                self.overViewTablView.reloadData()
                self.sideTableViewView.isHidden = false
                self.overViewTablView.isHidden = false
                self.nodataLabel.isHidden = true
            }
        }else {
            currentsubView = "Overview"
            overViewTablView.isScrollEnabled = true
            self.overViewTablView.delegate = self
            self.overViewTablView.dataSource = self
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- Tableview Delegate & DataSource..
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 1001 || tableView.tag == 1002{
            return 1
        }else{
            return self.gotoArray.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1001{
            return self.QuickActionsArray.count
        }else if tableView.tag == 1002 {
            return self.requiredActionsArray.count
        }else{
            if DeviceType == iPad{
                if(tableView == gotoTableView) {
                    return gotoArray.count
                }else {
                    if self.hiddenSections.contains(section) {
                        return 0
                    }else{
                        return 1
                    }
                }
            }else{
                return 3
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if tableView.tag == 1001 || tableView.tag == 1002{
            return 40
        }else{
            return 60
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView.tag == 1001 {
            let headerView = UIView()
            headerView.frame = CGRect(x: 0, y:0, width: tableView.bounds.width, height: 40)
            headerView.backgroundColor = appColor
            let headerTitle = UILabel()
            headerTitle.frame = CGRect(x: 10, y: 0, width: headerView.bounds.width - 10, height: 40)
            headerTitle.textAlignment = .left
            headerTitle.textColor = .white
            headerTitle.text = "Quick Links"
            headerView.addSubview(headerTitle)
            return headerView
        }else if tableView.tag == 1002{
            let headerView = UIView()
            headerView.frame = CGRect(x: 0, y:0, width: tableView.bounds.width, height: 40)
            headerView.backgroundColor = appColor
            let headerTitle = UILabel()
            headerTitle.frame = CGRect(x: 10, y: 0, width: headerView.bounds.width - 10, height: 40)
            headerTitle.textAlignment = .left
            headerTitle.textColor = .white
            headerTitle.text = "Required Actions"
            headerView.addSubview(headerTitle)
            return headerView
        }else{
            let headerView = UIView()
            headerView.frame = CGRect(x: 0, y:0, width: tableView.bounds.width, height: 60)
            let headerView1 = UIView()
            headerView1.frame = CGRect(x: 0, y:10, width: headerView.bounds.width, height: 40)
            headerView1.backgroundColor = appColor
            headerView1.layer.borderWidth = 1.0
            headerView1.layer.borderColor = UIColor.white.cgColor
            headerView1.layer.cornerRadius = 5.0
            let headerTitle = UILabel()
            headerTitle.frame = CGRect(x: 10, y: 0, width: headerView.bounds.width - 10, height: 40)
            headerTitle.textAlignment = .left
            headerTitle.textColor = .white
            headerTitle.text = self.gotoArray[section] as? String ?? ""
            let arrowImage = UIImageView()
            arrowImage.frame = CGRect(x: headerView.bounds.width - 50, y: 5, width: 30, height: 30)
            arrowImage.tag = 700
            arrowImage.image = UIImage.init(named: "DownArrowWhite")
            let sectionButton = UIButton()
            sectionButton.tag = section
            sectionButton.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
            sectionButton.addTarget(self,
                                    action: #selector(self.hideSection(sender:)),
                                    for: .touchUpInside)
            headerView1.addSubview(headerTitle)
            headerView1.addSubview(arrowImage)
            headerView1.addSubview(sectionButton)
            headerView.addSubview(headerView1)
            return headerView
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1002{
            return UITableViewCell()
        }else if tableView.tag == 1001{
            return UITableViewCell()
        }else if(tableView == gotoTableView) {
            let overViewGoToCell = tableView.dequeueReusableCell(withIdentifier: "OverViewGoToCell") as! OverViewGoToCell
            overViewGoToCell.gotoDetailLabel.text = (gotoArray[indexPath.row] as? String)?.localized()
            overViewGoToCell.cellClickButton.tag = indexPath.row
            return overViewGoToCell
        }else {
            if singleWorkOrderArray.count > 0 {
                if let workorderClass = self.singleWorkOrderArray[0] as? WoHeaderModel {
                    if indexPath.section == 0{
                        if(indexPath.row == 0) {
                            let customerInfoOverViewCell =  ScreenManager.getCustomerInfoOverViewCell(tableView: tableView)
                            customerInfoOverViewCell.customerInfoNameLabel.text = singleWorkOrder.Name
                            customerInfoOverViewCell.customerInfoContactLabel.text = singleWorkOrder.PhoneNumber
                            customerInfoOverViewCell.customerInfoAddressLabel.text = workorderClass.Address
                            let activity = workorderClass.MaintActivityType + " - " + workorderClass.MaintActivityTypeText
                            if activity == " - " {
                                customerInfoOverViewCell.customerInfoActivityTypeLabel.text = ""
                            }else {
                                customerInfoOverViewCell.customerInfoActivityTypeLabel.text = activity
                            }
                            customerInfoOverViewCell.customerInfoDescriptionLabel.text = workorderClass.ShortText
                            var priority = String()
                            let priorityFilteredArray = globalPriorityArray.filter{ $0.Priority == workorderClass.Priority}
                            if priorityFilteredArray.count > 0 {
                                let obj = priorityFilteredArray[0]
                                priority = obj.PriorityText
                            }
                            let mobileStatus = WorkOrderDataManegeClass.uniqueInstance.setWorkOrderStatus(userStatus: workorderClass.UserStatus, mobileStatus: workorderClass.MobileObjStatus,woClass: workorderClass)
                            let mobileStatusDesc = ""
                            customerInfoOverViewCell.customerInfoPriorityLabel.text = priority
                            customerInfoOverViewCell.customerInfoTypeLabel.text = workorderClass.OrderType
                            customerInfoOverViewCell.customerInfoMobileStatusLabel.text = mobileStatusDesc
                            customerInfoOverViewCell.customerInfoCategoryLabel.text = workorderClass.Category + " - " + workorderClass.CategoryText
                            customerInfoOverViewCell.customerInfoNotificationLabel.text = workorderClass.NotificationNum
                            customerInfoOverViewCell.customerInfoPlantLabel.text = workorderClass.Plant
                            customerInfoOverViewCell.customerInfoPlanningPlantLabel.text = workorderClass.MaintPlanningPlant
                            if workorderClass.SchdStrtDate != nil{
                                customerInfoOverViewCell.customerInfoStartLabel.text = workorderClass.SchdStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                customerInfoOverViewCell.customerInfoStartLabel.text = ""
                            }
                            if DeviceType == iPhone{
                                isTranformHidden = false
                            }else{
                                customerInfoOverViewCell.customerInfoTransferHieght.constant = 65
                            }
                            if workorderClass.TransferPerson != "00000000"{
                                let newpredict = NSPredicate(format: "SELF.PersonnelNo == %@",workorderClass.TransferPerson)
                                let newfilterar = self.personResponsibleArray.filtered(using: newpredict) as! [PersonResponseModel]
                                if newfilterar.count > 0{
                                    let details = newfilterar[0]
                                    customerInfoOverViewCell.customerInfotransfertoview.isHidden = false
                                    if DeviceType == iPhone{
                                        isTranformHidden = false
                                    }
                                    customerInfoOverViewCell.customerInfotransfertoLabel.text = details.SystemID
                                }
                            }else if workorderClass.ToMainWorkCtr != ""{
                                customerInfoOverViewCell.customerInfotransfertoview.isHidden = false
                                if DeviceType == iPhone{
                                    isTranformHidden = false
                                }
                                customerInfoOverViewCell.customerInfotransfertoLabel.text = workorderClass.ToMainWorkCtr
                            }
                            customerInfoOverViewCell.customerInfoInspectionLotLabel.text = workorderClass.InspectionLot
                            return customerInfoOverViewCell
                        }
                    }else if indexPath.section == 1{
                        if(indexPath.row == 0) {
                            let assetAndDatesCell = ScreenManager.getAssetAndDatesCell(tableView: tableView)
                            assetAndDatesCell.assetEquipmentButton.tag = indexPath.row
                            assetAndDatesCell.assetEquipmentButton.setTitle(workorderClass.EquipNum, for: .normal)
                            assetAndDatesCell.assetEquipmentLabel.text = workorderClass.EquipNum
                            assetAndDatesCell.assetDescriptionLabel.text = workorderClass.TechObjDescription
                            assetAndDatesCell.assetLocationLabel.text = workorderClass.TechObjLocAndAssgnmnt
                            assetAndDatesCell.assetsystemConditionLabel.text = workorderClass.SysCondition + " - " + workorderClass.SysContitionText
                            assetAndDatesCell.assetFunctionLocationLabel.text = workorderClass.FuncLocation
                            assetAndDatesCell.assetFunctionLocationButton.setTitle(workorderClass.FuncLocation, for: .normal)
                            assetAndDatesCell.assetFunctionLocationButton.tag = indexPath.row
                            if workorderClass.BasicStrtDate != nil{
                                assetAndDatesCell.assetBasicStartLabel.text = workorderClass.BasicStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                assetAndDatesCell.assetBasicStartLabel.text = ""
                            }
                            if workorderClass.BasicFnshDate != nil{
                                assetAndDatesCell.assetDueDateLabel.text = workorderClass.BasicFnshDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                assetAndDatesCell.assetDueDateLabel.text = ""
                            }
                            if workorderClass.SchdStrtDate != nil{
                                assetAndDatesCell.assetScheduleStartLabel.text =  workorderClass.SchdStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                assetAndDatesCell.assetScheduleStartLabel.text = ""
                            }
                            if workorderClass.SchdFnshDate != nil{
                                assetAndDatesCell.assetScheduleFinishLabel.text = workorderClass.SchdFnshDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                assetAndDatesCell.assetScheduleFinishLabel.text = ""
                            }
                            if workorderClass.ActlStrtDate != nil{
                                assetAndDatesCell.assetActualStartLabel.text = workorderClass.ActlStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                assetAndDatesCell.assetActualStartLabel.text = ""
                            }
                            return assetAndDatesCell
                        }
                    }else if indexPath.section == 2{
                        if(indexPath.row == 0) {
                            let additionalDataOverViewCell = ScreenManager.getAdditionalDataOverViewCell(tableView: tableView)
                            if workorderClass.CreatedOn != nil{
                                additionalDataOverViewCell.additionalDataCreatedOnTextLabel.text =  workorderClass.CreatedOn!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                additionalDataOverViewCell.additionalDataCreatedOnTextLabel.text = ""
                            }
                            additionalDataOverViewCell.additionalDataBusinessAreaLabel.text = workorderClass.BusArea + " - " + workorderClass.BusAreaText
                            additionalDataOverViewCell.additionalDataControllingAreaLabel.text = workorderClass.ControllingArea
                            additionalDataOverViewCell.additionalDataWorkPermitLabel.text = workorderClass.WorkPermitIssued
                            additionalDataOverViewCell.additionalDataWBSLabel.text = workorderClass.WBSElem
                            additionalDataOverViewCell.additionalDataMainWorkCenterLabel.text = workorderClass.MainWorkCtr
                            additionalDataOverViewCell.additionalDataAssociatedPlantLabel.text = workorderClass.Plant
                            additionalDataOverViewCell.additionalDataRespPlannerGroupLabel.text = workorderClass.ResponsiblPlannerGrp
                            additionalDataOverViewCell.additionalDataMaintenansePlantUILabel.text = workorderClass.MaintPlant
                            if workorderClass.PersonResponsible != ""{
                                let newpredict = NSPredicate(format: "SELF.PersonnelNo == %@",workorderClass.PersonResponsible)
                                let newfilterar = self.personResponsibleArray.filtered(using: newpredict) as! [PersonResponseModel]
                                if newfilterar.count > 0{
                                    let details = newfilterar[0]
                                    additionalDataOverViewCell.additionalDataPersonResponsibleLabel.text = details.SystemID
                                }else{
                                    additionalDataOverViewCell.additionalDataPersonResponsibleLabel.text = ""
                                }
                            }else{
                                additionalDataOverViewCell.additionalDataPersonResponsibleLabel.text = ""
                            }
                            return additionalDataOverViewCell
                        }
                    }
                }
            }else{
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1001 || tableView.tag == 1002{
            return 40
        }else{
            if DeviceType == iPad{
                return UITableView.automaticDimension
            }else{
                if indexPath.row == 0 {
                    if isTranformHidden == false{
                        return 1020
                    }else{
                        return 910
                    }
                }else {
                    return 700.0
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1001{
            let value = QuickActionsArray[indexPath.row]
            if value == "Capture Attachment"{
                
            }
        }else{
            if(tableView == gotoTableView){
                let indexPath = IndexPath(row: indexPath.row, section: 0)
                self.overViewTablView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
            }
        }
    }
    
    @IBAction func topViewButtonAction(_ sender: UIButton) {
        if sender.isSelected == true{
            sender.isSelected = false
            self.topViewHightConstant.constant = 300.0
            self.RequiredActionView.isHidden = false
            self.QuickActioncView.isHidden = false
            sender.setImage(UIImage(named: "UpArrowWhite"), for: .normal)
        }else{
            sender.isSelected = true
            self.topViewHightConstant.constant = 14.0
            self.RequiredActionView.isHidden = true
            self.QuickActioncView.isHidden = true
            sender.setImage(UIImage(named: "DownArrowWhite"), for: .normal)
        }
    }
    @objc private func hideSection(sender: UIButton) {
        
        let section = sender.tag
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            for row in 0..<1 {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            return indexPaths
        }
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.overViewTablView.insertRows(at: indexPathsForSection(), with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.overViewTablView.deleteRows(at: indexPathsForSection(),
                                             with: .fade)
        }
        let headerview = self.overViewTablView.headerView(forSection: section)
        if headerview != nil{
            for view in headerview!.subviews {
                if view is UIImageView && view.tag == 700{
                    if self.hiddenSections.contains(section) {
                        (view as! UIImageView).image = UIImage(named: "UpArrowWhite")
                    } else {
                        (view as! UIImageView).image = UIImage(named: "DownArrowWhite")
                    }
                }
            }
        }
    }
    //MARK:- OverView Button Action..
    @IBAction func addNotificationButtonAction(sender: AnyObject) {
        mJCLogger.log("addNotificationButtonAction".localized(), Type: "")
        if isActiveWorkOrder == true {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_WO_NO", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    menuDataModel.presentCreateNotificationScreen(vc: self)
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
    
    @IBAction func followonWoCreateAction(_ sender: Any) {
        if AllowedFollOnObjTypArray.count > 0{
            DispatchQueue.main.async {
                menuDataModel.presentCreateWorkorderScreen(vc: self, isScreen: "WorkOrder", notificationNum: "", AllowedFollOnObjTypArray: self.AllowedFollOnObjTypArray, fromfollowOnWo: true, delegateVC: self)
            }
        }else{
            DispatchQueue.main.async {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Order_Type_Found".localized(), button: okay)
            }
        }
        
    }
    @objc func equipmentmapButtonAction(sener: UIButton){
        
        mJCLogger.log("equipmentmapButtonAction".localized(), Type: "")
        
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_ESRI_MAP", orderType: "X",from:"WorkOrder")
        
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            
            if workFlowObj.ActionType == "Screen" {
                if self.singleWorkOrderArray.count > 0 {
                    let workorderClass = self.singleWorkOrderArray[0]
                    
                    if workorderClass.EquipNum == "" {
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
                        return
                    }
                    if DeviceType == iPad {
                        assetmapVC.openmappage(id: workorderClass.EquipNum)
                    }else {
                        currentMasterView = "WorkOrder"
                        selectedNotificationNumber = ""
                        selectedEquipment = workorderClass.EquipNum
                        let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                        assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                        self.present(assetMapDeatilsVC, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func funlocmapbuttonAction(sender : UIButton){
        
        mJCLogger.log("funlocmapbuttonAction".localized(), Type: "")
        
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_FL_ESRI_MAP", orderType: "X",from:"WorkOrder")
        
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            
            if workFlowObj.ActionType == "Screen" {
                if self.singleWorkOrderArray.count > 0 {
                    let workorderClass = self.singleWorkOrderArray[0]
                    
                    if workorderClass.FuncLocation == "" {
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
                        return
                    }
                    if DeviceType == iPad {
                        assetmapVC.openmappage(id: workorderClass.FuncLocation)
                    }else {
                        currentMasterView = "WorkOrder"
                        selectedNotificationNumber = ""
                        selectedEquipment = workorderClass.FuncLocation
                        let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
                        assetMapDeatilsVC.modalPresentationStyle = .fullScreen
                        self.present(assetMapDeatilsVC, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    @IBAction func editWorkOrderButtonAction(sender: AnyObject) {
        
        mJCLogger.log("editWorkOrderButtonAction".localized(), Type: "")
        
        if (isActiveWorkOrder == true) || singleWorkOrder.WorkOrderNum.contains(find: "L") || Role_ID == "PLN"{
            
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "EDIT_WO", orderType: singleWorkOrder.OrderType,from:"WorkOrder")
            
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                
                if workFlowObj.ActionType == "Screen" {
                    menuDataModel.presentCreateWorkorderScreen(vc: self, isFromEdit: true, delegateVC: self)
                }
            }
        }
        else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
    }
    
    @IBAction func workOrderDeleteButtonAction(sender: AnyObject) {
        
        mJCLogger.log("workOrderDeleteButtonAction".localized(), Type: "")
        
        
        if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: singleWorkOrder.entity) == true && (selectedworkOrderNumber.contains(find: "L") || selectedworkOrderNumber.contains(find: "Temp")){
            
            if deletionValue == true {
                
                let params = Parameters(
                    title: alerttitle,
                    message: "Operations_Completed_Sucessfully".localized(),
                    cancelButton: "YES".localized(),
                    otherButtons: ["NO".localized()]
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0:
                        self.deleteWorkOrderFromList()
                    case 1: break
                    default: break
                    }
                }
            }
            else {
                
                self.deleteWorkOrderFromList()
                
            }
            
        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_cannot_mark_this_workorder_as_deleted".localized(), button: okay)
        }
        
    }
    
    func deleteWorkOrderFromList() {
        DispatchQueue.main.async {
            if myAssetDataManager.uniqueInstance.checkEntityisLocal(Entity: singleWorkOrder.entity) == true{
                WoHeaderModel.deleteWorkorderEntity(entity: singleWorkOrder.entity, options: nil, completionHandler: { (response, error) in
                    if error == nil {
                        mJCLogger.log("\(singleWorkOrder.WorkOrderNum) record deleted : Done", Type: "Debug")
                        menuDataModel.uniqueInstance.presentDashboardScreen()
                    }
                    else {
                        print("\(singleWorkOrder.WorkOrderNum) record deleted : Fail!")
                        mJCLogger.log("\(singleWorkOrder.WorkOrderNum) record deleted : Fail!", Type: "Error")
                    }
                })
            }else {
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_cannot_mark_this_workorder_as_deleted".localized(), button: okay)
            }
        }
    }
    
    @IBAction func noteListButtonAction(sender: AnyObject){
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_NOTES", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                mJCLogger.log("noteListButtonAction".localized(), Type: "")
                let noteListVC = ScreenManager.getLongTextListScreen()
                noteListVC.fromScreen = "woOverView"
                if isActiveWorkOrder == true || selectedworkOrderNumber.contains(find: "L"){
                    noteListVC.isAddNewNote = true
                    }
                self.present(noteListVC, animated: false) {}
                }
            }
    }
    
    //MARK:- Goto TableView Button Action..
    @objc func tapOnGotoCell(sender:UIButton) {
        
        mJCLogger.log("tapOnGotoCell".localized(), Type: "")
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        self.overViewTablView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
    }
    @objc func quickLinksAction(sender:UIButton) {
        
        if self.QuickActionsArray[sender.tag] == "Complete all operations" {
            if isActiveWorkOrder == true  {
                self.getConfirmationOpeartionSet()
            }
            else {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                }else{
                    mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                }
            }
            
        }else if self.QuickActionsArray[sender.tag] == "Issue all components"{
            if isActiveWorkOrder == true  {
                self.getComponentList()
            }
            else {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                }else{
                    mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                }
            }
        }else if self.QuickActionsArray[sender.tag] == "Capture Attachment"{
            if isActiveWorkOrder == true  {
                self.selectedbutton = "takePhoto"
                self.openCamera()
            }
            else {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                }else{
                    mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                }
            }
        }else if self.QuickActionsArray[sender.tag] == "Upload Document"{
            if isActiveWorkOrder == true  {
                self.selectedbutton = "choosePhoto"
                self.openPhotoLibrary()
            }
            else {
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    mJCAlertHelper.showAlert(self, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
                }else{
                    mJCAlertHelper.showAlert(self, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
                }
            }
        }
    }
    
    
    //MARK:- OverView Cell Button Action..
    //Function Location Button Action..
    @objc func assetFunctionLocationButtonAction(sender : UIButton) {
        
        //       let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_FUNCTLOC", orderType: "X",from:"WorkOrder")
        //        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
        //            if workFlowObj.ActionType == "Screen" {
        //
        //                mJCLogger.log("assetFunctionLocationButtonAction".localized(), Type: "")
        //                if sender.titleLabel?.text != "" && sender.titleLabel?.text != nil {
        //
        //                    FunctionalLocationModel.getFuncLocationDetails(funcLocation: "\((sender.titleLabel?.text)!)"){ (responseDict, error)  in
        //                        if error == nil{
        //                            if let responseArr = responseDict["data"] as? [FunctionalLocationModel]{
        //                                if responseArr.count > 0 {
        //
        //                                    if DeviceType == iPad{
        //                                        let functionalLocationOverView = ScreenManager.getFunctionalLocationOverViewScreen()
        //                                        functionalLocationOverView.isFrom = "WorkOrder"
        //                                        functionalLocationOverView.funcLocOverviewModel.functionalLocationNumber = (sender.titleLabel?.text)!
        //                                        functionalLocationOverView.funcLocOverviewModel.functionalLocationArray = responseArr
        //                                        functionalLocationOverView.modalPresentationStyle = .fullScreen
        //                                        self.present(functionalLocationOverView, animated: false) {}
        //
        //                                    }else{
        //
        //                                        let mainViewController = ScreenManager.getFunctionalLocationOverViewScreen()
        //                                        mainViewController.funcLocOverviewModel.functionalLocationNumber = (sender.titleLabel?.text)!
        //                                        mainViewController.funcLocOverviewModel.functionalLocationArray = responseArr
        //                                        mainViewController.isFrom = "WorkOrder"
        //                                        myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
        //                                        myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
        //                                        myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
        //                                        myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
        //                                        self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
        //                                        self.appDeli.window?.makeKeyAndVisible()
        //                                        myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        //                                    }
        //                                }
        //                                else {
        //
        //                                    mJCLogger.log("No_data_available_for_this_functional_location".localized()
        //                                                  , Type: "Error")
        //                                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_for_this_functional_location".localized(), button: okay)
        //                                }
        //                            }else{
        //
        //                            }
        //                        }else{
        //                            mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
        //                        }
        //                    }
        //
        //                }
        //            }
        //        }
        
    }
    @objc func speakaddress(sender : UIButton){
        mJCLogger.log("speakaddress".localized(), Type: "")
        ReadAndWriteModelclass.uniqueInstance.ReadText(text: singleWorkOrder.Address)
    }
    @objc func speakdescription(sender : UIButton){
        
        if self.singleWorkOrderArray.count > 0 {
            let workorderClass = self.singleWorkOrderArray[0]
            ReadAndWriteModelclass.uniqueInstance.ReadText(text: workorderClass.ShortText)
        }
    }
    
    
    //Notification Button Action..
    @objc func customerInfoNotificationButtonAction(sender: UIButton!) {
        
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_NO", orderType: "X",from:"WorkOrder")
        
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            
            if workFlowObj.ActionType == "Screen" {
                if isfrom != "Supervisor" {
                    if self.singleWorkOrderArray.count > 0 {
                        if DeviceType == iPad{
                            let workorderClass = self.singleWorkOrderArray[0]
                            menuDataModel.uniqueInstance.presentSingleNotificationScreen(vc: self, woClass: workorderClass)
                        }else{
                            currentMasterView = "Notification"
                            UserDefaults.standard.removeObject(forKey: "ListFilter")
                            let workorderClass = self.singleWorkOrderArray[0]
                            selectedNotificationNumber = workorderClass.NotificationNum
                            isSingleNotification = true
                            isSingleNotifFromWorkOrder = true
                            let mainViewController = ScreenManager.getMasterListDetailScreen()
                            mainViewController.workorderNotification = true
                            myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: mainViewController, menuType: "")
                        }
                    }
                }
                else {
                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
                }
            }
        }
        
    }
    
    
    //Equipment Button Action..
    @objc func assetEquipmentButtonAction(sender : UIButton) {
        
        //        mJCLogger.log("assetEquipmentButtonAction".localized(), Type: "")
        //        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_EQPMNT", orderType: "X",from:"WorkOrder")
        //        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
        //            if workFlowObj.ActionType == "Screen" {
        //                if sender.titleLabel?.text != "" && sender.titleLabel?.text != nil {
        //
        //                    EquipmentModel.getEquipmentDetails(equipNum: (sender.titleLabel?.text)!){ (responseDict, error)  in
        //                        if error == nil{
        //                            if let responseArr = responseDict["data"] as? [EquipmentModel]{
        //                                if responseArr.count > 0 {
        //
        //                                    if DeviceType == iPad{
        //                                        let equipmentVC = ScreenManager.getEquipmentScreen()
        //                                        equipmentVC.equipmentModel.equipmentNumber = (sender.titleLabel?.text)!
        //                                        equipmentVC.isFrom = "WorkOrder"
        //                                        equipmentVC.equipmentModel.equipmentArray = responseArr
        //                                        equipmentVC.modalPresentationStyle = .fullScreen
        //                                        self.present(equipmentVC, animated: false) {}
        //                                    }else{
        //
        //                                        let mainViewController = ScreenManager.getEquipmentScreen()
        //                                        mainViewController.equipmentModel.equipmentNumber = (sender.titleLabel?.text)!
        //                                        mainViewController.equipmentModel.equipmentArray = responseArr
        //                                        mainViewController.isFrom = "WorkOrder"
        //                                        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Equipment"
        //                                        UserDefaults.standard.set("overView", forKey: "equipmenu")
        //
        //                                        myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
        //                                        myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
        //                                        myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
        //                                        myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
        //                                        self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
        //                                        self.appDeli.window?.makeKeyAndVisible()
        //                                        myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        //                                    }
        //                                }
        //                                else {
        //                                    mJCLogger.log("No_data_available_for_this_equipment".localized(), Type: "Error")
        //                                    mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_data_available_for_this_equipment".localized(), button: okay)
        //                                }
        //                            }
        //                        }
        //                        else {
        //                            mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
        //                        }
        //
        //                    }
        //
        //                }else{
        //                    mJCLogger.log("Equipment_Not_Found".localized(), Type: "Error")
        //                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
        //                }
        //            }
        //        }
    }
    //InspectionLotInfo Button Action..
    @objc func customerInfoInspectionLotInfoButtonAction(sender: UIButton!){
        let inspectionLot = singleWorkOrder.InspectionLot
        if inspectionLot == "000000000000" || inspectionLot == ""{
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Inspection_Lot_Not_Available".localized(), button: okay)
            return
        }
        InspectionLotModel.getInspLotDetails(inspLotNum: inspectionLot){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [InspectionLotModel]{
                    if responseArr.count > 0 {
                        let lotDetails = responseArr[0]
                        DispatchQueue.main.async{
                            let lotPopUp = Bundle.main.loadNibNamed("InspectionLotOverview", owner: self, options: nil)?.last as! InspectionLotOverview
                            
                            lotPopUp.inspectionLotLabel.text = lotDetails.InspLot
                            lotPopUp.createdByLabel.text = lotDetails.EnteredBy
                            
                            if lotDetails.CreatedOnDate != nil{
                                lotPopUp.createdOnLabel.text = lotDetails.CreatedOnDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                lotPopUp.createdOnLabel.text = ""
                            }
                            
                            if lotDetails.InspectionStartsOnDate != nil{
                                lotPopUp.inspectionStartLabel.text = lotDetails.InspectionStartsOnDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                lotPopUp.inspectionStartLabel.text = ""
                            }
                            
                            if lotDetails.InspectionEndsOnDate != nil{
                                lotPopUp.inspectionEndLabel.text = lotDetails.InspectionEndsOnDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }else{
                                lotPopUp.inspectionEndLabel.text = ""
                            }
                            
                            lotPopUp.sampleSizeLabel.text = "\(lotDetails.SampleSize)"
                            lotPopUp.ActualInspQtyLabel.text = "\(lotDetails.SampleQtyActuallyInspected)"
                            lotPopUp.destroyedQtyLabel.text = "\(lotDetails.SampleQtyDestroyed)"
                            lotPopUp.defectiveQtyLabel.text = "\(lotDetails.SampleQtyDefective)"
                            lotPopUp.valuationLabel.text = lotDetails.CodeValuation
                            lotPopUp.systemStatusLabel.text = lotDetails.SyStDscr
                            
                            let windows = UIApplication.shared.windows
                            let lastWindow = windows.last
                            lotPopUp.frame = UIScreen.main.bounds
                            lotPopUp.popUpViewUI()
                            lastWindow?.addSubview(lotPopUp)
                        }
                    }else{
                        
                    }
                }
            }
            else {
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        
    }
    
    //MARK:- Notification methods..
    func getNotificationList() {
        NotificationModel.getWoNotificationDetailsWith(NotifNum: singleNotification.Notification){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationModel]{
                    if responseArr.count > 0 {
                        singleNotification = responseArr[0]
                    }else{
                        
                    }
                }else{
                    
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    
    //MARK:- Get Person Responsible List..
    func getPersonResponsibleList() {
        self.personResponsibleArray.removeAllObjects()
        if globalPersonRespArray.count > 0 {
            self.personResponsibleArray.addObjects(from: globalPersonRespArray)
        }
    }
    
    func getAllowedFollowOnObjectType() {
        AllowedFollowOnObjectTypeModel.getAllowedFollowOnObjectTypeList(objectType: singleWorkOrder.OrderType, roleId: Role_ID){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [AllowedFollowOnObjectTypeModel]{
                    self.AllowedFollOnObjTypArray = responseArr
                }else{
                    
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    
    func backButtonClicked(_ sender: UIButton?){
        
    }
    //MARK:- Quick Link Actions..
    func openPhotoLibrary() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            
            isSupportPortait = true
            let imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.formSheet
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: false, completion: nil)
        }
    }
    func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
            isSupportPortait = true
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera;
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .photo
            
            
            self.present(imagePicker, animated: false, completion: nil)
        }
        else {
            mJCAlertHelper.showAlert(self, title: sorrytitle, message: "There_is_no_camera_available_on_this_device".localized(), button: okay)
        }
    }
    //MARK:- UIImagePickerController Delegate..
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        isSupportPortait = false
        self.dismiss(animated: false) {}
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        isSupportPortait = false
        if #available(iOS 13.0, *){
            
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentScreen()
            uploadAttachmentVC.isFromScreen = "WORKORDER"
            uploadAttachmentVC.objectNum = selectedworkOrderNumber
            
            
            var arr = NSArray()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy_HHmmss"
            let dateString = dateFormatter.string(from: NSDate() as Date)
            
            if self.selectedbutton == "takePhoto" || self.selectedbutton == "choosePhoto" {
                
                if self.selectedbutton == "takePhoto" {
                    
                    uploadAttachmentVC.fileType = "JPG"
                }
                else {
                    let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                    let newFileName = imageURL.lastPathComponent!
                    arr = (newFileName.components(separatedBy: ".")) as NSArray
                    uploadAttachmentVC.fileType = (arr[1] as! String).lowercased()
                }
                
                self.selectedbutton = ""
                let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                uploadAttachmentVC.fileName  = "IMAGE_\(dateString)"
                uploadAttachmentVC.image = chosenImage
                uploadAttachmentVC.attachmentType = "Image"
                uploadAttachmentVC.modalPresentationStyle = .fullScreen
                self.dismiss(animated: false, completion: {
                    self.present(uploadAttachmentVC, animated: false) {}
                })
            }
        }
    }
    //MARK:- Complete All Operations..
    func getConfirmationOpeartionSet() {
        
        let defineQuery = "$filter=(WorkOrderNum eq '\(selectedworkOrderNumber)' and Complete eq 'X')&$select=OperationNum,WorkOrderNum"
        
        WoOperationModel.getWoConfirmationSet(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoOperationModel]{
                    if responseArr.count > 0 {
                        self.selectedOperationArray.removeAll()
                        var arr = [String]()
                        for item in responseArr{
                            arr.append(item.OperationNum)
                        }
                        self.confirmOperationList = arr
                    }
                    self.getOpeartionData()
                }
            }else{
                
            }
        }
        
    }
    func getOpeartionData() {
        
        
        let defineQuery = "$filter=(WorkOrderNum eq '\(selectedworkOrderNumber)'and startswith(SystemStatus,'" + "DLT" + "') ne true)&$orderby=OperationNum,SubOperation"
        WoOperationModel.getOperationList(filterQuery: defineQuery){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [WoOperationModel]{
                    self.selectedOperationArray.removeAll()
                    if responseArr.count > 0 {
                        self.selectedOperationArray = responseArr
                        self.completeBulkOperationMethod(count: 0)
                    }else{
                        
                    }
                }else{
                    
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
    }
    
    func completeBulkOperationMethod(count:Int){
        
        let mobStatusCode = WorkOrderDataManegeClass.uniqueInstance.getMobileStatusCode(status: "CNF")
        if self.selectedOperationArray.count == count{
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Operations not availble to complete".localized(), button: okay)
        }else{
            let singleOperationClass = self.selectedOperationArray[count]
            
            if singleOperationClass.SystemStatus != mobStatusCode && !singleOperationClass.OperationNum.contains("L"){
                (singleOperationClass.entity.properties["SystemStatus"] as! SODataProperty).value = mobStatusCode as NSObject
                
                WoOperationModel.updateOperationEntity(entity: singleOperationClass.entity, options: nil, completionHandler: { (response, error) in
                    
                    if(error == nil) {
                        
                        singleOperationClass.isCompleted = true
                        self.completeOperation(singleOperationClass: singleOperationClass, Count: count)
                        
                    }
                    else {
                        
                        mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_update_operation_try_again".localized(), button: okay)
                    }
                })
                
            }else{
                self.completeBulkOperationMethod(count:count + 1)
            }
            
        }
    }
    func completeOperation(singleOperationClass: WoOperationModel,Count:Int) {
        
        
        let singleOperationClass = singleOperationClass
        
        print("completeOperation conformation == \(singleOperationClass.OperationNum)")
        
        let property = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "ConfNo")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfCounter")
        
        let count = self.confirmOperationList.count+1
        print("confirmOperationList count == \(self.confirmOperationList.count)")
        let confCounter = myAssetDataManager.uniqueInstance.getObjectByAppendingZero(Max: 8, Num: "\(count)")
        prop!.value = confCounter as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = singleOperationClass.OperationNum as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "SubOper")
        prop!.value = singleOperationClass.SubOperation as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Split")
        prop!.value = 0 as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "PostgDate")
        prop!.value = Date().localDate() as NSObject
        property.add(prop!)
        
        
        prop = SODataPropertyDefault(name: "ExCreatedDate")
        prop!.value = NSDate()
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ExCreatedTime")
        let basicTime = SODataDuration()
        let time = Date().toString(format: .custom("HH:mm"))
        let basicTimeArray = time.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
        basicTime.seconds = 0
        prop!.value = basicTime
        property.add(prop!)
        
        
        prop = SODataPropertyDefault(name: "Plant")
        prop!.value = singleOperationClass.Plant as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkCntr")
        prop!.value = singleOperationClass.WorkCenter as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FinConf")
        prop!.value = STATUS_SET_FLAG as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Complete")
        prop!.value = STATUS_SET_FLAG as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ConfText")
        prop!.value = OPERATION_COMPLETE_TEXT as NSObject
        property.add(prop!)
        
        
        prop = SODataPropertyDefault(name: "PersNo")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: workOrderConfirmationEntity)
        
        for prop in property {
            
            let proper = prop as! SODataProperty
            entity?.properties[proper.name] = proper
            print("Key : \(String(describing: proper.name))")
            print("Value :\(proper.value!)")
            print("...............")
        }
        
        WoOperationModel.createWoConfirmationEntity(entity: entity!, collectionPath: woConfirmationSet, options: nil, completionHandler: { (response, error) in
            
            DispatchQueue.main.async {
                
                if(error == nil) {
                    
                    print("\(singleOperationClass.OperationNum) Confirmation Posted")
                    mJCLogger.log("\(singleOperationClass.OperationNum) Confirmation Posted".localized(), Type: "")
                    singleOperationClass.isCompleted = true
                    
                    self.confirmOperationList.append(singleOperationClass.OperationNum)
                    
                    if self.selectedOperationArray.count == Count + 1 {
                        self.getConfirmationOpeartionSet()
                        
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Operations_Completed_Sucessfully".localized() , button: okay)
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue:"setOperationCountNotification"), object: "")
                    }else{
                        
                        self.completeBulkOperationMethod(count:Count + 1)
                    }
                }
                else {
                    print("Confirmation fails")
                    mJCLogger.log("Confirmation fails".localized(), Type: "")
                }
            }
        })
        
    }
    //MARK:- issue All components..
    
    func getComponentList() {
        
        var defineQuery = String()
        
        if isfrom == "Supervisor"{
            
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && WO_OP_OBJS_DISPLAY == "X"{
                defineQuery = "$filter=WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27 and OperAct%20eq%20%27" + selectedOperationNumber + "%27&$orderby=Item"
            }else{
                defineQuery = "$filter=WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27&$orderby=Item"
            }
            
            WoComponentModel.getSuperVisorComponentsListCount(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [WoComponentModel]{
                        if responseArr.count > 0{
                            self.selectedComponentArray = responseArr
                            self.componentIssueSet(count: 0)
                        }else{
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Components not available to issue", button: okay)
                        }
                    }
                }
                else {
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
            
        }else{
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && WO_OP_OBJS_DISPLAY == "X"{
                defineQuery = "$filter=WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27 and OperAct%20eq%20%27" + selectedOperationNumber + "%27 and Deleted eq false &$orderby=Item"
            }else{
                defineQuery = "$filter=WorkOrderNum%20eq%20%27" + selectedworkOrderNumber + "%27 and Deleted eq false&$orderby=Item"
            }
            WoComponentModel.getSuperVisorComponentsListCount(filterQuery: defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [WoComponentModel]{
                        if responseArr.count > 0{
                            self.selectedComponentArray = responseArr
                            self.componentIssueSet(count: 0)
                        }else{
                            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Components not available to issue", button: okay)
                        }
                    }
                }
                else {
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        
    }
    
    func componentIssueSet(count:Int) {
        
        let componentClass = selectedComponentArray[count]
        if selectedComponentArray.count == count{
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Components not available to issue", button: okay)
        }else{
            if componentClass.ReqmtQty == componentClass.WithdrawalQty || componentClass.Reservation == ""{
                self.componentIssueSet(count: count + 1)
            }else{
                
                self.property = NSMutableArray()
                var prop : SODataProperty! = SODataPropertyDefault(name: "Item")
                prop!.value = componentClass.Item as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "Material")
                prop!.value = componentClass.Material as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "Plant")
                prop!.value = componentClass.Plant as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "StorLocation")
                prop!.value = componentClass.StorLocation as NSObject
                self.property.add(prop!)
                
                //                prop = SODataPropertyDefault(name: "Counter")
                //                prop!.value = String.random(length: 2, type: "Number") as NSObject
                //                self.property.add(prop!)
                
                //                prop = SODataPropertyDefault(name: "IssueQty")
                //                let issueQuantity  =  componentClass.ReqmtQty - componentClass.WithdrawalQty
                //                prop!.value = NSDecimalNumber(string: "\(issueQuantity)")
                //                self.property.add(prop!)
                
                
                prop = SODataPropertyDefault(name: "UOM")
                prop!.value = componentClass.BaseUnit as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "WorkOrderNum")
                prop!.value = selectedworkOrderNumber as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "MovementType")
                prop!.value = componentClass.MovementType as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "OperAct")
                prop!.value = componentClass.OperAct as NSObject
                self.property.add(prop!)
                
                prop = SODataPropertyDefault(name: "Reservation")
                prop!.value = componentClass.Reservation as NSObject
                self.property.add(prop!)
                
                print("===== Issue Component Key Value ======")
                
                let entity = SODataEntityDefault(type: woComponentIssueSetEntity)
                for prop in self.property {
                    
                    let proper = prop as! SODataProperty
                    entity?.properties[proper.name] = proper
                    print("Key : \(String(describing: proper.name))")
                    print("Value :\(proper.value!)")
                    print("..............")
                }
                
                WoComponentIssueModel.issueComponentEntity(entity:entity!, collectionPath: woComponentIssueSet, options: nil, completionHandler: { (response, error) in
                    
                    DispatchQueue.main.async {
                        
                        if(error == nil) {
                            mJCLogger.log("\(componentClass.Item)-\(componentClass.Material)  component issued".localized(), Type: "")
                            self.updateWithdrawalQtyComponent(componentClass:self.selectedComponentArray[count] as! WoComponentModel, count: count)
                        }
                        else {
                            print("Error : \(String(describing: error?.localizedDescription))")
                            mJCLogger.log("Error : \(String(describing: error?.localizedDescription))", Type: "Error")
                        }
                    }
                })
            }
        }
    }
    func updateWithdrawalQtyComponent(componentClass:WoComponentModel,count:Int){
        
        
        mJCLogger.log("updateWithdrawalQtyComponent start".localized(), Type: "")
        
        let withdrawn = componentClass.ReqmtQty
        let withdrawalQty = "\(withdrawn).00"
        
        (componentClass.entity.properties["WithdrawalQty"] as! SODataProperty).value = NSDecimalNumber(string: "\(withdrawalQty)")
        componentClass.WithdrawalQty = withdrawn
        
        WoComponentIssueModel.updateIssueComponentEntity(entity: componentClass.entity, options: nil, completionHandler: { (response, error) in
            
            DispatchQueue.main.async {
                
                if(error == nil) {
                    
                    mJCLogger.log("\(componentClass.Item)-\(componentClass.Material) withdrwal component updated".localized(), Type: "Debug")
                    if self.selectedComponentArray.count == count + 1{
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue:"setComponentBadgeIcon"), object: "")
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Issued_Components_Sucessfully".localized(), button: okay)
                        isComponentIssueDone = true
                        
                        
                    }else{
                        self.componentIssueSet(count: count + 1)
                    }
                    
                }
                else {
                    print("Update Withdrawal Qty Component : fail")
                    mJCLogger.log("Update Withdrawal Qty Component : fail".localized(), Type: "Error")
                }
            }
        })
        
    }
    //...END...//
}
