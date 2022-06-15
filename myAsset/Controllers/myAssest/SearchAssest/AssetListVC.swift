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

class AssetListVC: UIViewController,viewModelDelegate,CLLocationManagerDelegate,CustomNavigationBarDelegate, FuncLocEquipSelectDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var assetTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var selectedLbl: UILabel!
    @IBOutlet weak var selectedStackView: UIStackView!
    @IBOutlet var printTagButton: UIButton!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var navHeaderView = CustomNavHeader_iPhone()
    let menudropDown = DropDown()
    var searchParam = Dictionary<String,Any>()
    var assetSearchVM = AssetSearchViewModel()
    var selectedArr = [EquipmentModel]()
    var locationManager: CLLocationManager = CLLocationManager()
    var currentlat : Double = 0.0
    var currentLong : Double = 0.0
    var selectedFloc = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.assetTableView.delegate = self
        self.assetTableView.dataSource = self
        assetSearchVM.delegate = self
        assetSearchVM.searchParams = self.searchParam
        assetSearchVM.getAssetList()
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
        navHeaderView = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: false, leftMenu: true, leftTitle: "Asset List", NewJobButton: true, refresButton: true, threedotmenu: true, leftMenuType: "Back")
        self.view.addSubview(navHeaderView)
        if flushStatus == true{
            self.navHeaderView.refreshBtn.showSpin()
        }
        self.navHeaderView.delegate = self
        self.viewWillAppear(true)
    }
    
    @IBAction func printTagButtonAction(_ sender: Any) {
        print("mk")
    }
    //MARK: - Table view delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.assetSearchVM.assetList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScreenManager.getInspectedCell(tableView: tableView)
        if self.assetSearchVM.assetList.indices.contains(indexPath.row){
            let equipment = self.assetSearchVM.assetList[indexPath.row]
            cell.assetListCellModel = equipment
            if self.selectedArr.contains(equipment){
                cell.checkBoxImgView.image = UIImage(named: "ic_check_fill")
            }else{
                cell.checkBoxImgView.image = UIImage(named: "ic_check_nil")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.assetSearchVM.assetList[indexPath.row]
        if !selectedArr.contains(item){
            selectedArr.append(item)
        }else{
            if let index = self.selectedArr.index(of: item){
                selectedArr.remove(at: index)
            }
        }
        DispatchQueue.main.async {
            self.selectedLbl.text = "\(self.selectedArr.count)"
            self.assetTableView.reloadData()
            if self.selectedArr.count > 0{
                self.printTagButton.isHidden = false
            }else{
                self.printTagButton.isHidden = true
            }
        }
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "assetList"{
            DispatchQueue.main.async {
                self.totalLbl.text = "\(self.assetSearchVM.assetList.count)"
                self.assetTableView.reloadData()
            }
        }
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.selectedArr.removeAll()
        assetTableView.reloadData()
        self.selectedLbl.text = ""
    }
    func leftMenuButtonClicked(_ sender: UIButton?){
        self.dismiss(animated: false) {}
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
        menuarr = ["Update_Geo_Location".localized(),"Update_Functional_Location".localized()]
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
                    mJCAlertHelper.showAlert(title: alerttitle, message: "", button: okay)
                }else{
                    self.assetSearchVM.updateGeoLocation(list: selectedArr, currentLoc: "x:\(self.currentlat),y:\(self.currentLong)", count: 0)
                }
            }else if item == "Update_Functional_Location".localized(){
                if selectedArr.count == 0{
                    mJCAlertHelper.showAlert(title: alerttitle, message: "", button: okay)
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
        }
    }
    func FuncLocOrEquipSelected(selectedObj:String,EquipObj:EquipmentModel,FuncObj:FunctionalLocationModel){
        print("mj")
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
}