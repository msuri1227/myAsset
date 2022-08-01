//
//  SupervisorMapDetailVC.swift
//  myJobCard
//
//  Created by Rover Software on 24/07/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class SupervisorMapDetailVC: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate,GMSMapViewDelegate {
    
    //MARK:- Outlets...
    @IBOutlet var googleMapsView: GMSMapView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var headerView: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var addFolderButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
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
    @IBOutlet var workOrderLocationTypeiImageView: UIImageView!
    @IBOutlet var HomeButton: UIButton!
    @IBOutlet var lastView: UIView!
    @IBOutlet var timeImageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var funLocationLabel: UILabel!
    @IBOutlet var equipementLabel: UILabel!
    @IBOutlet var notificationLabel: UILabel!
    @IBOutlet var notificationImageView: UIImageView!
    @IBOutlet var settingImageView: UIImageView!
    @IBOutlet var distanceview: UIView!
    @IBOutlet var distancelabel: UILabel!
    
    //MARK:- Declared Variables...
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var bounds = GMSCoordinateBounds()
    var destinationMarker: GMSMarker!
    var didFindMyLocation = false
    let earthDistane : Double = 40075.0
    var isFoundLocation = true
    var latitude = String()
    var longitude = String()
    var locationManager: CLLocationManager = CLLocationManager()
    var locationMarker: GMSMarker!
    var selectedMarkerBounds = GMSCoordinateBounds()
    var originlocation = CLLocation()
    var originMarker: GMSMarker!
    var routePolyline: GMSPolyline!
    var totalDistance = Double()
    var travelMode = TravelModes.driving
    var woLat : Double = 0.0
    var woLong : Double = 0.0
    var currentlat : Double = 0.0
    var currentLong : Double = 0.0
    var supMapDetViewModel = SuperMapDetViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        supMapDetViewModel.vc = self
        self.googleMapsView.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }else {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_on_location_services".localized() , button: okay)
        }
        self.supMapDetViewModel.markersShowOnMap()
        NotificationCenter.default.addObserver(self, selector: #selector(SupervisorMapDetailVC.selectWorkOrder(notification:)), name:NSNotification.Name(rawValue:"SelectWorkOrder"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SupervisorMapDetailVC.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SupervisorMapDetailVC.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true{
            if DeviceType == iPad{
                self.refreshButton.showSpin()
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLayoutSubviews() {
        mJCLogger.log("Starting", Type: "info")
        if selectedworkOrderNumber == "" {
            self.bottomView.isHidden = true
        }else {
            self.bottomView.isHidden = false
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:- Notification Methods..
    @objc func selectWorkOrder(notification : NSNotification){
        mJCLogger.log("Starting", Type: "info")
        if notification.object as! String == "selectWorkOrder" {
            DispatchQueue.main.async {
                self.workOrderNumberLabel.text = "\(selectedworkOrderNumber)"
            }
            self.setDataToBottomView()
            self.supMapDetViewModel.markersShowOnMap()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Header Button Actions..
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        mJCLogger.log("Starting", Type: "info")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "FilterWorkOrder"), object: searchTextField.text)
        mJCLogger.log("Ended", Type: "info")
    }
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
            }else if workFlowObj.ActionType == "FORM" || workFlowObj.ActionType == "Form"{
                myAssetDataManager.uniqueInstance.getFormsPage(formDetails: workFlowObj.ActionKey, screen: self, statusCategoryCls: StatusCategoryModel(), formFrom: "")
            }else{
                myAssetDataManager.uniqueInstance.showtoastmsg(actionTitle: alerttitle, msg: "WorkFlowError".localized())
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
            }else {
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
        menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Time_Sheet".localized(),"Master_Data_Refresh".localized(), "Asset_Map".localized(),"Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
        
        imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM"),#imageLiteral(resourceName: "Notifi"),#imageLiteral(resourceName: "timesht"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView"),#imageLiteral(resourceName: "LogOutWithDarkTheme")]
        
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
        menuDataModel.uniqueInstance.presentMenu(menuArr: menuarr, imgArr: imgArray, sender: sender, vc: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func HomeButtonAction(_ sender: Any) {
        menuDataModel.uniqueInstance.presentDashboardScreen()
    }
    
    //MARK:- More Button View Actions..
    @IBAction func moreInfoButtonAction(sender: AnyObject) {
        menuDataModel.uniqueInstance.presentSupervisorSplitScreen(isFromMapScrn: true)
    }
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
                self.timeImageView.image = UIImage(named: "Time")
                if singleWorkOrder.BasicFnshDate != nil{
                    self.timeLabel.text =  singleWorkOrder.BasicFnshDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    self.timeLabel.text = ""
                }
                self.settingImageView.image = UIImage(named: "Settings")
                self.equipementLabel.text = "Eqp#: \(singleWorkOrder.EquipNum)"
                self.funLocationLabel.text = "Func Loc#: \(singleWorkOrder.FuncLocation)"
                self.notificationImageView.image = UIImage(named: "Footer_notification")
                self.notificationLabel.text = singleWorkOrder.NotificationNum
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mJCLogger.log("Starting", Type: "info")
        if (status == CLAuthorizationStatus.denied) {
            print("The user denied authorization")
            mJCLogger.log("The user denied authorization".localized(), Type: "")
        }else if (status == CLAuthorizationStatus.notDetermined) {
            locationManager.requestWhenInUseAuthorization()
            print("NotDetermined Location")
            mJCLogger.log("NotDetermined Location".localized(), Type: "")
        }else if (status == CLAuthorizationStatus.restricted) {
            print("Restricted to use Location")
            mJCLogger.log("Restricted to use Location".localized(), Type: "")
        }else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            print("AuthorizedWhenInUse")
            mJCLogger.log("AuthorizedWhenInUse".localized(), Type: "")
        }else if (status == CLAuthorizationStatus.authorizedAlways) {
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
        NotificationCenter.default.post(name: Notification.Name(rawValue:"refreshTableView"), object: "refreshTableView")
        mJCLogger.log("Ended", Type: "info")
        return false
    }
    //...END...//
}
