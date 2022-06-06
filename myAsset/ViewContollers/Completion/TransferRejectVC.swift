//
//  TransferRejectVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/23/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class TransferRejectVC: UIViewController,UITextViewDelegate,UITextFieldDelegate,personResponsibleDelegate,timeSheetDelegate,viewModelDelegate{
    
    
    //MARK:- TransferView Outlets..
    @IBOutlet var transferHeaderLabel: UILabel!
    @IBOutlet var backButton: UIButton!

    // transferReason outlets
    @IBOutlet weak var transferReasonView: UIView!
    @IBOutlet var transferReasonButtonView: UIView!
    @IBOutlet var transferReasonLabel: UILabel!
    @IBOutlet var transferReasonButton: UIButton!

    @IBOutlet weak var priorityView: UIView!
    @IBOutlet var transferPriorityButtonView: UIView!
    @IBOutlet var transferPriorityLabel: UILabel!
    @IBOutlet var transferPriorityButton: UIButton!

    @IBOutlet weak var notesView: UIView!
    @IBOutlet var transferNoteView: UIView!
    @IBOutlet var transferNoteLabel: UILabel!
    @IBOutlet var transferNoteTextView: UITextView!

    @IBOutlet weak var transferToView: UIView!
    @IBOutlet var transferToUserButtonView: UIView!
    @IBOutlet weak var titleType: UILabel!
    @IBOutlet var transferToUserButton: UIButton!


    //MARK:- Declared Variables..
    let dropDown = DropDown()
    var rejectString = NSString()
    var priorityValue = String()
    var screenfrom = String()
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var presentPerson = String()
    var transferReasonArray = [ReasonCodeModel]()
    var transferReasonListArray = [String]()
    var priorityArray = [PriorityListModel]()
    var priorityListArray = [String]()
    var personResponsibleArray = [PersonResponseModel]()
    var personResponsibleListArray = [String]()
    var rejectReasonArray = [ReasonCodeModel]()
    var rejectReasonListArray = [String]()
    var noteArray = [LongTextModel]()
    var subStringArr = NSMutableArray()
    @objc var PriorityText = String()
    var workCentersArray = [WorkCenterModel]()
    var workCentersListArray = [String]()
    var notePropertyArr = NSMutableArray()
    var transferOperationClass = WoOperationModel()
    var statusCategoryCls = StatusCategoryModel()

    var woLongTextVM = woLongTextViewModel()
    var noLongTextVM = noLongTextViewModel()

    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")

        if screenfrom == "Notification"{
            noLongTextVM.delegate = self
            noLongTextVM.noObj = singleNotification
            noLongTextVM.userId = "\(strUser)".uppercased()
            noLongTextVM.getNoLongText()
        }else{
            woLongTextVM.woObj = singleWorkOrder
            woLongTextVM.oprObj = singleOperation
            woLongTextVM.delegate = self
            woLongTextVM.userId = "\(strUser)".uppercased()
            if WORKORDER_ASSIGNMENT_TYPE == "1"  || WORKORDER_ASSIGNMENT_TYPE == "3"{
                self.woLongTextVM.getWoLongText()
            }else{
                self.woLongTextVM.getOprLongText()
            }
        }
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if rejectString .isEqual(to: "Reject") {
            self.priorityView.isHidden = true
            self.transferToView.isHidden = true
            if screenfrom == "WorkOrder"{
                self.transferHeaderLabel.text = "Reject_Work_Order".localized()
                self.transferReasonLabel.text = "Reject_Reason".localized()
            }else if screenfrom == "Notification"{
                self.transferReasonLabel.text = "Reject_Reason".localized()
                self.transferHeaderLabel.text = "Reject_Notification".localized()
            }
            self.getRejectReasonData()
        }else if rejectString.isEqual(to: "Transfer") {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                self.priorityView.isHidden = true
            }else{
                self.priorityView.isHidden = false
            }
            if onlineSearch == true {
                self.titleType.text = "Assigned_To".localized()
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    self.transferHeaderLabel.text = "Assign_Operation".localized()
                }else{
                    self.transferHeaderLabel.text = "Assign_Work_Order".localized()
                }
                self.transferReasonView.isHidden = true
                self.transferReasonView.isHidden = true
                self.notesView.isHidden = true
                self.transferReasonLabel.isHidden = true
                
            }else {
                self.titleType.text = "Transfer_To".localized()
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    self.transferHeaderLabel.text = "Transfer_Operation".localized()
                }else{
                    self.transferHeaderLabel.text = "Transfer_Work_Order".localized()
                }
                self.transferReasonView.isHidden = false
            }
            self.transferToView.isHidden = false
            self.transferReasonLabel.text = "Transfer_Reason".localized()
            self.getTransferReasonData()
            self.getPersonResponsibleList()
            self.getPriorityList()
        }else if rejectString.isEqual(to: "Complete"){
            if screenfrom == "Notification"{
                self.priorityView.isHidden = true
                self.transferToView.isHidden = true
                self.transferReasonView.isHidden = true
                self.transferReasonView.isHidden = true
                self.transferHeaderLabel.text = "Complete_Notification".localized()
            }
        }
        var priority = String()
        let priorityFilteredArray = globalPriorityArray.filter{ $0.Priority == priorityValue}
        if priorityFilteredArray.count > 0 {
            let obj = priorityFilteredArray[0]
            priority = obj.PriorityText
        }
        self.transferPriorityButton.setTitle(priority, for: .normal)
        self.setViewLayout(view: self.transferReasonButtonView)
        self.setViewLayout(view: self.transferPriorityButtonView)
        self.setViewLayout(view: self.transferNoteView)
        self.setViewLayout(view: self.transferToUserButtonView)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            let anchorView = self.dropDown.anchorView as! UIView
            
            if anchorView.tag == 1000 {
                self.transferReasonButton.setTitle(item, for: .normal)
            }else if anchorView.tag == 1001 {
                self.transferPriorityButton.setTitle(item, for: .normal)
            }else if anchorView.tag == 1002 {
                self.transferToUserButton.setTitle(item, for: .normal)
            }
            self.dropDown.hide()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(TransferRejectVC.updatedStatusSuccessfully(notification:)), name:NSNotification.Name(rawValue: "StatusUpdated"), object: nil)
        if onlineSearch == true{
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(TransferRejectVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }

    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "longTextFetch"{
            if let textArr = object as? [LongTextModel]{
                self.noteArray = textArr
            }
        }else if type == "longTextCreated"{

        }
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.stopAnimating()
        DispatchQueue.main.async{
            self.dismiss(animated: false, completion: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setViewLayout(view:UIView) {
        mJCLogger.log("Starting", Type: "info")
        view.layer.borderColor = appColor.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 3.0
        view.layer.masksToBounds = true
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //Notification..
    @objc func updatedStatusSuccessfully(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        var msg = String()
        if self.rejectString.isEqual(to: "Reject"){
            if screenfrom == "Notification"{
                msg = "Notification_Rejected_completed".localized()
            }else{
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                    msg = "Operation_Rejected_successfully".localized()
                }else{
                    msg = "Work_Order_Rejected_successfully".localized()
                }
            }
        }else if self.rejectString.isEqual(to: "Complete"){
            msg = "Notification_Completed_successfully".localized()
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                msg = "Operation_Transfer_successfully".localized()
            }else{
                msg = "Work_Order_Transferred_successfully".localized()
                
            }
        }
        DispatchQueue.main.async{
            let alert = UIAlertController(title: MessageTitle, message: msg as String, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: okay, style: UIAlertAction.Style.default, handler: {_ in 
                self.dismiss(animated: false) {}
            }))
            self.present(alert, animated: true, completion: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- get Hold Reason Data..
    func getTransferReasonData() {
        mJCLogger.log("Starting", Type: "info")
        var statusCategory = String()
        if screenfrom == "Notification"{
            statusCategory = NotificationLevel
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                statusCategory = WorkorderLevel
            }else if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                statusCategory = OperationLevel
            }
        }
        let query = "$filter=(Type eq '\(STATUS_TRANSFER)' and ObjectCategory eq '\(statusCategory)')"
        ReasonCodeModel.getResonCodeList(filterQuery:query){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [ReasonCodeModel]{
                    DispatchQueue.main.async {
                        self.transferReasonArray = responseArr
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        for itemCount in 0..<responseArr.count {
                            let reasonCodeSetClass = responseArr[itemCount]
                            self.transferReasonListArray.append(reasonCodeSetClass.Reason)
                        }
                        if self.transferReasonListArray.count > 0 {
                            self.transferReasonButton.setTitle(self.transferReasonListArray[0], for: .normal)
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get PriorityList..
    func getPriorityList() {
        mJCLogger.log("Starting", Type: "info")
        self.priorityArray.removeAll()
        self.priorityListArray.removeAll()
        if globalPriorityArray.count > 0 {
            let array = globalPriorityArray.sorted(by: { $0.Priority < $1.Priority})
            self.priorityArray = array
            for item in self.priorityArray {
                self.priorityListArray.append(item.PriorityText)
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Get Person Responsible List..
    func getPersonResponsibleList() {
        mJCLogger.log("Starting", Type: "info")
        if WORKORDER_ASSIGNMENT_TYPE != "3" && WORKORDER_ASSIGNMENT_TYPE != "4"{
            self.personResponsibleListArray.removeAll()
            if globalPersonRespArray.count > 0 {
                self.personResponsibleArray.append(contentsOf: globalPersonRespArray)
                for item in self.personResponsibleArray {
                    self.personResponsibleListArray.append(item.SystemID + " - " + item.EmplApplName)
                }
                if self.personResponsibleListArray.count > 0 {
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        let personResponsibleFilteredArray = globalPersonRespArray.filter{ $0.PersonnelNo == "\(singleOperation.PersonnelNo)"}
                        if personResponsibleFilteredArray.count > 0{
                            let personResponsibleClass = personResponsibleFilteredArray[0]
                            self.transferToUserButton.setTitle(personResponsibleClass.SystemID + " - " + personResponsibleClass.EmplApplName, for: .normal)
                            self.presentPerson = personResponsibleClass.EmplApplName
                        }else{
                            if self.personResponsibleListArray.count > 0{
                                self.transferToUserButton.setTitle( self.personResponsibleListArray[0], for: .normal)
                            }
                        }
                    }else{
                        let personResponsibleFilteredArray = globalPersonRespArray.filter{ $0.PersonnelNo == "\(singleWorkOrder.PersonResponsible)"}
                        if personResponsibleFilteredArray.count > 0{
                            let personResponsibleClass = personResponsibleFilteredArray[0]
                            self.transferToUserButton.setTitle(personResponsibleClass.SystemID + " - " + personResponsibleClass.EmplApplName, for: .normal)
                            self.presentPerson = personResponsibleClass.EmplApplName
                        }else{
                            if self.personResponsibleListArray.count > 0{
                                self.transferToUserButton.setTitle( self.personResponsibleListArray[0], for: .normal)
                            }
                        }
                    }
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            self.workCentersArray.removeAll()
            if globalWorkCtrArray.count > 0 {
                workCentersArray.append(contentsOf: globalWorkCtrArray)
                self.setWorkCenterValue()
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setWorkCenterValue()  {
        mJCLogger.log("Starting", Type: "info")
        self.workCentersListArray.removeAll()
        DispatchQueue.main.async {
            var selectedWorkCenter = String()
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKeyPath: "ListFilter") as! Dictionary<String,Any>
                let WorkCenterArray = dict["WorkCenter"] as! Array<Any>
                if WorkCenterArray.count > 0{
                    selectedWorkCenter = WorkCenterArray[0] as! String
                }
            }
            for item in self.workCentersArray {
                self.workCentersListArray.append(item.WorkCenter + " - " + item.ShortText)
                if selectedWorkCenter != "" &&  selectedWorkCenter == item.WorkCenter {
                    self.transferToUserButton.setTitle(item.WorkCenter + " - " + item.ShortText, for: .normal)
                    self.presentPerson = item.WorkCenter
                }
            }
            if self.transferToUserButton.titleLabel?.text == nil || self.transferToUserButton.titleLabel?.text == "" {
                self.transferToUserButton.setTitle(self.workCentersListArray[0], for: .normal)
                let arr = (self.workCentersListArray[0] as? String ?? "").components(separatedBy: " - ")
                if arr.count > 0{
                    self.presentPerson = arr[0]
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- get Hold Reason Data..
    func getRejectReasonData() {
        mJCLogger.log("Starting", Type: "info")
        var statusCategory = String()
        if screenfrom == "Notification"{
            statusCategory = NotificationLevel
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                statusCategory = WorkorderLevel
            }else if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                statusCategory = OperationLevel
            }
        }
        let query = "$filter=(Type eq '\(STATUS_REJECT)' and ObjectCategory eq '\(statusCategory)')"
        ReasonCodeModel.getResonCodeList(filterQuery:query){ (responseDict, error)  in
            if error == nil{
                self.rejectReasonArray.removeAll()
                self.rejectReasonListArray.removeAll()
                if let responseArr = responseDict["data"] as? [ReasonCodeModel]{
                    self.rejectReasonArray = responseArr
                    for itemCount in 0..<responseArr.count {
                        let reasonCodeSetClass = responseArr[itemCount]
                        self.rejectReasonListArray.append(reasonCodeSetClass.Reason)
                    }
                    if self.rejectReasonListArray.count > 0 {
                        DispatchQueue.main.async {
                            self.transferReasonButton.setTitle(self.rejectReasonListArray[0], for: .normal)
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Transfer Field Button Action..
    @IBAction func transferReasonButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        transferReasonButtonView.tag = 1000
        dropDown.anchorView = transferReasonButtonView
        if rejectString.isEqual(to: "Reject")
        {
            let arr : [String] = self.rejectReasonListArray as NSArray as! [String]
            dropDown.dataSource = arr
        }else if rejectString.isEqual(to: "Transfer"){
            let arr : [String] = self.transferReasonListArray as NSArray as! [String]
            dropDown.dataSource = arr
        }
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func transferPriorityButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        transferPriorityButtonView.tag = 1001
        dropDown.anchorView = transferPriorityButtonView
        let arr : [String] = self.priorityListArray as NSArray as! [String]
        dropDown.dataSource = arr
        dropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func transferToUserButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if WORKORDER_ASSIGNMENT_TYPE != "3" && WORKORDER_ASSIGNMENT_TYPE != "4"{
            if self.personResponsibleListArray.count > 0 {
                let personRespVC = ScreenManager.getPersonResponsibleListScreen()
                personRespVC.modalPresentationStyle = .fullScreen
                personRespVC.delegate = self
                self.present(personRespVC, animated: false) {
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            if self.workCentersListArray.count > 0 {
                transferToUserButton.tag = 1002
                dropDown.anchorView = self.transferToUserButton
                let arr : [String] = self.workCentersListArray as NSArray as! [String]
                dropDown.dataSource = arr
                dropDown.show()
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func didSelectPersonRespData(_ result: String,_ objcet: AnyObject,_ respType: String?) {
        self.transferToUserButton.setTitle( result, for: .normal)
    }
    //MARK:- Bottom Btton Actions..
    @IBAction func transferRefreshButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        self.transferNoteTextView.text = ""
        if rejectString .isEqual(to: "Reject") {
            if self.rejectReasonListArray.count > 0{
                self.transferReasonButton.setTitle(self.rejectReasonListArray[0], for: .normal)
            }
        }else if rejectString.isEqual(to: "Transfer") {
            if self.transferReasonListArray.count > 0{
                self.transferReasonButton.setTitle(self.transferReasonListArray[0], for: .normal)
            }
            if self.priorityListArray.count > 0{
                self.transferPriorityButton.setTitle(self.priorityListArray[0], for: .normal)
            }
            if WORKORDER_ASSIGNMENT_TYPE == "3" || WORKORDER_ASSIGNMENT_TYPE == "4"{
                if self.workCentersListArray.count > 0{
                    self.transferToUserButton.setTitle(self.workCentersListArray[0], for: .normal)
                }
            }else{
                if self.personResponsibleListArray.count > 0{
                    self.transferToUserButton.setTitle(self.personResponsibleListArray[0], for: .normal)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func transferCancelButtonAction(sender: AnyObject) {
        self.dismiss(animated: false) {}
    }
    @IBAction func transferDoneButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if onlineSearch == true {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5" {
                if singleOperation.PersonnelNo != "00000000"{
                    let params = Parameters(
                        title: alerttitle,
                        message: "This_operation_already_Assigned_to".localized() + " \(self.presentPerson). " + "Do_you_want_to_Continue".localized(),
                        cancelButton: "Cancel".localized(),
                        otherButtons: ["Continue".localized()]
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0: break
                        case 1:
                            self.assignOnlineOperation()
                        default: break
                        }
                    }
                }else {
                    self.assignOnlineOperation()
                }
            }else if WORKORDER_ASSIGNMENT_TYPE == "4" {
                var workCenter = ""
                if self.transferToUserButton.titleLabel?.text != ""{
                    let personRespArr = self.transferToUserButton.titleLabel?.text?.components(separatedBy: " - ")
                    if personRespArr!.count > 0 {
                        workCenter = personRespArr![0]
                    }
                }
                if singleOperation.WorkCenter == workCenter{
                    let alertVc = UIAlertController.init(title: alerttitle, message: "You_are_assigning_operation_to_same_work_center_please_select_other_work_center".localized(), preferredStyle: .alert)
                    let cancelAction = UIAlertAction.init(title: okay, style: .default, handler: nil)
                    alertVc.addAction(cancelAction)
                    self.present(alertVc, animated: true, completion: nil)
                }else if singleOperation.WorkCenter == ""{
                    let alertVc = UIAlertController.init(title: alerttitle, message: "Do_You_Want_To_Assign_This_Operation_To_Your_Self".localized() , preferredStyle: .alert)
                    let cancelAction = UIAlertAction.init(title: "Cancel".localized(), style: .default, handler: nil)
                    let continueAction = UIAlertAction.init(title: "Continue".localized(), style: .default) { _ in
                        self.assignOnlineOperation()
                    }
                    alertVc.addAction(cancelAction)
                    alertVc.addAction(continueAction)
                    self.present(alertVc, animated: true, completion: nil)
                }else  if singleOperation.WorkCenter != ""{
                    let alertVc = UIAlertController.init(title: alerttitle, message: "This_operation_already_Assigned_to".localized() + " \(self.presentPerson). " + "Do_you_want_to_Continue".localized(), preferredStyle: .alert)
                    let cancelAction = UIAlertAction.init(title: "Cancel".localized(), style: .default, handler: nil)
                    let continueAction = UIAlertAction.init(title: "Continue".localized(), style: .default) { _ in
                        self.assignOnlineOperation()
                    }
                    alertVc.addAction(cancelAction)
                    alertVc.addAction(continueAction)
                    self.present(alertVc, animated: true, completion: nil)
                }else {
                    self.assignOnlineOperation()
                }
            }else{
                if singleWorkOrder.PersonResponsible != "00000000" {
                    let params = Parameters(
                        title: alerttitle,
                        message: "This_Work_Order_already_Assigned_to".localized() + " \(self.presentPerson). " + "Do_you_want_to_Continue".localized(),
                        cancelButton: "Cancel".localized(),
                        otherButtons: ["Continue".localized()]
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0: break
                        case 1:
                            self.assignOnlineWorkOrder()
                        default: break
                        }
                    }
                }else {
                    self.assignOnlineWorkOrder()
                }
            }
        }else {
            if rejectString .isEqual(to: "Complete"){
                if screenfrom == "Notification"{
                    let completeNote = self.transferNoteTextView.text
                    self.noLongTextVM.createNoLongtext(text: completeNote!)
                }
            }
            if rejectString .isEqual(to: "Reject") {
                if screenfrom == "Notification"{
                    let rejectNote = self.transferNoteTextView.text
                    let rejectReason = self.transferReasonButton.titleLabel?.text ?? ""
                    WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: rejectReason, objStatus: self.statusCategoryCls.StatusCode,objClass: singleNotification,flushRequired: true)
                    self.noLongTextVM.createNoLongtext(text: rejectNote!)
                }else{
                    let rejectReason = self.transferReasonButton.titleLabel?.text ?? ""
                    let rejectNote = self.transferNoteTextView.text
                    DispatchQueue.main.async {
                        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                            WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: rejectReason, objStatus: self.statusCategoryCls.StatusCode, objClass: singleOperation, flushRequired: true)
                            self.woLongTextVM.createOprLongtext(text: rejectNote!)
                        }else{
                            WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: rejectReason, objStatus: self.statusCategoryCls.StatusCode,objClass: singleWorkOrder,flushRequired: true)
                            self.woLongTextVM.createWoLongtext(text: rejectNote!)
                        }
                    }
                }
            }else if rejectString.isEqual(to: "Transfer") {
                UserDefaults.standard.removeObject(forKey: "active_details")
                if statusCategoryCls.DispTimeSheetString == "X"{
                    var status = String()
                    if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                        status = WorkOrderDataManegeClass.uniqueInstance.setWorkOrderStatus(userStatus: singleWorkOrder.UserStatus, mobileStatus: singleWorkOrder.MobileObjStatus, woClass: singleWorkOrder)
                    }else{
                        status = WorkOrderDataManegeClass.uniqueInstance.setOperationStatus(userStatus: singleOperation.UserStatus, mobileStatus: singleOperation.MobileStatus, oprClass: singleOperation)
                    }
                    if status == "MOBI" || status == "ACCP"{
                        self.timeSheetAdded(statusCategoryCls: StatusCategoryModel())
                    }else{
                        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_TIME", orderType: "X",from:"WorkOrder")
                        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                            if workFlowObj.ActionType == "Screen" {
                                let addTimeEntryVC = ScreenManager.getCreateTimeSheetScreen()
                                addTimeEntryVC.screenType = "StatusChange"
                                addTimeEntryVC.selectedworkOrder = selectedworkOrderNumber
                                addTimeEntryVC.timeSheetDelegate = self
                                addTimeEntryVC.statusCategoryCls = self.statusCategoryCls
                                addTimeEntryVC.modalPresentationStyle = .fullScreen
                                self.present(addTimeEntryVC, animated: false) {}
                            }
                        }
                    }
                }else{
                    self.timeSheetAdded(statusCategoryCls: StatusCategoryModel())
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func assignOnlineWorkOrder() {
        mJCLogger.log("Starting", Type: "info")
        
        mJCLoader.startAnimating(status: "Please_Wait".localized())
        let entityset = singleWorkOrder.entityValue.entitySet
        let entitype = entityset.entityType
        var propety = SODataV4_Property.init()
        let resultentity = singleWorkOrder.entityValue
        let options = SODataV4_RequestOptions.new()
        options.updateMode = SODataV4_UpdateMode.replace
        var assigendtoSelf = Bool()
        var personResponsiable : Bool?
        if singleWorkOrder.PersonResponsible  == "00000000" {
            personResponsiable = false
        }else {
            personResponsiable = true
        }
        if personResponsiable == true {
            let status = WorkOrderDataManegeClass.uniqueInstance.woMobileStatusDec(status: "TRNS")
            switch status {
            case "TRANSFER" :
                propety = entitype.getProperty("TransferFlag")
                propety.setString(resultentity, STATUS_SET_FLAG)
                
                propety = entitype.getProperty("StatusFlag")
                propety.setString(resultentity, "")
                
                break
            default :
                propety = entitype.getProperty("StatusFlag")
                propety.setString(resultentity, STATUS_SET_FLAG)
                
                break
            }
            propety = entitype.getProperty("MobileObjStatus")
            propety.setString(resultentity, "TRNS")
            singleWorkOrder.MobileObjectType = "TRNS"
            singleWorkOrder.UserStatus = "TRNS"
            
            propety = entitype.getProperty("Priority")
            if self.transferPriorityButton.titleLabel?.text != ""{
                if let prioritytext = self.transferPriorityButton.titleLabel?.text{
                    let priorityFilteredArray = self.priorityArray.filter{$0.PriorityText == "\(prioritytext)"}
                    if priorityFilteredArray.count > 0{
                        let priorityClass = priorityFilteredArray[0]
                        singleWorkOrder.Priority = priorityClass.Priority
                        propety.setString(resultentity, priorityClass.Priority)
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
            propety = entitype.getProperty("ToMainWorkCtr")
            if self.transferToUserButton.titleLabel?.text != ""{
                let personrespArr = self.transferToUserButton.titleLabel?.text?.components(separatedBy: " - ")
                if personrespArr!.count > 0 {
                    propety.setString(resultentity, personrespArr![0])
                    singleWorkOrder.ToMainWorkCtr = personrespArr![0]
                    if singleWorkOrder.TransferPerson == userWorkcenter{
                        assigendtoSelf = true
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
            if WORKORDER_ASSIGNMENT_TYPE == "1" {
                if self.transferToUserButton.titleLabel!.text != ""{
                    let personArray = self.transferToUserButton.titleLabel!.text!.components(separatedBy: " - ")
                    if personArray.count > 0 {
                        let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == personArray[0] && $0.EmplApplName == personArray[1]}
                        if personResponsibleFilteredArray.count > 0{
                            let personResponsibleClass = personResponsibleFilteredArray[0]
                            propety = entitype.getProperty("TransferPerson")
                            propety.setString(resultentity, personResponsibleClass.PersonnelNo)
                            singleWorkOrder.TransferPerson = personResponsibleClass.PersonnelNo
                            if singleWorkOrder.TransferPerson == userPersonnelNo{
                                assigendtoSelf = true
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                    
                }
            }
        }else if personResponsiable == false {
            if self.transferToUserButton.titleLabel?.text != ""{
                let personrespArr = self.transferToUserButton.titleLabel?.text?.components(separatedBy: " - ")
                if personrespArr!.count > 0 {
                    (singleWorkOrder.entity.properties["ToMainWorkCtr"] as! SODataProperty).value = personrespArr![0] as NSObject
                    singleWorkOrder.TransferPerson = personrespArr![0]
                    if singleWorkOrder.TransferPerson == userWorkcenter{
                        assigendtoSelf = true
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
            if WORKORDER_ASSIGNMENT_TYPE == "1" {
                if self.transferToUserButton.titleLabel!.text != ""{
                    let personArray = self.transferToUserButton.titleLabel!.text!.components(separatedBy: " - ")
                    if personArray.count > 0 {
                        let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == personArray[0] && $0.EmplApplName == personArray[1]}
                        if personResponsibleFilteredArray.count > 0{
                            let personResponsibleClass = personResponsibleFilteredArray[0]
                            propety = entitype.getProperty("PersonResponsible")
                            propety.setString(resultentity, personResponsibleClass.PersonnelNo)
                            singleWorkOrder.PersonResponsible = personResponsibleClass.PersonnelNo
                            if singleWorkOrder.PersonResponsible == userPersonnelNo{
                                assigendtoSelf = true
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
            propety = entitype.getProperty("Priority")
            if self.transferPriorityButton.titleLabel?.text != ""{
                if let prioritytext = self.transferPriorityButton.titleLabel?.text{
                    let priorityFilteredArray = self.priorityArray.filter{$0.PriorityText == "\(prioritytext)"}
                    if priorityFilteredArray.count > 0{
                        let priorityClass = priorityFilteredArray[0]
                        singleWorkOrder.Priority = priorityClass.Priority
                        propety.setString(resultentity, priorityClass.Priority)
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
            propety = entitype.getProperty("StatusFlag")
            propety.setString(resultentity, "")
        }
        let httpConvMan = HttpConversationManager.init()
        let commonfig = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
        }else if authType == "SAML"{
            commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
        commonfig.configureManager(httpConvMan)
        
        let respDict = WoHeaderModel.updateOnlineWorkorderEntity(httpcon: httpConvMan!, entityValue: resultentity)
        if let status = respDict["Status"] as? String{
            if status == "Success"{
                if assigendtoSelf == true{
                    let params = Parameters(
                        title: alerttitle,
                        message: "Work_order_Assigned_your_self_successfully_Do_u_want_transmit".localized(),
                        cancelButton: "Cancel".localized(),
                        otherButtons: ["Continue".localized()]
                    )
                    mJCLoader.stopAnimating()
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            self.dismiss(animated: false) {}
                        case 1:
                            
                            mJCLoader.startAnimating(status: "Uploading".localized())
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
                            })
                        default: break
                        }
                    }
                }else{
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Work_order_Assigned".localized(),
                        cancelButton: okay
                    )
                    mJCLoader.stopAnimating()
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            self.dismiss(animated: false) {}
                        default: break
                        }
                    }
                }
            }else if status == "-1"{
                mJCLoader.stopAnimating()
                mJCLogger.log("Reason : \(respDict["Error"] ?? "")", Type: "Error")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "\(respDict["Error"] ?? "")", button: okay)
            }
        }else{
            mJCLoader.stopAnimating()
            mJCLogger.log("Reason : \(somethingwrongalert)", Type: "Error")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func assignOnlineOperation() {
        
        mJCLogger.log("Starting", Type: "info")
        
        mJCLoader.startAnimating(status: "Please_Wait".localized())
        
        let entityset = singleOperation.entityValue.entitySet
        let entitype = entityset.entityType
        var propety = SODataV4_Property.init()
        let resultentity = singleOperation.entityValue
        let options = SODataV4_RequestOptions.new()
        options.updateMode = SODataV4_UpdateMode.replace
        var assigendtoSelf = Bool()
        var PersonnelNo : Bool?
        if WORKORDER_ASSIGNMENT_TYPE == "4"{
            if singleOperation.WorkCenter  == "" {
                PersonnelNo = false
            }else {
                PersonnelNo = true
            }
        }else{
            if singleOperation.PersonnelNo  == "00000000" {
                PersonnelNo = false
            }else {
                PersonnelNo = true
            }
        }
        if PersonnelNo == true {
            let status = WorkOrderDataManegeClass.uniqueInstance.oprMobileStatusDec(status: "TRNS")
            switch status {
            case "TRANSFER" :
                propety = entitype.getProperty("TransferFlag")
                propety.setString(resultentity, STATUS_SET_FLAG)
                propety = entitype.getProperty("StatusFlag")
                propety.setString(resultentity, "")
                break
            default :
                propety = entitype.getProperty("StatusFlag")
                propety.setString(resultentity, STATUS_SET_FLAG)
                break
            }
            propety = entitype.getProperty("MobileStatus")
            propety.setString(resultentity, "TRNS")
            singleOperation.MobileObjectType = "TRNS"
            singleOperation.UserStatus = "TRNS"
            
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                let personArray = self.transferToUserButton.titleLabel!.text!.components(separatedBy: " - ")
                if personArray.count > 0 {
                    let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == personArray[0] && $0.EmplApplName == personArray[1]}
                    if personResponsibleFilteredArray.count > 0{
                        let personResponsibleClass = personResponsibleFilteredArray[0]
                        propety = entitype.getProperty("TransferPerson")
                        propety.setString(resultentity, personResponsibleClass.PersonnelNo)
                        singleOperation.TransferPerson = personResponsibleClass.PersonnelNo
                        if singleOperation.TransferPerson == userPersonnelNo{
                            assigendtoSelf = true
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else if WORKORDER_ASSIGNMENT_TYPE == "4"{
                if self.transferToUserButton.titleLabel?.text != ""{
                    let personArray = self.transferToUserButton.titleLabel!.text!.components(separatedBy: " - ")
                    if personArray.count > 0 {
                        let personResponsibleFilteredArray = self.workCentersArray.filter{$0.WorkCenter == personArray[0]}
                        if personResponsibleFilteredArray.count > 0{
                            let personResponseClass = personResponsibleFilteredArray[0]
                            propety = entitype.getProperty("ToWorkCenter")
                            propety.setString(resultentity, personResponseClass.WorkCenter)
                            if personResponseClass.WorkCenter == userWorkcenter{
                                assigendtoSelf = true
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
        }else if PersonnelNo == false {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                if self.transferToUserButton.titleLabel!.text != ""{
                    let personArray = self.transferToUserButton.titleLabel!.text!.components(separatedBy: " - ")
                    if personArray.count > 0 {
                        let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == personArray[0] && $0.EmplApplName == personArray[1]}
                        if personResponsibleFilteredArray.count > 0{
                            let personResponsibleClass = personResponsibleFilteredArray[0]
                            propety = entitype.getProperty("PersonnelNo")
                            propety.setString(resultentity, personResponsibleClass.PersonnelNo)
                            singleOperation.PersonnelNo = personResponsibleClass.PersonnelNo
                            if singleOperation.PersonnelNo == userPersonnelNo{
                                assigendtoSelf = true
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }else if WORKORDER_ASSIGNMENT_TYPE == "4"{
                if self.transferToUserButton.titleLabel?.text != ""{
                    let personArray = self.transferToUserButton.titleLabel!.text!.components(separatedBy: " - ")
                    if personArray.count > 0 {
                        propety = entitype.getProperty("WorkCenter")
                        propety.setString(resultentity, personArray[0])
                        if singleOperation.WorkCenter == userWorkcenter{
                            assigendtoSelf = true
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
            propety = entitype.getProperty("StatusFlag")
            propety.setString(resultentity, "")
        }
        
        let httpConvMan = HttpConversationManager.init()
        let commonfig = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
        }else if authType == "SAML"{
            commonfig.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
        commonfig.configureManager(httpConvMan)
        
        let respDict = WoOperationModel.updateOnlineWorkorderEntity(httpcon: httpConvMan!, entityValue: resultentity)
        if let status = respDict["Status"] as? String{
            mJCLoader.stopAnimating()
            if status == "Success"{
                DispatchQueue.main.async{
                    if assigendtoSelf == true{
                        let params = Parameters(
                            title: "Warning".localized(),
                            message: "Operation_Assigned_your_self_successfully_Do_u_want_transmit".localized(),
                            cancelButton: "Cancel".localized(),
                            otherButtons: ["Continue".localized()]
                        )
                        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                            switch buttonIndex {
                            case 0: break
                            case 1:
                                mJCLoader.startAnimating(status: "Uploading".localized())
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                    myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
                                })
                            default: break
                            }
                        }
                    }else{
                        let params = Parameters(
                            title: MessageTitle,
                            message: "Operation_Assigned".localized(),
                            cancelButton: okay
                        )
                        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                            switch buttonIndex {
                            case 0:
                                mJCLoader.stopAnimating()
                                self.dismiss(animated: false) {}
                            default: break
                            }
                        }
                    }
                }
            }else if status == "-1"{
                mJCLoader.stopAnimating()
                print("Update Entity Error \(respDict["Error"] ?? "")")
                mJCLogger.log("Reason : \(respDict["Error"] ?? "")", Type: "Error")
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "\(respDict["Error"] ?? "")", button: okay)
            }
        }else{
            mJCLoader.stopAnimating()
            mJCLogger.log("Reason : \(somethingwrongalert)", Type: "Error")
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func timeSheetAdded(statusCategoryCls: StatusCategoryModel){
        
        mJCLogger.log("Starting", Type: "info")
        let transferReason = self.transferReasonButton.titleLabel?.text ?? ""
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
            (singleWorkOrder.entity.properties["TransferReason"] as! SODataProperty).value = transferReason as NSObject
            singleWorkOrder.TransferReason = transferReason
            if self.transferPriorityButton.titleLabel?.text != ""{
                if let prioritytext = self.transferPriorityButton.titleLabel?.text{
                    let priorityFilteredArray = self.priorityArray.filter{$0.PriorityText == "\(prioritytext)"}
                    if priorityFilteredArray.count > 0{
                        let priorityClass = priorityFilteredArray[0]
                        (singleWorkOrder.entity.properties["Priority"] as! SODataProperty).value = priorityClass.Priority as NSObject
                        singleWorkOrder.Priority = priorityClass.Priority
                    }
                }
            }
        }else{
            (singleOperation.entity.properties["TransferReason"] as! SODataProperty).value = transferReason as NSObject
            singleOperation.TransferReason = transferReason
        }
        
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            if self.transferToUserButton.titleLabel?.text != ""{
                if (self.transferToUserButton.titleLabel?.text) != nil {
                    let personArray = self.transferToUserButton.titleLabel!.text!.components(separatedBy: " - ")
                    if personArray.count > 0 {
                        let personResponsibleFilteredArray = self.personResponsibleArray.filter{$0.SystemID == personArray[0] && $0.EmplApplName == personArray[1]}
                        if personResponsibleFilteredArray.count > 0{
                            let personResponseClass = personResponsibleFilteredArray[0]
                            if WORKORDER_ASSIGNMENT_TYPE == "1"{
                                (singleWorkOrder.entity.properties["TransferPerson"] as! SODataProperty).value = personResponseClass.PersonnelNo as NSObject
                                singleWorkOrder.TransferPerson = personResponseClass.PersonnelNo
                            }else if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                                (singleOperation.entity.properties["TransferPerson"] as! SODataProperty).value = personResponseClass.PersonnelNo as NSObject
                                singleOperation.TransferPerson = personResponseClass.PersonnelNo
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }
                }
            }
        }
        if WORKORDER_ASSIGNMENT_TYPE == "3" || WORKORDER_ASSIGNMENT_TYPE == "4"{
            if self.transferToUserButton.titleLabel?.text != ""{
                let personrespArr = self.transferToUserButton.titleLabel?.text?.components(separatedBy: " - ")
                if personrespArr!.count > 0 {
                    if WORKORDER_ASSIGNMENT_TYPE == "3"{
                        (singleWorkOrder.entity.properties["ToMainWorkCtr"] as! SODataProperty).value = personrespArr![0] as NSObject
                        singleWorkOrder.ToMainWorkCtr = personrespArr![0]
                    }else if WORKORDER_ASSIGNMENT_TYPE == "4"{
                        (singleOperation.entity.properties["ToWorkCenter"] as! SODataProperty).value = personrespArr![0] as NSObject
                        singleOperation.ToWorkCenter = personrespArr![0]
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            DispatchQueue.main.async {
                WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: transferReason, objStatus: self.statusCategoryCls.StatusCode,objClass: singleOperation,flushRequired: true)
                if self.transferNoteTextView.text != "" {
                    if self.transferNoteTextView.text.count > 0  {
                        self.woLongTextVM.createOprLongtext(text: self.transferNoteTextView.text)
                        self.transferNoteTextView.text = ""
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                WorkOrderDataManegeClass.uniqueInstance.updateObjectStatus(statusReason: transferReason, objStatus: self.statusCategoryCls.StatusCode,objClass: singleWorkOrder,flushRequired: true)
                if self.transferNoteTextView.text != "" {
                    if self.transferNoteTextView.text.count > 0 {
                        self.woLongTextVM.createOprLongtext(text: self.transferNoteTextView.text)
                        self.transferNoteTextView.text = ""
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(sender: AnyObject) {
        self.dismiss(animated: false) {}
    }
}
