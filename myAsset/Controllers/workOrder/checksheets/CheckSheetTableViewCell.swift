//
//  FormTableViewCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/23/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class CheckSheetTableViewCell: UITableViewCell {

    @IBOutlet var backGroundView: UIView!
    @IBOutlet var mandatoryView: UIView!
    @IBOutlet var formTitle: UILabel!
    @IBOutlet var fillType: UILabel!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var versionCount: UILabel!
    @IBOutlet var submissonLabel: UILabel!
    @IBOutlet var submissonCount: UILabel!
    @IBOutlet var filledLabel: UILabel!
    @IBOutlet var filledCount: UILabel!
    @IBOutlet var reviewersLabel: UILabel!
    @IBOutlet var reviewersCount: UILabel!
    @IBOutlet var operationLabel: UILabel!
    @IBOutlet var operationValue: UILabel!

    @IBOutlet var versionStackView: UIStackView!
    @IBOutlet var reviewerStackView: UIStackView!
    @IBOutlet var filledStachView: UIStackView!
    @IBOutlet var operationStackView: UIStackView!
    @IBOutlet var submissionsStackView: UIStackView!
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var infoButton: UIButton!

    var indexpath = IndexPath()
    var isFromApproval = false
    var isFromManual = false
    var mangeCSVC: ManageCheckSheetVC?

    var formApprovalViewModel = CheckSheetApprovalViewModel()
    var fromStr = String()
    var checkSheetListVC: CheckSheetListVC?
    var generalCheckSheetVC : GeneralCheckSheetListVC?

    var predefinedCheckSheetCellModel: FormAssignDataModel? {
        didSet{
            predefinedFormConfiguration()
        }
    }
    var manulCheckSheetCellModel: FormAssignDataModel?{
        didSet{
            manulCheckSheetConfiguration()
        }
    }
    var approvalCheckSheetCellModel: FormAssignDataModel?{
        didSet{
            checkSheetApprovalConfiguration()
        }
    }
    var generalFormModelCellModel: FormAssignDataModel? {
        didSet{
            generalFormConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mJCLogger.log("Starting", Type: "info")
        ODSUIHelper.setCircleButtonLayout(button: self.addButton, bgColor: appColor)
        mJCLogger.log("Ended", Type: "info")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func predefinedFormConfiguration() {
        
        mJCLogger.log("Starting", Type: "info")
        addButton.setImage(UIImage.init(named: "add_icon"), for: .normal)
        addButton.backgroundColor = appColor
        versionCount.text = predefinedCheckSheetCellModel?.Version
        formTitle.text = predefinedCheckSheetCellModel?.FormName
        if formTitle.text == ""{
            formTitle.text = predefinedCheckSheetCellModel?.FormID
        }
//        if checkSheetListVC?.isfrom == "Supervisor"{
//            addButton.isHidden = true
//        }
        if(predefinedCheckSheetCellModel?.MultipleSub == "X" && Int(predefinedCheckSheetCellModel?.Occur ?? "") ?? 0 == 0) {
            submissonCount.text = "Multiple".localized()
            addButton.isEnabled = true
        }else if(predefinedCheckSheetCellModel?.MultipleSub == "X" && Int(predefinedCheckSheetCellModel?.Occur ?? "") ?? 0 > 0) {
            submissonCount.text = predefinedCheckSheetCellModel?.Occur ?? ""
            addButton.isEnabled = true
        }else if(predefinedCheckSheetCellModel?.MultipleSub != "X") {
            submissonCount.text =  String(predefinedCheckSheetCellModel?.Occur ?? "")
            if(Int(predefinedCheckSheetCellModel?.Occur ?? "") ?? 0 > 0) {
                addButton.isEnabled = true
            }else{
                addButton.isEnabled = true
            }
        }
        if(predefinedCheckSheetCellModel?.Mandatory == "X") {
            fillType.text = "MANDATORY".localized()
//            if checkSheetListVC?.isfrom != "Supervisor"{
//                mandatoryView.backgroundColor = UIColor.systemRed
//            }
        }else {
            fillType.text = "OPTIONAL".localized()
//            if checkSheetListVC?.isfrom != "Supervisor"{
//                mandatoryView.backgroundColor = filledCountColor
//            }
        }
        if predefinedCheckSheetCellModel?.filledFormCount == 0 {
            mandatoryView.isHidden = false
        }else{
            mandatoryView.isHidden = true
        }
        filledCount.text = String(predefinedCheckSheetCellModel?.filledFormCount ?? 0)
        if(predefinedCheckSheetCellModel?.filledFormCount ?? 0 > 0) {
            addButton.isSelected = true
            filledCount.textColor = appColor
        }else {
            addButton.isSelected = false
            if(predefinedCheckSheetCellModel?.Mandatory == "X") {
                filledCount.textColor = UIColor.systemRed
            }else {
                filledCount.textColor = appColor
            }
        }
        editButton.isHidden = true
        reviewerStackView.isHidden = true
        operationStackView.isHidden = true
        addButton.tag = indexpath.row
        infoButton.tag = indexpath.row
        addButton.addTarget(self, action: #selector(predefinedformButtonAction), for: UIControl.Event.touchUpInside)
        infoButton.addTarget(self, action: #selector(predefinedInfoButtonAction), for: UIControl.Event.touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func predefinedformButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        self.checkSheetListVC?.formTableViewCellButtonAction(tagValue: btn.tag, from: "preDefined")
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func predefinedInfoButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let checkSheetArr = self.formApprovalViewModel.checkSheetArray.filter{$0.FormID == "\(predefinedCheckSheetCellModel?.FormID ?? "")" && $0.Version == "\(predefinedCheckSheetCellModel?.Version ?? "")"}
        if checkSheetArr.count > 0{
            let checkSheet = checkSheetArr[0]
            self.presentCheckSheetInfo(checkSheetObj: checkSheet)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func manulCheckSheetConfiguration() {
        
        mJCLogger.log("Starting", Type: "info")
        versionCount.text = "\(Int(manulCheckSheetCellModel?.Version ?? "0") ?? 0)"
        formTitle.text = manulCheckSheetCellModel?.FormName
        if formTitle.text == ""{
            formTitle.text = predefinedCheckSheetCellModel?.FormID
        }
        submissonCount.text = "\(Int(manulCheckSheetCellModel?.Occur ?? "0") ?? 0)"
        if(manulCheckSheetCellModel?.Mandatory == "X") {
            fillType.text = "MANDATORY".localized()
            mandatoryView.backgroundColor = UIColor.systemRed
        }else{
            fillType.text = "OPTIONAL".localized()
            mandatoryView.backgroundColor = filledCountColor
        }
        if isFromManual  == true{
            if fromStr == "Manage"{
                addButton.tag = indexpath.row
                infoButton.isHidden = true
                filledStachView.isHidden = true
                reviewerStackView.isHidden = true
                operationStackView.isHidden = true
                addButton.setImage(UIImage.init(named: "ic_Delete"), for: .normal)
                addButton.addTarget(self, action: #selector(deleteCheckSheetButtonAction), for: .touchUpInside)
                self.editButton.addTarget(self, action: #selector(editCheckSheetButtonAction), for: .touchUpInside)
                if !applicationFeatureArrayKeys.contains("DELETE_MANUAL_CHECKSHEET"){
                    self.addButton.isHidden = true
                }else{
                    self.addButton.isHidden = false
                }
                addButton.isHidden = true
                if !applicationFeatureArrayKeys.contains("EDIT_MANUAL_CHECKSHEET"){
                    self.editButton.isHidden = true
                }else{
                    self.editButton.isHidden = false
                }
            }else{
                if applicationFeatureArrayKeys.contains("FORM_ADD_NEW_FORM_OPTION"){
                    addButton.isHidden = false
                }else{
                    addButton.isHidden = true
                }
                self.editButton.isHidden = true
                infoButton.isHidden = false
                filledCount.text = String(manulCheckSheetCellModel?.filledFormCount ?? 0)
                addButton.setImage(UIImage.init(named: "add_icon"), for: .normal)
                addButton.backgroundColor = appColor
                if(manulCheckSheetCellModel?.MultipleSub == "X" && Int(manulCheckSheetCellModel?.Occur ?? "0") ?? 0 == 0) {
                    submissonCount.text = "Multiple".localized()
                    addButton.isEnabled = true
                }else if(manulCheckSheetCellModel?.MultipleSub == "X" && Int(manulCheckSheetCellModel?.Occur ?? "0") ?? 0 > 0) {
                    submissonCount.text = "\(Int(manulCheckSheetCellModel?.Occur ?? "0") ?? 0)"
                    addButton.isEnabled = true
                }else if(manulCheckSheetCellModel?.MultipleSub != "X") {
                    submissonCount.text = "\(Int(manulCheckSheetCellModel?.Occur ?? "0") ?? 0)"
                    if (Int(manulCheckSheetCellModel?.Occur ?? "0") ?? 0 > 0) {
                        addButton.isEnabled = true
                    }else{
                        addButton.isEnabled = true
                    }
                }
                if manulCheckSheetCellModel?.filledFormCount == 0 {
                    mandatoryView.isHidden = false
                }else{
                    mandatoryView.isHidden = true
                }
                if(manulCheckSheetCellModel?.filledFormCount ?? 0 > 0) {
                    addButton.isSelected = true
                    filledCount.textColor = appColor
                }else {
                    addButton.isSelected = false
                    if(manulCheckSheetCellModel?.Mandatory == "X") {
                        filledCount.textColor = UIColor.systemRed
                    }else {
                        filledCount.textColor = appColor
                    }
                }
                var apprverCountArr = [FormAssignDataModel]()
                if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                    apprverCountArr = self.formApprovalViewModel.self.checksheetApproverArr.filter{$0.FormID == "\(manulCheckSheetCellModel!.FormID)" && $0.Version == "\(manulCheckSheetCellModel!.Version)" && $0.WorkOrderNum == "\(selectedworkOrderNumber)" }
                }else{
                    apprverCountArr = self.formApprovalViewModel.self.checksheetApproverArr.filter{$0.FormID == "\(manulCheckSheetCellModel!.FormID)" && $0.Version == "\(manulCheckSheetCellModel!.Version)" && $0.WorkOrderNum == "\(selectedworkOrderNumber)" && $0.OprNum == "\(selectedOperationNumber)"}
                }
                reviewersCount.text = "\(apprverCountArr.count)"
                operationValue.text = "\(manulCheckSheetCellModel?.OprNum ?? "")"
                addButton.tag = indexpath.row
                addButton.backgroundColor = appColor
                addButton.addTarget(self, action: #selector(manualformButtonAction), for: UIControl.Event.touchUpInside)
                infoButton.addTarget(self, action: #selector(manualformInfoButtonAction), for: UIControl.Event.touchUpInside)
                mJCLogger.log("Ended", Type: "info")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func manualformInfoButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let checkSheetArr = self.formApprovalViewModel.checkSheetArray.filter{$0.FormID == "\(manulCheckSheetCellModel?.FormID ?? "")" && $0.Version == "\(manulCheckSheetCellModel?.Version ?? "")"}
        if checkSheetArr.count > 0{
            let checkSheet = checkSheetArr[0]
            self.presentCheckSheetInfo(checkSheetObj: checkSheet)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func manualformButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        self.checkSheetListVC?.formTableViewCellButtonAction(tagValue: btn.tag, from: "manual")
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Form Cell Button Action..
    @objc func deleteCheckSheetButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let params = Parameters(
            title: alerttitle,
            message: "Are_you_sure_you_want_to_delete".localized(),
            cancelButton: "Cancel".localized(),
            otherButtons: [okay]
        )
        mJCAlertHelper.showAlertWithHandler(parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0: break
            case 1:
                self.mangeCSVC?.manualCheckSheetVM.deleteCheckSheet(tag: btn.tag)
            default: break
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Form Cell Button Action..
    @objc func editCheckSheetButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
            let popView = Bundle.main.loadNibNamed("EditCheckSheetOptionsView", owner: self, options: nil)?.last as! EditCheckSheetOptionsView
            let screenFrame = UIScreen.main.bounds
            popView.frame = screenFrame
            popView.popUpViewUI()
            popView.mangeCSVC = self.mangeCSVC
            popView.manulCheckSheetModel = self.manulCheckSheetCellModel
            UIApplication.shared.windows.first!.addSubview(popView)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Form Cell Button Action..
    @objc func viewCheckSheetButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Ended", Type: "info")
    }
    func checkSheetApprovalConfiguration(){
        
        mJCLogger.log("Starting", Type: "info")
        versionCount.text = approvalCheckSheetCellModel?.Version
        formTitle.text = approvalCheckSheetCellModel?.FormName
        submissonCount.text =  "\(approvalCheckSheetCellModel?.Occur ?? "0")"
        if(approvalCheckSheetCellModel?.Mandatory == "X") {
            fillType.text = "MANDATORY".localized()
            mandatoryView.backgroundColor = UIColor.systemRed
        }else {
            fillType.text = "OPTIONAL".localized()
            mandatoryView.backgroundColor = filledCountColor
        }
        if isFromApproval == true{
            addButton.tag = indexpath.row
            editButton.isHidden = true
            addButton.isSelected = true
            infoButton.isHidden = false
            filledStachView.isHidden = true
            operationStackView.isHidden = true
            addButton.addTarget(self, action: #selector(formApprovalButtonAction), for: UIControl.Event.touchUpInside)
            infoButton.tag = indexpath.row
            infoButton.addTarget(self, action: #selector(formInfoButtonAction), for: UIControl.Event.touchUpInside)
            let arr = formApprovalViewModel.checksheetApproverArr.filter{$0.FormID == "\(approvalCheckSheetCellModel?.FormID ?? "")" && $0.Version == "\(approvalCheckSheetCellModel?.Version ?? "")"}
            reviewersCount.text = "\(arr.count)"
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func formApprovalButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let checkSheetAvailabilityVc = ScreenManager.getCheckSheetAvailabilityScreen()
        checkSheetAvailabilityVc.isFrom = "Approval"
        checkSheetAvailabilityVc.selectedCheckSheet = approvalCheckSheetCellModel!
        checkSheetAvailabilityVc.delegate = formApprovalViewModel.formApprovalVC
        checkSheetAvailabilityVc.modalPresentationStyle = .overFullScreen
        formApprovalViewModel.formApprovalVC?.present(checkSheetAvailabilityVc, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func formInfoButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let checkSheetArr = self.formApprovalViewModel.checkSheetArray.filter{$0.FormID == "\(approvalCheckSheetCellModel?.FormID ?? "")" && $0.Version == "\(approvalCheckSheetCellModel?.Version ?? "")"}
        if checkSheetArr.count > 0{
            let checkSheet = checkSheetArr[0]
            self.presentCheckSheetInfo(checkSheetObj: checkSheet)
        }
        mJCLogger.log("Ended", Type: "info")
    }

    // General Form
    func generalFormConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if fromStr == "FORM_TEMPLATE" {
            addButton.setImage(UIImage.init(named: "add_icon"), for: .normal)
            versionCount.text = generalFormModelCellModel?.Version
            formTitle.text = generalFormModelCellModel?.FormID
            if(generalFormModelCellModel?.MultipleSub == "X" && Int(generalFormModelCellModel?.Occur ?? "") ?? 0 == 0) {
                submissonCount.text = "Multiple".localized()
                addButton.isEnabled = true
            }else if(generalFormModelCellModel?.MultipleSub == "X" && Int(generalFormModelCellModel?.Occur ?? "") ?? 0 > 0) {
                submissonCount.text = generalFormModelCellModel!.Occur
                addButton.isEnabled = true
            }else if(generalFormModelCellModel?.MultipleSub != "X") {
                submissonCount.text = generalFormModelCellModel!.Occur
                if(Int(generalFormModelCellModel?.Occur ?? "") ?? 0 > 0) {
                    addButton.isEnabled = true
                }else{
                    addButton.isEnabled = true
                }
            }
            if(generalFormModelCellModel?.Mandatory == "X") {
                fillType.text = "MANDATORY".localized()
                mandatoryView.backgroundColor = UIColor.systemRed
            }else {
                fillType.text = "OPTIONAL".localized()
                mandatoryView.backgroundColor = filledCountColor
            }
            mandatoryView.isHidden = false
            addButton.isSelected = false
            filledCount.text = String(generalFormModelCellModel?.filledFormCount ?? 0)
            if(generalFormModelCellModel?.Mandatory == "X") {
                filledCount.textColor = UIColor.systemRed
            }else {
                filledCount.textColor = appColor
            }
            editButton.isHidden = true
            addButton.tag = indexpath.row
            addButton.addTarget(self, action: #selector(createNewGeneralCheckSheet), for: UIControl.Event.touchUpInside)
            infoButton.isHidden = true
            reviewerStackView.isHidden = true
            filledStachView.isHidden = true
            operationStackView.isHidden = true

        }else{
            versionCount.text = generalFormModelCellModel?.Version
            formTitle.text = generalFormModelCellModel?.FormID
            if(generalFormModelCellModel?.MultipleSub == "X" && Int(generalFormModelCellModel!.Occur) ?? 0 == 0) {
                submissonCount.text = "Multiple".localized()
                addButton.isEnabled = true
            }else if(generalFormModelCellModel?.MultipleSub == "X" && Int(generalFormModelCellModel!.Occur) ?? 0 > 0) {
                submissonCount.text = generalFormModelCellModel?.Occur ?? ""
                addButton.isEnabled = true
            }else if(generalFormModelCellModel?.MultipleSub != "X") {
                submissonCount.text =  String(generalFormModelCellModel?.Occur ?? "")
                if(Int(generalFormModelCellModel!.Occur) ?? 0 > 0) {
                    addButton.isEnabled = true
                }else{
                    addButton.isEnabled = true
                }
            }
            if(generalFormModelCellModel?.Mandatory == "X") {
                fillType.text = "MANDATORY".localized()
                mandatoryView.backgroundColor = UIColor.systemRed
            }else {
                fillType.text = "OPTIONAL".localized()
                mandatoryView.backgroundColor = filledCountColor
            }
            mandatoryView.isHidden = true
            filledCount.text = String(generalFormModelCellModel?.filledFormCount ?? 0)
            if(generalFormModelCellModel?.filledFormCount ?? 0 > 0) {
                addButton.isSelected = true
                filledCount.textColor = appColor
            }
            addButton.tag = indexpath.row
            addButton.addTarget(self, action: #selector(generalFormButtonAction), for: UIControl.Event.touchUpInside)
            infoButton.isHidden = true
            editButton.isHidden = true
            reviewerStackView.isHidden = true
            operationStackView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func generalTempleteformInfoButtonAction(btn:UIButton){

    }
    @objc func submitedTempleteformInfoButtonAction(btn:UIButton){

    }
    //MARK:- Form Cell Button Action..
    @objc func createNewGeneralCheckSheet(btn:UIButton)  {
        mJCLogger.log("Starting", Type: "info")
        generalCheckSheetVC?.createNewGeneralCheckSheet(index: btn.tag)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func generalFormButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        generalCheckSheetVC?.getFilledChecksheetData(index: btn.tag)
        mJCLogger.log("Ended", Type: "info")
    }
    func presentCheckSheetInfo(checkSheetObj: FormMasterMetaDataModel){
        DispatchQueue.main.async{
            let popView = Bundle.main.loadNibNamed("CheckSheetInfoView", owner: self, options: nil)?.last as! CheckSheetInfoView
            popView.setFrame()
            popView.setCheckSheetData(checkSheetObj: checkSheetObj)
            UIApplication.shared.windows.first!.addSubview(popView)
        }
    }
}

