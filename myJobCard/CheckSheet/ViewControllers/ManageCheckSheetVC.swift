//
//  ManageCheckSheetVC.swift
//  myJobCard
//
//  Created by Suri on 27/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class ManageCheckSheetVC: UIViewController,UITableViewDataSource,UITableViewDelegate,viewModelDelegate {
    
    @IBOutlet var checkSheetTable: UITableView!
    @IBOutlet var checkSheetTableView: UIView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var noDataAvaialableLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!

    var manualCheckSheetVM = manualCheckSheetViewModel()

    override func viewDidLoad() {

        super.viewDidLoad()

        manualCheckSheetVM.delegate = self
        self.manualCheckSheetVM.woObj = singleWorkOrder
        self.manualCheckSheetVM.oprObj = singleOperation
        self.manualCheckSheetVM.getManualCheckSheetData()
        self.manualCheckSheetVM.woAssigmentType = WORKORDER_ASSIGNMENT_TYPE
        self.manualCheckSheetVM.formAssignmentType = FORM_ASSIGNMENT_TYPE

        ODSUIHelper.setCircleButtonLayout(button: self.addButton, bgColor: appColor)
        ScreenManager.registerFormTableViewCell(tableView: self.checkSheetTable)
        if !applicationFeatureArrayKeys.contains("CREATE_MANUAL_CHECKSHEET"){
            self.addButton.isHidden = true
        }else{
            self.addButton.isHidden = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.manualCheckSheetVM.getManualCheckSheetData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.manualCheckSheetVM.manualCheckListArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let formTableviewCell = ScreenManager.getFormTableViewCell(tableView: tableView)
        if self.manualCheckSheetVM.manualCheckListArray.count > 0{
            formTableviewCell.indexpath = indexPath
            formTableviewCell.isFromManual = true
            formTableviewCell.fromStr = "Manage"
            formTableviewCell.mangeCSVC = self
            formTableviewCell.manulCheckSheetCellModel = manualCheckSheetVM.manualCheckListArray[indexPath.row]
        }
        mJCLogger.log("Ended", Type: "info")
        return formTableviewCell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            DispatchQueue.main.async {
                let params = Parameters(
                    title: alerttitle,
                    message: "Are_you_sure_you_want_to_delete".localized(),
                    cancelButton: "Cancel".localized(),
                    otherButtons: [okay]
                )
                mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                    switch buttonIndex {
                    case 0: break
                    case 1: self.manualCheckSheetVM.deleteCheckSheet(tag: indexPath.row)
                    default: break
                    }
                }
            }
        }
        deleteAction.backgroundColor =  UIColor(red: 233.0/255.0, green: 79.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        let viewAction = UITableViewRowAction(style: .destructive, title: "View") { (rowAction, indexPath) in
            print("viewAction")
        }
        viewAction.backgroundColor =  UIColor(red: 88.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        return [deleteAction]
    }
    @IBAction func addButtonAction(_ sender: Any) {
        let addAssignment = ScreenManager.getCheckSheetAssignmentScreen()
        addAssignment.previousCheckSheetListArr = manualCheckSheetVM.manualCheckListArray
        addAssignment.modalPresentationStyle = .fullScreen
        self.present(addAssignment, animated: false) {}
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "ManualCheckSheetList"{
            DispatchQueue.main.async {
                if self.manualCheckSheetVM.manualCheckListArray.count > 0{
                    self.checkSheetTable.reloadData()
                    self.checkSheetTable.isHidden = false
                    self.noDataAvaialableLabel.isHidden = true
                    self.totalLabel.text = "Total_Checksheet".localized() +  " : "
                    + "\(self.manualCheckSheetVM.manualCheckListArray.count)"
                }else{
                    self.checkSheetTable.isHidden = true
                    self.noDataAvaialableLabel.isHidden = false
                    self.totalLabel.text = "Total_Checksheet".localized() +  " : "
                    + "0"
                }
            }
        }
    }
}
