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

class SearchAssestVC: UIViewController,FuncLocEquipSelectDelegate, barcodeDelegate,viewModelDelegate,SlideMenuControllerSelectDelegate {
    
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
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var assetVM = AssetClassViewModel()
    var assetListArr:[String] = []
    var typeOfScanCode = String()
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
            assetListArr.append(selectStr)
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
        assetHierarchyVC.delegate = self
        self.present(assetHierarchyVC, animated: false, completion: nil)
    }
    @IBAction func assestIdScanButtonAction(_ sender: Any) {
        typeOfScanCode = "AssetID"
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: typeOfScanCode, delegate: self,controller: self)
    }
    @IBAction func funcLocScanButtonAction(_ sender: Any) {
        typeOfScanCode = "floc"
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: typeOfScanCode, delegate: self,controller: self)
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            if typeOfScanCode == "AssetID" {
                self.assestIdTxtFld.text = barCode
            }else if typeOfScanCode == "floc" {
                self.funcLocTxtFld.text = barCode
//                DispatchQueue.main.async {
//                    if let obj = object as? FunctionalLocationModel,obj.FunctionalLoc != ""{
//                        self.funcLocTxtFld.text = obj.FunctionalLoc
//                    }else{
//                        self.appDeli.window?.showSnackbar(message: "couldn’t_find_functional_location_for_id".localized(), actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
//                    }
//                    self.dismiss(animated: true, completion: nil)
//                }
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func resetButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.assestIdTxtFld.text = ""
        self.descTxtFld.text = ""
        self.funcLocTxtFld.text = ""
        self.roomTxtFld.text = ""
        self.assestClassTxtFld.text = ""
        self.costCenterTxtFld.text = ""
        self.locationTxtFld.text = ""
        self.assestClassTxtFld.placeholder = selectStr
        self.costCenterTxtFld.placeholder = selectStr
        self.locationTxtFld.placeholder = selectStr
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        let dashboard = ScreenManager.getDashBoardScreen()
        self.appDeli.window?.rootViewController = dashboard
        self.appDeli.window?.makeKeyAndVisible()
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        if assestIdTxtFld.text == "" &&  descTxtFld.text == "" && assestClassTxtFld.text == "" &&
            funcLocTxtFld.text == "" && costCenterTxtFld.text == "" && locationTxtFld.text == "" && roomTxtFld.text == ""{
            self.appDeli.window?.showSnackbar(message: "Please enter at least one field", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
        }else{
            var searchParams = Dictionary<String,Any>()
            searchParams["assetID"] = self.assestIdTxtFld.text ?? ""
            searchParams["assetDesc"] = self.descTxtFld.text
            if self.assestClassTxtFld.text != ""{
                let arr = self.assestClassTxtFld.text?.components(separatedBy: " - ")
                if arr?.count ?? 0 > 0{
                    searchParams["assetCls"] = arr![0]
                }else{
                    searchParams["assetCls"] = ""
                }
            }else{
                searchParams["assetCls"] = ""
            }
            searchParams["assetFloc"] = self.funcLocTxtFld.text
            if self.costCenterTxtFld.text != ""{
                let arr = self.costCenterTxtFld.text?.components(separatedBy: " - ")
                if arr?.count ?? 0 > 0{
                    searchParams["assetCostCtr"] = arr![0]
                }else{
                    searchParams["assetCostCtr"] = ""
                }
            }else{
                searchParams["assetCostCtr"] = ""
            }
            if self.locationTxtFld.text != ""{
                let arr = self.locationTxtFld.text?.components(separatedBy: " - ")
                if arr?.count ?? 0 > 0{
                    searchParams["assetLocation"] = arr![0]
                }else{
                    searchParams["assetLocation"] = ""
                }
            }else{
                searchParams["assetLocation"] = ""
            }
            searchParams["assetRoom"] = self.roomTxtFld.text
            let searchAssetVc = ScreenManager.getAssetListVCScreen()
            searchAssetVc.searchParam = searchParams
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(searchAssetVc, animated: false)
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
