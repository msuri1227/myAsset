//
//   swift
//  myJobCard
//
//  Created by Ondevice Solutions on 20/04/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class InspectionCell: UITableViewCell {
    
    @IBOutlet weak var sideIndicatorCharacteristicView: UIView!
    @IBOutlet weak var charateisticNumberLabel: UILabel!
    @IBOutlet weak var targetlabel: UILabel!
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultSaveButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var remarkTextView: UITextView!
    @IBOutlet weak var resultTitle: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var resultTextView: UIView!
    var indexPath = IndexPath()
    var section = Int()
    
    var inspViewModel = InspectionViewModel()
    var inspectionModel:InspectionCharModel?{
        didSet{
            configureInspectionCell()
        }
    }
    var inspectionResultModel:InspectionResultModel?{
        didSet{
            configureResultInspectionCell()
        }
    }
    var inspectionAddModel:InspectionCharModel?{
        didSet{
            configureResultAddInspectionCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        ODSUIHelper.setBorderToView(view: resultTextView, borderColor: appColor)
        ODSUIHelper.setBorderToView(view: remarkTextView, borderColor: appColor)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func configureInspectionCell(){
        
        mJCLogger.log("Starting", Type: "info")
        resultButton.isHidden = true
        AddButton.isHidden = false
        resultSaveButton.isHidden = true
        
        if let inspectCharcls = inspectionModel{
            resultSaveButton.isHidden = true
            editButton.isHidden = true
            resultTextField.isUserInteractionEnabled = false
            remarkTextView.isUserInteractionEnabled = false
            resultTextField.text = ""
            remarkTextView.text = ""
            mJCLogger.log("Response:\(inspViewModel.inspPointCharArray.count)", Type: "Debug")
            charateisticNumberLabel.text = inspectCharcls.InspChar + " - " + inspectCharcls.CharDescr
            targetlabel.text = inspectCharcls.TargetVal + " / " + inspectCharcls.LwTolLmt + " - " + inspectCharcls.UpTolLmt
            statusLabel.text = inspectCharcls.Status + " - " + inspectCharcls.StatusDesc
            AddButton.tag = indexPath.row
            editButton.tag = indexPath.row
            resultButton.tag = indexPath.row
            resultSaveButton.tag = indexPath.row
            AddButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
            editButton.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
            resultButton.addTarget(self, action: #selector(resultAction(sender:)), for: .touchUpInside)
            resultSaveButton.addTarget(self, action: #selector(resultSaveAction(sender:)), for: .touchUpInside)
            if inspViewModel.inspResultArray.count > 0{
                var filterArr = Array<InspectionResultModel>()
                if inspectCharcls.Scope == "1"{
                    filterArr = inspViewModel.inspResultArray.filter{$0.InspLot == "\(inspectCharcls.InspLot)" && $0.InspSample == "\(inspectCharcls.InspPoint)" && $0.InspOper == "\(inspectCharcls.InspOper)" && $0.InspChar == "\(inspectCharcls.InspChar)"}
                }else{
                    filterArr = inspViewModel.inspResultArray.filter{$0.InspLot == "\(inspectCharcls.InspLot)" && $0.InspSample == "\(inspectCharcls.InspPoint)" && $0.InspOper == "\(inspectCharcls.InspOper)" && $0.InspChar == "\(inspectCharcls.InspChar)"}
                }
                let inspectionResultArray = inspViewModel.inspResultArray.unique{$0.ResValue}.sorted{$0.ResValue.compare($1.ResValue) == .orderedAscending }
                if filterArr.count > 0{
                    mJCLogger.log("Response:\(filterArr[0])", Type: "Debug")
                    var inspectResultcls = InspectionResultModel()
                    editButton.isHidden = false
                    resultSaveButton.isHidden = true
                    if  inspViewModel.fromResultsScreen == true{
                        AddButton.isHidden = true
                        inspectResultcls = inspViewModel.inspResultArray[indexPath.row]
                    }else{
                        AddButton.isHidden = false
                        let array = inspectionResultArray.filter({$0.InspChar == inspectCharcls.InspChar })
                        if array.last?.InspChar == inspectCharcls.InspChar{
                            inspectResultcls = array.last!
                        }
                    }
                    let lowerlimt = Double(inspectCharcls.LwTolLmt) ?? 0.0
                    let upperlimt = Double(inspectCharcls.UpTolLmt) ?? 0.0
                    let result = Double(inspectResultcls.ResValue) ?? 0.0
                    var date = String()
                    if inspectResultcls.InspDate != nil{
                        date = (inspectResultcls.InspDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current))!
                    }
                    let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: inspectResultcls.InspTime)
                    dateLabel.text  = "\(date) \(time)"
                    remarkTextView.text = inspectResultcls.Remark
                    if lowerlimt < result && upperlimt > result{
                        sideIndicatorCharacteristicView.backgroundColor =  UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }else{
                        sideIndicatorCharacteristicView.backgroundColor =  UIColor(red: 220.0/255.0, green: 34.0/255.0, blue: 80.0/255.0, alpha: 1)
                    }
                    if inspectCharcls.CharType == "02" {
                        if inspectResultcls.Code1 != ""{
                            let arr = inspViewModel.qmValutionListArray.filter{$0.Charnum == "\(inspectCharcls.InspChar)" && $0.SelectedSet == "\(inspectCharcls.SelectedSet)" && $0.Code == "\(inspectResultcls.Code1)"}
                            if arr.count > 0{
                                let cls = arr[0]
                                resultTextField.text = cls.Code + " - " + cls.Description
                            }
                        }
                        sideIndicatorCharacteristicView.backgroundColor =  UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }else{
                        resultTextField.text = inspectResultcls.ResValue
                    }
                }else{
                    if inspectCharcls.CharType == "02"{
                        resultSaveButton.isHidden = false
                        editButton.isHidden = true
                        resultTextField.isUserInteractionEnabled = false
                        remarkTextView.isUserInteractionEnabled = true
                        resultTextField.text = ""
                        remarkTextView.text = ""
                        resultButton.isHidden = false
                    }else{
                        resultSaveButton.isHidden = false
                        editButton.isHidden = true
                        resultButton.isHidden = true
                        resultTextField.isUserInteractionEnabled = true
                        remarkTextView.isUserInteractionEnabled = true
                        resultTextField.text = ""
                        remarkTextView.text = ""
                    }
                }
            }else{
                if inspectCharcls.CharType == "02"{
                    resultTitle.text = "Valuation".localized()
                    resultSaveButton.isHidden = false
                    editButton.isHidden = true
                    resultTextField.isUserInteractionEnabled = false
                    remarkTextView.isUserInteractionEnabled = true
                    resultButton.isHidden = false
                }else{
                    resultSaveButton.isHidden = false
                    resultButton.isHidden = true
                    editButton.isHidden = true
                    resultTextField.isUserInteractionEnabled = true
                    remarkTextView.isUserInteractionEnabled = true
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func addAction(sender : UIButton) {
        let inspectionResultVc = ScreenManager.getMultipleInspectionResultCaptureScreen()
        inspectionResultVc.modalPresentationStyle = .overFullScreen
        inspectionResultVc.inspPointCharCls = inspViewModel.inspPointCharArray[sender.tag]
        inspectionResultVc.inspViewModel = self.inspViewModel
        inspViewModel.inspVc?.present(inspectionResultVc, animated: false) {}
    }
    
    @objc func editAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let tag = sender.tag
        if let charclas =  inspectionModel{
            if charclas.CharType == "02"{
                resultTextField.isUserInteractionEnabled = false
                resultButton.isHidden = false
            }else{
                resultTextField.isUserInteractionEnabled = true
                resultButton.isHidden = true
            }
        }
        remarkTextView.isUserInteractionEnabled = true
        editButton.isHidden = true
        resultSaveButton.isHidden = false
        resultSaveButton.setTitle("Update".localized(), for: .normal)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func resultAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            let arr = self.inspViewModel.qmValutionListArray.filter{$0.Charnum == "\(self.inspViewModel.charclas.InspChar)" && $0.SelectedSet == "\(self.inspViewModel.charclas.SelectedSet)"}
            if arr.count > 0{
                self.showDropDownDetails(sender: sender, qmResultArray: arr)
            }else{
                mJCLogger.log("No_data_available_show".localized(), Type: "Debug")
                mJCAlertHelper.showAlert(UIViewController(), title: alerttitle, message: "No_data_available_show".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func resultSaveAction(sender : UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        if inspectionModel != nil{
            inspViewModel.charclas = self.inspectionModel!
        }else{
            inspViewModel.charclas = self.inspectionAddModel!
        }
        let title = sender.titleLabel?.text
        if title == "Update".localized(){
            inspViewModel.UpdateInspectionResult(index: sender.tag, section: section)
        }else{
            inspViewModel.saveInspectionResult(index: sender.tag, section: section)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func showDropDownDetails(sender:UIButton,qmResultArray:[QmResultModel]){
        mJCLogger.log("Starting", Type: "info")
        
        let menudropDown = DropDown()
        var menuarr = [String]()
        for resultObj in qmResultArray {
            menuarr.append(resultObj.Code + " - " + resultObj.Description)
        }
        menudropDown.dataSource = menuarr
        menudropDown.anchorView = sender
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            resultTextField.text = item
            menudropDown.hide()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func configureResultInspectionCell() {
        mJCLogger.log("Starting", Type: "info")
        self.resultButton.isHidden = true
        self.AddButton.isHidden = true
        self.editButton.isHidden = false
        if let inspectCharcls = inspectionModel{
            resultTextField.isUserInteractionEnabled = false
            remarkTextView.isUserInteractionEnabled = false
            resultTextField.text = ""
            remarkTextView.text = ""
            mJCLogger.log("Response:\(inspViewModel.inspPointCharArray.count)", Type: "Debug")
            charateisticNumberLabel.text = inspectCharcls.InspChar + " - " + inspectCharcls.CharDescr
            targetlabel.text = inspectCharcls.TargetVal + " / " + inspectCharcls.LwTolLmt + " - " + inspectCharcls.UpTolLmt
            statusLabel.text = inspectCharcls.Status + " - " + inspectCharcls.StatusDesc
            editButton.tag = indexPath.row
            resultButton.tag = indexPath.row
            resultSaveButton.tag = indexPath.row
            editButton.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
            resultButton.addTarget(self, action: #selector(resultAction(sender:)), for: .touchUpInside)
            resultSaveButton.addTarget(self, action: #selector(resultSaveAction(sender:)), for: .touchUpInside)
            if inspViewModel.inspResultArray.count > 0{
                mJCLogger.log("Response:\(inspViewModel.inspResultArray.count)", Type: "Debug")
                var filterArr = Array<InspectionResultModel>()
                if inspectCharcls.Scope == "1"{
                    filterArr = inspViewModel.inspResultArray.filter{$0.InspLot == "\(inspectCharcls.InspLot)" && $0.InspSample == "\(inspectCharcls.InspPoint)" && $0.InspOper == "\(inspectCharcls.InspOper)" && $0.InspChar == "\(inspectCharcls.InspChar)"}
                }else{
                    filterArr = inspViewModel.inspResultArray.filter{$0.InspLot == "\(inspectCharcls.InspLot)" && $0.InspSample == "\(inspectCharcls.InspPoint)" && $0.InspOper == "\(inspectCharcls.InspOper)" && $0.InspChar == "\(inspectCharcls.InspChar)"}
                }
                if filterArr.count > indexPath.row {
                    mJCLogger.log("Response:\(filterArr[0])", Type: "Debug")
                    let inspectResultcls = filterArr[indexPath.row]
                    remarkTextView.text = inspectResultcls.Remark
                    var date = String()
                    var time = String()
                    if inspectResultcls.InspDate != nil{
                        date = (inspectResultcls.InspDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current))!
                    }
                    time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: inspectResultcls.InspTime)
                    dateLabel.text  = "\(date) \(time)"
                    let lowerlimt = Double(inspectCharcls.LwTolLmt) ?? 0.0
                    let upperlimt = Double(inspectCharcls.UpTolLmt) ?? 0.0
                    let result = Double(inspectResultcls.ResValue) ?? 0.0
                    if lowerlimt < result && upperlimt > result{
                        sideIndicatorCharacteristicView.backgroundColor =  UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }else{
                        sideIndicatorCharacteristicView.backgroundColor =  UIColor(red: 220.0/255.0, green: 34.0/255.0, blue: 80.0/255.0, alpha: 1)
                    }
                    if inspectCharcls.CharType == "02" {
                        if inspectResultcls.Code1 != ""{
                            let arr = inspViewModel.qmValutionListArray.filter{$0.Charnum == "\(inspectCharcls.InspChar)" && $0.SelectedSet == "\(inspectCharcls.SelectedSet)" && $0.Code == "\(inspectResultcls.Code1)"}
                            if arr.count > 0{
                                let cls = arr[0]
                                resultTextField.text = cls.Code + " - " + cls.Description
                            }
                        }
                        sideIndicatorCharacteristicView.backgroundColor =  UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }else{
                        resultTextField.text = inspectResultcls.ResValue
                    }
                }else{
                    if inspectCharcls.CharType == "02"{
                        resultTextField.isUserInteractionEnabled = false
                        remarkTextView.isUserInteractionEnabled = true
                        resultTextField.text = ""
                        remarkTextView.text = ""
                        resultButton.isHidden = false
                    }else{
                        resultButton.isHidden = true
                        resultTextField.isUserInteractionEnabled = true
                        remarkTextView.isUserInteractionEnabled = true
                        resultTextField.text = ""
                        remarkTextView.text = ""
                    }
                }
            }else{
                if inspectCharcls.CharType == "02"{
                    resultTitle.text = "Valuation".localized()
                    resultTextField.isUserInteractionEnabled = false
                    remarkTextView.isUserInteractionEnabled = true
                    resultButton.isHidden = false
                }else{
                    resultButton.isHidden = true
                    resultTextField.isUserInteractionEnabled = true
                    remarkTextView.isUserInteractionEnabled = true
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func configureResultAddInspectionCell() {
        mJCLogger.log("Starting", Type: "info")
        resultButton.isHidden = true
        AddButton.isHidden = true
        resultSaveButton.isHidden = true
        if let inspectCharcls = inspectionAddModel{
            resultSaveButton.isHidden = true
            editButton.isHidden = true
            resultTextField.isUserInteractionEnabled = false
            remarkTextView.isUserInteractionEnabled = false
            resultTextField.text = ""
            remarkTextView.text = ""
            charateisticNumberLabel.text = inspectCharcls.InspChar + " - " + inspectCharcls.CharDescr
            targetlabel.text = inspectCharcls.TargetVal + " / " + inspectCharcls.LwTolLmt + " - " + inspectCharcls.UpTolLmt
            statusLabel.text = inspectCharcls.Status + " - " + inspectCharcls.StatusDesc
            AddButton.tag = indexPath.row
            editButton.tag = indexPath.row
            resultButton.tag = indexPath.row
            resultSaveButton.tag = indexPath.row
            AddButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
            editButton.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
            resultButton.addTarget(self, action: #selector(resultAction(sender:)), for: .touchUpInside)
            resultSaveButton.addTarget(self, action: #selector(resultSaveAction(sender:)), for: .touchUpInside)
            resultSaveButton.isHidden = false
            editButton.isHidden = true
            resultButton.isHidden = true
            resultTextField.isUserInteractionEnabled = true
            remarkTextView.isUserInteractionEnabled = true
            resultTextField.text = ""
            remarkTextView.text = ""
            if inspectCharcls.CharType == "02"{
                resultTitle.text = "Valuation".localized()
                resultSaveButton.isHidden = false
                editButton.isHidden = true
                resultTextField.isUserInteractionEnabled = false
                remarkTextView.isUserInteractionEnabled = true
                resultButton.isHidden = false
            }else{
                resultSaveButton.isHidden = false
                resultButton.isHidden = true
                editButton.isHidden = true
                resultTextField.isUserInteractionEnabled = true
                remarkTextView.isUserInteractionEnabled = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
