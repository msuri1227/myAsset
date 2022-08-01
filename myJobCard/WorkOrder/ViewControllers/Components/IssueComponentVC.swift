//
//  IssueComponentVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/11/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class IssueComponentVC: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate {

    //MARK:-   Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var backbutton: UIButton!
    @IBOutlet var issueCompponentHeaderLabel: UILabel!
    
    //descriptionView Outlets..
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var descriptionTextFieldView: UIView!
    
    //plantView Outlets..
    @IBOutlet var plantView: UIView!
    @IBOutlet var plantTitleLabel: UILabel!
    @IBOutlet var plantTextField: UITextField!
    @IBOutlet var plantTextFieldView: UIView!
    @IBOutlet var plantButton: UIButton!
    
    //storageLocationView Outlets..
    @IBOutlet var storageLocationView: UIView!
    @IBOutlet var storageLocationTitleLabel: UILabel!
    @IBOutlet var storageLocationTextField: UITextField!
    @IBOutlet var storageLocationTextFieldView: UIView!
    @IBOutlet var storageLocationButton: UIButton!
    
    //itemView Outlets..
    @IBOutlet var itemView: UIView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var itemTextFieldView: UIView!
    
    //quintityWithdrawnView Outlets..
    @IBOutlet var quintityWithdrawnView: UIView!
    @IBOutlet var quintityWithdrawnTitleLabel: UILabel!
    @IBOutlet var quintityWithdrawnTextField: UITextField!
    @IBOutlet var quintityWithdrawnTextFieldView: UIView!
    
    //buttonView Outlets..
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    //MARK:- Declared Variables..
    var componentClass = WoComponentModel()
    
    let dropDown = DropDown()
    var dropDownSelectString = String()

    var isFoundIssueComponent = Bool()
    var issueComponentArray = [WoComponentIssueModel]()
    var issueComponentsClass = WoComponentIssueModel()

    var maintPlantArray = NSMutableArray()
    
    var plantArray = NSMutableArray()
    var property = NSMutableArray()
    var createUpdateDelegate:CreateUpdateDelegate?
    //MARK:- LifeCycle..
    override func viewDidLoad() {

        self.setMandatoryFields()
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        ODSUIHelper.setBorderToView(view:self.descriptionTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.plantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.storageLocationTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.itemTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.quintityWithdrawnTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        let tap = UITapGestureRecognizer(target: self, action: #selector(IssueComponentVC.handleTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        self.setBasicValue()
        self.getIssueComponentList()
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
    //Back button Action..
    @IBAction func backbuttonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func setMandatoryFields(){
        myAssetDataManager.setMandatoryLabel(label: self.quintityWithdrawnTitleLabel)
    }
    //MARK:- footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()

        if quintityWithdrawnTextField.text! == "" {
            mJCLogger.log("Please_enter_withdrawn_quantity".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_withdrawn_quantity".localized(), button: okay)
        }else {
           // let compCount : Int = Int(quintityWithdrawnTextField.text!)!
            let compCount : Decimal? =  Decimal(string: quintityWithdrawnTextField.text ?? "0") ?? 0.0
            if compCount ?? 0.0 <= 0 {
                mJCLogger.log("You_can_not_withdraw_less_than_1".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "You_can_not_withdraw_less_than_1".localized(), button: okay)
            }else {
                let canWithdrawalQty = (componentClass.ReqmtQty as Decimal) - (componentClass.WithdrawalQty as Decimal)
                let quintity :Decimal? =  Decimal(string: quintityWithdrawnTextField.text ?? "0") ?? 0.0
                if quintity! as Decimal > canWithdrawalQty {
                    let params = Parameters(
                        title: alerttitle,
                        message: "Quantity_of_issues_Component_is_more_than_the_require_Qunatity_Do_you_want_to_continue".localized(),
                        cancelButton:  "Cancel".localized(),
                        otherButtons: [okay]
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0: break
                        case 1: self.componentIssueSet()
                        default: break
                        }
                    }
                }else {
                    self.componentIssueSet()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.setBasicValue()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Field Button Action..
    @IBAction func plantButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")
        if self.plantArray.count > 0 {
            dropDown.anchorView = self.plantTextFieldView
            let arr : [String] = self.plantArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDownSelectString = "PlantDropDown"
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func storageLocationButtonAction(sender: AnyObject) {
        
    }
    //UITextField Editing Changed methods
    @IBAction func quantityWithdrawnEditingChanged(sender: UITextField) {
        mJCLogger.log("Starting", Type: "info")
        let resultString = sender.text?.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890.").inverted)
        sender.text = resultString
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- UITapGesture Recognizer..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.allTextFieldResign()
    }
    //MARK:- Get Issue Component List..
    func getIssueComponentList()  {

        mJCLogger.log("Starting", Type: "info")
        WoComponentIssueModel.getIssuedComponentsList(workOrderNo: selectedworkOrderNumber){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoComponentIssueModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0{
                        self.issueComponentArray = responseArr
                        let issueCompFilteredArray = self.issueComponentArray.filter{$0.Item == "\(self.componentClass.Item)"}
                        if issueCompFilteredArray.count > 0 {
                            self.isFoundIssueComponent = true
                            self.issueComponentsClass = issueCompFilteredArray[0]
                        }else {
                            self.isFoundIssueComponent = false
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                if error?.code == 10{
                    mJCLogger.log("Store open Failed", Type: "Debug")
                }else if error?.code == 1227{
                    mJCLogger.log("Entity set not found", Type: "Debug")
                }else{
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func setBasicValue() {

        mJCLogger.log("Starting", Type: "info")
        self.refreshButton.isHidden = false
        self.plantTextField.isEnabled = false
        self.plantTextField.isEnabled = false
        self.plantTextField.isEnabled = false
        self.plantTextField.text = componentClass.Plant
        self.itemTextField.text = componentClass.Material
        self.descriptionTextField.text = componentClass.MaterialDescription
        self.storageLocationTextField.text = componentClass.StorLocation
        let canWithdrawalQty = (componentClass.ReqmtQty as Decimal) - (componentClass.WithdrawalQty as Decimal)
        self.quintityWithdrawnTextField.text = "\(canWithdrawalQty)"
        self.plantTextField.textColor = UIColor.lightGray
        self.itemTextField.textColor = UIColor.lightGray
        self.descriptionTextField.textColor = UIColor.lightGray
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.descriptionTextField.resignFirstResponder()
        self.plantTextField.resignFirstResponder()
        self.storageLocationTextField.resignFirstResponder()
        self.itemTextField.resignFirstResponder()
        self.quintityWithdrawnTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Create Component Issue Set..
    func componentIssueSet() {
        
        mJCLogger.log("Starting", Type: "info")
        self.property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "Item")
        prop!.value = self.componentClass.Item as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Material")
        prop!.value = self.componentClass.Material as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Plant")
        prop!.value = self.componentClass.Plant as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "StorLocation")
        prop!.value = self.componentClass.StorLocation as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = String.random(length: 2, type: "Number") as NSObject
        self.property.add(prop!)

        prop = SODataPropertyDefault(name: "IssueQty")
//        let withdrawn = Int(quintityWithdrawnTextField.text!)!
//        prop!.value = NSDecimalNumber(string: "\(withdrawn)")
        let withdrawn : Decimal? =  Decimal(string: quintityWithdrawnTextField.text ?? "0") ?? 0.0
        prop!.value = NSDecimalNumber(string: "\(withdrawn ?? 0.0)")
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "UOM")
        prop!.value = self.componentClass.BaseUnit as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MovementType")
        prop!.value = self.componentClass.MovementType as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperAct")
        prop!.value = self.componentClass.OperAct as NSObject
        self.property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Reservation")
        prop!.value = self.componentClass.Reservation as NSObject
        self.property.add(prop!)
        
        print("===== Issue Component Key Value ======")
        
        let entity = SODataEntityDefault(type: woComponentIssueSetEntity)
        for prop in self.property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("Value :\(proper.value!)")
            print("..............")
        }
        WoComponentIssueModel.issueComponentEntity(entity: entity!, collectionPath: woComponentIssueSet, flushRequired: false,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                workOrderCreateDictionary.removeAllObjects()
                mJCLogger.log("components issue sucessfully".localized(), Type: "Debug")
                self.updateWithdrawalQtyComponent()
            }else {
                print("Error : \(error?.localizedDescription ?? "")")
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Issue_component_fails_please_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Update Component..
    func updateWithdrawalQtyComponent() {

        mJCLogger.log("Starting", Type: "info")
        let withdrawn = (Decimal(string: quintityWithdrawnTextField.text ?? "0") ?? 0.0) + ( componentClass.WithdrawalQty as Decimal)
        let withdrawalQty = "\(withdrawn).00"
        (componentClass.entity.properties["WithdrawalQty"] as! SODataProperty).value = NSDecimalNumber(string: "\(withdrawalQty)")
        componentClass.WithdrawalQty = NSDecimalNumber(decimal: withdrawn)
        WoComponentIssueModel.updateIssueComponentEntity(entity: componentClass.entity, flushRequired: true,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Update Withdrawal Qty Component : Done".localized(), Type: "Debug")
                NotificationCenter.default.post(name: Notification.Name(rawValue:"setComponentBadgeIcon"), object: "")
                self.createUpdateDelegate?.EntityCreated?()
                let params = Parameters(
                    title: alerttitle,
                    message: "Component_has_been_issued".localized(),
                    cancelButton: okay
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0:
                        self.dismiss(animated: false) {}
                    default: break
                    }
                }
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Delete Component Entity..
    func deleteIssueComponent()  {
        
        mJCLogger.log("Starting", Type: "info")
        WoComponentIssueModel.deleteIssueComponentEntity(entity: self.issueComponentsClass.entity, options: nil, completionHandler: { (response, error) in
            if error == nil {
                self.componentIssueSet()
                mJCLogger.log("\(self.issueComponentsClass.Item) record deleted : Done", Type: "Debug")
            }else {
                if error?.code == 10{
                    mJCLogger.log("Store open Failed", Type: "Debug")
                }else if error?.code == 1227{
                    mJCLogger.log("Entity set not found", Type: "Debug")
                }else{
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
}
