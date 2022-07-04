//
//  WorkOrderswift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/27/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation
import AVFoundation

class WorkOrderCell: UITableViewCell {


    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var priorityImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var orderTypeLabel: UILabel!
    @IBOutlet weak var breakDownImageView: UIImageView!
    @IBOutlet weak var orderTypeImageView: UIImageView!
    @IBOutlet weak var attachmentImageView: UIImageView!
    @IBOutlet var topView: UIView!
    @IBOutlet weak var operationInfoButton: UIButton!

    @IBOutlet weak var transperentView: UIView!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var isSelectedCellView: UIView!
    @IBOutlet weak var shortTextLabel: UILabel!
    @IBOutlet weak var functionalLocLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var createdByMeImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var activeInfoButton: UIButton!
    @IBOutlet weak var followOnButton: UIButton!
    @IBOutlet weak var postalView: UIView!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var postalImage: UIImageView!
    @IBOutlet weak var detailButton: UIButton!
    // Supervisor

    @IBOutlet weak var technicianIdLabel: UILabel!
    @IBOutlet weak var totalWorkOrders: UILabel!
    @IBOutlet weak var bottomView: UIView!

    @IBOutlet weak var detailArrowImageView: UIImageView!
    //Old
    @IBOutlet weak var oprCountView: UIView!
    @IBOutlet weak var oprCountImageView: UIImageView!
    @IBOutlet weak var oprCountLabel: UILabel!
    @IBOutlet weak var oprTitleLabel: UILabel!
    @IBOutlet weak var inspCountView: UIView!
    @IBOutlet weak var inspCountImageView: UIImageView!
    @IBOutlet weak var inspCountLabel: UILabel!
    @IBOutlet weak var inspTitleLabel: UILabel!
    @IBOutlet weak var compCountView: UIView!
    @IBOutlet weak var compCountImageView: UIImageView!
    @IBOutlet weak var compCountLabel: UILabel!
    @IBOutlet weak var compTitleLabel: UILabel!
    @IBOutlet weak var attachmentCountView: UIView!
    @IBOutlet weak var bottomAttchImgView: UIImageView!
    @IBOutlet weak var attachmentCountLabel: UILabel!
    @IBOutlet weak var attachmentTitleLabel: UILabel!
    @IBOutlet weak var pointsCountView: UIView!
    @IBOutlet weak var pointsCountImageView: UIImageView!
    @IBOutlet weak var pointsCountLabel: UILabel!
    @IBOutlet weak var pointsTitleLabel: UILabel!
    @IBOutlet weak var formsCountView: UIView!
    @IBOutlet weak var formsCountImageView: UIImageView!
    @IBOutlet weak var formsCountLabel: UILabel!
    @IBOutlet weak var formsTitleLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!

    @IBOutlet weak var actualMHRSLabel: UILabel!
    @IBOutlet weak var plannedMHRSLabel: UILabel!
    @IBOutlet weak var approvedCheckSheetCountLabel: UILabel!
    @IBOutlet weak var yetToBeReviewedCountLabel: UILabel!
    @IBOutlet weak var rejectedCheckSheetCountLabel: UILabel!
    @IBOutlet var detailLabelView: UIView!

    
    var masterViewModel = MasterViewModel()
    var mapMasterViewModel = MapMasterViewModel()
    var indexpath = IndexPath()

    var operationClass: WoOperationModel?{
        didSet{
            operationCellConfiguration()
        }
    }
    var woModelClass: WoHeaderModel?{
        didSet{
            workorderCellConfiguration()
        }
    }
    var dBVc : DashboardStyle2?
    var dBWorkOrderClass: WoHeaderModel?{
        didSet{
            dBWorkorderCellConfiguration()
        }
    }
    var dBOperationClass: WoOperationModel?{
        didSet{
            dBOperationConfiguration()
        }
    }
    var dBNotificationClass: NotificationModel?{
        didSet{
            dBNotificationConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func dBWorkorderCellConfiguration(){

        if let workOrderCls = dBWorkOrderClass{
            operationInfoButton.isHidden = true
            bottomView.isHidden = true
            numberLabel.text = workOrderCls.WorkOrderNum
            shortTextLabel.text = workOrderCls.ShortText
            functionalLocLabel.text = "FLoc : \(workOrderCls.FuncLocation)"
            equipmentLabel.text = "Eqp : \(workOrderCls.EquipNum)"
            priorityImageView.image = myAssetDataManager.getPriorityImage(priority: workOrderCls.Priority)
            breakDownImageView.isHidden = true
            if workOrderCls.BasicStrtDate != nil{
                dateLabel.text = "Start_Date".localized() + " : " + workOrderCls.BasicStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                dateLabel.text = "Start_Date".localized() + " : "
            }
            if workOrderCls.BasicFnshDate != nil{
                endDateLabel.text = "Due_Date".localized() + " : " +  workOrderCls.BasicFnshDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                endDateLabel.text = "Due_Date".localized() + " : "
            }
            if Show_Postal_Code == true{
                if workOrderCls.PostalCode != ""{
                    postalView.isHidden = false
                    postalCodeLabel.text =  workOrderCls.PostalCode
                }else{
                    postalView.isHidden = true
                    postalCodeLabel.text = ""
                }
            }else{
                postalView.isHidden = true
                postalCodeLabel.text = ""
            }
            if DeviceType == iPhone{
                orderTypeLabel.text = workOrderCls.OrderType
            }else{
                orderTypeLabel.isHidden = true
            }
            if globalWoAttachmentArr.contains(workOrderCls.WorkOrderNum){
                attachmentImageView.isHidden = false
            }else{
                attachmentImageView.isHidden = true
            }
            let arr = statusCategoryArr.filter{$0.StatusCode == "\(workOrderCls.MobileObjStatus)"}
            if arr.count > 0{
                if let statusImage = UIImage(named: arr[0].ImageResKey) {
                    self.statusImageView.image = statusImage
                }else{
                    self.statusImageView.image = UIImage(named: "MOBI")
                }
            }else{
                self.statusImageView.image = UIImage(named: "MOBI")
            }
            if indexpath.row == self.dBVc!.currentRow {
                if self.dBVc!.cellTapped{
                    bottomView.isHidden = false
                    bottomView.layer.cornerRadius = 3.0
                    bottomView.layer.shadowOffset = CGSize(width: 1, height: 1)
                    bottomView.layer.shadowOpacity = 0.2
                    bottomView.layer.shadowRadius = 1
                    downButton.setImage(UIImage(named: "ic_Sort_Up"), for: .normal)

                    if OprCount != ""{
                        oprCountLabel.isHidden = false
                        oprCountLabel.text = "\(OprCount)"
                        oprCountLabel.backgroundColor = OprColor
                        ODSUIHelper.setRoundLabel(label: oprCountLabel)
                    }else{
                        oprCountLabel.isHidden = true
                    }
                    if attchmentCount != ""{
                        attachmentCountLabel.isHidden = false
                        attachmentCountLabel.text = "\(attchmentCount)"
                        attachmentCountLabel.backgroundColor = attchmentColor
                        ODSUIHelper.setRoundLabel(label: attachmentCountLabel)
                    }else{
                        attachmentCountLabel.isHidden = true
                    }
                    if cmpCount != "" && cmpCount != "0"{
                        compCountLabel.isHidden = false
                        compCountLabel.text = "\(cmpCount)"
                        compCountLabel.backgroundColor = cmpColor
                        ODSUIHelper.setRoundLabel(label: compCountLabel)
                    }else{
                        compCountLabel.isHidden = true
                    }
                    if formCount != "" && formCount != "0"{
                        formsCountLabel.isHidden = false
                        formsCountLabel.text = "\(formCount)"
                        formsCountLabel.backgroundColor = formColor
                        ODSUIHelper.setRoundLabel(label: formsCountLabel)
                    }else{
                        formsCountLabel.isHidden = true
                    }
                    if rpCount != "" && rpCount != "0"{
                        pointsCountLabel.isHidden = false
                        pointsCountLabel.text = "\(rpCount)"
                        pointsCountLabel.backgroundColor = rpColor
                        ODSUIHelper.setRoundLabel(label: pointsCountLabel)
                    }else{
                        pointsCountLabel.isHidden = true
                    }
                    if workOrderCls.InspectionLot != "000000000000" && inspCount != ""{
                        inspCountView.isHidden = false
                        inspCountLabel.text = "\(String(describing: inspCount))"
                        inspCountLabel.backgroundColor = InspColor
                        ODSUIHelper.setRoundLabel(label: inspCountLabel)
                    }else{
                        inspCountView.isHidden = true
                    }
                    let oprObj = allOperationsArray.filter{$0.WorkOrderNum == workOrderCls.WorkOrderNum}
                    if oprObj.count > 0 {
                        var actualwork = Double()
                        var normalDuration = Double()
                        for item in oprObj{
                            actualwork = actualwork + item.ActualWork.doubleValue
                            normalDuration = normalDuration + (Double(item.NumberPerson) * item.NormalDuration.doubleValue)
                        }
                        actualMHRSLabel.text = "Actual mHRS : " + "\(actualwork)"
                        plannedMHRSLabel.text = "Planned mHRS : " + "\(normalDuration)"
                    }else{
                        actualMHRSLabel.text = "Actual mHRS : 0"
                        plannedMHRSLabel.text = "Planned mHRS : 0"
                    }
                    approvedCheckSheetCountLabel.text = "Approved CheckSheet : " + "\(self.dBVc!.approvedChecksheetArr.count)"
                    rejectedCheckSheetCountLabel.text = "Rejected CheckSheet : " + "\(self.dBVc!.rejectedChecksheetArr.count)"
                    yetToBeReviewedCountLabel.text = "Yet to be reviewed : " + "\(self.dBVc!.yetToBeReviewedArr.count)"

                    oprTitleLabel.text = "Operations".localized()
                    inspTitleLabel.text = "UNQ-ES-5nU".localized()
                    compTitleLabel.text = "Components".localized()
                    attachmentTitleLabel.text = "Attachments".localized()
                    pointsTitleLabel.text = "Record_Points".localized()
                    formsTitleLabel.text = "Checklists".localized()

                }else{
                    bottomView.isHidden = true
                    backGroundView.layer.cornerRadius = 3.0
                    backGroundView.layer.shadowOffset = CGSize(width: 1, height: 1)
                    backGroundView.layer.shadowOpacity = 0.2
                    backGroundView.layer.shadowRadius = 1
                    downButton.setImage(UIImage(named: "ic_Sort_Down"), for: .normal)
                    actualMHRSLabel.text = ""
                    plannedMHRSLabel.text = ""
                    approvedCheckSheetCountLabel.text = ""
                    rejectedCheckSheetCountLabel.text = ""
                    yetToBeReviewedCountLabel.text = ""
                }
            }
            downButton.tag = indexpath.row
            downButton.addTarget(self, action: #selector(self.downButtonTapped(sender:)), for: .touchUpInside)
            detailButton.setTitle("", for: .normal)
            detailArrowImageView.isHidden = true
            detailButton.addTarget(self, action: #selector(self.detailButtonAction(sender:)), for: .touchUpInside)
        }
    }
    func dBOperationConfiguration(){

        if let oprCls = dBOperationClass{

            bottomView.isHidden = true
            shortTextLabel.text = oprCls.ShortText
            functionalLocLabel.text = "FLoc : \(oprCls.FuncLoc)"
            equipmentLabel.text = "Eqp : \(oprCls.Equipment)"
            priorityImageView.image = myAssetDataManager.getPriorityImage(priority: oprCls.WoPriority)
            breakDownImageView.isHidden = true
            if oprCls.SubOperation != ""{
                numberLabel.text = "\(oprCls.WorkOrderNum) / \(oprCls.OperationNum) / \(oprCls.SubOperation)"
            }else{
                numberLabel.text = "\(oprCls.WorkOrderNum) / \(oprCls.OperationNum)"
            }
            if oprCls.LatestSchStartDate != nil{
                dateLabel.text = "Start_Date".localized() + " : \(oprCls.LatestSchStartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current))"
            }else{
                dateLabel.text = "Start_Date".localized() + " :"
            }
            if oprCls.LatestSchFinishDate != nil{
                endDateLabel.text = "Due_Date".localized() + " : \(oprCls.LatestSchFinishDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current))"
            }else{
                endDateLabel.text = "Due_Date".localized() + " :"
            }
            priorityImageView.image = myAssetDataManager.getPriorityImage(priority: oprCls.WoPriority)
            if DeviceType == iPhone{
                orderTypeLabel.text = oprCls.OrderType
            }else{
                orderTypeLabel.isHidden = true
            }
            if globalWoAttachmentArr.contains(oprCls.WorkOrderNum){
                attachmentImageView.isHidden = false
            }else{
                attachmentImageView.isHidden = true
            }
            let arr = statusCategoryArr.filter{$0.StatusCode == "\(oprCls.MobileStatus)"}
            if arr.count > 0{
                if let statusImage = UIImage(named: arr[0].ImageResKey) {
                    self.statusImageView.image = statusImage
                }else{
                    self.statusImageView.image = UIImage(named: "MOBI")
                }
            }else{
                self.statusImageView.image = UIImage(named: "MOBI")
            }
            if indexpath.row == self.dBVc!.currentRow {

                if self.dBVc!.cellTapped{

                    bottomView.isHidden = false
                    bottomView.layer.cornerRadius = 3.0
                    bottomView.layer.shadowOffset = CGSize(width: 1, height: 1)
                    bottomView.layer.shadowOpacity = 0.2
                    bottomView.layer.shadowRadius = 1
                    downButton.setImage(UIImage(named: "ic_Sort_Up"), for: .normal)
                    oprCountView.isHidden = true
                    if OprCount != ""{
                        oprCountLabel.text = "\(OprCount)"
                        oprCountLabel.backgroundColor = OprColor
                        ODSUIHelper.setRoundLabel(label: oprCountLabel)

                    }
                    if attchmentCount != ""{
                        attachmentCountLabel.text = "\(attchmentCount)"
                        attachmentCountLabel.backgroundColor = attchmentColor
                        ODSUIHelper.setRoundLabel(label: attachmentCountLabel)
                    }
                    if cmpCount != ""{
                        compCountLabel.text = "\(cmpCount)"
                        compCountLabel.backgroundColor = cmpColor
                        ODSUIHelper.setRoundLabel(label: compCountLabel)
                    }
                    if formCount != ""{
                        formsCountLabel.text = "\(formCount)"
                        formsCountLabel.backgroundColor = formColor
                        ODSUIHelper.setRoundLabel(label: formsCountLabel)
                    }
                    if rpCount != ""{
                        pointsCountLabel.text = "\(rpCount)"
                        pointsCountLabel.backgroundColor = rpColor
                        ODSUIHelper.setRoundLabel(label: pointsCountLabel)
                    }
                    inspCountView.isHidden = true
                    if oprCls.ActualWork == 0 {
                        actualMHRSLabel.text = "Actual mHRS : 0.00"
                    }else{
                        actualMHRSLabel.text = "Actual mHRS : " + "\(oprCls.ActualWork)"
                    }
                    if oprCls.NormalDuration == 0 {
                        plannedMHRSLabel.text = "Planned mHRS : 0"
                    }else{
                        plannedMHRSLabel.text = "Planned mHRS : " + "\(Double(truncating: oprCls.NormalDuration) * Double(oprCls.NumberPerson))"
                    }
                    approvedCheckSheetCountLabel.text = "Approved CheckSheet : " + "\(self.dBVc!.approvedChecksheetArr.count)"
                    rejectedCheckSheetCountLabel.text = "Rejected CheckSheet : " + "\(self.dBVc!.rejectedChecksheetArr.count)"
                    yetToBeReviewedCountLabel.text = "Yet to be reviewed : " + "\(self.dBVc!.yetToBeReviewedArr.count)"
                    oprTitleLabel.text = "Operations".localized()
                    inspTitleLabel.text = "UNQ-ES-5nU".localized()
                    compTitleLabel.text = "Components".localized()
                    attachmentTitleLabel.text = "Attachments".localized()
                    pointsTitleLabel.text = "Record_Points".localized()
                    formsTitleLabel.text = "Checklists".localized()
                } else {
                    bottomView.isHidden = true
                    backGroundView.layer.cornerRadius = 3.0
                    backGroundView.layer.shadowOffset = CGSize(width: 1, height: 1)
                    backGroundView.layer.shadowOpacity = 0.2
                    backGroundView.layer.shadowRadius = 1
                    downButton.setImage(UIImage(named: "ic_Sort_Down"), for: .normal)
                    actualMHRSLabel.text = ""
                    plannedMHRSLabel.text = ""
                    approvedCheckSheetCountLabel.text = ""
                    rejectedCheckSheetCountLabel.text = ""
                    yetToBeReviewedCountLabel.text = ""
                }
            }
            detailButton.setTitle("", for: .normal)
            detailArrowImageView.isHidden = true
            downButton.tag = indexpath.row
            downButton.addTarget(self, action: #selector(self.downButtonTapped(sender:)), for: .touchUpInside)
        }
    }
    func dBNotificationConfiguration(){

        if let notifCls = dBNotificationClass{
            operationInfoButton.isHidden = true
            bottomView.isHidden = true
            numberLabel.text = notifCls.Notification
            shortTextLabel.text = notifCls.ShortText
            functionalLocLabel.text = "Floc : \(notifCls.FunctionalLoc)"
            equipmentLabel.text = "Eqp : \(notifCls.Equipment)"
            priorityImageView.image = myAssetDataManager.getPriorityImage(priority: notifCls.Priority)
            if notifCls.RequiredStartDate != nil{
                dateLabel.text = "Start_Date".localized() + " : " + notifCls.RequiredStartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                dateLabel.text = "Start_Date".localized() + " : "
            }
            if notifCls.RequiredEndDate != nil{
                endDateLabel.text = "Due_Date".localized() + " : " +  notifCls.RequiredEndDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                endDateLabel.text = "Due_Date".localized() + " : "
            }
            if Show_Postal_Code == true{
                if notifCls.PostalCode != ""{
                    postalView.isHidden = false
                    postalCodeLabel.text =  notifCls.PostalCode
                }else{
                    postalView.isHidden = true
                    postalCodeLabel.text = ""
                }
            }else{
                postalView.isHidden = true
                postalCodeLabel.text = ""
            }
            if DeviceType == iPhone{
                orderTypeLabel.text = notifCls.NotificationType
            }else{
                orderTypeLabel.isHidden = true
            }
            if globalNoAttachmentArr.contains(notifCls.Notification){
                attachmentImageView.isHidden = false
            }else{
                attachmentImageView.isHidden = true
            }
            if notifCls.Breakdown == "X" || notifCls.Breakdown == "x"{
                breakDownImageView.isHidden  = false
            }else {
                breakDownImageView.isHidden  = true
            }
            let arr = statusCategoryArr.filter{$0.StatusCode == "\(notifCls.MobileStatus)"}
            if arr.count > 0{
                if let statusImage = UIImage(named: arr[0].ImageResKey) {
                    self.statusImageView.image = statusImage
                }else{
                    self.statusImageView.image = UIImage(named: "MOBI")
                }
            }else{
                self.statusImageView.image = UIImage(named: "MOBI")
            }
            if indexpath.row == self.dBVc!.currentRow {
                if self.dBVc!.cellTapped{
                    bottomView.isHidden = false
                    bottomView.layer.cornerRadius = 3.0
                    bottomView.layer.shadowOffset = CGSize(width: 1, height: 1)
                    bottomView.layer.shadowOpacity = 0.2
                    bottomView.layer.shadowRadius = 1
                    downButton.setImage(UIImage(named: "ic_Sort_Up"), for: .normal)

                    oprCountImageView.image = UIImage(named: "items.png")
                    inspCountImageView.image = UIImage(named: "activities.png")
                    compCountImageView.image = UIImage(named: "tasks.png")
                    bottomAttchImgView.image = UIImage(named: "attachment.png")
                    pointsCountView.isHidden = true
                    formsCountView.isHidden = true

                    oprTitleLabel.text = "Items".localized()
                    inspTitleLabel.text = "Activities".localized()
                    compTitleLabel.text = "Tasks".localized()
                    attachmentTitleLabel.text = "Attachments".localized()
                    pointsTitleLabel.text = "Record_Points".localized()
                    formsTitleLabel.text = "Checklists".localized()

                    if ItemCount != ""{
                        oprCountLabel.text = "\(ItemCount)"
                        oprCountLabel.backgroundColor = appColor
                        ODSUIHelper.setRoundLabel(label: oprCountLabel)
                    }
                    if  ActvityCount != ""{
                        inspCountLabel.text = "\(ActvityCount)"
                        inspCountLabel.backgroundColor = appColor
                        ODSUIHelper.setRoundLabel(label: inspCountLabel)
                    }
                    if TaskCount != ""{
                        compCountLabel.text = "\(TaskCount)"
                        compCountLabel.backgroundColor = appColor
                        ODSUIHelper.setRoundLabel(label: compCountLabel)
                    }
                    if attchmentCount != ""{
                        attachmentCountLabel.text = "\(attchmentCount)"
                        attachmentCountLabel.backgroundColor = appColor
                        ODSUIHelper.setRoundLabel(label: attachmentCountLabel)
                    }
                    actualMHRSLabel.text = "Actual mHRS : 0"
                    plannedMHRSLabel.text = "Planned mHRS : 0"
                    approvedCheckSheetCountLabel.text = "Approved CheckSheet : 0"
                    rejectedCheckSheetCountLabel.text = "Rejected CheckSheet : 0"
                    yetToBeReviewedCountLabel.text = "Yet to be reviewed : 0"
                } else {
                    bottomView.isHidden = true
                    backGroundView.layer.cornerRadius = 3.0
                    backGroundView.layer.shadowOffset = CGSize(width: 1, height: 1)
                    backGroundView.layer.shadowOpacity = 0.2
                    backGroundView.layer.shadowRadius = 1
                    downButton.setImage(UIImage(named: "ic_Sort_Down"), for: .normal)
                    actualMHRSLabel.text = ""
                    plannedMHRSLabel.text = ""
                    approvedCheckSheetCountLabel.text = ""
                    rejectedCheckSheetCountLabel.text = ""
                    yetToBeReviewedCountLabel.text = ""
                }
            }else{
                bottomView.isHidden = true
                backGroundView.layer.cornerRadius = 3.0
                backGroundView.layer.shadowOffset = CGSize(width: 1, height: 1)
                backGroundView.layer.shadowOpacity = 0.2
                backGroundView.layer.shadowRadius = 1
                downButton.setImage(UIImage(named: "ic_Sort_Down"), for: .normal)
            }
            detailButton.setTitle("", for: .normal)
            detailArrowImageView.isHidden = true
            downButton.tag = indexpath.row
            downButton.addTarget(self, action: #selector(self.downButtonTapped(sender:)), for: .touchUpInside)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func detailButtonAction(sender: AnyObject){
        print("details tapp")
    }
    @objc func downButtonTapped(sender: AnyObject){
        mJCLogger.log("Starting", Type: "info")
        self.dBVc!.cellTapped = !self.dBVc!.cellTapped
        self.dBVc!.currentRow = sender.tag
        DispatchQueue.main.async {
            self.dBVc!.detailsTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func workorderCellConfiguration() {
        
        self.backGroundView.layer.cornerRadius = 3.0
        self.backGroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.backGroundView.layer.shadowOpacity = 0.2
        self.backGroundView.layer.shadowRadius = 2

        if let workorderCls = woModelClass{
            if currentMasterView == "WorkOrder" {
                if masterViewModel.woNoArray.count == masterViewModel.woNoListArray.count{
                    masterViewModel.skipvalue = masterViewModel.woNoListArray.count
                }
                let status = WorkOrderDataManegeClass.uniqueInstance.setWorkOrderStatus(userStatus: workorderCls.UserStatus, mobileStatus: workorderCls.MobileObjStatus, woClass: workorderCls)
                let arr = statusCategoryArr.filter{$0.StatusCode == status}
                if arr.count > 0{
                    if let statusImage = UIImage(named: arr[0].ImageResKey) {
                        self.statusImageView.image = statusImage
                    }else{
                        self.statusImageView.image = UIImage(named: "MOBI")
                    }
                }else{
                    self.statusImageView.image = UIImage(named: "MOBI")
                }
                self.priorityImageView.image = myAssetDataManager.getPriorityImage(priority: workorderCls.Priority)
                self.numberLabel.text = workorderCls.WorkOrderNum
                self.shortTextLabel.text = workorderCls.ShortText
                self.functionalLocLabel.text = "Floc: \(workorderCls.FuncLocation)"
                self.equipmentLabel.text = "Eqp: \(workorderCls.EquipNum)"
                if globalWoAttachmentArr.contains(workorderCls.WorkOrderNum){
                    self.attachmentImageView.isHidden = false
                }else{
                    self.attachmentImageView.isHidden = true
                }
                if workorderCls.EnteredBy == userDisplayName && DOWNLOAD_CREATEDBY_WO == "X"{
                    self.createdByMeImageView.isHidden = false
                }else {
                    self.createdByMeImageView.isHidden = true
                }
                if Show_Postal_Code == true{
                    if workorderCls.PostalCode == ""{
                        self.postalView.isHidden = true
                        self.postalCodeLabel.text = ""
                    }else{
                        self.postalView.isHidden = false
                        self.postalCodeLabel.text = workorderCls.PostalCode
                    }
                }else{
                    self.postalView.isHidden = true
                }
                if workorderCls.SuperiorOrder != ""{
                    self.followOnButton.isHidden = false
                    ODSUIHelper.setBorderToView(view: self.followOnButton, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
                }else{
                    self.followOnButton.isHidden = true
                }
                if workorderCls.BasicStrtDate != nil{
                    let startDate = workorderCls.BasicStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    self.dateLabel.text = "Start_Date".localized() + " : " + startDate
                }else{
                    self.dateLabel.text = "Start_Date".localized() + " : "
                }
                if DeviceType == iPhone{
                    self.orderTypeLabel.isHidden = false
                    self.orderTypeLabel.text = workorderCls.OrderType
                    if((UserDefaults.standard.value(forKey:"active_details")) != nil){
                        let activedetails = UserDefaults.standard.value(forKey: "active_details") as! Dictionary<String, Any>
                        if let activeWOnum = activedetails["WorkorderNum"] as? String{
                            if activeWOnum == workorderCls.WorkOrderNum{
                                self.activeInfoButton.isHidden = false
                                self.transperentView.isHidden = false
                                self.isSelectedCellView.isHidden = false
                            }else{
                                self.activeInfoButton.isHidden = true
                                self.transperentView.isHidden = true
                                self.isSelectedCellView.isHidden = true
                            }
                        }else{
                            self.activeInfoButton.isHidden = true
                            self.transperentView.isHidden = true
                            self.isSelectedCellView.isHidden = true
                        }
                    }else{
                        self.activeInfoButton.isHidden = true
                        self.transperentView.isHidden = true
                        self.isSelectedCellView.isHidden = true
                    }
                }else{
                    self.orderTypeLabel.isHidden = true
                    if workorderCls.isSelectedCell {
                        self.transperentView.isHidden = false
                        self.isSelectedCellView.isHidden = false
                        self.activeInfoButton.isHidden = false
                        masterViewModel.getCurrentReading(objectType: workorderCls)
                        masterViewModel.getSingleNotificationList()
                    }else {
                        self.transperentView.isHidden = true
                        self.isSelectedCellView.isHidden = true
                        self.activeInfoButton.isHidden = true
                    }
                }
            }
        }
    }
    func operationCellConfiguration() {

        if let oprCls = operationClass {

            self.backGroundView.layer.cornerRadius = 3.0
            self.backGroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
            self.backGroundView.layer.shadowOpacity = 0.2
            self.backGroundView.layer.shadowRadius = 2
            self.createdByMeImageView.isHidden = true

            if masterViewModel.woNoArray.indices.contains(indexpath.row){
                let status =  WorkOrderDataManegeClass.uniqueInstance.setOperationStatus(userStatus: oprCls.UserStatus, mobileStatus: oprCls.MobileStatus, oprClass: oprCls)
                let arr = statusCategoryArr.filter{$0.StatusCode == status}
                if arr.count > 0{
                    if let statusImage = UIImage(named: arr[0].ImageResKey) {
                        self.statusImageView.image = statusImage
                    }else{
                        self.statusImageView.image = UIImage(named: "MOBI")
                    }
                }else{
                    self.statusImageView.image = UIImage(named: "MOBI")
                }
                self.priorityImageView.image = myAssetDataManager.getPriorityImage(priority: oprCls.WoPriority)
                self.shortTextLabel.text = "\(oprCls.ShortText)"
                self.functionalLocLabel.text = "Floc: \(oprCls.FuncLoc)"
                self.equipmentLabel.text = "Eqp: \(oprCls.Equipment)"

                if oprCls.SubOperation != ""{
                    self.numberLabel.text = "\(oprCls.WorkOrderNum) / \(oprCls.OperationNum) / \(oprCls.SubOperation)"
                }else{
                    self.numberLabel.text = "\(oprCls.WorkOrderNum) / \(oprCls.OperationNum)"
                }
                if globalWoAttachmentArr.contains(oprCls.WorkOrderNum){
                    self.attachmentImageView.isHidden = false
                }else{
                    self.attachmentImageView.isHidden = true
                }
                self.operationInfoButton.isHidden = false
                self.operationInfoButton.tag = indexpath.row
                self.operationInfoButton.addTarget(self, action: #selector(operationInfoBtnAction(sender:)), for: .touchUpInside)
                if oprCls.LatestSchStartDate != nil{
                    self.dateLabel.text = "Start_Date".localized() + " : \(oprCls.LatestSchStartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current))"
                }else{
                    self.dateLabel.text = "Start_Date".localized() + " :"
                }
                if DeviceType == iPhone{
                    self.orderTypeLabel.isHidden = false
                    self.orderTypeLabel.text = oprCls.OrderType
                    if((UserDefaults.standard.value(forKey:"active_details")) != nil){
                        let activedetails = UserDefaults.standard.value(forKey: "active_details") as! Dictionary<String, Any>
                        if let activeWOnum = activedetails["WorkorderNum"] as? String{
                            let activeOprNum = activedetails["OperationNum"] as! String
                            if activeWOnum == oprCls.WorkOrderNum && activeOprNum == oprCls.OperationNum{
                                self.activeInfoButton.isHidden = false
                                self.transperentView.isHidden = false
                                self.isSelectedCellView.isHidden = false
                            }else{
                                self.activeInfoButton.isHidden = true
                                self.transperentView.isHidden = true
                                self.isSelectedCellView.isHidden = true
                            }
                        }else{
                            self.activeInfoButton.isHidden = true
                            self.transperentView.isHidden = true
                            self.isSelectedCellView.isHidden = true
                        }
                    }else{
                        self.activeInfoButton.isHidden = true
                        self.transperentView.isHidden = true
                        self.isSelectedCellView.isHidden = true
                    }
                }else{
                    self.orderTypeLabel.isHidden = true
                    if(oprCls.isSelected) {
                        self.isSelectedCellView.isHidden = false
                        self.transperentView.isHidden = false
                        self.masterViewModel.getWorkorderDetails(woNumber: oprCls.WorkOrderNum, showPopUp: false)
                    }else{
                        self.transperentView.isHidden = true
                        self.isSelectedCellView.isHidden = true
                    }
                }
            }
        }
    }
    @objc func operationInfoBtnAction(sender: AnyObject){
        if onlineSearch == true{
            let operationClass = self.masterViewModel.woNoArray[sender.tag] as! WoOperationModel
            let array = onlineSearchArray as! [WoHeaderModel]
            let filterar = array.filter{ $0.WorkOrderNum == "\(operationClass.WorkOrderNum)"}
            if filterar.count > 0{
                let workorderdetail = filterar[0]
                myAssetDataManager.presentWorkOrderInfoView(woObject: workorderdetail)
            }else{
                mJCAlertHelper.showAlert(title: MessageTitle, message: "UNABLE_FETCH_WO".localized(), button: okay)
            }
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                let workorderclass = self.masterViewModel.woNoArray[sender.tag] as! WoHeaderModel
                masterViewModel.getWorkorderDetails(woNumber: workorderclass.WorkOrderNum, showPopUp : true)
            }else{
                let operationClass = self.masterViewModel.woNoArray[sender.tag] as! WoOperationModel
                masterViewModel.getWorkorderDetails(woNumber: operationClass.WorkOrderNum, showPopUp : true)
            }
        }
    }
}
