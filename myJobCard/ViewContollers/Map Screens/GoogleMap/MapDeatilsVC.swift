//
//  MapDeatilsVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 1/7/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib



class MapDeatilsVC: UIViewController,UIGestureRecognizerDelegate,CLLocationManagerDelegate,GMSMapViewDelegate,UISearchBarDelegate, CustomNavigationBarDelegate, SlideMenuControllerSelectDelegate,filterDelegate{
    
    //MARK:- Outlets...
    @IBOutlet var googleMapsView: GMSMapView!
    
    
    @IBOutlet var searchTextField: UISearchBar!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchInView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet var headerView: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var addFolderButton: UIButton!
    
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var filterCountLbl: UILabel!
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
    
    @IBOutlet weak var totalWorkOrdersLbl: UILabel!
    @IBOutlet var distanceview: UIView!
    @IBOutlet var distancelabel: UILabel!
    @IBOutlet var NoDataView: UIView!
    @IBOutlet var noLabelView: UILabel!
    
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var scanButtonWidthConstraint: NSLayoutConstraint!
    
    //MARK:- Declared Variables...
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var bounds = GMSCoordinateBounds()
    var selectedWoBounds = GMSCoordinateBounds()
    var destinationMarker: GMSMarker!
    var didFindMyLocation = false
    let earthDistane : Double = 40075.0
    var isFromOverView = false
    var isFoundLocation = true
    var latitude = String()
    var longitude = String()
    var locationManager: CLLocationManager = CLLocationManager()
    var locationMarker: GMSMarker!
    var markersArray: Array<GMSMarker> = []
    var originlocation = CLLocation()
    var originMarker: GMSMarker!
    var routePolyline: GMSPolyline!
    var totalDistance = Double()
    var travelMode = TravelModes.driving
    var waypointsArray: Array<String> = []
    var woLat : Double = 0.0
    var woLong : Double = 0.0
    var currentlat : Double = 0.0
    var currentLong : Double = 0.0
    let menudropDown = DropDown()
    var dropDownString = String()
    var workOrderArray = [Any]()
    var workOrderListArray = [Any]()

    var selectedWONumber = String()
    var mapDetailViewModel = MapDetailViewModel()
    var currentWorkOrder = WoHeaderModel()
    var addressDict = NSMutableDictionary()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        mapDetailViewModel.vc = self
        self.googleMapsView.delegate = self
        self.bottomView.isHidden = true
        self.googleMapsView.bringSubviewToFront(bottomView)
        self.searchTextField.delegate = self
        self.workOrderStatusImageView.layer.cornerRadius = self.workOrderStatusImageView.frame.size.width /
            2
        self.workOrderStatusImageView.layer.masksToBounds = true
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        else {
            mJCLogger.log("Please_on_location_services".localized() , Type: "Debug")
            
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_on_location_services".localized() , button: okay)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapDeatilsVC.selectWorkOrder(notification:)), name:NSNotification.Name(rawValue:"SelectWorkOrder"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapDeatilsVC.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapDeatilsVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        
        if DeviceType == iPad {
            
            
            menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                if self.dropDownString == "Menu" {
                    
                    if item == "Work_Orders".localized() {
                        selectedworkOrderNumber = ""
                        currentMasterView = "WorkOrder"
                        UserDefaults.standard.removeObject(forKey: "ListFilter")
                        isfromMapScreen = false
                        let splitVC = ScreenManager.getListSplitScreen()
                        self.appDeli.window?.rootViewController = splitVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }else if item == "Notifications".localized() {
                        selectedworkOrderNumber = ""
                        isfromMapScreen = false
                        currentMasterView = "Notification"
                        UserDefaults.standard.removeObject(forKey: "ListFilter")
                        let splitVC = ScreenManager.getListSplitScreen()
                        self.appDeli.window?.rootViewController = splitVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }else if item == "Time_Sheet".localized() {
                        isfromMapScreen = false
                        selectedworkOrderNumber = ""
                        currentMasterView = "TimeSheet"
                        DispatchQueue.main.async {
                            let timeSheetVC = ScreenManager.getTimeSheetScreen()
                            self.appDeli.window?.rootViewController = timeSheetVC
                            self.appDeli.window?.makeKeyAndVisible()
                        }
                    }else if item == "Master_Data_Refresh".localized() {
                        DispatchQueue.main.async {
                            mJCLoader.startAnimating(status: "Uploading".localized())
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
                            })
                        }
                    }else if item == "Asset_Map".localized() {
                        ASSETMAP_TYPE = "ESRIMAP"
                       assetmapVC.openmappage(id: "")
                    }else if item == "Settings".localized() {
                        let settingsVC = ScreenManager.getSettingsScreen()
                        settingsVC.modalPresentationStyle = .fullScreen
                        self.present(settingsVC, animated: false, completion: nil)
                    }else if item == "Log_Out".localized() {
                        myAssetDataManager.uniqueInstance.logOutApp()
                    }else if item == "Error_Logs".localized() {
                        myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
                    }
                }
            }
        }else {
            self.searchInView.layer.borderWidth = 1.0
            self.searchInView.layer.borderColor = UIColor.lightGray.cgColor
            self.searchInView.layer.masksToBounds = true
            self.filterCountLbl.layer.cornerRadius = self.filterCountLbl.frame.size.width / 2
            self.filterCountLbl.layer.masksToBounds = true
            
            if self.workOrderArray.count > 0 {
                self.totalWorkOrdersLbl.text = "Total_Workorders".localized() + " : \(self.workOrderArray.count)"
            }else{
                self.totalWorkOrdersLbl.text = "Total_Workorders".localized() + " : 0"
            }
            
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Work_Orders".localized(), NewJobButton: true, refresButton: true, threedotmenu: false, leftMenuType: "Menu")
            self.view.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
            updateSlideMenu()
            
            
        }
        if addressPlistPath != nil{
            if myAsset.fileManager.fileExists(atPath: addressPlistPath!.path){
                let data = myAsset.fileManager.contents(atPath: addressPlistPath!.path)
                
                do {
                    let addressList = try PropertyListSerialization.propertyList(from: data!, options: .mutableContainersAndLeaves, format: nil) as! NSMutableDictionary
                    addressDict.addEntries(from: (addressList  as! [AnyHashable : Any]))
                    
                }catch{
                    mJCLogger.log("An error occurred while writing to plist".localized() , Type: "Debug")
                    
                    print("An error occurred while writing to plist")
                }
            }
            
        }
        if fromSupervisorWorkOrder == true {
            self.mapDetailViewModel.getSupervisorsWorkOrderListForMarkers()
        }
        
        if DeviceType != iPad{
            scanButtonWidthConstraint.constant = 0
            scanButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone {
            if self.workOrderArray.count > 0 {
                self.totalWorkOrdersLbl.text = "Total_Workorders".localized() + " : \(self.workOrderArray.count)"
            }else{
                self.totalWorkOrdersLbl.text = "Total_Workorders".localized() + " : 0"
            }
        }
        if flushStatus == true{
            if DeviceType == iPad{
                self.refreshButton.showSpin()
            }
        }
        if DeviceType == iPhone {
            self.updateSlideMenu()
            
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
        mJCLogger.log("Store Flush And Refresh Done..".localized(), Type: "")
        mJCLogger.log("Ended", Type: "info")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Updating slideMenu data make sure data should not mismatch - Rubi-25/11/2019
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone {
            
            workOrderNumberLabel.text = "\(selectedworkOrderNumber)"
            self.setDataToBottomView()
            self.googleMapsView.isHidden = false
            self.bottomView.isHidden = false

            let view = CustomNavHeader_iPhone.init(viewcontroller: self, backButton: true, leftMenu: true, leftTitle: "Work_Orders".localized(), NewJobButton: true, refresButton: true, threedotmenu: false, leftMenuType: "Menu")
            self.view.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
        }

        self.mapDetailViewModel.plotMarkersOnMap()
        mJCLogger.log("Ended", Type: "info")
        
    }
    
    private func updateSlideMenu() {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "MapSplitViewController"
        
        myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Workorder"
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.last
        }
        if isSupervisor == "X" {
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Home".localized(),"Work_Orders".localized(),"Notifications".localized(),"Supervisor_View".localized(),"Team".localized(),"Time_Sheet".localized(),"Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(), "Log_Out".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "TimeSheetSM"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        } else {
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr = ["Home".localized(),"Work_Orders".localized(),"Notifications".localized(),"Time_Sheet".localized(),"Master_Data_Refresh".localized(), "Asset_Map".localized(),"Settings".localized(), "Log_Out".localized()]
            myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr = [#imageLiteral(resourceName: "HomeSM"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "TimeSheetSM"),#imageLiteral(resourceName: "MasterDataRefreshSM"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        }
        if !applicationFeatureArrayKeys.contains("Timesheet"){
            if let index =  myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Time_Sheet".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.firstIndex(of: "Asset_Map".localized()){
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuListArr.remove(at: index)
                myAssetDataManager.uniqueInstance.leftViewController.sideMenuImgArr.remove(at: index)
            }
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    func getroutedetails(lat: String,long:String,WONum:String){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
           
            let array = [[
                "latitude" :  self.currentlat,
                "longitude" :  self.currentLong
                ],[
                    "latitude" : Double(lat)!,
                    "longitude" : Double(long)!
                ]]
            var bounds =  GMSCoordinateBounds()
            var location = CLLocationCoordinate2D()
            for dict1 in array{
                
                location.latitude = dict1["latitude"]!
                location.longitude = dict1["longitude"]!
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                if location.latitude == self.currentlat && location.longitude == self.currentLong {
                    
                    marker.icon = UIImage(named: "ic_user")
                    bounds = bounds.includingCoordinate(marker.position)
                    marker.map = self.googleMapsView
                }else{
                    marker.title = WONum
                    marker.icon = GMSMarker.markerImage(with: mapMarkerColor)
                    bounds = bounds.includingCoordinate(marker.position)
                    marker.map = self.googleMapsView
                    self.googleMapsView.selectedMarker = marker
                }
                
            }
            
            let camera = GMSCameraUpdate.fit(bounds, with:  UIEdgeInsets(top: 100, left: 100, bottom: 220, right: 100))
            self.googleMapsView.animate(with: camera)
            if DeviceType == iPad
            {
                self.distanceview.isHidden = true
            }
            self.woLat = Double(lat)!
            self.woLong = Double(long)!
            self.mapDetailViewModel.createRoute(sourcelat: self.currentlat, sourcelong: self.currentLong, destlat: Double(lat)!, destlong: Double(long)!)
            
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func navigationButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            UIApplication.shared.open(URL(string:
                                            "comgooglemaps://?saddr=&daddr=\(woLat),\(woLong)&directionsmode=driving")!, options: [:], completionHandler: { (success) in
                                            })
        }else{
            UIApplication.shared.open(URL(string:"http://maps.apple.com/maps?saddr=\(currentlat),\(currentLong)&daddr=\(woLat),\(woLong)")!, options: [:], completionHandler: { (success) in
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func filterBtnAction(_ sender: Any){

        let filterVC = ScreenManager.getListFilterScreen()
        filterVC.isfrom = currentMasterView
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "VIEW_WO_FILTER", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                var priorityArray = [String]()
                var ordertypeArray = [String]()
                var statusArray = [String]()
                var plantArray = [String]()
                var createdByArray = [String]()
                var mainWorkCenterArray = [String]()
                var mainPlantGroupArray = [String]()
                var staffIdArr = [String]()
                var maintenancePlantArray = [String]()
                var planningPlantArray = [String]()
                var equipArray = [String]()

                priorityArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.Priority}
                ordertypeArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.OrderType}
                statusArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.MobileObjStatus}
                plantArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.Plant}
                createdByArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.EnteredBy}
                mainWorkCenterArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.MainWorkCtr}
                mainPlantGroupArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.ResponsiblPlannerGrp}
                staffIdArr = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.PersonResponsible}
                maintenancePlantArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.MaintPlant}
                planningPlantArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.MaintPlanningPlant}
                equipArray = (self.workOrderListArray as! [WoHeaderModel]).uniqueValues{$0.EquipNum}

                filterVC.filterViewModel.priorityArray = priorityArray
                filterVC.filterViewModel.typeArray = ordertypeArray
                filterVC.filterViewModel.statusArray = statusArray
                filterVC.filterViewModel.plantsArray = plantArray
                filterVC.filterViewModel.createdByArray = createdByArray
                filterVC.filterViewModel.mainWorkCenterArry = mainWorkCenterArray
                filterVC.filterViewModel.mainPlantGroupListArray = mainPlantGroupArray
                filterVC.filterViewModel.persponseArray = staffIdArr
                filterVC.filterViewModel.maintenancePlantArray = maintenancePlantArray
                filterVC.filterViewModel.planningPlantArray = planningPlantArray
                filterVC.filterViewModel.equipmentArray = equipArray

                filterVC.isfrom = "WorkOrderMAP"
                filterVC.delegate = self
                filterVC.modalPresentationStyle = .fullScreen
                self.present(filterVC, animated: false) {}

            }
        }
    }

    func ApplyFilter(){
        mJCLogger.log("Starting", Type: "info")

        if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
            let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
            if self.workOrderListArray.count>0{
                self.mapDetailViewModel.setWorkorderFilterQuery(dict: dict)
            }
        }else{
            filterCountLbl.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Menu button action
    @IBAction func moreInfoButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")

        isfromMapScreen = true
        currentMasterView = "WorkOrder"
        UserDefaults.standard.removeObject(forKey: "ListFilter")
        
        if DeviceType == iPad {
            let splitVC = ScreenManager.getListSplitScreen()
            self.appDeli.window?.rootViewController = splitVC
            self.appDeli.window?.makeKeyAndVisible()
        }else{
            if self.currentWorkOrder.WorkOrderNum != "" {
                singleWorkOrder = self.currentWorkOrder
            }
            selectedworkOrderNumber = singleWorkOrder.WorkOrderNum
            
            let mainViewController = ScreenManager.getMasterListDetailScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notification deinit..
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLayoutSubviews() {
        mJCLogger.log("Starting", Type: "info")

        if selectedworkOrderNumber == "" {
            bottomView.isHidden = true
        }
        else {
            bottomView.isHidden = false
        }
        mJCLogger.log("Ended", Type: "info")

    }
    
    //MARK:- Notification Methods..
    @objc func selectWorkOrder(notification : NSNotification){
        
        mJCLogger.log("Starting", Type: "info")

        if notification.object as! String == "selectWorkOrder" {
            
            workOrderNumberLabel.text = "\(selectedworkOrderNumber)"
                self.setDataToBottomView()
                self.googleMapsView.isHidden = false
                self.bottomView.isHidden = false
            self.mapDetailViewModel.plotMarkersOnMap()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Header Button Actions..
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        mJCLogger.log("Starting", Type: "info")

        if searchBar.text != "" {
            if DeviceType == iPad {
                
               // NotificationCenter.default.post(name: Notification.Name(rawValue: "FilterWorkOrder"), object: searchTextField.text)
                
            }
            else {
                
//                self.mapDetailViewModel.map_searchTextFieldEditingChanged(searchText: searchTextField.text!)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mJCLogger.log("Starting", Type: "info")

        if DeviceType == iPad {
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "FilterWorkOrder"), object: searchTextField.text)
        }
        else {
                self.mapDetailViewModel.map_searchTextFieldEditingChanged(searchText: searchTextField.text!)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Button Actions
    @IBAction func searchButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")

        if searchTextField.text != "" {
            searchTextField.resignFirstResponder()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "FilterWorkOrder"), object: searchTextField.text)
        }
    }
    
    @IBAction func addFolderButtonAction(sender: AnyObject) {
        
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
                    mJCLogger.log("WorkFlowError".localized() , Type: "Debug")

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
    }
    
    @IBAction func menuButtonAction(sender: AnyObject) {
        
        mJCLogger.log("Starting", Type: "info")

        
        if UIDevice.current.userInterfaceIdiom ==  UIUserInterfaceIdiom.phone {
            self.navigationController?.popViewController(animated: true)
        }
        else {
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
    
    @IBAction func dotMenuButtonAction(sender: AnyObject){
        
        mJCLogger.log("Starting", Type: "info")
        
        var menuarr = [String]()
        var imgArray = [UIImage]()
        
        if isSupervisor == "X"{
            
            if ASSETMAP_TYPE == "ESRIMAP"{
                menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Time_Sheet".localized(), "Master_Data_Refresh".localized(),"Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
                imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM1"),#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "timesht-1"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
                
            }else{
                menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Time_Sheet".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
                imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM1"),#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "timesht-1"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
                
            }
        }else{
            if ASSETMAP_TYPE == "ESRIMAP"{
                menuarr = ["Notifications".localized(), "Time_Sheet".localized(), "Master_Data_Refresh".localized(),"Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
                imgArray = [#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "timesht-1"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
                
            }else{
                menuarr = ["Notifications".localized(), "Time_Sheet".localized(), "Master_Data_Refresh".localized(), "Asset_Map".localized(),"Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
                imgArray = [#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "timesht-1"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
                
            }
        }
        if !applicationFeatureArrayKeys.contains("Timesheet"){
            if let index =  menuarr.firstIndex(of: "Time_Sheet".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
            if let index =  menuarr.firstIndex(of: "Asset_Map".localized()){
                menuarr.remove(at: index)
                imgArray.remove(at: index)
            }
        }
        menudropDown.dataSource = menuarr
        self.customizeDropDown(imgArry: imgArray)
        menudropDown.anchorView = sender as! UIButton
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        
        self.dropDownString = "Menu"
        menudropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    @IBAction func HomeButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")

        
        singleWorkOrder = WoHeaderModel()
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        currentMasterView = "Dashboard"
        let dashboard = ScreenManager.getDashBoardScreen()
        self.appDeli.window?.rootViewController = dashboard
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func listButtonAction(_ sender: Any) {
        
        mJCLogger.log("listButtonAction".localized(), Type: "")

        selectedworkOrderNumber = ""
        currentMasterView = "WorkOrder"
        UserDefaults.standard.removeObject(forKey: "ListFilter")
        isfromMapScreen = false
        let splitVC = ScreenManager.getListSplitScreen()
        self.appDeli.window?.rootViewController = splitVC
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- More Button View Actions..
    
    func setDataToBottomView() {
        mJCLogger.log("Starting", Type: "info")
        if selectedworkOrderNumber != "" {
            
            DispatchQueue.main.async{
                
                self.workOrderNumberLabel.text = singleWorkOrder.WorkOrderNum
                self.PriorityIamgeView.image = myAssetDataManager.getPriorityImage(priority: singleWorkOrder.Priority)
                self.locationImageView.image = UIImage(named: "location_white")
            
                let statuArray = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "X", StatuscCategory: WORKORDER_ASSIGNMENT_TYPE, ObjectType: "X")
                 
                 let arr = statuArray.filter{$0.StatusCode == singleWorkOrder.UserStatus}
                 var imgName = String()
                     if arr.count > 0{
                         imgName = arr[0].ImageResKey
                     }
                     if imgName == "" || imgName == "TBC"{
                         imgName = "MOBI"
                     }
                
                self.workOrderStatusImageView.image = UIImage(named: imgName)
                self.workOrderTypeImageView.image = UIImage(named: "workorderDes")
                self.workOrderdescriptionLabel.text = singleWorkOrder.ShortText
                self.LocationAddressLabel.text = singleWorkOrder.Address
                if DeviceType == iPad {
                    
                    self.timeImageView.image = UIImage(named: "Time")
                    
                    if singleWorkOrder.BasicFnshDate != nil{
                        self.timeLabel.text = singleWorkOrder.BasicFnshDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    }else{
                        self.timeLabel.text = ""
                    }
                    
                    self.settingImageView.image = UIImage(named: "Settings")
                    self.equipementLabel.text = "Eqp".localized() + "#: \(singleWorkOrder.EquipNum)"
                    self.funLocationLabel.text = "Func_Loc".localized() + "#: \(singleWorkOrder.FuncLocation)"
                    self.notificationImageView.image = UIImage(named: "Footer_notification")
                    self.notificationLabel.text = singleWorkOrder.NotificationNum
                    
                }
                
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func customizeDropDown(imgArry: [UIImage]) {
        mJCLogger.log("Starting", Type: "info")
        menudropDown.showImage = true
        menudropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownWithImageCell else { return }
            cell.logoImageView.image = imgArry[index]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mJCLogger.log("Starting", Type: "info")
        if (status == CLAuthorizationStatus.denied) {
            
            print("The user denied authorization")
            
            mJCLogger.log("The user denied authorization".localized(), Type: "")

            
        }
        else if (status == CLAuthorizationStatus.notDetermined) {
            
            locationManager.requestWhenInUseAuthorization()
            print("NotDetermined Location")
            mJCLogger.log("NotDeterminedLocation".localized(), Type: "Error")

            
        }
        else if (status == CLAuthorizationStatus.restricted) {
            
            print("Restricted to use Location")
            
            mJCLogger.log("Restricted to use Location".localized(), Type: "Error")

            
            
        }
        else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            
            locationManager.startUpdatingLocation()
            print("AuthorizedWhenInUse")
            
            mJCLogger.log("AuthorizedWhenInUse".localized(), Type: "")

            
        }
        else if (status == CLAuthorizationStatus.authorizedAlways) {
            
            locationManager.startUpdatingLocation()
            print("AuthorizedAlways")
            mJCLogger.log("AuthorizedAlways".localized(), Type: "")

            
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
    
    //MARK:- GMSMapView Delegate method
    func mapView(_ mapView: GMSMapView!, didTap marker: GMSMarker!) -> Bool {
        
        mJCLogger.log("Starting", Type: "info")
        NotificationCenter.default.post(name: Notification.Name(rawValue:"reloadTableView"), object: "reloadTableView")

        if self.mapDetailViewModel.coOrdinateArr.count != 0 {
            mJCLogger.log("Response:\(self.mapDetailViewModel.coOrdinateArr.count)", Type: "Debug")

            for i in 0..<self.mapDetailViewModel.coOrdinateArr.count {
                
                let workDic = self.mapDetailViewModel.coOrdinateArr[i] as! NSDictionary
                
                let latitudeDob = workDic["Latitude"]
                let longitudeDob = workDic["Longitude"]
                let indexVal = workDic["Index"] as! Int

//                if indexVal == selectedWOIndex {
//                    
//                    self.mapDetailViewModel.createRoute(sourcelat: self.currentlat, sourcelong: self.currentLong, destlat: latitudeDob as! Double, destlong: longitudeDob as! Double)
//                    
//                }

            }
        }
        mJCLogger.log("Ended", Type: "info")
        return false
        
    }
    
    func mapView(_ mapView: GMSMapView!, didTapAt coordinate: CLLocationCoordinate2D) {
        mJCLogger.log("Starting", Type: "info")
        self.bottomView.isHidden = true
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- CustomNavigation Delegate iPhone
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        openLeft()
        mJCLogger.log("Ended", Type: "info")
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
                    mJCLogger.log("WorkFlowError".localized() , Type: "Debug")

                }
             }else{
                mJCLogger.log("Data not found", Type: "Debug")
             }
    }
    
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.refreshDataButtonAction(sender: UIButton())
        mJCLogger.log("Ended", Type: "info")

    }
    
    func SlideMenuSelected(index: Int, title: String,menuType menutype:String){
        mJCLogger.log("Starting", Type: "info")
        if title == "Work_Orders".localized() {
            
            currentMasterView = "WorkOrder"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
            
        }else if title == "Notifications".localized() {
            
            
            currentMasterView = "Notification"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }else if title == "Time_Sheet".localized() {
            
            currentMasterView = "TimeSheet"
            
            let mainViewController = ScreenManager.getTimeSheetScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
            
        }else if title == "Asset_Map".localized() {
//            if DeviceType == iPad{
//               assetmapVC.openmappage(id: "")
//            }else{
//                currentMasterView = "WorkOrder"
//                selectedworkOrderNumber = ""
//                selectedNotificationNumber = ""
//                let assetMapDeatilsVC = ScreenManager.getAssetMapDeatilsScreen()
//                assetMapDeatilsVC.modalPresentationStyle = .fullScreen
//                self.present(assetMapDeatilsVC, animated: true, completion: nil)
//                
//            }
            
        }else if title == "Settings".localized() {

            let settingsVC = ScreenManager.getSettingsScreen()
            self.navigationController?.pushViewController(settingsVC, animated: true)
               
        }else if title == "Master_Data_Refresh".localized() {
           
            mJCLoader.startAnimating(status: "Uploading".localized())
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
            })
            
            
        }else if title == "Log_Out".localized() {
            
            myAssetDataManager.uniqueInstance.logOutApp()
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    func backButtonClicked(_ sender: UIButton?){
        
    }

}

