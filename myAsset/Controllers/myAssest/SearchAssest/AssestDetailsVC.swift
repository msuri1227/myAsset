//
//  AssestDetailsVC.swift
//  myAsset
//
//  Created by Mangi Reddy on 08/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class AssestDetailsVC: UIViewController,viewModelDelegate {
    
    @IBOutlet weak var segmentBgView: UIView!
    @IBOutlet weak var assestSegment: UISegmentedControl!
    @IBOutlet weak var assetTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var selectedLbl: UILabel!
    @IBOutlet weak var selectedStackView: UIStackView!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var selectedArr:[Int] = []
    var objmodel = WorkOrderObjectsViewModel()
    var inspectedArr = [WorkorderObjectModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objmodel.delegate = self
        objmodel.getObjectlist()
        
        assetTableView.register(UINib(nibName: "SearchAssetCell_iPhone", bundle: nil), forCellReuseIdentifier: "SearchAssetCell_iPhone")
        assetTableView.rowHeight = 170
        assetTableView.estimatedRowHeight = UITableView.automaticDimension
        
        ODSUIHelper.setBorderToView(view:self.searchView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.assetTableView.allowsMultipleSelection = true
    }
    
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "assetList"{
            self.inspectedArr = self.objmodel.objectListArray
            DispatchQueue.main.async {
                self.totalLbl.text = "\(self.inspectedArr.count)"
                self.assestSegment.selectedSegmentIndex = 0
                self.assestSegmentAction(self.assestSegment)
            }
        }
    }
    
    @IBAction func assestSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.selectedStackView.isHidden = false
            self.inspectedArr.removeAll()
            self.inspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic == ""}
            self.assetTableView.reloadData()
        }
        else{
            self.selectedStackView.isHidden = true
            self.inspectedArr.removeAll()
            self.inspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic != ""}
            self.assetTableView.reloadData()
        }
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.selectedArr.removeAll()
        assetTableView.reloadData()
        self.selectedLbl.text = ""
    }
}

extension AssestDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inspectedArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScreenManager.getInspectedCell(tableView: tableView)
        cell.assetLbl.text = self.inspectedArr[indexPath.row].Equipment
        cell.assetIdLbl.text = self.inspectedArr[indexPath.row].Equipment
        cell.descLbl.text = self.inspectedArr[indexPath.row].EquipmentDescription
        cell.funcLocLbl.text = self.inspectedArr[indexPath.row].FunctionalLoc
        cell.serialNumLbl.text = self.inspectedArr[indexPath.row].SerialNumber
        if assestSegment.selectedSegmentIndex == 0{
            cell.cameraBtn.isHidden = false
            cell.rightArrowbtn.isHidden = false
            if selectedArr.contains(indexPath.row){
                cell.checkBoxImgView.image = UIImage(named: "ic_check_fill")
            }else{
                cell.checkBoxImgView.image = UIImage(named: "ic_check_nil")
            }
        }
        else{
            cell.cameraBtn.isHidden = true
            cell.rightArrowbtn.isHidden = true
            cell.checkBoxImgView.image = UIImage(named: "ic_check_fill")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130//UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedArr.contains(indexPath.row){
            let myInd = self.selectedArr.firstIndex(of: indexPath.row)
            self.selectedArr.remove(at: myInd!)
            self.selectedLbl.text = "\(selectedArr.count)"
        }else{
            selectedArr.append(indexPath.row)
            self.selectedLbl.text = "\(selectedArr.count)"
        }
        self.assetTableView.reloadData()
    }
}
