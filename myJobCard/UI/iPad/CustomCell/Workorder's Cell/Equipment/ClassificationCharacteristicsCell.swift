//
//  ClassificationCharacteristicsCell.swift
//  myJobCard
//
//  Created by Gowri on 12/02/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class ClassificationCharacteristicsCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var CharacteristicTitleLbl: UILabel!
    @IBOutlet weak var CharacteristicdescriptionLbl: UILabel!
    @IBOutlet weak var CharacteristicValueTxtField: UITextField!
    @IBOutlet weak var CharacteristicValueBtn: UIButton!
    @IBOutlet weak var CharacteristicDataTypeLbl: UILabel!
    @IBOutlet weak var CharacteristicRequiredLbl: UILabel!
    @IBOutlet weak var CharacteristicDecimalLbl: UILabel!
    @IBOutlet weak var CharacteristicUnOMeasureLbl: UILabel!
    @IBOutlet weak var CharacteristicCharactersLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    var indexpath = IndexPath()
    var equipCharacteristicsModelClass: CharateristicsModel? {
        didSet{
            equipCharacteristicsConfiguration()
        }
    }
    var funclocCharacteristicsModelClass: CharateristicsModel? {
        didSet{
            FunctionLocationCharacteristicsConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CharacteristicValueTxtField.delegate = self
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func equipCharacteristicsConfiguration() {
        
//        CharacteristicTitleLbl.text = equipCharacteristicsModelClass?.CharacteristicName
//        CharacteristicdescriptionLbl.text = equipCharacteristicsModelClass?.Description
//        if equipCharacteristicsModelClass?.DataType == "CHAR" && equipCharacteristicsModelClass?.Value1 == "" && equipCharacteristicsModelClass?.SingleValue == true {
//            CharacteristicValueTxtField.text = equipCharacteristicsModelClass?.CharValue
//        }else if equipCharacteristicsModelClass?.DataType == "CHAR" && equipCharacteristicsModelClass?.Value1 == "" && equipCharacteristicsModelClass?.SingleValue == false{
//            
//            let arr = equipCharacteristicsViewModel.ClassCharateristicsValueArr.filter{ $0.CharName == "\(equipCharacteristicsModelClass?.CharacteristicName ?? "")" && $0.CharValue == "\(equipCharacteristicsModelClass?.CharValue ?? "")"}
//            if arr.count > 0{
//                CharacteristicValueTxtField.text = arr[0].CharValue + " - " + arr[0].CharValueDescr
//            }else{
//                CharacteristicValueTxtField.text = ""
//            }
//            
//        }else  if equipCharacteristicsModelClass?.DataType == "CHAR" && equipCharacteristicsModelClass?.Value1 != "" && equipCharacteristicsModelClass?.SingleValue == false{
//            
//            let arr = equipCharacteristicsViewModel.ClassCharateristicsValueArr.filter{ $0.CharName == "\(equipCharacteristicsModelClass?.CharacteristicName ?? "")" && $0.CharValue == "\(equipCharacteristicsModelClass?.Value1 ?? "")"}
//            if arr.count > 0 {
//                CharacteristicValueTxtField.text = arr[0].CharValue + " - " + arr[0].CharValueDescr
//            }else{
//                CharacteristicValueTxtField.text = ""
//            }
//            
//        }else if equipCharacteristicsModelClass?.SingleValue == false{
//            let arr = equipCharacteristicsViewModel.ClassCharateristicsValueArr.filter{ $0.CharName == "\(equipCharacteristicsModelClass?.CharacteristicName ?? "")" && $0.CharValue == "\(equipCharacteristicsModelClass?.Value1 ?? "")"}
//            if arr.count > 0 {
//                CharacteristicValueTxtField.text = arr[0].CharValue + " - " + arr[0].CharValueDescr
//            }else{
//                CharacteristicValueTxtField.text = ""
//            }
//        }else{
//            CharacteristicValueTxtField.text = equipCharacteristicsModelClass?.Value1
//        }
//        
//        CharacteristicDataTypeLbl.text = equipCharacteristicsModelClass?.DataType
//        CharacteristicDecimalLbl.text = "\(equipCharacteristicsModelClass?.Decimals ?? 0)"
//        CharacteristicUnOMeasureLbl.text = equipCharacteristicsModelClass?.UnitofMeasure
//        CharacteristicCharactersLbl.text = "\(equipCharacteristicsModelClass?.Characters ?? 0)"
//        CharacteristicValueTxtField.isUserInteractionEnabled = false
//        CharacteristicValueTxtField.backgroundColor = UIColor.lightGray
//        
//        CharacteristicValueTxtField.tag = indexpath.row
//        editBtn.tag = indexpath.row
//        CharacteristicValueBtn.tag = indexpath.row
//        if !applicationFeatureArrayKeys.contains("EQUIP_CHARACTERISTICS_EDIT_OPTION"){
//            editBtn.isHidden = true
//        }else{
//            editBtn.isHidden = false
//        }
//        editBtn.addTarget(self, action: #selector(characteristicsEditAction(sender:)), for: .touchUpInside)
//        CharacteristicValueBtn.addTarget(self, action: #selector(dateAndTimeEquipmentSelectAction(sender:)), for: .touchUpInside)
//        CharacteristicValueBtn.isUserInteractionEnabled = false
//        
//        if equipCharacteristicsModelClass?.DataType == "NUM" || equipCharacteristicsModelClass?.DataType == "CURR"{
//            CharacteristicValueTxtField.keyboardType = .numberPad
//        }
    }
    
    @objc func characteristicsEditAction(sender : UIButton) {
//        if isActiveWorkOrder == true {
//            let cell = equipCharacteristicsViewModel.equipmentVc?.CharacteristicsListTableView.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! ClassificationCharacteristicsCell
//            let saveimg = UIImage(named: "save")
//            let editImage = UIImage(named: "ic_EditPencil")
//            let cellImg = cell.editBtn.imageView?.image
//            let tag = sender.tag
//            let cls = equipCharacteristicsViewModel.EquipmentCharateristicsArr[tag]
//            if cellImg == saveimg{
//                let length = cell.CharacteristicValueTxtField.text?.count
//                if cls.DataType == "CHAR" {
//                    let leg = Int(cls.Characters)
//                    if length! > leg && cls.SingleValue == true{
//                        mJCAlertHelper.showAlert(equipCharacteristicsViewModel.equipmentVc!, title: alerttitle, message: "Value_length_should_not_be_more_than_Character_count".localized(), button: okay)
//                    }else{
//                        equipCharacteristicsViewModel.UpdateCharateristicEquipment(Index: sender.tag)
//                        cell.CharacteristicValueTxtField.isUserInteractionEnabled = false
//                        cell.CharacteristicValueTxtField.backgroundColor = UIColor.lightGray
//                        cell.editBtn.setImage(editImage, for: .normal)
//                    }
//                }else if cls.DataType == "NUM" || cls.DataType == "CURR" {
//                    let leg = Int(cls.Characters)
//                    if length! > leg {
//                        mJCAlertHelper.showAlert(equipCharacteristicsViewModel.equipmentVc!, title: alerttitle, message: "Value_length_should_not_be_more_than_decimal_count".localized(), button: okay)
//                    }else{
//                        equipCharacteristicsViewModel.UpdateCharateristicEquipment(Index: sender.tag)
//                        cell.CharacteristicValueTxtField.isUserInteractionEnabled = false
//                        cell.CharacteristicValueTxtField.backgroundColor = UIColor.lightGray
//                        cell.editBtn.setImage(editImage, for: .normal)
//                    }
//                }else{
//                    cell.CharacteristicValueTxtField.isUserInteractionEnabled = false
//                    cell.CharacteristicValueBtn.isUserInteractionEnabled = false
//                    cell.CharacteristicValueTxtField.backgroundColor = UIColor.lightGray
//                    cell.editBtn.setImage(editImage, for: .normal)
//                    equipCharacteristicsViewModel.UpdateCharateristicEquipment(Index: sender.tag)
//                }
//            }else{
//                if cls.DataType == "DATE" || cls.DataType == "TIME" || cls.SingleValue == false {
//                    cell.CharacteristicValueBtn.isUserInteractionEnabled = true
//                    cell.CharacteristicValueTxtField.isUserInteractionEnabled = false
//                }
//                else{
//                    cell.CharacteristicValueTxtField.becomeFirstResponder()
//                    cell.CharacteristicValueBtn.isUserInteractionEnabled = false
//                    cell.CharacteristicValueTxtField.isUserInteractionEnabled = true
//                }
//
//                cell.CharacteristicValueTxtField.backgroundColor = UIColor.white
//                cell.editBtn.setImage(saveimg, for: .normal)
//            }
//        }else{
//            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
//                mJCAlertHelper.showAlert(equipCharacteristicsViewModel.equipmentVc!, title: inactiveOperationAlertTitle, message: inactiveOperationAlertMessage, button: okay)
//            }else{
//                mJCAlertHelper.showAlert(equipCharacteristicsViewModel.equipmentVc!, title: inactiveWorkorderAlertTitle, message: inactiveWorkorderAlertMessage, button: okay)
//            }
//        }
    }
    @objc func dateAndTimeEquipmentSelectAction(sender: UIButton) {
        
//        let CharateristCls = equipCharacteristicsViewModel.EquipmentCharateristicsArr[sender.tag]
//        let cell = equipCharacteristicsViewModel.equipmentVc?.CharacteristicsListTableView.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! ClassificationCharacteristicsCell
//
//        if CharateristCls.SingleValue == false{
//
//            let classCharArr = equipCharacteristicsViewModel.ClassCharateristicsValueArr.filter{ $0.CharName == "\(CharateristCls.CharacteristicName)"}
//            equipCharacteristicsViewModel.clsCharactristicListArray.removeAllObjects()
//            for item in classCharArr{
//                equipCharacteristicsViewModel.clsCharactristicListArray.add(item.CharValue + " - " + item.CharValueDescr)
//            }
//            UserDefaults.standard.setValue(sender.tag, forKey: "DropDownsender")
//
//            if equipCharacteristicsViewModel.clsCharactristicListArray.count > 0 {
//
//                equipCharacteristicsViewModel.equipmentVc?.dropDown.anchorView = cell.CharacteristicValueTxtField
//                let arr : [String] = equipCharacteristicsViewModel.clsCharactristicListArray as NSArray as! [String]
//                equipCharacteristicsViewModel.equipmentVc?.dropDown.dataSource = arr
//                equipCharacteristicsViewModel.equipmentVc?.dropDown.show()
//
//                equipCharacteristicsViewModel.equipmentVc?.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//
//                    let tag = UserDefaults.standard.value(forKey: "DropDownsender") as! Int
//                    let indexPath = IndexPath(row: tag, section: 0)
//                    let cell = equipCharacteristicsViewModel.equipmentVc?.CharacteristicsListTableView.cellForRow(at: indexPath) as! ClassificationCharacteristicsCell
//                    cell.CharacteristicValueTxtField.text = item
//                    equipCharacteristicsViewModel.equipmentVc?.dropDown.hide()
//                    UserDefaults.standard.removeSuite(named: "DropDownsender")
//                }
//            }
//
//        }else{
//            equipCharacteristicsViewModel.equipmentVc?.dateAndTimeTag = cell.CharacteristicValueBtn.tag
//            equipCharacteristicsViewModel.equipmentVc?.updateUIDateAndTimeEquipmentSelectAction(tagValue: sender.tag)
//        }
        
    }
    
    func FunctionLocationCharacteristicsConfiguration() {
        
//        CharacteristicTitleLbl.text = funclocCharacteristicsModelClass?.CharacteristicName
//        CharacteristicdescriptionLbl.text = funclocCharacteristicsModelClass?.Description
//
//        if funclocCharacteristicsModelClass?.DataType == "CHAR" && funclocCharacteristicsModelClass?.Value1 == "" && funclocCharacteristicsModelClass?.SingleValue == true {
//            CharacteristicValueTxtField.text = funclocCharacteristicsModelClass?.CharValue
//        }else if funclocCharacteristicsModelClass?.DataType == "CHAR" && funclocCharacteristicsModelClass?.Value1 == "" && funclocCharacteristicsModelClass?.SingleValue == false{
//
//            let arr = funclocCharacteristicsViewModel.FLClassCharateristicsValueArr.filter{ $0.CharName == "\(funclocCharacteristicsModelClass?.CharacteristicName ?? "")" && $0.CharValue == "\(funclocCharacteristicsModelClass?.CharValue ?? "")"}
//            if arr.count > 0
//            {
//                CharacteristicValueTxtField.text = arr[0].CharValue + " - " + arr[0].CharValueDescr
//            }else{
//                CharacteristicValueTxtField.text = ""
//            }
//
//        }else  if funclocCharacteristicsModelClass?.DataType == "CHAR" && funclocCharacteristicsModelClass?.Value1 != "" && funclocCharacteristicsModelClass?.SingleValue == false{
//
//            let arr = funclocCharacteristicsViewModel.FLClassCharateristicsValueArr.filter{ $0.CharName == "\(funclocCharacteristicsModelClass?.CharacteristicName ?? "")" && $0.CharValue == "\(funclocCharacteristicsModelClass?.Value1 ?? "")"}
//            if arr.count > 0 {
//                CharacteristicValueTxtField.text = arr[0].CharValue + " - " + arr[0].CharValueDescr
//            }else{
//                CharacteristicValueTxtField.text = ""
//            }
//
//        }else if funclocCharacteristicsModelClass?.SingleValue == false{
//            let arr = funclocCharacteristicsViewModel.FLClassCharateristicsValueArr.filter{ $0.CharName == "\(funclocCharacteristicsModelClass?.CharacteristicName ?? "")" && $0.CharValue == "\(funclocCharacteristicsModelClass?.Value1 ?? "")"}
//            if arr.count > 0 {
//                CharacteristicValueTxtField.text = arr[0].CharValue + " - " + arr[0].CharValueDescr
//            }else{
//                CharacteristicValueTxtField.text = ""
//            }
//        }else{
//            CharacteristicValueTxtField.text = funclocCharacteristicsModelClass?.Value1
//        }
//
//        CharacteristicDataTypeLbl.text = funclocCharacteristicsModelClass?.DataType
//        CharacteristicDecimalLbl.text = "\(funclocCharacteristicsModelClass?.Decimals ?? 0)"
//        CharacteristicUnOMeasureLbl.text = funclocCharacteristicsModelClass?.UnitofMeasure
//        CharacteristicCharactersLbl.text = "\(funclocCharacteristicsModelClass?.Characters ?? 0)"
//        CharacteristicValueTxtField.backgroundColor = UIColor.lightGray
//        CharacteristicValueTxtField.isUserInteractionEnabled = false
//        CharacteristicValueBtn.isUserInteractionEnabled = false
//
//        CharacteristicValueTxtField.tag = indexpath.row
//        editBtn.tag = indexpath.row
//        CharacteristicValueBtn.tag = indexpath.row
//        if !applicationFeatureArrayKeys.contains("FLOC_CHARACTERISTICS_EDIT_OPTION"){
//            editBtn.isHidden = true
//        }else{
//            editBtn.isHidden = false
//        }
//        editBtn.addTarget(self, action: #selector(functionalLocationcharacteristicsEditAction(sender:)), for: .touchUpInside)
//        CharacteristicValueBtn.addTarget(self, action: #selector(functionalLocationdateAndTimeSelectAction(sender:)), for: .touchUpInside)
//
//        if funclocCharacteristicsModelClass?.DataType == "NUM" || funclocCharacteristicsModelClass?.DataType == "CURR"{
//            CharacteristicValueTxtField.keyboardType = .numberPad
//        }
        
    }
    @objc func functionalLocationcharacteristicsEditAction(sender : UIButton){
        
//        funclocCharacteristicsViewModel.cellIndex = sender.tag
//        let cell = funclocCharacteristicsViewModel.funcLocOverviewVc?.FLCharacteristicsTableView.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! ClassificationCharacteristicsCell
//
//        let saveimg = UIImage(named: "save")
//        let editImage = UIImage(named: "ic_EditPencil")
//        let cellImg = cell.editBtn.imageView?.image
//        let tag = sender.tag
//        let cls = funclocCharacteristicsViewModel.FLCharateristicsArr[tag]
//        if cellImg == saveimg{
//            let length = cell.CharacteristicValueTxtField.text?.count
//            if cls.DataType == "CHAR" {
//                let leg = Int(cls.Characters)
//                if length! > leg {
//                    mJCAlertHelper.showAlert(self.funclocCharacteristicsViewModel.funcLocOverviewVc!, title: alerttitle, message: "Value_length_should_not_be_more_than_Character_count".localized(), button: okay)
//                }else{
//                    cell.CharacteristicValueTxtField.isUserInteractionEnabled = false
//                    cell.CharacteristicValueTxtField.backgroundColor = UIColor.lightGray
//                    cell.editBtn.setImage(editImage, for: .normal)
//                    funclocCharacteristicsViewModel.UpdateCharateristic(Index: sender.tag)
//                }
//            }else if cls.DataType == "NUM" || cls.DataType == "CURR" {
//                let leg = Int(cls.Characters)
//                if length! > leg {
//                    mJCAlertHelper.showAlert(self.funclocCharacteristicsViewModel.funcLocOverviewVc!, title: alerttitle, message: "Value_length_should_not_be_more_than_decimal_count".localized(), button: okay)
//                }else{
//                    cell.CharacteristicValueTxtField.isUserInteractionEnabled = false
//                    cell.CharacteristicValueTxtField.backgroundColor = UIColor.lightGray
//                    cell.editBtn.setImage(editImage, for: .normal)
//                    funclocCharacteristicsViewModel.UpdateCharateristic(Index: sender.tag)
//                }
//            }else{
//                cell.CharacteristicValueTxtField.isUserInteractionEnabled = false
//                cell.CharacteristicValueBtn.isUserInteractionEnabled = false
//                cell.CharacteristicValueTxtField.backgroundColor = UIColor.lightGray
//                cell.editBtn.setImage(editImage, for: .normal)
//                funclocCharacteristicsViewModel.UpdateCharateristic(Index: sender.tag)
//            }
//        }else{
//            if cls.DataType == "DATE" || cls.DataType == "TIME" {
//                cell.CharacteristicValueBtn.isUserInteractionEnabled = true
//            }
//            else{
//                cell.CharacteristicValueBtn.isUserInteractionEnabled = false
//                cell.CharacteristicValueTxtField.becomeFirstResponder()
//            }
//            cell.CharacteristicValueTxtField.isUserInteractionEnabled = true
//            cell.CharacteristicValueTxtField.backgroundColor = UIColor.white
//            cell.editBtn.setImage(saveimg, for: .normal)
//
//        }
    }
    
    @objc func functionalLocationdateAndTimeSelectAction(sender: UIButton) {
//        let CharateristCls = funclocCharacteristicsViewModel.FLCharateristicsArr[sender.tag]
//        let cell = funclocCharacteristicsViewModel.funcLocOverviewVc?.FLCharacteristicsTableView.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! ClassificationCharacteristicsCell
//        if CharateristCls.SingleValue == false{
//
//            let classCharArr = funclocCharacteristicsViewModel.FLClassCharateristicsValueArr.filter{ $0.CharName == "\(CharateristCls.CharacteristicName)"}
//            funclocCharacteristicsViewModel.FLclsCharactristicListArray.removeAllObjects()
//            for item in classCharArr{
//                funclocCharacteristicsViewModel.FLclsCharactristicListArray.add(item.CharValue + " - " + item.CharValueDescr)
//            }
//
//            if funclocCharacteristicsViewModel.FLclsCharactristicListArray.count > 0 {
//                funclocCharacteristicsViewModel.funcLocOverviewVc?.menudropDown.anchorView = cell.CharacteristicValueTxtField
//                let arr : [String] = funclocCharacteristicsViewModel.FLclsCharactristicListArray as NSArray as! [String]
//                funclocCharacteristicsViewModel.funcLocOverviewVc?.menudropDown.dataSource = arr
//                funclocCharacteristicsViewModel.funcLocOverviewVc?.dropDownString = "MethodDropDown"
//                funclocCharacteristicsViewModel.funcLocOverviewVc?.menudropDown.show()
//            }
//        }else{
//            funclocCharacteristicsViewModel.funcLocOverviewVc?.dateAndTimeTagFL = cell.CharacteristicValueBtn.tag
//            self.funclocCharacteristicsViewModel.funcLocOverviewVc?.updateUIFunctionalLocationdateAndTimeSelectAction(tagValue: sender.tag)
//        }
    }
    
}
