 //
//  AssetMapDeatilsVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 1/7/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
import ArcGIS

 class AssetMapDeatilsVC: UIViewController,UIGestureRecognizerDelegate,CLLocationManagerDelegate,GMSMapViewDelegate,UISearchBarDelegate,AGSGeoViewTouchDelegate,CustomNavigationBarDelegate,SlideMenuControllerSelectDelegate,filterDelegate {
    
    
    
    //MARK:- Outlets...
    @IBOutlet var EsriMapView: AGSMapView!
    @IBOutlet var searchTextField: UISearchBar!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchInView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet var headerView: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var addFolderButton: UIButton!
    
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet var dotMenuButton: UIButton!
    @IBOutlet var refreshDataButton: UIButton!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var firstView: UIView!
    @IBOutlet var workTypeImageView: UIImageView!
    @IBOutlet var workOrderNumberLabel: UILabel!
    
    @IBOutlet var moreInfoButton: UIButton!
    @IBOutlet var locationImageView: UIImageView!
    @IBOutlet var LocationAddressLabel: UILabel!
    @IBOutlet var workOrderTypeImageView: UIImageView!
    @IBOutlet var workOrderdescriptionLabel: UILabel!
    
    @IBOutlet var middelstatusView: UIView!
    @IBOutlet var PriorityIamgeView: UIImageView!
    @IBOutlet var workOrderStatusImageView: UIImageView!
    
    @IBOutlet var HomeButton: UIButton!
    @IBOutlet var lastView: UIView!
    @IBOutlet var timeImageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var funLocationLabel: UILabel!
    @IBOutlet var equipementLabel: UILabel!
    @IBOutlet var notificationLabel: UILabel!
    @IBOutlet var notificationImageView: UIImageView!
    @IBOutlet var settingImageView: UIImageView!
    @IBOutlet var bottomViewBottomConst: NSLayoutConstraint!
    @IBOutlet var bottomViewHeightConst: NSLayoutConstraint!
    
    @IBOutlet var distanceview: UIView!
    @IBOutlet var distancelabel: UILabel!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var workorderLabel: UILabel!
     @IBOutlet var iPhoneHeader: UIView!
    //MARK:- Declared Variables...
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var locationManager: CLLocationManager = CLLocationManager()
    var locationMarker: GMSMarker!
    var woLat : Double = 0.0
    var woLong : Double = 0.0
    var currentlat : Double = 0.0
    var currentLong : Double = 0.0
    var equipmentNum = String()
    var assetMapDetViewModel = AssetMapDetailViewModel()
    var assetMapMasterViewModel = AssetMapMasterViewModel()
    
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        assetMapDetViewModel.vc = self
        self.assetMapDetViewModel.getassetDetails()
        if DeviceType == iPhone{
            self.assetMapDetViewModel.getWorkOrderList()
            
        }
        self.bottomView.isHidden = true
        if DeviceType == iPhone{
            ODSUIHelper.setBorderToView(view: self.searchInView, borderWidth: 1.0, cornerRadius: 0, borderColor: .lightGray)
            searchTextField.compatibleSearchTextField.backgroundColor = UIColor.white
            searchTextField.setImage(UIImage(), for: .search, state: .normal)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        else {
            mJCLogger.log("Please_on_location_services", Type: "Debug")
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_on_location_services".localized() , button: okay)
        }
        
        self.assetMapDetViewModel.createMarkers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(AssetMapDeatilsVC.selectWorkOrder(notification:)), name:NSNotification.Name(rawValue:"AssetSelectWorkOrder"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AssetMapDeatilsVC.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AssetMapDeatilsVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        
        if DeviceType == iPad {
            workOrderNumberLabel.text = "\(selectedworkOrderNumber)"
        }
        else {
            ODSUIHelper.setBorderToView(view: self.searchInView, borderWidth: 1.0, cornerRadius: 0, borderColor: .lightGray)
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Asset_Map".localized(), NewJobButton: true, refresButton: true, threedotmenu: false,leftMenuType:"Back")
            self.iPhoneHeader.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
        }
        if fromSupervisorWorkOrder == true {
            self.assetMapDetViewModel.getSupervisorWorkOrderList()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func DownloadMapButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.assetMapDetViewModel.downloadMapDetails()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func assetMapFilterScreen(_ sender: Any) {
        menuDataModel.uniqueInstance.presentListFilterScreen(vc: self, isFrm: "ASSETMAP", delegateVC: self)
    }
    func ApplyFilter() {
        if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
            let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
            if dict.keys.contains("assetMap"),let arr = dict["assetMap"] as? [String]{
                self.assetMapDetViewModel.overlay.graphics.removeAllObjects()
                if arr.contains("Point Assets") || arr.contains("Line Assets"){
                    if self.assetMapDetViewModel.localPaths.count == 0{
                        self.assetMapDetViewModel.localPaths = self.assetMapDetViewModel.createGeodatabaseFilePath()
                        self.assetMapDetViewModel.updateFeatureLayer(paths: self.assetMapDetViewModel.localPaths)
                    }else{
                        self.assetMapDetViewModel.updateFeatureLayer(paths: self.assetMapDetViewModel.localPaths)
                    }
                }
                if arr.count == 0 {
                    if self.assetMapDetViewModel.localPaths.count == 0{
                        self.assetMapDetViewModel.localPaths = self.assetMapDetViewModel.createGeodatabaseFilePath()
                        self.assetMapDetViewModel.updateFeatureLayer(paths: self.assetMapDetViewModel.localPaths)
                    }else{
                        self.assetMapDetViewModel.updateFeatureLayer(paths: self.assetMapDetViewModel.localPaths)
                    }
                }
            }
        }
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.refreshDataButtonAction(sender: UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    override  func viewWillAppear(_ animated: Bool) {
        
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true{
            if DeviceType == iPad{
                self.refreshButton.showSpin()
            }
        }
        self.ApplyFilter()
        mJCLogger.log("Ended", Type: "info")
    }
    func featureTable(_ featureTable: AGSFeatureTable, featureQueryDidSucceedWith result: AGSFeatureQueryResult) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            var showPointAsset : Bool = true
            var showLineAsset : Bool? = true
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
                if dict.keys.contains("assetMap"),let arr = dict["assetMap"] as? [String]{
                    self.assetMapDetViewModel.overlay.graphics.removeAllObjects()
                    if arr.contains("Point Assets") && arr.contains("Line Assets"){
                        showPointAsset = true
                        showLineAsset = true
                    }else if arr.contains("Line Assets"){
                        showLineAsset = true
                        showPointAsset = false
                    }else if arr.contains("Point Assets"){
                        showLineAsset = false
                        showPointAsset = true
                    }
                }
            }
            var graphics = [AGSGraphic]()
            var Predicate = NSPredicate()
            Predicate = NSPredicate(format: "SELF.ObjectID == %@",selectedEquipment)
            let FilteredArray = (self.assetMapDetViewModel.assetdetailsArr as NSArray).filtered(using: Predicate)
            var objectid = String()
            if FilteredArray.count > 0{
                let finalval = FilteredArray[0] as! AssetDetailsModel
                objectid = finalval.GISID
                if finalval.LayerRef == "POINT_ASSETS" && showPointAsset == true {
                    let resultss = result.featureEnumerator().allObjects
                    let symbol = AGSSimpleMarkerSymbol(style: .circle, color: .red, size: CGFloat(18))
                    for feature in resultss{
                        let featureobjId = "\(feature.attributes.value(forKey: "OBJECTID")!)"
                        if  featureobjId  == objectid{
                            let grp = AGSGraphic(geometry: feature.geometry, symbol: symbol, attributes: feature.attributes as? [String : Any])
                            self.setbasicData(graphic: grp)
                        }
                    }
                }else if finalval.LayerRef == "LINE_ASSETS" && showLineAsset == true{
                    let symbol = AGSSimpleLineSymbol(style: .solid, color: .blue, width: 3)
                    let resultss = result.featureEnumerator().allObjects
                    for feature in resultss{
                        let featureobjId = "\(String(describing: feature.attributes.value(forKey: "OBJECTID")))"
                        if  featureobjId == objectid{
                            let grp = AGSGraphic(geometry: feature.geometry, symbol: symbol, attributes: feature.attributes as? [String : Any])
                            self.setbasicData(graphic: grp)
                        }
                    }
                }
            }else if FilteredArray.count == 0 && selectedEquipment != ""{
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Can't_found_the_location".localized(), button: okay)
                mJCLogger.log("Can't_found_the_location".localized(), Type: "Debug")
            }
            if featureTable.tableName == "Point_Assets" && showPointAsset == true {
                let symbol = AGSSimpleMarkerSymbol(style: .circle, color: .red, size: CGFloat(18))
                graphics = result.featureEnumerator().map {
                    AGSGraphic(geometry: ($0 as! AGSFeature).geometry, symbol: symbol, attributes: ($0 as! AGSFeature).attributes as? [String : Any])
                }
            }else if featureTable.tableName == "Line_Assets" && showLineAsset == true{
                let symbol = AGSSimpleLineSymbol(style: .solid, color: .blue, width: 3)
                graphics = result.featureEnumerator().map {
                    AGSGraphic(geometry: ($0 as! AGSFeature).geometry, symbol: symbol, attributes: ($0 as! AGSFeature).attributes as? [String : Any])
                }
            }
            self.assetMapDetViewModel.overlay.graphics.addObjects(from: graphics)
            mJCLogger.log("Ended", Type: "info")
        }
    }
    func setbasicData(graphic: AGSGraphic) {
        
        mJCLogger.log("Starting", Type: "info")
        
        var titleStr = String()
        var Predicate = NSPredicate()
        var Number = String()
        var Desc = String()
        var equpNo = String()
        
        if let objectid = graphic.attributes["OBJECTID"]{
            let point = AGSSimpleMarkerSymbol(style: .circle, color: .red, size: CGFloat(18))
            let line = AGSSimpleLineSymbol(style: .solid, color: .blue, width: 3)
            if (graphic.symbol?.isEqual(point))!{
                Predicate = NSPredicate(format: "SELF.GISID == %@ AND SELF.LayerRef == %@","\(objectid)","POINT_ASSETS")
            }else if (graphic.symbol?.isEqual(line))!{
                Predicate = NSPredicate(format: "SELF.GISID == %@ AND SELF.LayerRef == %@","\(objectid)","LINE_ASSETS")
            }
            let FilteredArray = (self.assetMapDetViewModel.assetdetailsArr as NSArray).filtered(using: Predicate)
            if FilteredArray.count > 0{
                if let finalval = FilteredArray[0] as? AssetDetailsModel {
                    titleStr = "\(finalval.ObjectType.lowercased()):\(finalval.ObjectID)"
                    Number = finalval.ObjectID
                    Desc = graphic.attributes["Description"] as! String
                    equpNo = graphic.attributes["Material"] as! String
                }
            }else{
                if let AssetId = graphic.attributes["AssetID"] {
                    titleStr = "Equipement_No".localized() + " :\(AssetId)"
                    Number = AssetId as! String
                    Desc = graphic.attributes["Description"] as! String
                    equpNo = graphic.attributes["Material"] as! String
                }
            }
            self.equipmentNum = Number
            self.moreInfoButton.setTitle("Report_Fault".localized(), for: .normal)
        }
        self.setBottomView(Num: Number, Desc: Desc, time: "", equpNo: equpNo, funloc: "")
        EsriMapView.callout.title = titleStr
        EsriMapView.callout.isAccessoryButtonHidden = true
        EsriMapView.callout.show(for: graphic, tapLocation: graphic.geometry as? AGSPoint, animated: true)
        EsriMapView.callout.width = 200
        self.woLat = 0.0
        self.woLong = 0.0
        graphic.isSelected = true
        graphic.graphicsOverlay?.selectionColor = UIColor.yellow
        self.assetMapDetViewModel.asstpoint = graphic.geometry as? AGSPoint
        
        mJCLogger.log("Ended", Type: "info")
    }
    func featureTable(_ featureTable: AGSFeatureTable, featureQueryDidFailWith error: Error) {
        mJCLogger.log("Reason :\(featureTable.tableName) feature query failed: \(error)", Type: "Error")
        print("\(featureTable.tableName) feature query failed: \(error)")
    }
    
    @IBAction func navigationButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.assetMapDetViewModel.overlay.clearSelection()
        if self.assetMapDetViewModel.routeGraphic != nil{
            self.assetMapDetViewModel.overlay.graphics.remove(self.assetMapDetViewModel.routeGraphic!)
        }
        self.assetMapDetViewModel.createRoute(sourcelat: self.currentlat, sourcelong: self.currentLong, destlat: self.woLat, destlong: self.woLong)
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Menu button action
    @IBAction func moreInfoButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.moreInfoButton.titleLabel?.text == "More_Info".localized() {
            menuDataModel.uniqueInstance.presentListSplitScreen(type: "WorkOrder")
        }
        else if self.moreInfoButton.titleLabel?.text == "Report_Fault".localized() {
            let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
            if let workFlowObj = workFlowResp as? LtWorkFlowModel {
                if workFlowObj.ActionType == "Screen" {
                    menuDataModel.presentCreateJobScreen(vc: self, isFromMap: true, equipNo: equipmentNum)
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func selectWorkOrder(notification : NSNotification){
        mJCLogger.log("Starting", Type: "info")
        if self.assetMapDetViewModel.routeGraphic != nil{
            self.assetMapDetViewModel.overlay.graphics.remove(self.assetMapDetViewModel.routeGraphic!)
        }
        self.assetMapDetViewModel.overlay.clearSelection()
        self.assetMapDetViewModel.createMarkers()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Header Button Actions..
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        mJCLogger.log("Starting", Type: "info")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "FilterWorkOrder"), object: searchTextField.text)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Button Actions
    @IBAction func searchButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        searchTextField.resignFirstResponder()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "FilterWorkOrder"), object: searchTextField.text)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func addFolderButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                menuDataModel.presentCreateJobScreen(vc: self)
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func refreshDataButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func menuButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if UIDevice.current.userInterfaceIdiom ==  UIUserInterfaceIdiom.phone {
            self.navigationController?.popViewController(animated: true)
        }else {
            if isMasterHidden {
                isMasterHidden = false
                splitViewController!.preferredDisplayMode = .automatic
            }
            else {
                isMasterHidden = true
                splitViewController!.preferredDisplayMode = .primaryHidden
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Set form Bg sync started..
    @objc func backGroundSyncStarted(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.showSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.stopAnimating()
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }
        print("Store Flush And Refresh Done..")
        mJCLogger.log("Store Flush And Refresh Done..".localized(), Type: "")
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func dotMenuButtonAction(sender: AnyObject){
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if isSupervisor == "X"{
            if ASSETMAP_TYPE == "ESRIMAP"{
                menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(),"Map".localized(),"Time_Sheet".localized(),"Master_Data_Refresh".localized(), "Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
                imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "timesht"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
            }
        }else{
            if ASSETMAP_TYPE == "ESRIMAP"{
                menuarr = ["Notifications".localized(), "Time_Sheet".localized(),"Map".localized(),"Master_Data_Refresh".localized(), "Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
                imgArray = [#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "timesht"),#imageLiteral(resourceName: "Joblocation"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
            }
        }
        if !applicationFeatureArrayKeys.contains("Timesheet"){
            if let index =  menuarr.firstIndex(of: "Time_Sheet".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        menuDataModel.uniqueInstance.presentMenu(menuArr: menuarr, imgArr: imgArray, sender: sender, vc: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func HomeButtonAction(_ sender: Any) {
        menuDataModel.uniqueInstance.presentDashboardScreen()
    }
    @IBAction func listButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        menuDataModel.uniqueInstance.presentListSplitScreen(type: "WorkOrder")
        mJCLogger.log("Ended", Type: "info")
    }
    func frameToExtent() -> AGSEnvelope {
        mJCLogger.log("Starting", Type: "info")
        let frame = self.EsriMapView.convert(self.EsriMapView.frame, from: self.view)
        let minPoint = self.EsriMapView.screen(toLocation: frame.origin)
        let maxPoint = self.EsriMapView.screen(toLocation: CGPoint(x: frame.origin.x+frame.width, y: frame.origin.y+frame.height))
        let extent = AGSEnvelope(min: minPoint, max: maxPoint)
        mJCLogger.log("Ended", Type: "info")
        return extent
    }
    @IBAction func currentLocationButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.startLocationDisplay(with: AGSLocationDisplayAutoPanMode.recenter)
    }
    func startLocationDisplay(with autoPanMode:AGSLocationDisplayAutoPanMode) {
        mJCLogger.log("Starting", Type: "info")
        self.EsriMapView.locationDisplay.autoPanMode = autoPanMode
        self.EsriMapView.locationDisplay.start { (error:Error?) -> Void in
            //            if let error = error {
            //                self.presentAlert(error: error)
            //                self.sheet.selectedIndex = 0
            //            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- More Button View Actions..
    func setDataToBottomView() {
        mJCLogger.log("Starting", Type: "info")
        if selectedworkOrderNumber != "" {
            DispatchQueue.main.async{
                self.workOrderNumberLabel.text = singleWorkOrder.WorkOrderNum
                self.workOrderdescriptionLabel.text = singleWorkOrder.ShortText
                if DeviceType == iPad{
                    if singleWorkOrder.BasicFnshDate != nil{
                        self.timeLabel.text = singleWorkOrder.BasicFnshDate?.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    }else{
                        self.timeLabel.text = ""
                    }
                    self.funLocationLabel.text = "Func_Loc".localized() + "#: \(singleWorkOrder.FuncLocation)"
                }
                self.equipementLabel.text = "Eqp".localized() + "#: \(singleWorkOrder.EquipNum)"
            }
        }else if selectedNotificationNumber != ""{
            self.workOrderNumberLabel.text = singleNotification.Notification
            self.workOrderdescriptionLabel.text = singleNotification.ShortText
            self.equipementLabel.text = "Eqp".localized() + "#: \(singleNotification.Equipment)"
            if DeviceType == iPad{
                self.timeLabel.text = ""
                self.funLocationLabel.text = "Func_Loc".localized() + "#: \(singleNotification.FunctionalLoc)"
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mJCLogger.log("Starting", Type: "info")
        if (status == CLAuthorizationStatus.denied) {
            mJCLogger.log("The user denied authorization", Type: "Debug")
            print("The user denied authorization")
        } else if (status == CLAuthorizationStatus.notDetermined) {
            locationManager.requestWhenInUseAuthorization()
            mJCLogger.log("NotDetermined Location", Type: "Debug")
        }else if (status == CLAuthorizationStatus.restricted) {
            mJCLogger.log("Restricted to use Location", Type: "Debug")
            print("Restricted to use Location")
        }else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            mJCLogger.log("AuthorizedWhenInUse", Type: "Debug")
        }else if (status == CLAuthorizationStatus.authorizedAlways) {
            locationManager.startUpdatingLocation()
            mJCLogger.log("AuthorizedAlways", Type: "Debug")
            print("AuthorizedAlways")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mJCLogger.log("Starting", Type: "info")
        let lastLocation: CLLocation = locations[locations.count - 1]
        currentlat = lastLocation.coordinate.latitude
        currentLong = lastLocation.coordinate.longitude
        self.locationManager.stopUpdatingLocation()
        mJCLogger.log("Ended", Type: "info")
    }
    
    func showCurrentLocationonEsrimap(){
        mJCLogger.log("Starting", Type: "info")
        self.EsriMapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanMode.compassNavigation
        /* ** ADD ** */
        self.EsriMapView.locationDisplay.start { [weak self] (error:Error?) -> Void in
            if let error = error {
                mJCAlertHelper.showAlert(self!, title: MessageTitle, message: error.localizedDescription, button: okay)
                mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        mJCLogger.log("Starting", Type: "info")
        
        self.assetMapDetViewModel.overlay.clearSelection()
        
        geoView.identify(self.assetMapDetViewModel.overlay, screenPoint: screenPoint, tolerance: 20, returnPopupsOnly: false) { result in
            if let tappedGraphic = result.graphics.first {
                tappedGraphic.isSelected = false
                var titleStr = String()
                var Predicate = NSPredicate()
                var Number = String()
                var Desc = String()
                var time = String()
                var equpNo = String()
                var funloc = String()
                if let WONum = tappedGraphic.attributes["workorder"]{
                    tappedGraphic.isSelected = true
                    tappedGraphic.graphicsOverlay?.selectionColor = UIColor.red
                    titleStr = "Work_Order_No".localized() + " \(WONum)"
                    Predicate = NSPredicate(format: "SELF.WorkOrderNum == %@",WONum as! CVarArg)
                    let FilteredArray = (allworkorderArray as NSArray).filtered(using: Predicate)
                    if FilteredArray.count > 0{
                        if let finalwo = FilteredArray[0] as? WoHeaderModel {
                            Desc = finalwo.ShortText
                            if finalwo.BasicFnshDate != nil{
                                time = finalwo.BasicFnshDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                            }
                            equpNo = "Eqp".localized() + "#: \(finalwo.EquipNum)"
                            funloc = "Func_Loc".localized() + "#: \(finalwo.FuncLocation)"
                        }
                    }
                    Number = WONum as! String
                    
                    for i in 0..<self.assetMapDetViewModel.coOrdinateArr.count {
                        let workDic = self.assetMapDetViewModel.coOrdinateArr[i] as! NSDictionary
                        let latitudeDob = workDic["Latitude"]
                        let longitudeDob = workDic["Longitude"]
                        let workOrderNum = workDic["WorkOrderNumber"] as! String
                        let notificationNum = workDic["Notification"]
                        let indexVal = workDic["Index"] as! Int
                        if workOrderNum == selectedworkOrderNumber {
                            self.assetMapDetViewModel.createRoute(sourcelat: self.currentlat, sourcelong: self.currentLong, destlat: latitudeDob as! Double, destlong: longitudeDob as! Double)
                        }
                    }
                }else if let NOnum = tappedGraphic.attributes["Notification"]{
                    tappedGraphic.isSelected = true
                    tappedGraphic.graphicsOverlay?.selectionColor = UIColor.red
                    titleStr = "Notification_No".localized() + " \(NOnum)"
                    Number = NOnum as! String
                    let FilteredArray = (self.assetMapDetViewModel.notificationListArr as! [NotificationModel]).filter{$0.Notification == "\(NOnum)"}
                    if FilteredArray.count > 0{
                        let finalNo = FilteredArray[0]
                        Desc = finalNo.ShortText
                        equpNo = "Eqp".localized() + "#: \(finalNo.Equipment)"
                        funloc = "Func_Loc".localized() + "#: \(finalNo.FunctionalLoc)"
                    }
                    for i in 0..<self.assetMapDetViewModel.coOrdinateArr.count {
                        let workDic = self.assetMapDetViewModel.coOrdinateArr[i] as! NSDictionary
                        let latitudeDob = workDic["Latitude"]
                        let longitudeDob = workDic["Longitude"]
                        let workOrderNum = workDic["WorkOrderNumber"] as! String
                        let notificationNum = workDic["Notification"] as! String
                        let indexVal = workDic["Index"] as! Int
                        if notificationNum == selectedNotificationNumber {
                            self.assetMapDetViewModel.createRoute(sourcelat: self.currentlat, sourcelong: self.currentLong, destlat: latitudeDob as! Double, destlong: longitudeDob as! Double)
                        }
                    }
                }else if let objectid = tappedGraphic.attributes["OBJECTID"]{
                    tappedGraphic.isSelected = true
                    tappedGraphic.graphicsOverlay?.selectionColor = UIColor.yellow
                    let point = AGSSimpleMarkerSymbol(style: .circle, color: .red, size: CGFloat(18))
                    let line = AGSSimpleLineSymbol(style: .solid, color: .blue, width: 3)
                    if (tappedGraphic.symbol?.isEqual(point))!{
                        Predicate = NSPredicate(format: "SELF.GISID == %@ AND SELF.LayerRef == %@","\(objectid)","POINT_ASSETS")
                    }else if (tappedGraphic.symbol?.isEqual(line))!{
                        Predicate = NSPredicate(format: "SELF.GISID == %@ AND SELF.LayerRef == %@","\(objectid)","LINE_ASSETS")
                    }
                    let FilteredArray = (self.assetMapDetViewModel.assetdetailsArr as NSArray).filtered(using: Predicate)
                    if FilteredArray.count > 0{
                        if let finalval = FilteredArray[0] as? AssetDetailsModel {
                            titleStr = "\(finalval.ObjectType.lowercased()):\(finalval.ObjectID)"
                            Number = finalval.ObjectID
                            Desc = tappedGraphic.attributes["Description"] as! String
                            equpNo = tappedGraphic.attributes["Material"] as! String
                        }
                    }else{
                        if let AssetId = tappedGraphic.attributes["AssetID"] {
                            titleStr = "Equipement_No".localized() + " :\(AssetId)"
                            Number = AssetId as! String
                            Desc = tappedGraphic.attributes["Description"] as! String
                            equpNo = tappedGraphic.attributes["Material"] as! String
                        }
                    }
                    self.equipmentNum = Number
                    self.moreInfoButton.setTitle("Report_Fault".localized(), for: .normal)
                    self.woLat = 0.0
                    self.woLong = 0.0
                    self.assetMapDetViewModel.asstpoint = mapPoint
                }else{
                    geoView.callout.dismiss()
                    mJCLogger.log("Ended", Type: "info")
                    return
                }
                self.setBottomView(Num: Number, Desc: Desc, time: time, equpNo: equpNo, funloc: funloc)
                geoView.callout.title = titleStr
                geoView.callout.isAccessoryButtonHidden = true
                geoView.callout.show(for: tappedGraphic, tapLocation: mapPoint, animated: true)
                geoView.callout.width = 200
                NotificationCenter.default.post(name: Notification.Name(rawValue:"reloadWorkOrderTableView"), object: "reloadWorkOrderTableView")
                
            } else {
                geoView.callout.dismiss()
                self.bottomView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func setBottomView(Num: String,Desc:String,time:String,equpNo:String,funloc:String){
        mJCLogger.log("Starting", Type: "info")
        UIView.transition(with: self.view, duration: 0.9, options: .transitionCrossDissolve, animations: {
            self.bottomView.isHidden = false
        })
        workOrderNumberLabel.text = Num
        self.workOrderdescriptionLabel.text = Desc
        if DeviceType == iPad{
            self.timeLabel.text = time
            self.funLocationLabel.text = funloc
        }
        self.equipementLabel.text = equpNo
        mJCLogger.log("Ended", Type: "info")
        
    }
    //MARK:- CustomNavigation
    func leftMenuButtonClicked(_ sender: UIButton?) {
        mJCLogger.log("Starting", Type: "info")
        selectedEquipment = String()
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        menuDataModel.presentCreateJobScreen(vc: self)
        mJCLogger.log("Ended", Type: "info")
    }
    //Filter Button Action
    @IBAction func filterButtonAction(sender: AnyObject) {
        menuDataModel.uniqueInstance.presentListFilterScreen(vc: self, isFrm: "ASSETMAP", delegateVC: self)
    }
    func backButtonClicked(_ sender: UIButton?){
        
    }
 }
