//
//  ReadingpointsTableViewCell.swift
//  myJobCard
//
//  Created by Rover Software on 06/07/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation
import AVFoundation

class ReadingpointsTableViewCell: UITableViewCell , UITextFieldDelegate,UITextViewDelegate{

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var Statusview: UIView!
    @IBOutlet var voluationcodetxt: UILabel!
    @IBOutlet var pointtitle: UILabel!
    @IBOutlet var equipmentLabel: UILabel!
    @IBOutlet var equipmnetvalueLabel: UILabel!
    @IBOutlet var measuringunitLabel: UILabel!
    @IBOutlet var completedImage: UIImageView!
    @IBOutlet var completedimgWidth: NSLayoutConstraint!
    @IBOutlet var limitLabel: UILabel!
    @IBOutlet var operationLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet weak var EditButton: UIButton!
    
    @IBOutlet var addNotificationButton: UIButton!
    @IBOutlet var lineChartButton: UIButton!
    @IBOutlet var newReadingTextField: UITextField!
    @IBOutlet var newReadingDesTxtField: UITextField!
    
    @IBOutlet weak var newReadingDesTextView: UITextView!
    @IBOutlet var counterValue: UILabel!
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var newReadingtxtButton: UIButton!
    @IBOutlet var lastReadingValueLbl: UILabel!
    @IBOutlet var lastReadingTxt: UILabel!
    
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!    
    @IBOutlet var addnotificationbuttonYcons: NSLayoutConstraint!
    @IBOutlet weak var CounterViewHeightConstant: NSLayoutConstraint!
   
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var currentReadingView: UIView!
    @IBOutlet weak var currentDescriptionView: UIView!
    
    var indexPath = IndexPath()
    var recordPointViewModel = RecordPointsViewModel()
    var recordPointModelClass : MeasurementPointModel? {
        didSet{
            recordPointsConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // self.newReadingDesTxtField.delegate = self
        
    }
    func recordPointsConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let recordPointModelClass = recordPointModelClass {
            
            ODSUIHelper.setBorderToView(view: newReadingDesTextView, borderWidth: 1.5, cornerRadius: 2.0, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:newReadingDesTextView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:newReadingTextField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)

            if DeviceType == iPhone{
                mainView.layer.cornerRadius = 3.0
                mainView.layer.shadowOffset = CGSize(width: 3, height: 3)
                mainView.layer.shadowOpacity = 0.2
                mainView.layer.shadowRadius = 2
                
            }
            let point = recordPointModelClass.MeasuringPoint
            let descrption = recordPointModelClass.Description
            pointtitle.text = "\(point) - \(descrption)"

            if DeviceType == iPad{
                if recordPointModelClass.Equipment != ""{
                    equipmentLabel.text = "Equipment".localized() + ": "
                    equipmnetvalueLabel.text = recordPointModelClass.Equipment
                }else{
                    equipmentLabel.text = "Functional_Location".localized() +  ": "
                    equipmnetvalueLabel.text = recordPointModelClass.FunctionalLocation
                }
            }else{
                if recordPointModelClass.Equipment != ""{
                    equipmentLabel.text = "Equipment".localized()
                    equipmnetvalueLabel.text = recordPointModelClass.Equipment
                }else{
                    equipmentLabel.text = "Functional_Location".localized()
                    equipmnetvalueLabel.text = recordPointModelClass.FunctionalLocation
                }
            }

            if recordPointModelClass.OperationNum == ""{
                operationLabel.text = "N/A"
            }else{
                operationLabel.text = recordPointModelClass.OperationNum
            }
            var minlimt = String()
            var maxlimit = String()
           
            if recordPointModelClass.LimitMaxChar != "" {
                maxlimit = recordPointModelClass.LimitMaxChar
            }else{
                maxlimit = "Undefined"
            }
            if recordPointModelClass.LimitMinChar != "" {
                minlimt = recordPointModelClass.LimitMinChar
               
            }else{
                minlimt = "Undefined"
            }
            
            limitLabel.text   = "\(minlimt) - \(maxlimit)"
            measuringunitLabel.text = recordPointModelClass.MeasRangeUnit
            newReadingTextField.text = ""
            newReadingDesTextView.text = ""
            
            saveButton.tag = indexPath.row
            addNotificationButton.tag = indexPath.row
            lineChartButton.tag = indexPath.row
            
            saveButton.addTarget(self, action: #selector(saveButtonAction(sender:)), for: .touchUpInside)
            addNotificationButton.addTarget(self, action: #selector(createNotificationButtonAction(sender:)), for: .touchUpInside)
            lineChartButton.addTarget(self, action: #selector(linchartButtonAction(sender:)), for: .touchUpInside)
            lastReadingValueLbl.text = String(recordPointModelClass.MeasReadingChar )
            
            completedimgWidth.constant = 0.0
            newReadingTextField.backgroundColor =  UIColor(named: "mjcViewBgColor")
            newReadingDesTextView.backgroundColor = UIColor(named: "mjcViewBgColor")
            newReadingTextField.isUserInteractionEnabled = true
            newReadingDesTextView.isUserInteractionEnabled = true
            saveButton.isUserInteractionEnabled = true
            
            if recordPointModelClass.ValCodeSuff == false{
                
                lastReadingTxt.text = "Last_Reading".localized() + " : "
                voluationcodetxt.text = "Reading".localized() + " : "
                newReadingTextField.delegate = self
                newReadingtxtButton.isUserInteractionEnabled = false
                lastReadingValueLbl.text = String(recordPointModelClass.MeasReadingChar ?? "")
            }
            else{
                let catlogValue = recordPointModelClass.CatalogType
                let codeGroupValue = recordPointModelClass.CodeGroup
                let measValuationCodeValue = recordPointModelClass.MeasValuationCode
                
                recordPointViewModel.getvaluationcode(Catalog: catlogValue, CodeGroup: codeGroupValue, sender: indexPath.row, MeasValuationCode: measValuationCodeValue, from: "")
                
                newReadingTextField.isUserInteractionEnabled = false
                newReadingtxtButton.isUserInteractionEnabled = true
                lastReadingTxt.text = "Last_Valuation".localized() + " : "
                voluationcodetxt.text = "Valuation".localized() + " : "
                newReadingtxtButton.tag = indexPath.row
                newReadingtxtButton.addTarget(self, action: #selector(volutionbuttonAction(sender:)), for: .touchUpInside)
            }
            
            if recordPointModelClass.RefCounter == false{
                counterLabel.isHidden = true
                counterValue.isHidden = true
                if DeviceType == iPhone{
                    CounterViewHeightConstant.constant = 0.0
                }
            }else{
                counterLabel.isHidden = false
                counterValue.isHidden = false
                if DeviceType == iPhone{
                    CounterViewHeightConstant.constant = 20.0
                }
            }
            saveButton.isHidden = false
            EditButton.isHidden = true
            EditButton.tag = indexPath.row
            EditButton.addTarget(self, action: #selector(EditbuttonAction(sender:)), for: .touchUpInside)

            if recordPointViewModel.curentReadingArray.count > 0 {
                mJCLogger.log("Response:\(recordPointViewModel.curentReadingArray.count)", Type: "Debug")
                var searchPredict = NSPredicate()
                
                var filterArray = Array<MeasurementPointModel>()
                if recordPointModelClass.Equipment != ""{
                
                    if recordPointModelClass.OperationNum != ""{
                        let oprArray = recordPointViewModel.operationArray.filter({$0.OperationNum == "\(recordPointModelClass.OperationNum)"})
                        if oprArray.count > 0{
                            let opr = oprArray[0]
                            
                            searchPredict = NSPredicate(format: "SELF.MeasuringPoint == '\(String(describing: recordPointModelClass.MeasuringPoint))' AND SELF.Equipment == '\(String(describing: recordPointModelClass.Equipment))' AND SELF.OperationNum == '\(opr.OperationNum)' AND SELF.OpObjectNumber == '\(opr.OpObjectNum)'")
                            filterArray = recordPointViewModel.curentReadingArray.filter{searchPredict.evaluate(with: $0)}
                            
                          //  filterArray = self.curentReadingArray.filter({$0.MeasuringPoint == "\(measurementPointSetClass.MeasuringPoint)" && $0.Equipment == "\(measurementPointSetClass.Equipment)" && $0.OperationNum == "\(opr.OperationNum)" && $0.OpObjectNumber == "\(opr.OpObjectNum)"})
                        }
                    }else{
                        searchPredict = NSPredicate(format: "SELF.MeasuringPoint == '\(String(describing: recordPointModelClass.MeasuringPoint))' AND SELF.Equipment == '\(String(describing: recordPointModelClass.Equipment))' AND SELF.WOObjectNum == '\(singleWorkOrder.ObjectNumber)' AND SELF.OperationNum == ''")
                        
                        filterArray = recordPointViewModel.curentReadingArray.filter{searchPredict.evaluate(with: $0)}
                        
                       //  filterArray = self.curentReadingArray.filter({$0.MeasuringPoint == "\(measurementPointSetClass.MeasuringPoint)" && $0.Equipment == "\(measurementPointSetClass.Equipment)" && $0.WOObjectNum == "\(singleWorkOrder.ObjectNumber)" && $0.OperationNum == ""})
                    }
                }
                else
                {
                   if recordPointModelClass.OperationNum != ""{
                    let oprArray = recordPointViewModel.operationArray.filter({$0.OperationNum == "\(recordPointModelClass.OperationNum)"})
                       if oprArray.count > 0{
                           let opr = oprArray[0]
                        
                        searchPredict = NSPredicate(format: "SELF.MeasuringPoint == '\(recordPointModelClass.MeasuringPoint)' AND SELF.FunctionalLocation == '\(recordPointModelClass.FunctionalLocation)' AND SELF.OperationNum == '\(opr.OperationNum)' AND SELF.OpObjectNumber == '\(opr.OpObjectNum)'")
                        
                        filterArray = recordPointViewModel.curentReadingArray.filter{searchPredict.evaluate(with: $0)}
                        
                       // filterArray = self.curentReadingArray.filter({$0.MeasuringPoint == "\(measurementPointSetClass.MeasuringPoint)" && $0.FunctionalLocation == "\(measurementPointSetClass.FunctionalLocation)" && $0.OperationNum == "\(opr.OperationNum)" && $0.OpObjectNumber == "\(opr.OpObjectNum)"})
                       }
                   }else{
                    
                    searchPredict = NSPredicate(format: "SELF.MeasuringPoint == '\(recordPointModelClass.MeasuringPoint)' AND SELF.FunctionalLocation == '\(recordPointModelClass.FunctionalLocation)' AND SELF.WOObjectNum == '\(singleWorkOrder.ObjectNumber)'")
                    
                    filterArray = recordPointViewModel.curentReadingArray.filter{searchPredict.evaluate(with: $0)}
                    
                    //filterArray = self.curentReadingArray.filter({$0.MeasuringPoint == "\(measurementPointSetClass.MeasuringPoint)" && $0.FunctionalLocation == "\(measurementPointSetClass.FunctionalLocation)" && $0.WOObjectNum == "\(singleWorkOrder.ObjectNumber)"})
                   }
                
                }
                if DeviceType == iPad{
                     bottomViewHeightConstraint.constant = 40
                }
               
                
                if let featureListArr =  orderTypeFeatureDict.value(forKey: singleWorkOrder.OrderType){
                    if let featureDict = (featureListArr as! NSArray)[0] as? NSMutableDictionary{
                        if let featurelist = featureDict.allKeys as? [String]{
                            if featurelist.contains("RECORD_POINT"){
                                let mandLevel = featureDict.value(forKey: "RECORD_POINT") as? String ?? ""
                                if mandLevel == "1"{
                                    Statusview.backgroundColor = filledCountColor
                                }else{
                                    Statusview.backgroundColor = UIColor.red
                                }
                            }
                        }
                    }
                }
                if filterArray.count > 0
                {
                    mJCLogger.log("Response:\(filterArray[0])", Type: "Debug")
                    let value = filterArray[0]
                     
                    if (value.MeasuringPoint == recordPointModelClass.MeasuringPoint) && (value.OperationNum == recordPointModelClass.OperationNum){

                        EditButton.isHidden = false
                        saveButton.isHidden = true
                        completedimgWidth.constant = 25.0
                        
                        if recordPointModelClass.ValCodeSuff == false{
                            
                            lastReadingTxt.text = "Last_Reading".localized() + " : "
                            voluationcodetxt.text = "Reading".localized() + " : "
                            newReadingTextField.delegate = self
                            newReadingtxtButton.isUserInteractionEnabled = false
                            newReadingTextField.text = String(value.MeasReading)
                            newReadingDesTextView.text = String(value.MeasText)
                            recordPointModelClass.oldReading = String(value.MeasReadingChar)
                            recordPointModelClass.oldReadingDesc = String(value.MeasText)
                            Statusview.backgroundColor = UIColor.white
                            let catLogValue = recordPointModelClass.CatalogType
                            let codeGroupValue = recordPointModelClass.CodeGroup
                            recordPointViewModel.getvaluationcode(Catalog: catLogValue, CodeGroup: codeGroupValue, sender: indexPath.row, MeasValuationCode: value.MeasValuationCode, from: "Edit")

                        }
                        else
                        {
                            let catLogValue = recordPointModelClass.CatalogType
                            let codeGroupValue = recordPointModelClass.CodeGroup
                            recordPointViewModel.getvaluationcode(Catalog: catLogValue, CodeGroup: codeGroupValue, sender: indexPath.row, MeasValuationCode: value.MeasValuationCode, from: "Edit")
                            lastReadingTxt.text = "Last_Valuation".localized() + " : "
                            voluationcodetxt.text = "Valuation".localized() + " : "
                            newReadingTextField.text = String(value.MeasValuationCode)
                            newReadingDesTextView.text = String(value.MeasText)
                            
                            recordPointModelClass.oldReading = String(value.ValuationCode)
                            recordPointModelClass.oldReadingDesc = String(value.MeasText)
                            
                            
                            if recordPointModelClass.ValCodeSuff == true {
                                                  
                                  newReadingtxtButton.isUserInteractionEnabled = false
                                  newReadingTextField.isUserInteractionEnabled = false
                                  saveButton.isUserInteractionEnabled = false
            
    //                              let key  = "\(indexPath.row)code"
    //                              if self.volutioncodeDict.count > 0{
    //                                      if self.volutioncodeDict.value(forKey: key) as?NSMutableDictionary != nil {
    //                                      let dict = self.volutioncodeDict.value(forKey: key) as!NSMutableDictionary
    //                                      let data = dict.value(forKey: "data") as! NSMutableArray
    //                                      var text = String()
    //                                      for i in 0..<data.count {
    //                                          let codegroup = data[i] as! CodeGroupModel
    //                                          if codegroup.Code == value.MeasValuationCode{
    //                                              text = "\(codegroup.Code) - \(codegroup.CodeText)"
    //                                              ReadingpointsTableViewCell.lastReadingValueLbl.text = text
    //                                          }
    //                                      }
    //                                  }
    //                              }
                              }
                        }
                        
                        
                    if value.editOption == true{
                        newReadingTextField.isUserInteractionEnabled = true
                        newReadingDesTextView.isUserInteractionEnabled = true
                        newReadingTextField.backgroundColor =  UIColor(named: "mjcViewBgColor")
                        newReadingDesTextView.backgroundColor = UIColor(named: "mjcViewBgColor")
                        saveButton.isUserInteractionEnabled = true
                        saveButton.isUserInteractionEnabled = true
                        saveButton.isHidden = true
                    }else{
                        newReadingTextField.isUserInteractionEnabled = false
                        newReadingDesTextView.isUserInteractionEnabled = false
                        newReadingTextField.backgroundColor =  UIColor.lightGray
                        newReadingDesTextView.backgroundColor = UIColor.lightGray
                        saveButton.isUserInteractionEnabled = false
                    }
                    }
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            if recordPointViewModel.vcRecordPoints?.isfrom == "supervisor"{
                if DeviceType == iPad{
                    newReadingTextField.isHidden = true
                    newReadingtxtButton.isHidden = true
                    newReadingDesTextView.isHidden = true
                    saveButton.isHidden = true
                    voluationcodetxt.isHidden = true
                    descriptionLabel.isHidden = true
                    bottomViewHeightConstraint.constant = 0

                }else{
                    newReadingTextField.isUserInteractionEnabled = false
                    newReadingtxtButton.isUserInteractionEnabled = false
                    newReadingDesTextView.isUserInteractionEnabled = false
                    saveButton.isUserInteractionEnabled = false
                    voluationcodetxt.isUserInteractionEnabled = false
                    descriptionLabel.isUserInteractionEnabled = false
                    currentReadingView.isHidden = true
                    currentDescriptionView.isHidden = true
                    saveButton.isHidden = true
                }
            }

        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func saveButtonAction(sender : UIButton){
        
        mJCLogger.log("Starting", Type: "info")
        recordPointViewModel.vcRecordPoints?.view.endEditing(true)
        var isfromUpdate = Bool()

        if isActiveWorkOrder == true{

            let tag = sender.tag
            mJCLogger.log("Create New Reading Start".localized(), Type: "Debug")
            
            let indexPath = IndexPath(row: tag, section: 0)
            
            let cell = recordPointViewModel.vcRecordPoints?.detailTableView.cellForRow(at: indexPath) as! ReadingpointsTableViewCell
            let measuringPointClass = recordPointViewModel.recordPointArray[tag] as! MeasurementPointModel
            
            let updatestr = sender.titleLabel?.text
            if updatestr == "Update".localized(){
               
                isfromUpdate = true
                if measuringPointClass.oldReading == cell.newReadingTextField.text && measuringPointClass.oldReadingDesc == cell.newReadingDesTextView.text {
                    mJCLogger.log("Update_not_needed".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "Update_not_needed".localized(), button: okay)
                   return
                }
            }
            if cell.newReadingTextField.text! == selectStr {
                mJCLogger.log("Please_choose_valuation".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "Please_choose_valuation".localized(), button: okay)
                return
                
            }
            let newreadingText = Double(cell.newReadingTextField.text!)
            let oldreading = Double(measuringPointClass.MeasReadingChar)
         //   cell.newReadingDesTextView.delegate = self
            let newdescText = cell.newReadingDesTextView.text
            let ValCodeSuff = measuringPointClass.ValCodeSuff
            var valcode = String()
            var maxlimit : Double?
            var minlimit : Double?
            
            let countertype = measuringPointClass.RefCounter
            
            if measuringPointClass.LimitMaxChar != "" {
                if measuringPointClass.LimitMaxChar.contains(find: ","){
                    let limit = measuringPointClass.LimitMaxChar.replacingOccurrences(of: ",", with: ".")
                    maxlimit = Double(limit) ?? 0.0
                }else{
                    maxlimit = Double(measuringPointClass.LimitMaxChar) ?? 0.0
                }
            }
            if measuringPointClass.LimitMinChar != "" {
                if measuringPointClass.LimitMinChar.contains(find: ","){
                    let limit = measuringPointClass.LimitMinChar.replacingOccurrences(of: ",", with: ".")
                    minlimit = Double(limit) ?? 0.0
                }else{
                    minlimit = Double(measuringPointClass.LimitMinChar) ?? 0.0
                }
            }
            if ValCodeSuff == true {
                if cell.newReadingTextField.text != "" || cell.newReadingTextField.text != nil {
                    let strarray = cell.newReadingTextField.text?.components(separatedBy: " - ")
                    valcode = strarray![0]
                    
                    if valcode == ""{
                        mJCLogger.log("Please_choose_valuation".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "Please_choose_valuation".localized(), button: okay)
                        return
                    }
                    if newdescText == "" {
                        mJCLogger.log("Please_enter_description".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "Please_enter_description".localized(), button: okay)
                        return
                    }
                    else if newdescText!.count > 40 {
                        mJCLogger.log("Description_length_should_not_be_more_than_40_characters".localized(), Type: "Debug")
                        mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "Description_length_should_not_be_more_than_40_characters".localized(), button: okay)
                        return
                        
                    }else{
                        recordPointViewModel.createNewReading(tag: tag, isfromUpdate: isfromUpdate)
                    }
                }
                
            }else{
                if newreadingText == nil{
                    mJCLogger.log("Please_enter_valid_reading".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "Please_enter_valid_reading".localized(), button: okay)

                    return
                }else if newdescText == "" {
                    mJCLogger.log("Please_enter_description".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "Please_enter_description".localized(), button: okay)

                    return
                }
                else if newdescText!.count > 40 {
                    mJCLogger.log("Description_length_should_not_be_more_than_40_characters".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "Description_length_should_not_be_more_than_40_characters".localized(), button: okay)
                    return
                    
                }else if oldreading != nil && countertype == true && (newreadingText! <= oldreading!){
                    mJCLogger.log("Please_enter_reading_greater_than_Last_reading".localized(), Type: "Debug")
                    mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "Please_enter_reading_greater_than_Last_reading".localized(), button: okay)
                    return
                    
                }else if minlimit != nil && maxlimit != nil{
                        
                    if newreadingText! < minlimit! ||  newreadingText! > maxlimit! {
                        mJCLogger.log("Value_should_be_in_range".localized() + " \(minlimit!)" + " to ".localized(), Type: "Warn")
                        let params = Parameters(
                            title: "Warning".localized(),
                            message: "Value_should_be_in_range".localized() + " \(minlimit!)" + " to ".localized() + "\(maxlimit!) ",
                            cancelButton: "Cancel".localized(),
                            otherButtons: ["Continue".localized()]
                        )
                        mJCAlertHelper.showAlertWithHandler(recordPointViewModel.vcRecordPoints!, parameters: params) { buttonIndex in
                            switch buttonIndex {
                            case 0: break
                            case 1:
                                self.recordPointViewModel.createNewReading(tag: tag, isfromUpdate: isfromUpdate)
                            default: break
                            }
                        }
                    }else{
                        recordPointViewModel.createNewReading(tag: tag, isfromUpdate: isfromUpdate)
                    }
                }else if minlimit != nil && newreadingText! < minlimit!{
                    mJCLogger.log("Required_minimum_value_is".localized() + " \(minlimit!)", Type: "Warn")
                    let params = Parameters(
                        title: "Warning".localized(),
                        message: "Required_minimum_value_is".localized() + " \(minlimit!)",
                        cancelButton: "Cancel".localized(),
                        otherButtons: ["Continue".localized()]
                    )
                    mJCAlertHelper.showAlertWithHandler(recordPointViewModel.vcRecordPoints!, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0: break
                        case 1:
                            self.recordPointViewModel.createNewReading(tag: tag, isfromUpdate: isfromUpdate)
                        default: break
                        }
                    }

                }else if maxlimit != nil && newreadingText! > maxlimit!{
                    mJCLogger.log("Required_maximum_value_is".localized() + " \(maxlimit!)", Type: "Warn")
                    let params = Parameters(
                        title: "Warning".localized(),
                        message: "Required_maximum_value_is".localized() + " \(maxlimit!) ",
                        cancelButton: "Cancel".localized(),
                        otherButtons: ["Continue".localized()]
                    )
                    mJCAlertHelper.showAlertWithHandler(recordPointViewModel.vcRecordPoints!, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0: break
                        case 1:
                            self.recordPointViewModel.createNewReading(tag: tag, isfromUpdate: isfromUpdate)
                        default: break
                        }
                    }
                }else{
                    recordPointViewModel.createNewReading(tag: tag, isfromUpdate: isfromUpdate)
                }
            }
  
        }
        else {
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
               mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)

            }else{
                mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)

            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func createNotificationButtonAction(sender : UIButton){
       
        mJCLogger.log("Starting", Type: "info")
        if isActiveWorkOrder == true || recordPointViewModel.vcRecordPoints?.isfrom == "supervisor"{
            let measuringPointClass = recordPointViewModel.recordPointArray[sender.tag] as! MeasurementPointModel
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
                    
                    if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                        if workFlowObj.ActionType == "Screen" {
                            recordPointViewModel.vcRecordPoints?.updateUIcreateNotificationButton(equipment: measuringPointClass.Equipment, funcLoc: measuringPointClass.FunctionalLocation)
                        }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                            myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: recordPointViewModel.vcRecordPoints!, statusCategoryCls: StatusCategoryModel(), formFrom: "")
                        }else{
                            myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
                            mJCLogger.log("WorkFlowError".localized(), Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
         }else{
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
            }else{
                mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func linchartButtonAction(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        recordPointViewModel.vcRecordPoints?.updateUILinchartButton(senderValue: sender.tag)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func volutionbuttonAction(sender : UIButton){
        
        mJCLogger.log("Starting", Type: "info")
        let tag = sender.tag
        UserDefaults.standard.setValue(sender.tag, forKey: "volutionsender")
         let key  = "\(tag)code"
        let finalarray = NSMutableArray()
        if recordPointViewModel.volutioncodeDict.allKeys.count != 0 {
            mJCLogger.log("Response:\(recordPointViewModel.volutioncodeDict.allKeys.count)", Type: "Debug")
            if let dict = recordPointViewModel.volutioncodeDict.value(forKey: key) as? Array<CodeGroupModel>{
                 for item in dict {
                    let text = "\(item.Code) - \(item.CodeText)"
                        finalarray.add(text)
                }
            }
        }
        else {
            mJCLogger.log("Data not found", Type: "Debug")
            finalarray.add(selectStr)
        }
        
        recordPointViewModel.vcRecordPoints?.dropDown.anchorView = sender
        let arr : [String] = finalarray as NSArray as! [String]
        recordPointViewModel.vcRecordPoints?.dropDown.dataSource = arr
        recordPointViewModel.vcRecordPoints?.dropDown.show()
        
        if arr.count > 0 {
            mJCLogger.log("Response:\(arr.count)", Type: "Debug")
            recordPointViewModel.vcRecordPoints?.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                let tag = UserDefaults.standard.value(forKey: "volutionsender") as! Int
                let indexPath = IndexPath(row: tag, section: 0)
                let cell = recordPointViewModel.vcRecordPoints?.detailTableView.cellForRow(at: indexPath) as! ReadingpointsTableViewCell
                cell.newReadingTextField.text = item
                recordPointViewModel.vcRecordPoints?.dropDown.hide()
            }
        }else{
            mJCLogger.log("No_data_available_show", Type: "Debug")
            mJCAlertHelper.showAlert(recordPointViewModel.vcRecordPoints!, title: alerttitle, message: "No_data_available_show".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func EditbuttonAction(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        print(sender.tag)
        let tag = sender.tag
        mJCLogger.log("Edit Button Action".localized(), Type: "")
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = recordPointViewModel.vcRecordPoints?.detailTableView.cellForRow(at: indexPath) as! ReadingpointsTableViewCell
        cell.saveButton.setTitle("Update".localized(), for: .normal)
        cell.newReadingTextField.isUserInteractionEnabled = true
        cell.newReadingDesTextView.isUserInteractionEnabled = true
        cell.newReadingTextField.backgroundColor =  UIColor(named: "mjcViewBgColor")
        cell.newReadingDesTextView.backgroundColor = UIColor(named: "mjcViewBgColor")
        cell.EditButton.isHidden = true
        cell.saveButton.isUserInteractionEnabled = true
        let measuringPointClass = recordPointViewModel.recordPointArray[tag] as! MeasurementPointModel
        measuringPointClass.editOption = true
        if measuringPointClass.ValCodeSuff == false{
           cell.newReadingTextField.isUserInteractionEnabled = true
           cell.newReadingtxtButton.isUserInteractionEnabled = false
       }
       else{
            cell.newReadingTextField.isUserInteractionEnabled = false
            cell.newReadingtxtButton.isUserInteractionEnabled = true
       }
        cell.saveButton.isHidden = false
        cell.saveButton.isUserInteractionEnabled = true
        mJCLogger.log("Ended", Type: "info")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        mJCLogger.log("Starting", Type: "info")
        if textView == newReadingDesTextView {
                   
                   let maxLength = 40
                   let currentString: NSString = textView.text! as NSString
                   let newString: NSString =
                       currentString.replacingCharacters(in: range, with: text) as NSString
                   
                   if newString.length > maxLength {
                       
                    let alert = UIAlertView(title: MessageTitle, message: "Description_length_should_not_be_more_than_40_characters".localized, delegate: self, cancelButtonTitle: "OK")
                       alert.delegate = self
                       alert.show()
                       
                       return newString.length <= maxLength
                       
                   }
                   
               }
               mJCLogger.log("Ended", Type: "info")
               return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        mJCLogger.log("Starting", Type: "info")
        if textField == newReadingDesTxtField {
            
            let maxLength = 40
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if newString.length > maxLength {
                
                let alert = UIAlertView(title: MessageTitle, message: "Description_length_should_not_be_more_than_40_characters".localized, delegate: self, cancelButtonTitle: "OK")
                alert.delegate = self
                alert.show()
                
                return newString.length <= maxLength
                
            }
            
        }
        mJCLogger.log("Ended", Type: "info")
        return true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
