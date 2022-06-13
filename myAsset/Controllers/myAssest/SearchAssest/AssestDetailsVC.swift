//
//  AssetDetailsVC.swift
//  myAsset
//
//  Created by Mangi Reddy on 08/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class AssetDetailsVC: UIViewController, viewModelDelegate, barcodeDelegate {
    
    @IBOutlet weak var segmentBgView: UIView!
    @IBOutlet weak var assestSegment: UISegmentedControl!
    @IBOutlet weak var assetTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var selectedLbl: UILabel!
    @IBOutlet weak var selectedStackView: UIStackView!
    @IBOutlet weak var tblViewBottomConst: NSLayoutConstraint!
    @IBOutlet weak var scanBtnWidthConst: NSLayoutConstraint!
    @IBOutlet weak var barCodeScanBtn: UIButton!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var selectedArr:[Int] = []
    var objmodel = WorkOrderObjectsViewModel()
    var inspectedArr = [WorkorderObjectModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objmodel.delegate = self
        objmodel.getObjectlist()
        assetTableView.register(UINib(nibName: "SearchAssetCell_iPhone", bundle: nil), forCellReuseIdentifier: "SearchAssetCell_iPhone")
        assetTableView.rowHeight = 140
        assetTableView.estimatedRowHeight = UITableView.automaticDimension
        ODSUIHelper.setBorderToView(view:self.searchView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.assetTableView.allowsMultipleSelection = true
        self.tblViewBottomConst.constant = IS_IPHONE_XS_MAX ? 64 : 0 //default 54
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
    //MARK: - Button Action Methods
    @IBAction func assestSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.selectedStackView.isHidden = false
            self.inspectedArr.removeAll()
            self.inspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic == ""}
            self.totalLbl.text = "\(self.inspectedArr.count)"
            selectedCountLabelUpdate(count: self.selectedArr.count)
            self.scanBtnWidthConst.constant = 57.5
            self.assetTableView.reloadData()
        }else{
            self.selectedStackView.isHidden = true
            self.inspectedArr.removeAll()
            self.inspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic != ""}
            self.totalLbl.text = "\(self.inspectedArr.count)"
            self.scanBtnWidthConst.constant = 0
            self.assetTableView.reloadData()
        }
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.selectedArr.removeAll()
        selectedCountLabelUpdate(count: selectedArr.count)
        assetTableView.reloadData()
        self.selectedLbl.text = ""
    }
    @IBAction func barCodeScanBtnAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "asset", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            print("Asset scan code: \(barCode)")
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

extension AssetDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inspectedArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScreenManager.getInspectedCell(tableView: tableView)
        if self.inspectedArr.indices.contains(indexPath.row){
            let assetDetail = self.inspectedArr[indexPath.row]
            if assestSegment.selectedSegmentIndex == 0{
                cell.unInspCellModel = assetDetail
                if selectedArr.contains(indexPath.row){
                    cell.checkBoxImgView.image = UIImage(named: "ic_check_fill")
                }else{
                    cell.checkBoxImgView.image = UIImage(named: "ic_check_nil")
                }
            }else{
                cell.inspCellModel = assetDetail
            }
            cell.cameraBtn.tag = indexPath.row
            cell.rightArrowbtn.tag = indexPath.row
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedArr.contains(indexPath.row){
            let myInd = self.selectedArr.firstIndex(of: indexPath.row)
            self.selectedArr.remove(at: myInd!)
            selectedCountLabelUpdate(count: selectedArr.count)
        }else{
            selectedArr.append(indexPath.row)
            selectedCountLabelUpdate(count: selectedArr.count)
        }
        self.assetTableView.reloadData()
    }
    
    @objc func assetCameraButtonAction(sender: UIButton){
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "asset", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func moveToOverViewButtonAction(sender: UIButton){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = "floc"
            flocEquipDetails.flocEquipObjText = self.inspectedArr[sender.tag].Equipment
            flocEquipDetails.classificationType = "Workorder"
            flocEquipDetails.modalPresentationStyle = .fullScreen
            self.present(flocEquipDetails, animated: false) {}
        }else{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = "floc"
            flocEquipDetails.flocEquipObjText = self.inspectedArr[sender.tag].Equipment
            flocEquipDetails.classificationType = "Workorder"
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Equipment"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = flocEquipDetails as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(flocEquipDetails, animated: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func selectedCountLabelUpdate(count: Int){
        if assestSegment.selectedSegmentIndex == 0{
            if selectedArr.count > 0{
                self.selectedStackView.isHidden = false
                self.selectedLbl.text = "\(selectedArr.count)"
            }
            else{
                self.selectedStackView.isHidden = true
            }
        }
    }
}
