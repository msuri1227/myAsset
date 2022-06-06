//
//  CreateAssignmentViewController.swift
//  myJobCard
//
//  Created by Khaleel on 20/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import Foundation
import ODSFoundation
import FormsEngine
import mJCLib

class CheckSheetAssignmentVC: UIViewController,UITableViewDelegate,UITableViewDataSource, checkSheetSelectionDelegate,viewModelDelegate {
    
    @IBOutlet var checkSheetListView: UIView!
    @IBOutlet var chooseCheckSheetButtonView: UIView!
    @IBOutlet var chooseCheckSheetTxtField: UITextField!
    @IBOutlet var chooseCheckSheetButton: UIButton!
    @IBOutlet var checkSheetListTableView: UITableView!
    @IBOutlet var noDataAvailable: UILabel!
    
    var selectedFormsArray = [FormMasterMetaDataModel]()
    var checkListMasterArr = [FormMasterMetaDataModel]()
    var previousCheckSheetListArr = [FormAssignDataModel]()

    var manualCheckSheetVM = manualCheckSheetViewModel()
    var entityArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manualCheckSheetVM.delegate = self
        self.manualCheckSheetVM.woObj = singleWorkOrder
        self.manualCheckSheetVM.oprObj = singleOperation
        self.manualCheckSheetVM.getManualCheckSheetData()
        ODSUIHelper.setBorderToView(view:chooseCheckSheetTxtField, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ScreenManager.registerCheckSheetOptionsCell(tableView: self.checkSheetListTableView)
    }
    override func viewWillAppear(_ animated: Bool) {}
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "ManualCheckSheetList"{
            DispatchQueue.main.async {
                let checkSheetAvailabilityVc = ScreenManager.getCheckSheetAvailabilityScreen()
                checkSheetAvailabilityVc.delegate = self
                checkSheetAvailabilityVc.previousCheckListArr = self.previousCheckSheetListArr
                checkSheetAvailabilityVc.modalPresentationStyle = .overFullScreen
                self.present(checkSheetAvailabilityVc, animated: false) {}
            }
        }else if type == "Dismiss"{
            self.dismiss(animated: false)
        }
    }

    @IBAction func chooseCheckSheetButtonAction(_ sender: Any) {
        
        let checkSheetAvailabilityVc = ScreenManager.getCheckSheetAvailabilityScreen()
        checkSheetAvailabilityVc.delegate = self
        checkSheetAvailabilityVc.previousSelectedCheckSheetList = self.selectedFormsArray
        checkSheetAvailabilityVc.checkListMasterArr = self.checkListMasterArr
        checkSheetAvailabilityVc.previousCheckListArr = self.previousCheckSheetListArr
        checkSheetAvailabilityVc.modalPresentationStyle = .fullScreen
        self.present(checkSheetAvailabilityVc, animated: false) {}
    }
    func checkSheetSelected(list: [FormMasterMetaDataModel],masterList:[FormMasterMetaDataModel]) {
        if list.count > 0{
            self.selectedFormsArray = list
            self.checkListMasterArr = masterList
            self.checkSheetListTableView.reloadData()
            self.noDataAvailable.isHidden = true
            self.checkSheetListTableView.isHidden = false
        }else{
            self.checkSheetListTableView.isHidden = true
            self.noDataAvailable.isHidden = false
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.selectedFormsArray[indexPath.row]
        if item.multiOccur == true{
            return 160
        }else{
            return 120
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedFormsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let cell = ScreenManager.getCheckSheetOptionsCell(tableView: tableView)
        if selectedFormsArray.count > 0{
            cell.indexPath = indexPath
            let formMasterModel = selectedFormsArray[indexPath.row]
            cell.formMasterModel = formMasterModel
            cell.CSAssignmentVC = self
        }
        mJCLogger.log("Ended", Type: "info")
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
        }
        deleteAction.backgroundColor =  UIColor(red: 233.0/255.0, green: 79.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        let viewAction = UITableViewRowAction(style: .destructive, title: "View") { (rowAction, indexPath) in
            print("viewAction")
        }
        viewAction.backgroundColor =  UIColor(red: 88.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        return [deleteAction,viewAction]
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    @IBAction func SaveButtonAction(_ sender: Any) {
        if self.selectedFormsArray.count > 0{
            mJCLoader.startAnimating(status: "Please_Wait".localized())
            for i in 0..<selectedFormsArray.count{
                let formdata = selectedFormsArray[i]
                if formdata.multiOccur == true{
                    let occurrenceCount = formdata.occur
                    if occurrenceCount <= 0{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_Enter_Number_Of_Occurence_For".localized() + " " + formdata.FormID , button: okay)
                        mJCLoader.stopAnimating()
                        return
                    }
                }
            }
            self.createManualCheckSheets()
        }
    }
    func createManualCheckSheets(){
        if self.selectedFormsArray.count > 0{
            mJCLoader.startAnimating(status: "Please_Wait".localized())
            for i in 0..<selectedFormsArray.count{
                let formdata = selectedFormsArray[i]
                var multiOccurance = Bool()
                var multiOccCount = Int()
                if formdata.multiOccur == true{
                    multiOccurance = true
                    let occurrenceCount = formdata.occur
                    if occurrenceCount  <= 0{
                        return
                    }else if occurrenceCount == 0{
                        return
                    }else{
                        multiOccCount = occurrenceCount
                    }
                }else{
                    multiOccurance = false
                    multiOccCount = 1
                }
                let formEntityArray = NSMutableArray()

                var prop : SODataProperty! = SODataPropertyDefault(name: "FormID")
                prop!.value = formdata.FormID as NSObject
                formEntityArray.add(prop!)

                prop = SODataPropertyDefault(name: "FormName")
                prop!.value = formdata.FormName as NSObject
                formEntityArray.add(prop!)

                prop = SODataPropertyDefault(name: "Version")
                prop!.value = formdata.Version as NSObject
                formEntityArray.add(prop!)

                prop = SODataPropertyDefault(name: "FormAssignmentType")
                prop!.value = "\(FORM_ASSIGNMENT_TYPE)" as NSObject
                formEntityArray.add(prop!)

                prop = SODataPropertyDefault(name: "Mandatory")
                if formdata.mandatory == true{
                    prop!.value = "X" as NSObject
                }else{
                    prop!.value = "" as NSObject
                }
                formEntityArray.add(prop!)

                prop = SODataPropertyDefault(name: "MultipleSub")
                if multiOccurance == true{
                    prop!.value = "X" as NSObject
                }else{
                    prop!.value = "" as NSObject
                }
                formEntityArray.add(prop!)

                prop = SODataPropertyDefault(name: "Occur")
                prop!.value = "\(multiOccCount)" as NSObject
                formEntityArray.add(prop!)

                if FORM_ASSIGNMENT_TYPE == "6"{
                    prop = SODataPropertyDefault(name: "WorkOrderNum")
                    prop!.value = "\(selectedworkOrderNumber)" as NSObject
                    formEntityArray.add(prop!)
                }else if FORM_ASSIGNMENT_TYPE == "7" || FORM_ASSIGNMENT_TYPE == "10"{
                    prop = SODataPropertyDefault(name: "WorkOrderNum")
                    prop!.value = "\(selectedworkOrderNumber)" as NSObject
                    formEntityArray.add(prop!)

                    prop = SODataPropertyDefault(name: "OprNum")
                    prop!.value = "\(selectedOperationNumber)" as NSObject
                    formEntityArray.add(prop!)
                }else if FORM_ASSIGNMENT_TYPE == "8"{
                    prop = SODataPropertyDefault(name: "Equipment")
                    prop!.value = "" as NSObject
                    formEntityArray.add(prop!)
                }else if FORM_ASSIGNMENT_TYPE == "9"{
                    prop = SODataPropertyDefault(name: "FunctionalLocation")
                    prop!.value = "" as NSObject
                    formEntityArray.add(prop!)
                }
                prop = SODataPropertyDefault(name: "AssignedDate")
                let datestr = Date().localDate()
                prop.value = datestr as NSObject
                formEntityArray.add(prop)

                prop = SODataPropertyDefault(name: "AssignedTime")
                let basicTime = SODataDuration()
                let time = Date().toString(format: .custom("HH:mm"))
                let basicTimeArray = time.components(separatedBy:":")
                basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
                basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
                basicTime.seconds = 0
                prop.value = basicTime
                formEntityArray.add(prop)

                let entity = SODataEntityDefault(type: manualCheckSheetCreateEntity)
                for prop in formEntityArray {
                    let proper = prop as! SODataProperty
                    entity?.properties[proper.name as Any] = proper
                    print("Key : \(proper.name!)")
                    print("Value :\(proper.value!)")
                    print("..............")
                }
                self.entityArray.append(entity!)
            }
            self.manualCheckSheetVM.createEntities(entityList: self.entityArray, index: 0)
        }
    }
    @IBAction func cacelButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
