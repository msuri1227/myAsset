//
//  FuncLocOverViewVC.swift
//  myJobCard
//
//  Created by Navdeep Singla on 10/03/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib


class FlocEquipOverviewVC:UIViewController,UITableViewDelegate,UITableViewDataSource,viewModelDelegate{
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var installEquipmentButton: UIButton!
    @IBOutlet weak var functionalLocationTableView: UITableView!
    @IBOutlet weak var functionalLocOrEquipmentNumberLabel: UILabel!
    
    var flocOverViewModel = FlocEquipOverViewModel()
    var flocEquipObjType = String()
    var flocEquipObjText = String()
    var selectedFloc = FunctionalLocationModel()
    var selectedEquip = ZEquipmentModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        flocOverViewModel.delegate = self
        flocOverViewModel.flocEquipObjText = flocEquipObjText

        if flocEquipObjType == "floc" {
            ScreenManager.registerFunctionalLocationOverViewCell(tableView: self.functionalLocationTableView)
            ScreenManager.registerFunctionalLocationAdditionalInfoCell(tableView: self.functionalLocationTableView)
            flocOverViewModel.getFunctionalLocationDetails()
        }else{
            ScreenManager.registerEquipmentOverViewCell(tableView: self.functionalLocationTableView)
            ScreenManager.registerEquipmentAdditionalCell(tableView: self.functionalLocationTableView)
            ScreenManager.registerEquipmentWarrantyInfoCell(tableView: self.functionalLocationTableView)
            flocOverViewModel.ZgetEquipmentDetails()
        }
        self.functionalLocationTableView.separatorStyle = .none
        self.functionalLocationTableView.estimatedRowHeight = 1000
        functionalLocationTableView.rowHeight = UITableView.automaticDimension
        ODSUIHelper.setButtonLayout(button: self.installEquipmentButton, cornerRadius: self.installEquipmentButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    //MARK: viewModelDelegate
    func dataFetchCompleted(type:String,object:[Any]){
        if type == "floc"{
            if let objDict = object[0] as? FunctionalLocationModel{
                selectedFloc = objDict
            }else{
                selectedFloc = FunctionalLocationModel()
            }
        }else{
            if let objDict = object[0] as? ZEquipmentModel{
                selectedEquip = objDict
            }else{
                selectedEquip = ZEquipmentModel()
            }
        }
        DispatchQueue.main.async {
            self.functionalLocationTableView.reloadData()
        }
    }
    //MARK: - UITableView Delegate & DataSource..
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flocEquipObjType == "floc" {
            return 2
        }else{
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.functionalLocationTableView {
            if flocEquipObjType == "floc" {
                if indexPath.row == 0 {
                    let functioanLocationOverViewCell = ScreenManager.getFunctionalLocationOverViewCell(tableView: tableView)
                    functioanLocationOverViewCell.funcLocOverviewModelClass = selectedFloc
                    return functioanLocationOverViewCell
                }else {
                    let functioanLocationAdditionalInfoCell = ScreenManager.getFunctionalLocationAdditionalInfoCell(tableView: tableView)
                    functioanLocationAdditionalInfoCell.funcLocAdditionalInfoModelClass = selectedFloc
                    return functioanLocationAdditionalInfoCell
                }
            }else{
                if indexPath.row == 0 {
                    let equipmentCell = ScreenManager.getEquipmentOverViewCell(tableView: tableView)
                    equipmentCell.indexpath = indexPath
                    equipmentCell.equipOverviewModelClass = selectedEquip
                    return equipmentCell
                }else if indexPath.row == 1 {
                    let equipmentAdditionalCell = ScreenManager.getEquipmentAdditionalCell(tableView: tableView)
                    equipmentAdditionalCell.equipAdditionalModelClass = selectedEquip
                    return equipmentAdditionalCell
                }else if indexPath.row == 2 {
                    let equipmentWarrantyCell = ScreenManager.getEquipmentWarrantyInfoCell(tableView: tableView)
                    equipmentWarrantyCell.equipWarrantyInfoModelClass = selectedEquip
                    return equipmentWarrantyCell
                }
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if flocEquipObjType == "floc" {
            if indexPath.row == 0{
                return 950
            }
            else{
                return 1525
            }
        }
        else{
            if indexPath.row == 0{
                return 1900
            }
            else if indexPath.row == 1{
                return 1515
            }
            else{
                return 800
            }
        }
        //        return UITableView.automaticDimension
    }
    //MARK: - Button actions
    @IBAction func installEquipmentButtonAction(_ sender: Any) {
        if flocEquipObjType == "floc"  {
            mJCLogger.log("Starting", Type: "info")
            let installEquipOrFLVC = ScreenManager.getInstallEquipOrFLScreen()
            installEquipOrFLVC.isitfrom = "SuperiorFunc"
            installEquipOrFLVC.SuperiorFunc = selectedFloc.FunctionalLoc
            installEquipOrFLVC.modalPresentationStyle = .fullScreen
            self.present(installEquipOrFLVC, animated: false) {}
            mJCLogger.log("Ended", Type: "info")
        }else{
            mJCLogger.log("Starting", Type: "info")
            let installEquipOrFLVC = ScreenManager.getInstallEquipOrFLScreen()
            installEquipOrFLVC.isitfrom = "SuperiorEquipment"
            installEquipOrFLVC.SuperiorEquipment = selectedEquip.Equipment
            installEquipOrFLVC.modalPresentationStyle = .fullScreen
            self.present(installEquipOrFLVC, animated: false) {}
            mJCLogger.log("Ended", Type: "info")
        }
    }
}
