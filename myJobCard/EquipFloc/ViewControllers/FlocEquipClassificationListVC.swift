//
//  ClassificationVC.swift
//  myJobCard
//
//  Created by Navdeep Singla on 11/03/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class FlocEquipClassificationListVC: UIViewController, UITableViewDelegate, UITableViewDataSource,viewModelDelegate {
    
    @IBOutlet weak var classificationView: UIView!
    @IBOutlet weak var noClassificationLabel: UILabel!
    @IBOutlet weak var totalClassificationLabel: UILabel!
    @IBOutlet weak var classificationTableView: UITableView!
    
    @IBOutlet weak var characteristicView: UIView!
    @IBOutlet weak var noCharacteristicLabel: UILabel!
    @IBOutlet weak var totalCharacteristicLabel: UILabel!
    @IBOutlet weak var characteristicTableView: UITableView!
    

    var classificationViewModel = ClassificationViewModel()
    var classificationList = [ClassificationModel]()
    var charactersticsViewModel = CharactersticsViewModel()
    var charateristicsList = [CharateristicsModel]()
    
    
    var flocEquipObjType = String()
    var flocEquipObjText = String()
    var classificationType = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        classificationViewModel.delegate = self
        charactersticsViewModel.delegate = self

        classificationViewModel.flocEquipObjText = flocEquipObjText
        classificationViewModel.classificationType = classificationType
        charactersticsViewModel.classificationType = classificationType
        
        self.classificationTableView.separatorStyle = .none
        self.classificationTableView.estimatedRowHeight = 120
        self.characteristicTableView.separatorStyle = .none
        self.characteristicTableView.estimatedRowHeight = 120
        ScreenManager.registerClassificationListCell(tableView: self.classificationTableView)
        ScreenManager.registerClassificationCharacteristicsCell(tableView: self.characteristicTableView)
        charactersticsViewModel.getClassCharacteristicValueList()
        if flocEquipObjType == "floc" {
            classificationViewModel.getFlocClassficationList()
        }else{
            classificationViewModel.getEquipmentClassficationList()
        }
    }
    //MARK: viewModelDelegate
    func dataFetchCompleted(type:String,object:[Any]){
        if type == "classifications"{
            if let objList = object as? [ClassificationModel]{
                classificationList = objList
            }else{
                classificationList = [ClassificationModel]()
            }
            DispatchQueue.main.async {
                if self.classificationList.count > 0{
                    self.totalClassificationLabel.text = "Total_Classifications".localized() + ": \(self.classificationList.count)"
                    self.classificationTableView.isHidden = false
                    self.noClassificationLabel.isHidden = true
                    self.noClassificationLabel.text = ""
                    self.noCharacteristicLabel.text = ""
                }else{
                    self.totalClassificationLabel.text = "Total_Classifications".localized() + ": 0"
                    self.totalCharacteristicLabel.text = "Total_Charateristics".localized() + ": 0"
                    self.characteristicTableView.isHidden = true
                    self.classificationTableView.isHidden = true
                    self.noClassificationLabel.isHidden = false
                    self.noCharacteristicLabel.isHidden = false
                    self.noClassificationLabel.text = "No_Classification_Available".localized()
                    self.view.backgroundColor = UIColor(named: "mjcViewColor")
                    self.noCharacteristicLabel.text = "No_Charateristics_Available".localized()
                }
                self.classificationTableView.reloadData()
                if DeviceType == iPhone{
                    self.classificationView.isHidden = false
                    self.characteristicView.isHidden = true
                }
            }
        }else if type == "Charateristics"{
            if let objlist = object as? [CharateristicsModel]{
                charateristicsList = objlist
            }else{
                charateristicsList = [CharateristicsModel]()
            }
            DispatchQueue.main.async {
                if self.charateristicsList.count > 0{
                    self.totalCharacteristicLabel.text = "Total_Charateristics".localized() + " : \(self.charateristicsList.count)"
                    self.characteristicTableView.isHidden = false
                    self.noCharacteristicLabel.isHidden = true
                    self.noClassificationLabel.text = ""
                    self.noCharacteristicLabel.text = ""
                }else{
                    self.totalCharacteristicLabel.text = "Total_Charateristics".localized() + " : 0"
                    self.characteristicTableView.isHidden = true
                    self.noCharacteristicLabel.isHidden = false
                    self.noCharacteristicLabel.text = "No_Charateristics_Available".localized()
                }
                if DeviceType == iPhone{
                    self.classificationView.isHidden = true
                    self.characteristicView.isHidden = false
                }
                self.characteristicTableView.reloadData()
            }
        }
    }
    //MARK:- UITableView Delegate & DataSource..
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.classificationTableView{
            return self.classificationList.count
        }else if tableView == self.characteristicTableView{
            return charateristicsList.count
        }
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if tableView == self.characteristicTableView{
            let FLCharacteristicsCell = ScreenManager.getClassificationCharacteristicsCell(tableView: tableView)
            if self.charateristicsList.count > 0{
                FLCharacteristicsCell.indexpath = indexPath
               // FLCharacteristicsCell.classifiModel = classificationViewModel
                FLCharacteristicsCell.funclocCharacteristicsModelClass = charateristicsList[indexPath.row]
            }
            return FLCharacteristicsCell
        }else if tableView == self.classificationTableView{
            let FLClassiListCell = ScreenManager.getClassificationListCell(tableView: tableView)
            if self.classificationList.count > 0{
                FLClassiListCell.indexpath = indexPath
                //FLClassiListCell.classifiModel = classificationViewModel
                FLClassiListCell.funcLocClassificationModelClass = classificationList[indexPath.row]
            }
            return FLClassiListCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        if tableView == self.classificationTableView{
            let classficationObj = self.classificationList[indexPath.row]
            let cell = tableView.cellForRow(at: indexPath) as! ClassificationListCell
            cell.transparentView.isHidden = false
            if flocEquipObjType == "floc" {
                charactersticsViewModel.getFlocCharacterstics(classification: classficationObj)
            }else{
                charactersticsViewModel.getEquipCharacterstics(classification: classficationObj)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        mJCLogger.log("Starting", Type: "info")
        if tableView == self.classificationTableView{
            let cell = tableView.cellForRow(at: indexPath) as! ClassificationListCell
            cell.transparentView.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
