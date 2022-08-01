//
//  swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationActivityOverViewCell: UITableViewCell {
    
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    @IBOutlet var backGroundView: UIView!
    
    //ActivityView Outlets..
    @IBOutlet var overViewActivityView: UIView!
    @IBOutlet var overViewActivityLabelView: UIView!
    @IBOutlet var overViewActivityLabel: UILabel!
    @IBOutlet weak var notesBtn: UIButton!
    @IBOutlet weak var notesBtnConstant: NSLayoutConstraint!
    
    //ActivityTextView Outlets..
    @IBOutlet var overViewActivityTextView: UIView!
    @IBOutlet var overViewActivityTextLabelView: UIView!
    @IBOutlet var overViewActivityTextLabel: UILabel!
    
    //ActivityCodeView Outlets..
    @IBOutlet var overViewActivityCodeView: UIView!
    @IBOutlet var overViewActivityCodeLabelView: UIView!
    @IBOutlet var overViewActivityCodeLabel: UILabel!
    
    //ActivityCodeGroupView Outlets..
    @IBOutlet var overViewCodeGroupView: UIView!
    @IBOutlet var overViewCodeGroupLabelView: UIView!
    @IBOutlet var overViewCodeGroupLabel: UILabel!
    
    //ActivityCauseView Outlets..
    @IBOutlet var overViewCauseView: UIView!
    @IBOutlet var overViewCauseLabelView: UIView!
    @IBOutlet var overViewCauseLabel: UILabel!
    
    //ActivityCatalogTypeView Outlets..
    @IBOutlet var overViewCatalogTypeView: UIView!
    @IBOutlet var overViewCatalogTypeLabelView: UIView!
    @IBOutlet var overViewCatalogTypeLabel: UILabel!
    
    //SortNumberView Outlets..
    @IBOutlet var overViewSortNumberView: UIView!
    @IBOutlet var overViewSortNumberLabelView: UIView!
    @IBOutlet var overViewSortNumberLabel: UILabel!
    
    //TaskClassView Outlets..
    @IBOutlet var overViewTaskClassView: UIView!
    @IBOutlet var overViewTaskClassLabelView: UIView!
    @IBOutlet var overViewTaskClassLabel: UILabel!
    
    //WorkOrderView Outlets..
    @IBOutlet var overViewWorkOrderView: UIView!
    @IBOutlet var overViewWorkOrderLabelView: UIView!
    @IBOutlet var overViewWorkOrderLabel: UILabel!
    
    //OperationActivityView Outlets..
    @IBOutlet var overViewOperationActivityView: UIView!
    @IBOutlet var overViewOperationActivityLabelView: UIView!
    @IBOutlet var overViewOperationActivityLabel: UILabel!
    
    //StartView Outlets..
    @IBOutlet var overViewStartView: UIView!
    @IBOutlet var overViewStartLabelView: UIView!
    @IBOutlet var overViewStartLabel: UILabel!
    
    //EndView Outlets..
    @IBOutlet var overViewEndView: UIView!
    @IBOutlet var overViewEndLabelView: UIView!
    @IBOutlet var overViewEndLabel: UILabel!
    
    //ClassificationView Outlets..
    @IBOutlet var overViewClassificationView: UIView!
    @IBOutlet var overViewClassificationLabelView: UIView!
    @IBOutlet var overViewClassificationLabel: UILabel!
    
    var indexPath = IndexPath()
    var notificationItemCausesViewModel = NotificationItemCausesViewModel()
    var notificationActivityViewModel = NotificationActivityViewModel()
    
    var NotificationActivityModel:NotificationActivityModel?{
        didSet{
            configureNotificationActivityOverViewCell()
        }
    }
    
    func configureNotificationActivityOverViewCell(){
        mJCLogger.log("Starting", Type: "info")
        if notificationItemCausesViewModel.vc?.isFromScreen == "ItemActivity" {
            if let NotificationActivityModel = NotificationActivityModel {
                overViewActivityLabel.text = NotificationActivityModel.Activity
                overViewActivityTextLabel.text = NotificationActivityModel.ActivityText
                notesBtnConstant.constant = 0
                if overViewActivityTextLabel.text == "Refer_Activity_Long_Text".localized() {
                    notesBtnConstant.constant = 30
                }
                notesBtn.addTarget(self, action: #selector(NotesBtnAction(sender:)), for: .touchUpInside)
                if NotificationActivityModel.ActivityCodeText == "" {
                    overViewActivityCodeLabel.text = NotificationActivityModel.ActivityCode + " - " + NotificationActivityModel.ActivityText
                }else {
                    overViewActivityCodeLabel.text = "\(String(describing: NotificationActivityModel.ActivityCode)) - \(String(describing: NotificationActivityModel.ActivityCodeText))"
                }
                notificationActivityViewModel.getPartValue(catalogCode: NotificationActivityModel.CatalogType, codeGroup: NotificationActivityModel.CodeGroup, code: NotificationActivityModel.ActivityCode)
                overViewCauseLabel.text = NotificationActivityModel.Cause
                overViewCatalogTypeLabel.text = NotificationActivityModel.CatalogType
                overViewSortNumberLabel.text = NotificationActivityModel.SortNumber
                overViewTaskClassLabel.text = NotificationActivityModel.TaskClass
                overViewWorkOrderLabel.text = NotificationActivityModel.WorkOrderNum
                overViewOperationActivityLabel.text = NotificationActivityModel.OperAct
                if NotificationActivityModel.StartDate != nil{
                    overViewStartLabel.text = NotificationActivityModel.StartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    overViewStartLabel.text = ""
                }
                if NotificationActivityModel.EndDate != nil{
                    overViewEndLabel.text = NotificationActivityModel.EndDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    overViewEndLabel.text = ""
                }
                overViewClassificationLabel.text = NotificationActivityModel.Classificatn
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    if self.notificationActivityViewModel.partArray.count > 0 {
                        self.overViewCodeGroupLabel.text = "\(self.notificationActivityViewModel.partArray[0].CodeGroup) - \(self.notificationActivityViewModel.partArray[0].CodeGroupText)"
                    }
                })
            }
        }else{
            if let NotificationActivityModel = NotificationActivityModel {
                overViewActivityLabel.text = NotificationActivityModel.Activity
                overViewActivityTextLabel.text = NotificationActivityModel.ActivityText
                overViewActivityCodeLabel.text = NotificationActivityModel.ActivityCode + " - " + NotificationActivityModel.ActivityCodeText
                notificationActivityViewModel.getPartValue(catalogCode: NotificationActivityModel.CatalogType, codeGroup: NotificationActivityModel.CodeGroup, code: NotificationActivityModel.ActivityCode)
                overViewCauseLabel.text = NotificationActivityModel.Cause
                overViewCatalogTypeLabel.text = NotificationActivityModel.CatalogType
                overViewSortNumberLabel.text = NotificationActivityModel.SortNumber
                overViewTaskClassLabel.text = NotificationActivityModel.TaskClass
                overViewWorkOrderLabel.text = NotificationActivityModel.WorkOrderNum
                overViewOperationActivityLabel.text = NotificationActivityModel.OperAct
                if NotificationActivityModel.StartDate != nil{
                    overViewStartLabel.text = NotificationActivityModel.StartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    overViewStartLabel.text = ""
                }
                if NotificationActivityModel.EndDate != nil{
                    overViewEndLabel.text = NotificationActivityModel.EndDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    overViewEndLabel.text = ""
                }
                overViewClassificationLabel.text = NotificationActivityModel.Classificatn
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    if self.notificationActivityViewModel.partArray.count > 0 {
                        self.overViewCodeGroupLabel.text = "\(self.notificationActivityViewModel.partArray[0].CodeGroup)-\(self.notificationActivityViewModel.partArray[0].CodeGroupText)"
                    }
                })
            }
            notesBtnConstant.constant = 0.0
            notesBtn.addTarget(self, action:  #selector(NotesBtnAction1(sender:)), for: .touchUpInside)
            if overViewActivityTextLabel.text == "Refer_Activity_Long_Text".localized() {
                notesBtnConstant.constant = 30
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func NotesBtnAction(sender: UIButton){
        mJCLogger.log("Starting", Type: "info")
        notificationItemCausesViewModel.vc?.notesBtnAction(UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc func NotesBtnAction1(sender: UIButton){
        mJCLogger.log("Starting", Type: "info")
        let noteListVC = ScreenManager.getLongTextListScreen()
        if  isSingleNotification == true{
            noteListVC.itemNum = selectedItem
            noteListVC.fromScreen = "woNoItemActivity"
        }else{
            noteListVC.itemNum = "0000"
            noteListVC.fromScreen = "noItemActivity"
        }
        noteListVC.activityNum = selectedAcitivity
        noteListVC.isAddNewNote = true
        noteListVC.modalPresentationStyle = .fullScreen
        notificationItemCausesViewModel.vc?.present(noteListVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
}
