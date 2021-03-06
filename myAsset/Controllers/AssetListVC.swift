//
//  AssetListVC.swift
//  myAsset
//
//  Created by Mangi Reddy on 08/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
import PDFKit

class AssetListVC: UIViewController,viewModelDelegate,CLLocationManagerDelegate,CustomNavigationBarDelegate, FuncLocEquipSelectDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,barcodeDelegate,SlideMenuControllerSelectDelegate,iProgressHUDDelegete{
    
    @IBOutlet weak var iPhoneHeader: UIView!
    @IBOutlet weak var assetTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var selectedLbl: UILabel!
    @IBOutlet weak var selectedStackView: UIStackView!
    @IBOutlet var printTagButton: UIButton!
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var printBtn: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet var noDataLabel: UILabel!
    //RFID
    @IBOutlet var RFIDScanView: UIView!
    @IBOutlet var RFIDTableView: UITableView!
    @IBOutlet var RFIDSearchView: UIView!
    @IBOutlet var RFIDBottomButtonView: UIView!
    @IBOutlet var UpdateButton: UIButton!
    @IBOutlet var CancelButton: UIButton!
    @IBOutlet var rfidCount: UILabel!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var navHeaderView = CustomNavHeader_iPhone()
    let menudropDown = DropDown()
    var searchParam = Dictionary<String,Any>()
    var assetSearchVM = AssetSearchViewModel()
    var selectedArr = [ZEquipmentModel]()
    var assetArry = [ZEquipmentModel]()
    var assetListArry = [ZEquipmentModel]()
    var locationManager: CLLocationManager = CLLocationManager()
    var currentlat : Double = 0.0
    var currentLong : Double = 0.0
    var selectedFloc = String()
    let iprogress: iProgressHUD = iProgressHUD()
    var RfidListArry = [String]()
    var selectedRfid = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printBtn.setTitle("", for: .normal)
        self.assetTableView.delegate = self
        self.assetTableView.dataSource = self
        searchField.delegate = self
        assetSearchVM.delegate = self
        assetSearchVM.searchParams = self.searchParam
        assetSearchVM.getAssetList()
        searchField.compatibleSearchTextField.backgroundColor = UIColor.white
        searchField.setImage(UIImage(), for: .search, state: .normal)
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }else {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_on_location_services".localized() , button: okay)
        }
        assetTableView.register(UINib(nibName: "SearchAssetCell_iPhone", bundle: nil), forCellReuseIdentifier: "SearchAssetCell_iPhone")
        assetTableView.rowHeight = 170
        assetTableView.estimatedRowHeight = UITableView.automaticDimension
        ODSUIHelper.setBorderToView(view:self.searchView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.assetTableView.allowsMultipleSelection = true
        navHeaderView = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Asset List", NewJobButton: true, refresButton: true, threedotmenu: true, leftMenuType: "Back")
        self.iPhoneHeader.addSubview(navHeaderView)
        if flushStatus == true{
            self.navHeaderView.refreshBtn.showSpin()
        }
        self.navHeaderView.delegate = self
        self.viewWillAppear(true)
    }
    
    @IBAction func printTagButtonAction(_ sender: Any) {
        if selectedArr.count == 1{
            let selecetedObj = selectedArr[0]
            let img = PrintHelper.createQRCodeView(asseID: "\(selecetedObj.Asset)", assetDesc: "\(selecetedObj.EquipDescription)")
            PrintHelper.printQrCode(document: img, assetId: "\(selecetedObj.Asset)")
        }else if selectedArr.count > 1{
            var imgArr = [UIImage]()
            for item in selectedArr{
                let img = PrintHelper.createQRCodeView(asseID: "\(item.Asset)", assetDesc: "\(item.EquipDescription)")
                imgArr.append(img)
            }
            let pdfDocument = PDFDocument()
            for i in 0 ..< imgArr.count {
                let pdfPage = PDFPage(image: imgArr[i])
                pdfDocument.insert(pdfPage!, at: i)
            }
            let data = pdfDocument.dataRepresentation()
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let docURL = documentDirectory.appendingPathComponent("assetDetails.pdf")
            do{
                try data?.write(to: docURL)
            }catch(let error){
                print("error is \(error.localizedDescription)")
            }
            PrintHelper.printQrCode(document: docURL, assetId: "assetDetails")
        }
    }
    //MARK: - Table view delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == assetTableView{
            return self.assetArry.count
        }else{
            return self.RfidListArry.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == assetTableView{
            let cell = ScreenManager.getInspectedCell(tableView: tableView)
            if self.assetArry.indices.contains(indexPath.row){
                let equipment = self.assetArry[indexPath.row]
                cell.assetListCellModel = equipment
                if self.selectedArr.contains(equipment){
                    cell.checkBoxBtn.setImage(UIImage(named: "ic_check_fill"), for: .normal)
                }else{
                    cell.checkBoxBtn.setImage(UIImage(named: "ic_check_nil"), for: .normal)
                }
            }
            cell.rightArrowbtn.tag = indexPath.row
            cell.rightArrowbtn.addTarget(self, action: #selector(moveToOverViewButtonAction(sender:)), for: .touchUpInside)
            return cell
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            if(cell != nil){
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            }
            if self.RfidListArry.indices.contains(indexPath.row){
                let equipment = self.RfidListArry[indexPath.row]
                cell!.textLabel?.text = "RFID : \(equipment)"
            }
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == assetTableView{
            return 130
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == assetTableView{
            let item = self.assetArry[indexPath.row]
            if !selectedArr.contains(item){
                selectedArr.append(item)
                self.selectedCountLabelUpdate(count: self.selectedArr.count)
            }else{
                if let index = self.selectedArr.index(of: item){
                    selectedArr.remove(at: index)
                    self.selectedCountLabelUpdate(count: self.selectedArr.count)
                }
            }
            self.assetTableView.reloadData()
        }else if tableView == RFIDTableView{
            let item = self.RfidListArry[indexPath.row]
            self.selectedRfid = item
        }
    }
    @objc func moveToOverViewButtonAction(sender: UIButton){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = ""
            flocEquipDetails.flocEquipObjText = self.assetArry[sender.tag].Equipment
            flocEquipDetails.classificationType = "Workorder"
            flocEquipDetails.modalPresentationStyle = .fullScreen
            self.present(flocEquipDetails, animated: false) {}
        }else{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = ""
            flocEquipDetails.flocEquipObjText = self.assetArry[sender.tag].Equipment
            flocEquipDetails.classificationType = "Workorder"
            currentMasterView = "WorkOrder"
            myAssetDataManager.uniqueInstance.updateSlidemenuDelegates(delegateVC: flocEquipDetails)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "assetList"{
            DispatchQueue.main.async {
                self.assetArry = self.assetSearchVM.assetList
                self.assetListArry = self.assetSearchVM.assetList
                self.totalLbl.text = "\(self.assetArry.count)"
                self.selectedCountLabelUpdate(count: self.selectedArr.count)
                if self.assetArry.count > 0{
                    self.noDataLabel.isHidden = true
                    self.assetTableView.isHidden = false
                }else{
                    self.noDataLabel.isHidden = false
                    self.assetTableView.isHidden = true
                }
                self.assetTableView.reloadData()
            }
        }else if type == "FlocUpdated"{
            var functionalLocation = String()
            if let floc = object[0] as? String{
                functionalLocation = floc
            }
            self.appDeli.window?.showSnackbar(message: "Functional Location :\(functionalLocation) updated.", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
            DispatchQueue.main.async {
                self.assetSearchVM.getAssetList()
            }
        }else if type == "geoLocationUpdated"{
            var location = String()
            if let loc = object[0] as? String{
                location = loc
            }
            self.appDeli.window?.showSnackbar(message: "\(self.selectedArr.count) Asset(s) are updated! Location:(\(location))", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
        }
        else if type == "RFIDUpdated"{
            DispatchQueue.main.async {
                var rfidValue = String()
                if let rfid = object[0] as? String{
                    rfidValue = rfid
                }
                self.selectedRfid = ""
                self.RFIDScanView.isHidden = true
                self.appDeli.window?.showSnackbar(message: "RFID : \(rfidValue) updated.", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
                self.assetTableView.isHidden = false
                self.noDataLabel.isHidden = true
                self.assetTableView.reloadData()
            }
        }
    }
    @IBAction func scanBtnAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "asset", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    func selectedCountLabelUpdate(count: Int){
        if self.selectedArr.count > 0{
            self.selectedStackView.isHidden = false
            self.printTagButton.isHidden = false
            self.selectedLbl.text = "\(self.selectedArr.count)"
        }else{
            self.selectedStackView.isHidden = true
            self.printTagButton.isHidden = true
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.selectedArr.removeAll()
        self.selectedCountLabelUpdate(count:self.selectedArr.count)
        assetTableView.reloadData()
        self.selectedLbl.text = ""
    }
    @IBAction func updateButtonAction(_ sender: Any) {
        if selectedRfid != ""{
            self.assetSearchVM.updateRFIdTagValue(list: self.selectedArr, RFId: "\(selectedRfid)", count: 0)
        }else{
            self.appDeli.window?.showSnackbar(message: "Please select RFID to update.",  actionButtonText: "", bgColor: appColor,actionButtonClickHandler:nil)
        }
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.RFIDScanView.isHidden = true
        self.assetTableView.isHidden = false
        self.selectedRfid = ""
        self.RfidListArry.removeAll()
    }
    
    func leftMenuButtonClicked(_ sender: UIButton?){
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.remove(at: myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count - 1)
        }
        myAssetDataManager.uniqueInstance.navigationController?.popViewController(animated: true)
    }
    func backButtonClicked(_ sender: UIButton?){
        self.dismiss(animated: false) {}
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                let createNewJobVC = ScreenManager.getCreateJobScreen()
                createNewJobVC.isFromEdit = false
                createNewJobVC.isScreen = "WorkOrder"
                createNewJobVC.modalPresentationStyle = .fullScreen
                self.present(createNewJobVC, animated: false) {}
            }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
            }else{
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        var menuarr = [String]()
        menuarr = ["Update_Geo_Location".localized(),"Update_Functional_Location".localized(), "Update_RF_Id".localized()]
        if menuarr.count == 0{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Options_Available".localized(), button: okay)
        }
        menudropDown.dataSource = menuarr
        menudropDown.anchorView = sender
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "Update_Geo_Location".localized(){
                if selectedArr.count == 0{
                    self.appDeli.window?.showSnackbar(message: "Please_select_asset_to_update_geo_Location".localized(),  actionButtonText: "", bgColor: appColor,actionButtonClickHandler:nil)
                }else{
                    self.assetSearchVM.updateGeoLocation(list: selectedArr, currentLoc: "x:\(self.currentlat),y:\(self.currentLong)", count: 0)
                }
            }else if item == "Update_Functional_Location".localized(){
                if selectedArr.count == 0{
                    self.appDeli.window?.showSnackbar(message: "Please_select_asset_to_update_functional_location".localized(),  actionButtonText: "", bgColor: appColor,actionButtonClickHandler:nil)
                }else{
                    mJCLogger.log("Starting", Type: "info")
                    let functionaLocationListVC = ScreenManager.getFlocEquipHierarchyScreen()
                    functionaLocationListVC.isSelect = "FunctionalLocation"
                    functionaLocationListVC.modalPresentationStyle = .fullScreen
                    functionaLocationListVC.delegate = self
                    self.present(functionaLocationListVC, animated: false) {}
                    mJCLogger.log("Ended", Type: "info")
                }
            }
            else if item == "Update_RF_Id".localized(){
                self.RfidListArry.removeAll()
                if self.selectedArr.count > 0{
                    if self.selectedArr.count == 1{
                        self.assetTableView.isHidden = true
                        self.noDataLabel.isHidden = true
                        self.RFIDScanView.isHidden = false
                        self.RFIDTableView.isHidden = true
                        self.RFIDBottomButtonView.isHidden = true
                        self.iprogress.delegete = self
                        self.iprogress.iprogressStyle = .vertical
                        self.iprogress.indicatorStyle = .ballScaleMultiple
                        self.iprogress.isShowModal = false
                        self.iprogress.boxSize = 100
                        self.RFIDSearchView.isHidden = false
                        self.iprogress.attachProgress(toViews: RFIDSearchView)
                        self.RFIDSearchView.showProgress()
                        self.RFIDSearchView.updateCaption(text: "Searching RFID..")
                        self.RFIDSearchView.updateColors(modalColor: .white, boxColor: .white, indicatorColor: .blue, captionColor: .black)
                        self.rfidCount.text = "Available RFIDs : \(self.RfidListArry.count)"
                        let randomDouble = Double.random(in: 1...5)
                        DispatchQueue.main.asyncAfter(deadline: .now() + randomDouble, execute: {
                            let randomeInt = Int.random(in: 1...10)
                            self.RfidListArry.removeAll()
                            let selectedVal = self.selectedArr[0].Asset
                            self.RfidListArry.append("RF1298\(selectedVal)")
                            for _ in 1...randomeInt {
                                let random = Int.random(in: 10000...99999)
                                self.RfidListArry.append("RF1298\(random)")
                            }
                            self.RFIDSearchView.dismissProgress()
                            self.rfidCount.text = "Available RFIDs : \(self.RfidListArry.count)"
                            self.RFIDTableView.isHidden = false
                            self.RFIDBottomButtonView.isHidden = false
                            self.RFIDSearchView.isHidden = true
                            self.RFIDTableView.reloadData()
                        })
                        
                        //                        let selectedVal = self.selectedArr[0].Asset
                        //                        let params = Parameters(
                        //                            title: "Update_RF_Id".localized(),
                        //                            message: "Asset: \(selectedVal) \n\n RFID: RF1298\(selectedVal)",
                        //                            cancelButton: "Update".localized(),
                        //                            otherButtons: [cancelButtonTitle]
                        //                        )
                        //                        mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        //                            switch buttonIndex {
                        //                            case 0:
                        //                                self.assetSearchVM.updateRFIdTagValue(list: self.selectedArr, RFId: "RF1298\(self.selectedArr[0].Asset)", count: 0)
                        //                            case 1:
                        //                                self.dismiss(animated: true)
                        //                            default: break
                        //                            }
                        //                        }
                    }else{
                        self.appDeli.window?.showSnackbar(message: "Select only one Asset.", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
                    }
                }else{
                    self.appDeli.window?.showSnackbar(message: "Select only one Asset.", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
                }
            }
        }
    }
    func FuncLocOrEquipSelected(selectedObj:String,EquipObj:EquipmentModel,FuncObj:FunctionalLocationModel){
        if selectedObj == "FunctionalLocation"{
            self.assetSearchVM.updateFunctionalLocation(list: selectedArr, FuncLocation: FuncObj.FunctionalLoc, count: 0)
        }
    }
    @objc func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mJCLogger.log("Starting", Type: "info")
        if (status == CLAuthorizationStatus.denied) {
            mJCLogger.log("The user denied authorization".localized(), Type: "")
        }else if (status == CLAuthorizationStatus.notDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }else if (status == CLAuthorizationStatus.restricted) {
            print("Restricted to use Location")
        }else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            print("AuthorizedWhenInUse")
        }else if (status == CLAuthorizationStatus.authorizedAlways) {
            locationManager.startUpdatingLocation()
            print("AuthorizedAlways")
            mJCLogger.log("AuthorizedAlways".localized(), Type: "")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mJCLogger.log("Starting", Type: "info")
        let lastLocation: CLLocation = locations[locations.count - 1]
        currentlat = lastLocation.coordinate.latitude
        currentLong = lastLocation.coordinate.longitude
        self.locationManager.stopUpdatingLocation()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            print("Asset scan code: \(barCode)")
            self.searchField.text = barCode
            self.searchBar(searchField, textDidChange: self.searchField.text!)
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    //MARK: -  Search Bar delegate..
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchField.endEditing(true)
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        mJCLogger.log("Starting", Type: "info")
        if searchBar == searchField{
            if(searchText == "") {
                self.searchField.becomeFirstResponder()
                self.assetArry.removeAll()
                self.assetArry = self.assetListArry
                self.assetTableView.reloadData()
            }else{
                self.assetArry = self.assetListArry.filter{$0.Asset.containsIgnoringCase(find: "\(searchText)") || $0.EquipDescription.containsIgnoringCase(find: "\(searchText)")
                }
                if self.assetArry.count > 0 {
                    self.noDataLabel.isHidden = true
                    self.assetTableView.isHidden = false
                }else{
                    self.noDataLabel.isHidden = false
                    self.assetTableView.isHidden = true
                }
                self.assetTableView.reloadData()
            }
            mJCLogger.log("Ended", Type: "info")
        }
    }
    func onShow(view: UIView) {
        print("onShow")
    }
    
    func onDismiss(view: UIView) {
        print("onDismiss")
    }
    
    func onTouch(view: UIView) {
        print("onTouch")
    }
}
