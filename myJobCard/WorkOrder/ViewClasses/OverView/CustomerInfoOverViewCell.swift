//
//  CustomerInfoOverViewCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/28/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class CustomerInfoOverViewCell: UITableViewCell {
    
    //CustomerInfoHeaderView Outlets..
    @IBOutlet var customerInfoHeaderView: UIView!
    @IBOutlet var customerInfoHeaderLabel: UILabel!
    
    //BackGroundView Outlets..
    @IBOutlet var backGroundView: UIView!
    
    //CustomerInfoNameView Outlets..
    @IBOutlet var customerInfoNameView: UIView!
    @IBOutlet var customerInfoNameLabelView: UIView!
    @IBOutlet var customerInfoNameLabel: UILabel!
    
    //CustomerInfoContactView Outlets..
    @IBOutlet var customerInfoContactView: UIView!
    @IBOutlet var customerInfoContactLabelView: UIView!
    @IBOutlet var customerInfoContactLabel: UILabel!
    
    //CustomerInfoAddressView Outlets..
    @IBOutlet var customerInfoAddressView: UIView!
    @IBOutlet var customerInfoAddressLabelView: UIView!
    @IBOutlet var customerInfoAddressLabel: UILabel!
    
    @IBOutlet var addspeakerButton: UIButton!
    //CustomerInfoActivityTypeView Outlets..
    @IBOutlet var customerInfoActivityTypeView: UIView!
    @IBOutlet var customerInfoActivityTypeLabelView: UIView!
    @IBOutlet var customerInfoActivityTypeLabel: UILabel!
    
    //CustomerInfoDescriptionView Outlets..
    @IBOutlet var customerInfoDescriptionView: UIView!
    @IBOutlet var customerInfoDescriptionLabelView: UIView!
    @IBOutlet var customerInfoDescriptionLabel: UILabel!
    @IBOutlet var descSpeakerButton: UIButton!
    //CustomerInfoPriorityView Outlets..
    @IBOutlet var customerInfoPriorityView: UIView!
    @IBOutlet var customerInfoPriorityLabelView: UIView!
    @IBOutlet var customerInfoPriorityLabel: UILabel!
    
    //CustomerInfoTypeView Outlets..
    @IBOutlet var customerInfoTypeView: UIView!
    @IBOutlet var customerInfoTypeLabelView: UIView!
    @IBOutlet var customerInfoTypeLabel: UILabel!
    
    //CustomerInfoMobileStatusView Outlets..
    @IBOutlet var customerInfoMobileStatusView: UIView!
    @IBOutlet var customerInfoMobileStatusLabelView: UIView!
    @IBOutlet var customerInfoMobileStatusLabel: UILabel!

    //CustomerInfoSystemStatusView Outlets..
    @IBOutlet var customerInfoSystemStatusView: UIView!
    @IBOutlet var customerInfoSystemStatusLabelView: UIView!
    @IBOutlet var customerInfoSystemStatusLabel: UILabel!
    
    //CustomerInfoCategoryView Outlets..
    @IBOutlet var customerInfoCategoryView: UIView!
    @IBOutlet var customerInfoCategoryLabelView: UIView!
    @IBOutlet var customerInfoCategoryLabel: UILabel!
    
    //CustomerInfoNotificationView Outlets..
    @IBOutlet var customerInfoNotificationView: UIView!
    @IBOutlet var customerInfoNotificationLabelView: UIView!
    @IBOutlet var customerInfoNotificationLabel: UILabel!
    
    @IBOutlet var customerInfoNotificationButton: UIButton!
    //CustomerInfoPlantView Outlets..
    @IBOutlet var customerInfoPlantView: UIView!
    @IBOutlet var customerInfoPlantLabelView: UIView!
    @IBOutlet var customerInfoPlantLabel: UILabel!
    
    //CustomerInfoPlanningPlantView Outlets..
    @IBOutlet var customerInfoPlanningPlantView: UIView!
    @IBOutlet var customerInfoPlanningPlantLabelView: UIView!
    @IBOutlet var customerInfoPlanningPlantLabel: UILabel!
    
    //CustomerInfoStartView Outlets..
    @IBOutlet var customerInfoStartView: UIView!
    @IBOutlet var customerInfoStartLabelView: UIView!
    @IBOutlet var customerInfoStartLabel: UILabel!
    
    
    //CustomerInfo transferview Outlets..
    @IBOutlet var customerInfotransfertoview: UIView!
    @IBOutlet var customerInfotransferLabelView: UIView!
    @IBOutlet var customerInfotransfertoLabel: UILabel!
    
    
    @IBOutlet var customerInfoTransferHieght: NSLayoutConstraint!
    
    //CustomerInfo InspectionLot Outlets..
    
    @IBOutlet weak var customerInfoInspectionLotView: UIView!
    @IBOutlet weak var customerInfoInspectionLotLabel: UILabel!
    @IBOutlet weak var customerInfoInspectionLotLabelView: UIView!
    @IBOutlet weak var customerInfoInspectionLotInfoButton: UIButton!
    
    @IBOutlet weak var customerInfoSuperiorWorkorderView: UIView!
    @IBOutlet weak var customerInfoSuperiorWorkorderLabel: UILabel!
    @IBOutlet weak var customerInfoSuperiorWorkorderLabelView: UIView!
    
    @IBOutlet var customerInfoNotesButton: UIButton!
    @IBOutlet var customerNotificationButton: UIButton!
    var indexpath = IndexPath()
    var operationVCModel = OperationOverViewModel()
    var personRespArray = [PersonResponseModel]()
    var woOverviewModel = WorkOrderOverviewViewModel()
    var isCellFrom = ""
    var woOverViewCustomerInfoModel: WoHeaderModel? {
        didSet{
            woCustomerInfoOverViewConfiguration()
        }
    }
    var onlineWoOverviewViewModel = OnlineSearchWorkOrderOverviewViewModel()
    var onlineWoCustomerInfoModelClass: WoHeaderModel? {
        didSet{
            onlineWoCustomerInfoOverViewConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func woCustomerInfoOverViewConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let WorkOrderCls = woOverViewCustomerInfoModel {
            self.customerInfoNameLabel.text = WorkOrderCls.Name
            self.customerInfoContactLabel.text = WorkOrderCls.PhoneNumber
            self.customerInfoSuperiorWorkorderLabel.text = WorkOrderCls.SuperiorOrder
            if WorkOrderCls.Address == "" {
                let arr = NSMutableArray()
                arr.add(WorkOrderCls)
                let coOrdinateArr = myAssetDataManager.uniqueInstance.getLocationDetailsForWorkOrders(Arr: arr as! [Any])
                if coOrdinateArr.count != 0 {
                    mJCLogger.log("Response:\(coOrdinateArr.count)", Type: "Debug")
                    let workDic = coOrdinateArr[0] as! NSDictionary
                    let latitudeDob = workDic["Latitude"]
                    let longitudeDob = workDic["Longitude"]
                    let geocoder = GMSGeocoder()
                    let location = CLLocationCoordinate2DMake(latitudeDob as! CLLocationDegrees, longitudeDob as! CLLocationDegrees)
                    geocoder.reverseGeocodeCoordinate(location) { response, error in
                        if error != nil {
                            mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                        }else {
                            if let places = response?.results() {
                                if let place = places.first {
                                    if let lines = (place as AnyObject).lines {
                                        print("GEOCODE: Formatted Address: \(String(describing: lines))")
                                    }
                                }
                                else {
                                    print("GEOCODE: nil first in places")
                                }
                            }
                            else{
                                print("GEOCODE: nil first in places")
                            }
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else {
                self.customerInfoAddressLabel.text = WorkOrderCls.Address
            }
            let activity = WorkOrderCls.MaintActivityType + " - " + WorkOrderCls.MaintActivityTypeText
            if activity == " - " {
                self.customerInfoActivityTypeLabel.text = ""
            }else {
                self.customerInfoActivityTypeLabel.text = activity
            }
            self.customerInfoDescriptionLabel.text = WorkOrderCls.ShortText
            var priority = String()
            let priorityFilteredArray = globalPriorityArray.filter{ $0.Priority == WorkOrderCls.Priority}
            if priorityFilteredArray.count > 0 {
                let obj = priorityFilteredArray[0]
                priority = obj.PriorityText
            }
            let mobileStatus = WorkOrderDataManegeClass.uniqueInstance.setWorkOrderStatus(userStatus: WorkOrderCls.UserStatus, mobileStatus: WorkOrderCls.MobileObjStatus,woClass: WorkOrderCls)
            let mobileStatusDesc = WorkOrderDataManegeClass.uniqueInstance.woMobileStatusDec(status: mobileStatus)
            self.customerInfoMobileStatusLabel.text = mobileStatusDesc
            self.customerInfoSystemStatusLabel.text = WorkOrderCls.SysStatus
            self.customerInfoInspectionLotLabel.text = WorkOrderCls.InspectionLot
            self.customerInfoInspectionLotInfoButton.addTarget(self, action:#selector(self.customerInfoInspectionLotInfoButtonAction(sender:)), for: .touchUpInside)
            self.customerInfoPriorityLabel.text = priority
            self.customerInfoTypeLabel.text = WorkOrderCls.OrderType
            self.customerInfoCategoryLabel.text = WorkOrderCls.Category + " - " + WorkOrderCls.CategoryText
            self.customerInfoNotificationLabel.text = WorkOrderCls.NotificationNum
            self.customerInfoPlantLabel.text = WorkOrderCls.Plant
            self.customerInfoPlanningPlantLabel.text = WorkOrderCls.MaintPlanningPlant
            if WorkOrderCls.SchdStrtDate != nil{
                self.customerInfoStartLabel.text = WorkOrderCls.SchdStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.customerInfoStartLabel.text = ""
            }
            if WorkOrderCls.TransferPerson != "00000000"{
                let newpredict = NSPredicate(format: "SELF.PersonnelNo == %@",WorkOrderCls.TransferPerson)
                let newfilterar = operationVCModel.personResponsibleArray.filtered(using: newpredict) as! [PersonResponseModel]
                if newfilterar.count > 0{
                    mJCLogger.log("Response:\(newfilterar[0])", Type: "Debug")
                    let details = newfilterar[0]
                    self.customerInfotransfertoview.isHidden = false
                    self.customerInfotransfertoLabel.text = details.SystemID
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                    self.customerInfotransfertoview.isHidden = true
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                self.customerInfotransfertoview.isHidden = true
            }
            self.customerInfoNotificationButton.addTarget(self, action:#selector(self.customerInfoNotificationButtonAction(sender:)), for: .touchUpInside)
            if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && woOverviewModel.vcOverview?.isfromsup != "Supervisor" && onlineSearch == false {
                self.customerInfoNotesButton.isHidden = false
                self.customerNotificationButton.isHidden = false
                ODSUIHelper.setButtonLayout(button: self.customerInfoNotesButton, cornerRadius: self.customerInfoNotesButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
                ODSUIHelper.setButtonLayout(button: self.customerNotificationButton, cornerRadius: self.customerNotificationButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
                self.customerInfoNotesButton.addTarget(self, action:#selector(self.customerInfoNotesButtonAction(sender:)), for: .touchUpInside)
                self.customerNotificationButton.addTarget(self, action:#selector(self.customerInfoNotificationAction(sender:)), for: .touchUpInside)
            }else{
                self.customerInfoNotesButton.isHidden = true
                self.customerNotificationButton.isHidden = true
            }
            self.addspeakerButton.addTarget(self, action: #selector(self.speakaddress(sender:)), for: .touchUpInside)
            self.descSpeakerButton.addTarget(self, action: #selector(self.speakdescription(sender:)), for: .touchUpInside)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK:- Speak Address Button Action..
    @objc func speakaddress(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        ReadAndWriteModelclass.uniqueInstance.ReadText(text: singleWorkOrder.Address)
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK:- Speak Description Button Action..
    @objc func speakdescription(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        ReadAndWriteModelclass.uniqueInstance.ReadText(text: woOverViewCustomerInfoModel?.ShortText ?? "")
        mJCLogger.log("Ended", Type: "info")
    }
    
    // MARK:- InspectionLotInfo Button Action..
    @objc func customerInfoInspectionLotInfoButtonAction(sender: UIButton!){
        mJCLogger.log("Starting", Type: "info")
        if isCellFrom == "OperationDetails" {
            operationVCModel.getInspectionLot()
        }else {
            woOverviewModel.getInspectionLotInfo()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    // MARK:- Notification Button Action..
    @objc func customerInfoNotificationButtonAction(sender: UIButton!) {
        mJCLogger.log("Starting", Type: "info")
        if isCellFrom == "OperationDetails" {
            operationVCModel.operationsVC.customerInfoNotificationAction()
        }else {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_ORVW_NO", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    if woOverviewModel.vcOverview?.isfromsup != "Supervisor" {
                        woOverviewModel.vcOverview?.updateUICustomerInfoNotificationButton()
                    }else {
                        mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(woOverviewModel.vcOverview!, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    // Online Work Order Overview
    func onlineWoCustomerInfoOverViewConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        customerInfoNameLabel.text = onlineWoCustomerInfoModelClass?.Name
        customerInfoContactLabel.text = onlineWoCustomerInfoModelClass?.PhoneNumber
        customerInfoAddressLabel.text = onlineWoCustomerInfoModelClass?.Address
        let activity = onlineWoCustomerInfoModelClass?.MaintActivityType ?? "" + " - " + onlineWoCustomerInfoModelClass!.MaintActivityTypeText
        if activity == " - " {
            customerInfoActivityTypeLabel.text = ""
        }else {
            customerInfoActivityTypeLabel.text = activity
        }
        customerInfoDescriptionLabel.text = onlineWoCustomerInfoModelClass?.ShortText
        
        var priority = String()
        let priorityFilteredArray = globalPriorityArray.filter{ $0.Priority == onlineWoCustomerInfoModelClass?.Priority}
        if priorityFilteredArray.count > 0 {
            let obj = priorityFilteredArray[0]
            priority = obj.PriorityText
        }
        
        let userStatusStr = onlineWoCustomerInfoModelClass?.UserStatus ?? ""
        let moileObjStatusStr = onlineWoCustomerInfoModelClass?.MobileObjStatus ?? ""
        let mobileStatus = WorkOrderDataManegeClass.uniqueInstance.setWorkOrderStatus(userStatus: userStatusStr, mobileStatus: moileObjStatusStr,woClass: onlineWoCustomerInfoModelClass!)
        let mobileStatusDesc = WorkOrderDataManegeClass.uniqueInstance.woMobileStatusDec(status: mobileStatus)
        customerInfoPriorityLabel.text = priority
        customerInfoTypeLabel.text = onlineWoCustomerInfoModelClass?.OrderType
        customerInfoMobileStatusLabel.text = mobileStatusDesc
        customerInfoSystemStatusLabel.text = onlineWoCustomerInfoModelClass?.SysStatus
        customerInfoCategoryLabel.text = onlineWoCustomerInfoModelClass?.Category ?? "" + " - " + onlineWoCustomerInfoModelClass!.CategoryText
        customerInfoNotificationLabel.text = onlineWoCustomerInfoModelClass?.NotificationNum
        customerInfoPlantLabel.text = onlineWoCustomerInfoModelClass?.Plant
        customerInfoPlanningPlantLabel.text = onlineWoCustomerInfoModelClass?.MaintPlanningPlant
        
        if onlineWoCustomerInfoModelClass?.SchdStrtDate != nil{
            customerInfoStartLabel.text = onlineWoCustomerInfoModelClass?.SchdStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            customerInfoStartLabel.text = ""
        }
        
        if onlineWoCustomerInfoModelClass?.TransferPerson != "00000000"{
            let newpredict = NSPredicate(format: "SELF.PersonnelNo == %@",onlineWoCustomerInfoModelClass!.TransferPerson)
            let newfilterar = onlineWoOverviewViewModel.personResponsibleArray.filtered(using: newpredict) as! [PersonResponseModel]
            if newfilterar.count > 0{
                mJCLogger.log("Response:\(newfilterar[0])", Type: "Debug")
                let details = newfilterar[0]
                customerInfotransfertoview.isHidden = false
                customerInfotransfertoLabel.text = details.SystemID
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                customerInfotransfertoview.isHidden = true
                onlineWoOverviewViewModel.isTranformHidden = true
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
            customerInfotransfertoview.isHidden = true
            onlineWoOverviewViewModel.isTranformHidden = true
        }
        if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") {
            self.customerInfoNotesButton.isHidden = false
            self.customerNotificationButton.isHidden = false
            self.customerInfoNotesButton.addTarget(self, action:#selector(customerInfoNotesButtonAction(sender:)), for: .touchUpInside)
            self.customerNotificationButton.addTarget(self, action:#selector(customerInfoNotificationAction(sender:)), for: .touchUpInside)
        }else{
            self.customerInfoNotesButton.isHidden = true
            self.customerNotificationButton.isHidden = true
        }

        addspeakerButton.addTarget(self, action: #selector(onlineSpeakaddress(sender:)), for: .touchUpInside)
        descSpeakerButton.addTarget(self, action: #selector(onlineSpeakdescription(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func onlineSpeakaddress(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        if onlineWoOverviewViewModel.selecetdWorkOrderDetailsArr.count > 0 {
            let workorderClass = onlineWoOverviewViewModel.selecetdWorkOrderDetailsArr[0] as! WoHeaderModel
                ReadAndWriteModelclass.uniqueInstance.ReadText(text: workorderClass.Address)
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func onlineSpeakdescription(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        if onlineWoOverviewViewModel.selecetdWorkOrderDetailsArr.count > 0 {
            let workorderClass = onlineWoOverviewViewModel.selecetdWorkOrderDetailsArr[0] as! WoHeaderModel
            ReadAndWriteModelclass.uniqueInstance.ReadText(text: workorderClass.ShortText)
            
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Notification Button Action..
    @objc func onlineCustomerInfoNotificationButtonAction(sender: UIButton!) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
        mJCAlertHelper.showAlert(onlineWoOverviewViewModel.vcOnlineWoOverview!, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func customerInfoNotesButtonAction(sender:UIButton!) {
        operationVCModel.operationsVC.customerInfoNotesAction()
    }
    @objc func customerInfoNotificationAction(sender:UIButton!) {
        operationVCModel.operationsVC.customerNotificationAction()
    }
}
