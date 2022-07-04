//
//  InstalledEquipmentVC.swift
//  myJobCard
//
//  Created by Navdeep Singla on 15/03/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class InstalledEquipmentVC: UIViewController, UITableViewDelegate, UITableViewDataSource,viewModelDelegate {

    @IBOutlet weak var installedTotalLabel: UILabel!
    @IBOutlet weak var installedEquipmentTableView: UITableView!
    @IBOutlet weak var noDataAvailableLabel: UILabel!

    var installedEquipmentViewModel = InstalledEquipmentViewModel()
    var installedEquipmentList = [EquipmentModel]()
    var flocEquipObjType = String()
    var flocEquipObjText = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        installedEquipmentViewModel.delegate = self
        self.installedEquipmentTableView.separatorStyle = .none
        self.installedEquipmentTableView.estimatedRowHeight = 120
        ScreenManager.registerInstalledEqupFLdetailsTableViewCell(tableView: self.installedEquipmentTableView)
        if flocEquipObjType == "floc" {
            installedEquipmentViewModel.getInstalledEquipmentToFlocList()
        }else{
            installedEquipmentViewModel.getInstalledEquipmentToEquipList()
        }
    }
    //MARK: viewModelDelegate
    func dataFetchCompleted(type:String,object:[Any]){
        if let objDictList = object as? [EquipmentModel]{
            installedEquipmentList = objDictList
        }else{
            installedEquipmentList = [EquipmentModel]()
        }
        DispatchQueue.main.async{
            if self.installedEquipmentList.count > 0 {
                self.installedEquipmentTableView.isHidden = false
                self.noDataAvailableLabel.isHidden = true
            }else{
                self.installedEquipmentTableView.isHidden = true
                self.noDataAvailableLabel.isHidden = false
            }
            self.installedEquipmentTableView.reloadData()
            self.installedTotalLabel.text = "Total_Entries".localized() + " : \(self.installedEquipmentList.count)"
        }
    }

    //MARK:- UITableView Delegate & DataSource..
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.installedEquipmentList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.installedEquipmentTableView{
            if flocEquipObjType == "floc" {
                let InstalledEqupCell = ScreenManager.getInstalledEqupFLdetailsTableViewCell(tableView: tableView)
                InstalledEqupCell.installEqupFLDetailModelClass = installedEquipmentList[indexPath.row]
                return InstalledEqupCell
            }else{
                let InstalledEqupCell = ScreenManager.getInstalledEqupFLdetailsTableViewCell(tableView: tableView)
                InstalledEqupCell.installedEquipmentModel = installedEquipmentList[indexPath.row]
                return InstalledEqupCell
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
