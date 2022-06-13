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

class AssetListVC: UIViewController,viewModelDelegate,CustomNavigationBarDelegate {
    
    @IBOutlet weak var assetTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var selectedLbl: UILabel!
    @IBOutlet weak var selectedStackView: UIStackView!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var selectedArr:[Int] = []
    var objmodel = WorkOrderObjectsViewModel()
    var inspectedArr = [WorkorderObjectModel]()
    var navHeaderView = CustomNavHeader_iPhone()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objmodel.delegate = self
        objmodel.getObjectlist()
        
        assetTableView.register(UINib(nibName: "SearchAssetCell_iPhone", bundle: nil), forCellReuseIdentifier: "SearchAssetCell_iPhone")
        assetTableView.rowHeight = 170
        assetTableView.estimatedRowHeight = UITableView.automaticDimension
        
        ODSUIHelper.setBorderToView(view:self.searchView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.assetTableView.allowsMultipleSelection = true
        
        navHeaderView = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "", NewJobButton: true, refresButton: true, threedotmenu: true, leftMenuType: "Menu")
        self.view.addSubview(navHeaderView)
        if flushStatus == true{
            self.navHeaderView.refreshBtn.showSpin()
        }
        self.navHeaderView.delegate = self
        self.viewWillAppear(true)
    }
    
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "datafetch"{
            self.inspectedArr = self.objmodel.objectListArray
            DispatchQueue.main.async {
                self.totalLbl.text = "\(self.inspectedArr.count)"
            }
        }
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.selectedArr.removeAll()
        assetTableView.reloadData()
        self.selectedLbl.text = ""
    }
    func leftMenuButtonClicked(_ sender: UIButton?){
        openLeft()
    }
    func backButtonClicked(_ sender: UIButton?){
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        
    }
    func refreshButtonClicked(_ sender: UIButton?){
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
    }
}

extension AssetListVC:UITableViewDelegate,UITableViewDataSource{
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
        cell.cameraBtn.isHidden = true
        cell.rightArrowbtn.isHidden = true
        cell.checkBoxImgView.image = UIImage(named: "ic_check_fill")
        
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
