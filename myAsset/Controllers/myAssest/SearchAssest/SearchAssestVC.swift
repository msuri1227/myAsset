//
//  SearchAssestVC.swift
//  myAsset
//
//  Created by Mangi Reddy on 07/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class SearchAssestVC: UIViewController,FuncLocEquipSelectDelegate, barcodeDelegate,viewModelDelegate {
    
    @IBOutlet weak var assestIdBgView: UIView!
    @IBOutlet weak var descBgView: UIView!
    @IBOutlet weak var assestClassBgView: UIView!
    @IBOutlet weak var funcLocBgView: UIView!
    @IBOutlet weak var costCenterBgView: UIView!
    @IBOutlet weak var locationBgView: UIView!
    @IBOutlet weak var roomBgView: UIView!
    
    @IBOutlet weak var assestIdLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var assestClassLbl: UILabel!
    @IBOutlet weak var funcLocLbl: UILabel!
    @IBOutlet weak var costCenterLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var roomLbl: UILabel!
    
    @IBOutlet weak var assestIdTxtFld: UITextField!
    @IBOutlet weak var descTxtFld: UITextField!
    @IBOutlet weak var assestClassTxtFld: iOSDropDown!
    @IBOutlet weak var funcLocTxtFld: UITextField!
    @IBOutlet weak var costCenterTxtFld: iOSDropDown!
    @IBOutlet weak var locationTxtFld: iOSDropDown!
    @IBOutlet weak var roomTxtFld: UITextField!
    
    @IBOutlet weak var assestIdScanButton: UIButton!
    @IBOutlet weak var funcLocScanButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var assetVM = AssetClassViewModel()
    var assetListArr:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assetVM.delegate = self
        assetVM.getAssetClassList()
        assetVM.getCostCenterList()
        assetVM.getLocationList()
        
        ODSUIHelper.setBorderToView(view:assestIdBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:descBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:assestClassBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:funcLocBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:costCenterBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:locationBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:roomBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        
        //Asset class
        self.assestClassTxtFld.didSelect { selectedText, index, id in
            self.assestClassTxtFld.text = selectedText
        }
        //Cost center
        self.costCenterTxtFld.optionArray = assetVM.costCenterList
        self.costCenterTxtFld.checkMarkEnabled = false
        self.costCenterTxtFld.didSelect { selectedText, index, id in
            self.costCenterTxtFld.text = selectedText
        }
        //Location
        self.locationTxtFld.optionArray = assetVM.locationList
        self.locationTxtFld.checkMarkEnabled = false
        self.locationTxtFld.didSelect { selectedText, index, id in
            self.locationTxtFld.text = selectedText
        }
    }
    //MARK: - Data fetch methods
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "assetList"{
            assetListArr.removeAll()
            assetListArr.append("--Select--")
            for list in assetVM.assetClassList{
                assetListArr.append("\(list.AssetC) - \(list.AssetDes)")
            }
            self.assestClassTxtFld.optionArray = assetListArr
            self.assestClassTxtFld.checkMarkEnabled = false
        }
    }
    //MARK: - Button Action Methods
    @IBAction func funcLocaButtonAction(_ sender: Any) {
        let assetHierarchyVC = ScreenManager.getFlocEquipHierarchyScreen()
        assetHierarchyVC.modalPresentationStyle = .fullScreen
        assetHierarchyVC.isSelect = "FunctionalLocation"
        self.present(assetHierarchyVC, animated: false, completion: nil)
    }
    @IBAction func assestIdScanButtonAction(_ sender: Any) {
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Equip", delegate: self,controller: self)
    }
    @IBAction func funcLocScanButtonAction(_ sender: Any) {
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "Floc", delegate: self,controller: self)
    }
    @IBAction func resetButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.assestIdTxtFld.text = ""
        self.descTxtFld.text = ""
        self.assestClassTxtFld.text = self.assetListArr[0]
        self.funcLocTxtFld.text = ""
        self.costCenterTxtFld.text = self.assetVM.costCenterList[0]
        self.locationTxtFld.text = self.assetVM.locationList[0]
        self.roomTxtFld .text = ""
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        if assestIdTxtFld.text == "" &&  descTxtFld.text == "" && assestClassTxtFld.text == "" &&
            funcLocTxtFld.text == "" && costCenterTxtFld.text == "" && locationTxtFld.text == "" && roomTxtFld.text == ""{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "please select at least one param", button: okay)
        }else{
            let searchAssetVc = ScreenManager.getAssetListVCScreen()
            self.present(searchAssetVc, animated: false)
        }
    }
    func FuncLocOrEquipSelected(selectedObj: String, EquipObj: EquipmentModel, FuncObj: FunctionalLocationModel) {
        mJCLogger.log("Starting", Type: "info")
        if selectedObj == "FunctionalLocation"{
            self.funcLocTxtFld.text = FuncObj.FunctionalLoc
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
