//
//  AssetDetailsVC.swift
//  myAsset
//  Created by Mangi Reddy on 08/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class AssetDetailsVC: UIViewController, viewModelDelegate, barcodeDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UISearchBarDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var segmentBgView: UIView!
    @IBOutlet weak var assestSegment: UISegmentedControl!
    @IBOutlet weak var assetTableView: UITableView!
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var noDataLblView: UIView!
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var selectedLbl: UILabel!
    @IBOutlet weak var selectedStackView: UIStackView!
    @IBOutlet weak var scanBtnWidthConst: NSLayoutConstraint!
    @IBOutlet weak var barCodeScanBtn: UIButton!
    
    @IBOutlet weak var writeOffBgView: UIView!
    @IBOutlet weak var notesDoneBtn: UIButton!
    @IBOutlet weak var noteTextViewBgView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var notesCancelBtn: UIButton!
    
    //iPad
    @IBOutlet weak var unInspectedTblView: UITableView!
    @IBOutlet weak var inspectedTblView: UITableView!
    
    @IBOutlet weak var unInspectedScanBtn: UIButton!
    @IBOutlet weak var unInspectedSearchBtn: UIButton!
    
    @IBOutlet weak var inspectedSearchBtn: UIButton!
    @IBOutlet weak var selectedCancelBtn: UIButton!
    @IBOutlet weak var selectedCountLbl: UILabel!
    @IBOutlet weak var unInspectedTotalCountLbl: UILabel!
    @IBOutlet weak var inspectedTotalCountLbl: UILabel!
    @IBOutlet weak var totalStackView: UIStackView!
    @IBOutlet weak var unInspectedSearchBar: UISearchBar!
    @IBOutlet weak var inspectedSearchBar: UISearchBar!
    @IBOutlet weak var unInspectedNoDataLbl: UILabel!
    @IBOutlet weak var inspectedNoDataLbl: UILabel!
    @IBOutlet weak var inspectedSearchBgView: UIView!
    @IBOutlet weak var unInspectedSearchBgView: UIView!
    @IBOutlet weak var inspectedScanBtn: UIButton!
    
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var writeOffBtn: UIButton!
    @IBOutlet weak var updateGeoLocbtn: UIButton!
    @IBOutlet weak var assetLocBtn: UIButton!
    
    @IBOutlet var rfidScanButton: UIButton!
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var objmodel = WorkOrderObjectsViewModel()
    var inspectedArr = [WorkorderObjectModel]()
    var inspectedListArr = [WorkorderObjectModel]()
    var selectedAssetListArr = [WorkorderObjectModel]()
    var attachmentsViewModel = AttachmentsViewModel()
    var selectedEquipNumber: String?
    
    //iPad
    var totalListArr = [WorkorderObjectModel]()
    var unInspectedArr = [WorkorderObjectModel]()
    var unInspectedListArr = [WorkorderObjectModel]()
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentlat : Double = 0.0
    var currentLong : Double = 0.0
    var isScanBtnSelected:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objmodel.delegate = self
        objmodel.getObjectlist()
        if DeviceType == iPhone{
            searchField.delegate = self
            searchField.setImage(UIImage(), for: .search, state: .normal)
            searchField.compatibleSearchTextField.backgroundColor = UIColor.white
            assetTableView.register(UINib(nibName: "SearchAssetCell_iPhone", bundle: nil), forCellReuseIdentifier: "SearchAssetCell_iPhone")
            assetTableView.rowHeight = 140
            assetTableView.estimatedRowHeight = UITableView.automaticDimension
            ODSUIHelper.setBorderToView(view:self.noteTextViewBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:self.searchView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            self.assetTableView.allowsMultipleSelection = true
        }
        else{
            unInspectedSearchBar.delegate = self
            unInspectedSearchBar.setImage(UIImage(), for: .search, state: .normal)
            unInspectedSearchBar.compatibleSearchTextField.backgroundColor = UIColor.white
            inspectedSearchBar.delegate = self
            inspectedSearchBar.setImage(UIImage(), for: .search, state: .normal)
            inspectedSearchBar.compatibleSearchTextField.backgroundColor = UIColor.white
            unInspectedTblView.register(UINib(nibName: "SearchAssetCell_iPhone", bundle: nil), forCellReuseIdentifier: "SearchAssetCell_iPhone")
            unInspectedTblView.rowHeight = 140
            unInspectedTblView.estimatedRowHeight = UITableView.automaticDimension
            inspectedTblView.register(UINib(nibName: "SearchAssetCell_iPhone", bundle: nil), forCellReuseIdentifier: "SearchAssetCell_iPhone")
            inspectedTblView.rowHeight = 140
            inspectedTblView.estimatedRowHeight = UITableView.automaticDimension
            unInspectedTblView.allowsMultipleSelection = true
            unInspectedTblView.allowsSelection = true
            unInspectedTblView.allowsSelectionDuringEditing = true
            ODSUIHelper.setBorderToView(view:self.noteTextViewBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:self.unInspectedSearchBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setBorderToView(view:self.inspectedSearchBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.verifyBtn, cornerRadius: self.verifyBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.writeOffBtn, cornerRadius: self.writeOffBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.updateGeoLocbtn, cornerRadius: self.updateGeoLocbtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
            ODSUIHelper.setButtonLayout(button: self.assetLocBtn, cornerRadius: self.assetLocBtn.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }else {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_on_location_services".localized() , button: okay)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(AssetDetailsVC.handleTap(sender:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        self.objectSelected()
    }
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
    }
    @objc func objectSelected(){
        objmodel.delegate = self
        objmodel.getObjectlist()
        if DeviceType == iPhone{
            searchField.delegate = self
        }
        else{
            unInspectedSearchBar.delegate = self
            inspectedSearchBar.delegate = self
        }
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "assetList"{
            if DeviceType == iPhone{
                self.inspectedArr = self.objmodel.objectListArray
                self.inspectedListArr = self.objmodel.objectListArray
                DispatchQueue.main.async {
                    self.selectedAssetListArr.removeAll()
                    self.totalLbl.text = "\(self.inspectedArr.count)"
                    self.assestSegment.selectedSegmentIndex = 0
                    self.assestSegmentAction(self.assestSegment)
                }
            }
            else{
                self.totalListArr = self.objmodel.objectListArray
                self.unInspectedArr.removeAll()
                self.selectedAssetListArr.removeAll()
                self.unInspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic == ""}
                self.unInspectedListArr = self.unInspectedArr
                
                DispatchQueue.main.async {
                    self.selectedStackView.isHidden = true
                    self.unInspectedTotalCountLbl.text = "\(self.unInspectedArr.count)"
                    if self.unInspectedArr.count > 0{
                        self.unInspectedNoDataLbl.isHidden = true
                        self.totalStackView.isHidden = false
                    }
                    else{
                        self.totalStackView.isHidden = true
                        self.unInspectedNoDataLbl.isHidden = false
                    }
                    self.unInspectedTblView.reloadData()
                }
                
                self.inspectedArr.removeAll()
                self.inspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic != ""}
                self.inspectedListArr = self.inspectedArr
                DispatchQueue.main.async {
                    self.inspectedTotalCountLbl.text = "\(self.inspectedArr.count)"
                    if self.inspectedArr.count > 0{
                        self.inspectedNoDataLbl.isHidden = true
                    }
                    else{
                        self.inspectedNoDataLbl.isHidden = false
                    }
                    self.inspectedTblView.reloadData()
                }
            }
        }else if type == "VerifyWriteOffCompleted"{
            DispatchQueue.main.async {
                self.writeOffBgView.isHidden = true
            }
            objmodel.getObjectlist()
        }else if type == "geoLocationUpdated"{
            var location = String()
            if let loc = object[0] as? String{
                location = loc
            }
            self.appDeli.window?.showSnackbar(message: "\(self.selectedAssetListArr.count) Asset(s) are updated! Location:(\(location))", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
        }else if type == "AssetMap"{
            DispatchQueue.main.async {
                let assetLocVc = ScreenManager.getAssetLocationScreen()
                var locListArr = [Dictionary<String,Any>]()
                for item in self.objmodel.equipmentArr{
                    var dict = Dictionary<String,Any>()
                    dict["AssetID"] = "\(item.Equipment)"
                    dict["AssetDesc"] = "\(item.EquipDescription)"
                    var location = item.GEOLocation
                    location = location.replacingOccurrences(of: "x:", with: "")
                    location = location.replacingOccurrences(of: "y:", with: "")
                    let locArr = location.components(separatedBy: ",")
                    if locArr.count == 2{
                        dict["AssetLat"] = "\(locArr[0])"
                        dict["AssetLong"] = "\(locArr[1])"
                        locListArr.append(dict)
                    }
                }
                assetLocVc.locations = locListArr
                self.present(assetLocVc, animated: false)
            }
        }
    }
    //MARK: - Button Action Methods
    @IBAction func assestSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
            self.selectedStackView.isHidden = false
            self.inspectedArr.removeAll()
            self.inspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic == ""}
            self.inspectedListArr = self.inspectedArr
            self.totalLbl.text = "\(self.inspectedArr.count)"
            self.searchField.text = ""
            selectedCountLabelUpdate(count: self.selectedAssetListArr.count)
            self.scanBtnWidthConst.constant = 57.5
            if self.inspectedArr.count == 0{
                self.noDataLblView.isHidden = false
            }
            else{
                self.noDataLblView.isHidden = true
            }
            self.assetTableView.reloadData()
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
            self.selectedStackView.isHidden = true
            self.inspectedArr.removeAll()
            self.inspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic != ""}
            self.inspectedListArr = self.inspectedArr
            self.totalLbl.text = "\(self.inspectedArr.count)"
            self.searchField.text = ""
            self.scanBtnWidthConst.constant = 0
            if self.inspectedArr.count == 0{
                self.noDataLblView.isHidden = false
            }
            else{
                self.noDataLblView.isHidden = true
            }
            self.assetTableView.reloadData()
        }
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.selectedAssetListArr.removeAll()
        selectedCountLabelUpdate(count: selectedAssetListArr.count)
        assetTableView.reloadData()
        self.selectedLbl.text = ""
    }
    @IBAction func barCodeScanBtnAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "asset", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func rfidScanButtonAction(_ sender: Any) {
        let iprogress: iProgressHUD = iProgressHUD()
        iprogress.iprogressStyle = .vertical
        iprogress.indicatorStyle = .ballScaleMultiple
        iprogress.isShowModal = false
        iprogress.boxSize = 100
        iprogress.attachProgress(toViews: self.view)
        self.view.showProgress()
        self.view.updateCaption(text: "Searching RFID..")
        self.view.updateColors(modalColor: .white, boxColor: .white, indicatorColor: .blue, captionColor: .black)
        let randomDouble = Double.random(in: 1...5)
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDouble, execute: {
            self.view.dismissProgress()
            if DeviceType == iPhone{
                self.selectedAssetListArr = self.inspectedArr
            }
            else{
                self.selectedAssetListArr = self.unInspectedArr
            }
            if self.selectedAssetListArr.indices.contains(4){
                self.selectedAssetListArr.remove(at: 4)
            }
            if self.selectedAssetListArr.indices.contains(1){
                self.selectedAssetListArr.remove(at: 1)
            }
            if self.selectedAssetListArr.count == 0{
                self.appDeli.window?.showSnackbar(message: "Assets not found", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
            }else{
                self.appDeli.window?.showSnackbar(message: "\(self.selectedAssetListArr.count) Asset(s) selected.", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
            }
            self.selectedCountLabelUpdate(count: self.selectedAssetListArr.count)
            if DeviceType == iPhone{
                self.assetTableView.reloadData()
            }
            else{
                self.unInspectedTblView.reloadData()
            }
        })
    }
    @IBAction func notesDoneBtnAction(_ sender: UIButton) {
        if notesTextView.text == ""{
            self.appDeli.window?.showSnackbar(message: "Please_enter_notes".localized(), actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
        }else{
            self.objmodel.updateWriteOffWorkOder(list: selectedAssetListArr, status: "W", notes: self.notesTextView.text, count: 0)
        }
    }
    @IBAction func notesCancelBtnAction(_ sender: UIButton) {
        self.writeOffBgView.isHidden = true
    }
    @IBAction func selectedCancelBtnAction(_ sender: Any) {
        self.selectedAssetListArr.removeAll()
        selectedCountLabelUpdate(count: selectedAssetListArr.count)
        if DeviceType == iPhone{
            assetTableView.reloadData()
        }else{
            unInspectedTblView.reloadData()
        }
        self.selectedCountLbl.text = ""
    }
    @IBAction func unInspectedScanBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        isScanBtnSelected = "UnInspected"
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "asset", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func inspectedScanBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        isScanBtnSelected = "Inspected"
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "asset", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func verifyBtnAction(_ sender: Any) {
        if selectedAssetListArr.count > 0{
            objmodel.updateVerifyWorkOrder(list: selectedAssetListArr, status: "I", count: 0)
        }else{
            self.appDeli.window?.showSnackbar(message: "Select at least one Asset.", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
        }
    }
    @IBAction func writeOffBtnAction(_ sender: Any) {
        if selectedAssetListArr.count > 0{
            DispatchQueue.main.async {
                self.notesTextView.text = ""
                self.writeOffBgView.isHidden = false
                self.view.bringSubviewToFront(self.writeOffBgView)
            }
        }else{
            self.appDeli.window?.showSnackbar(message: "Select at least one Asset.", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
        }
    }
    @IBAction func updateGeoLocBtnAction(_ sender: Any) {
        if selectedAssetListArr.count > 0{
            objmodel.getEquipmentListForAssets(list: selectedAssetListArr, currentLoc: "x:\(self.currentlat),y:\(self.currentLong)", from: "")
        }else{
            self.appDeli.window?.showSnackbar(message: "Please_select_asset_to_update_geo_Location".localized(),  actionButtonText: "", bgColor: appColor,actionButtonClickHandler:nil)
        }
    }
    @IBAction func assetLocBtnAction(_ sender: Any) {
        if selectedAssetListArr.count > 0{
            objmodel.getEquipmentListForAssets(list: selectedAssetListArr, currentLoc: "x:\(self.currentlat),y:\(self.currentLong)", from: "AssetMap")
        }else{
            self.appDeli.window?.showSnackbar(message: "Please_select_asset_to_update_functional_location".localized(),  actionButtonText: "", bgColor: appColor,actionButtonClickHandler:nil)
        }
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            if DeviceType == iPhone{
                self.searchField.text = barCode
                self.searchBar(searchField, textDidChange: self.searchField.text!)
            }
            else{
                if isScanBtnSelected == "UnInspected"{
                    self.unInspectedSearchBar.text = barCode
                    self.searchBar(unInspectedSearchBar, textDidChange: self.unInspectedSearchBar.text!)
                }
                else{
                    self.inspectedSearchBar.text = barCode
                    self.searchBar(inspectedSearchBar, textDidChange: self.inspectedSearchBar.text!)
                }
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    //MARK: -  Search Bar delegate..
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if DeviceType == iPhone{
            self.searchField.endEditing(true)
        }
        else{
            if searchBar == unInspectedSearchBar{
                self.unInspectedSearchBar.endEditing(true)
            }
            else{
                self.inspectedSearchBar.endEditing(true)
            }
        }
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            if searchBar == searchField{
                if(searchText == "") {
                    self.searchField.becomeFirstResponder()
                    inspectedArr = self.inspectedListArr
                    self.assetTableView.reloadData()
                }else{
                    self.inspectedArr = inspectedListArr.filter{$0.Equipment.containsIgnoringCase(find: "\(searchText)") || $0.EquipmentDescription.containsIgnoringCase(find: "\(searchText)")}
                    if inspectedArr.count > 0{
                        DispatchQueue.main.async{
                            self.noDataLblView.isHidden = true
                        }
                    }else{
                        self.noDataLblView.isHidden = false
                    }
                    self.assetTableView.reloadData()
                }
            }
        }
        else{
            if searchBar == inspectedSearchBar{
                if(searchText == "") {
                    self.inspectedSearchBar.becomeFirstResponder()
                    self.inspectedArr = self.inspectedListArr
                    self.inspectedTblView.reloadData()
                }else{
                    self.inspectedArr = inspectedListArr.filter{$0.Equipment.containsIgnoringCase(find: "\(searchText)") || $0.EquipmentDescription.containsIgnoringCase(find: "\(searchText)")}
                }
                if inspectedArr.count > 0{
                    DispatchQueue.main.async{
                        self.inspectedNoDataLbl.isHidden = true
                    }
                }else{
                    self.inspectedNoDataLbl.isHidden = false
                }
                self.inspectedTblView.reloadData()
            }
            else if searchBar == unInspectedSearchBar {
                if(searchText == "") {
                    self.unInspectedSearchBar.becomeFirstResponder()
                    self.unInspectedArr = self.unInspectedListArr
                    self.unInspectedTblView.reloadData()
                }else{
                    self.unInspectedArr = unInspectedListArr.filter{$0.Equipment.containsIgnoringCase(find: "\(searchText)") || $0.EquipmentDescription.containsIgnoringCase(find: "\(searchText)")}
                }
                if unInspectedArr.count > 0{
                    DispatchQueue.main.async{
                        self.unInspectedNoDataLbl.isHidden = true
                    }
                }else{
                    self.unInspectedNoDataLbl.isHidden = false
                }
                self.unInspectedTblView.reloadData()
            }
        }
    }
    //MARK: - Location manager delegate methods
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
}
//MARK: - Tableview Datasource & Delegate Methods
extension AssetDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DeviceType == iPhone{
            return self.inspectedArr.count
        }
        else{
            if tableView == self.unInspectedTblView{
                return self.unInspectedArr.count
            }
            else{
                return self.inspectedArr.count
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScreenManager.getInspectedCell(tableView: tableView)
        cell.selectionStyle = .none
        if DeviceType == iPhone{
            if self.inspectedArr.indices.contains(indexPath.row){
                let assetDetail = self.inspectedArr[indexPath.row]
                if assestSegment.selectedSegmentIndex == 0{
                    cell.unInspCellModel = assetDetail
                    if selectedAssetListArr.contains(assetDetail){
                        cell.checkBoxBtn.setImage(UIImage(named: "ic_check_fill"), for: .normal)
                    }else{
                        cell.checkBoxBtn.setImage(UIImage(named: "ic_check_nil"), for: .normal)
                    }
                }else{
                    cell.inspCellModel = assetDetail
                }
                cell.checkBoxBtn.tag = indexPath.row
                cell.cameraBtn.tag = indexPath.row
                cell.rightArrowbtn.tag = indexPath.row
                
                cell.cameraBtn.addTarget(self, action: #selector(inspectedCameraAction(sender:)), for: .touchUpInside)
                cell.rightArrowbtn.addTarget(self, action: #selector(inspectedArrowAction(sender:)), for: .touchUpInside)
            }
        }
        else{
            if tableView == self.unInspectedTblView{
                if self.unInspectedArr.indices.contains(indexPath.row){
                    let assetDetail = self.unInspectedArr[indexPath.row]
                    cell.unInspCellModel = assetDetail
                    if selectedAssetListArr.contains(assetDetail){
                        cell.checkBoxBtn.setImage(UIImage(named: "ic_check_fill"), for: .normal)
                    }else{
                        cell.checkBoxBtn.setImage(UIImage(named: "ic_check_nil"), for: .normal)
                    }
                    cell.checkBoxBtn.tag = indexPath.row
                    cell.cameraBtn.tag = indexPath.row
                    cell.rightArrowbtn.tag = indexPath.row
                    
                    cell.cameraBtn.addTarget(self, action: #selector(unInspectedCameraAction(sender:)), for: .touchUpInside)
                    cell.rightArrowbtn.addTarget(self, action: #selector(unInspectedArrowAction(sender:)), for: .touchUpInside)
                }
            }
            else{
                let assetDetail = self.inspectedArr[indexPath.row]
                cell.inspCellModel = assetDetail
                cell.cameraBtn.tag = indexPath.row
                cell.rightArrowbtn.tag = indexPath.row
                cell.cameraBtn.addTarget(self, action: #selector(inspectedCameraAction(sender:)), for: .touchUpInside)
                cell.rightArrowbtn.addTarget(self, action: #selector(inspectedArrowAction(sender:)), for: .touchUpInside)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if DeviceType == iPhone{
            if self.assestSegment.selectedSegmentIndex != 1{
                let item = self.inspectedArr[indexPath.row]
                if !selectedAssetListArr.contains(item){
                    selectedAssetListArr.append(item)
                    selectedCountLabelUpdate(count: selectedAssetListArr.count)
                }else{
                    if let index = self.selectedAssetListArr.index(of: item){
                        selectedAssetListArr.remove(at: index)
                        selectedCountLabelUpdate(count: selectedAssetListArr.count)
                    }
                }
                self.assetTableView.reloadData()
            }
        }
        else{
            switch tableView {
            case unInspectedTblView:
                let item = self.unInspectedArr[indexPath.row]
                if !selectedAssetListArr.contains(item){
                    selectedAssetListArr.append(item)
                    selectedCountLabelUpdate(count: selectedAssetListArr.count)
                }else{
                    if let index = self.selectedAssetListArr.index(of: item){
                        selectedAssetListArr.remove(at: index)
                        selectedCountLabelUpdate(count: selectedAssetListArr.count)
                    }
                }
                self.unInspectedTblView.reloadData()
            case inspectedTblView:
                break
            default:
                break
            }
        }
    }
    //MARK: - Cell button action methods
    @objc func inspectedCameraAction(sender: UIButton){
        self.selectedEquipNumber = self.inspectedArr[sender.tag].Equipment
        self.openCamera()
    }
    @objc func inspectedArrowAction(sender: UIButton){
        self.moveToOverViewButtonAction(euipmentNo: self.inspectedArr[sender.tag].Equipment)
    }
    @objc func unInspectedCameraAction(sender: UIButton){
        self.selectedEquipNumber = self.unInspectedArr[sender.tag].Equipment
        self.openCamera()
    }
    @objc func unInspectedArrowAction(sender: UIButton){
        self.moveToOverViewButtonAction(euipmentNo: self.unInspectedArr[sender.tag].Equipment)
    }
    @objc func moveToOverViewButtonAction(euipmentNo: String){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = ""
            flocEquipDetails.flocEquipObjText = euipmentNo
            flocEquipDetails.classificationType = "Workorder"
            flocEquipDetails.modalPresentationStyle = .fullScreen
            self.present(flocEquipDetails, animated: false) {}
        }else{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = ""
            flocEquipDetails.flocEquipObjText = euipmentNo
            flocEquipDetails.classificationType = "Workorder"
            myAssetDataManager.uniqueInstance.appendViewControllerToSideMenuStack(mainController: flocEquipDetails, menuType: "Equipment")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func selectedCountLabelUpdate(count: Int){
        if DeviceType == iPhone{
            if assestSegment.selectedSegmentIndex == 0{
                if selectedAssetListArr.count > 0{
                    self.selectedStackView.isHidden = false
                    self.selectedLbl.text = "\(selectedAssetListArr.count)"
                }
                else{
                    self.selectedStackView.isHidden = true
                }
            }
        }
        else{
            if selectedAssetListArr.count > 0{
                self.selectedStackView.isHidden = false
                self.selectedCountLbl.text = "\(selectedAssetListArr.count)"
            }
            else{
                self.selectedStackView.isHidden = true
            }
        }
    }
    //MARK: - Camera & UIImagePickerController Delegate..
    func openCamera() {
        mJCLogger.log("Starting", Type: "info")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            isSupportPortait = true
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                imagePicker.allowsEditing = true
                imagePicker.cameraCaptureMode = .photo
                self.present(imagePicker, animated: false, completion: nil)
            }
        }else {
            mJCLogger.log("There_is_no_camera_available_on_this_device".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:sorrytitle, message: "There_is_no_camera_available_on_this_device".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        mJCLogger.log("Starting", Type: "info")
        isSupportPortait = false
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        mJCLogger.log("Starting", Type: "info")
        isSupportPortait = false
        if #available(iOS 13.0, *){
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentScreen()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy_HHmmss"
            let dateString = dateFormatter.string(from: NSDate() as Date)
            uploadAttachmentVC.fileType = defaultImageType
            attachmentsViewModel.selectedbutton = ""
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            attachmentsViewModel.imagePicked.image = chosenImage
            attachmentsViewModel.imageData = chosenImage.pngData()! as NSData
            uploadAttachmentVC.fileName  = "IMAGE_\(dateString)"
            uploadAttachmentVC.image = chosenImage
            uploadAttachmentVC.attachmentType = "Image"
            uploadAttachmentVC.isFromScreen = "ASSET"
            uploadAttachmentVC.objectNum = self.selectedEquipNumber!
            uploadAttachmentVC.modalPresentationStyle = .fullScreen
            self.dismiss(animated: false, completion: {
                self.present(uploadAttachmentVC, animated: false) {}
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
