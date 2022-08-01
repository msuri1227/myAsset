//
//  AssetMapDetailViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation
import ArcGIS


class AssetMapDetailViewModel {
    
    var vc : AssetMapDeatilsVC!
    let overlay = AGSGraphicsOverlay()
    var routeTask : AGSRouteTask?
    var routeParameters : AGSRouteParameters?
    var routeGraphic : AGSGraphic?
    var selectedWo : AGSGraphic?
    var workOrdersListArr = [Any]()
    var notificationListArr = [Any]()
    let ponitSUrl = "https://services7.arcgis.com/MaZxgL04O7KLTOGI/arcgis/rest/services/Point_Assets/FeatureServer/"
    let LinesUrl = "https://services7.arcgis.com/MaZxgL04O7KLTOGI/arcgis/rest/services/Line_Assets/FeatureServer/"
    let tiledURL = "https://tiledbasemaps.arcgis.com/arcgis/rest/services/World_Street_Map/MapServer"
    var localPaths = [String]()
    var localGDBs = [AGSGeodatabase]()
    var featureServiceURLs = [String]()
    var featureLayers = [AGSFeatureLayer]()
    var gdbtask : AGSGeodatabaseSyncTask?
    var generateJob:AGSGenerateGeodatabaseJob!
    var generatedGeodatabase:AGSGeodatabase!
    var assetdetailsArr = [AssetDetailsModel]()
    var asstpoint : AGSPoint?
    let dir = "ArcGIS/geoDB/"
    let BaseDir = "ArcGIS/BaseMap/"
    var parameters:AGSGenerateOfflineMapParameters?
    var offlineMapTask:AGSOfflineMapTask?
    var generateOfflineMapJob:AGSGenerateOfflineMapJob?
    var tiledLayer:AGSArcGISTiledLayer?
    var exportTask:AGSExportTileCacheTask!
    var job:AGSExportTileCacheJob!
    var coOrdinateArr = NSMutableArray()
    
    func getSupervisorWorkOrderList() {
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getSuperVisorWorkorderList(){ (responseDict, error)  in
            if error == nil {
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.workOrdersListArr.removeAll()
                        self.workOrdersListArr = responseArr
                        self.createMarkers()
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else {
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func downloadMapDetails(){
        
        mJCLogger.log("Starting", Type: "info")
        if CLLocationManager.locationServicesEnabled() {
            let val = self.tiledLayer?.maxScale
            if val != nil || val == 0.0  {
                mJCLoader.startAnimating(status: "Downloading".localized())
                self.exportTask = AGSExportTileCacheTask(url: URL(string:"https://tiledbasemaps.arcgis.com/arcgis/rest/services/World_Street_Map/MapServer")!)
                self.exportTask.credential = AGSCredential(user: "shubham211", password: "sknsl@11")
                self.exportTask.exportTileCacheParameters(withAreaOfInterest: self.vc.frameToExtent(), minScale: self.vc.EsriMapView.mapScale, maxScale: self.tiledLayer!.maxScale) { [weak self] (params: AGSExportTileCacheParameters?, error: Error?) in
                    if let error = error {
                        print("\(error)")
                        mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                        mJCLoader.stopAnimating()
                    }else{
                        self?.exportTilesUsingParameters(params!)
                    }
                }
            }else {
                mJCLogger.log("Please_on_location_services".localized(), Type: "Warn")
                mJCAlertHelper.showAlert(self.vc, title: alerttitle, message: "Please_on_location_services".localized() , button: okay)
            }
        }else {
            mJCLogger.log("Please_on_location_services".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self.vc, title: alerttitle, message: "Please_on_location_services".localized() , button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getassetDetails(){
        mJCLogger.log("Starting", Type: "info")
        AssetDetailsModel.getassetDetailsList(filterQuery: ""){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [AssetDetailsModel]{
                    self.assetdetailsArr = responseArr
                }
            }else{
                mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- ESRI MAP Functions
    func createGeodatabaseFilePath() -> [String]{
        
        mJCLogger.log("Starting", Type: "info")
        if !self.featureServiceURLs.contains(ponitSUrl){
            self.featureServiceURLs.append(ponitSUrl)
        }
        if !self.featureServiceURLs.contains(LinesUrl){
            self.featureServiceURLs.append(LinesUrl)
        }
        var pathArray = [String]()
        let urls = myAsset.fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = urls[urls.count - 1] as URL
        let dirPath = documentDirectoryURL.appendingPathComponent(self.dir)
        if myAsset.fileManager.fileExists(atPath: dirPath.path) == false{
            do{
                try myAsset.fileManager.createDirectory(at: dirPath,   withIntermediateDirectories: true, attributes: nil)
                
            }catch let error as NSError{
                mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                print("Error while creating Folder \(error.localizedDescription)")
            }
        }else{
            mJCLogger.log("Directory Created", Type: "Debug")
        }
        for i in 0..<self.featureServiceURLs.count {
            let pathUrl = dirPath.appendingPathComponent("ODS_GeoDB_\(i).geodatabase")
            pathArray.append("\(pathUrl)")
            if myAsset.fileManager.fileExists(atPath: pathUrl.path) == false {
                let status = myAsset.fileManager.createFile(atPath: pathUrl.path, contents: nil, attributes: nil)
                if status == true{
                    //print("ODS_GeoDB_\(i).geodatabase created")
                }else{
                    // print("Error in creating ODS_GeoDB_\(i).geodatabase")
                }
            }else{
                // print("ODS_GeoDB_\(i).geodatabase exists")
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return pathArray
    }
    func updateFeatureLayer(paths: Array<String>){
        mJCLogger.log("Starting", Type: "info")
        var localDb : AGSGeodatabase?
        localGDBs.removeAll()
        for path in paths{
            localDb = AGSGeodatabase.init(fileURL:  URL(string: path)!)
            localGDBs.append(localDb!)
        }
        if let val = UserDefaults.standard.value(forKey: "featursDownloaded"){
            let featurestatus = val as? String
            if featurestatus == "YES"{
                for i in 0..<localGDBs.count{
                    let geodb = localGDBs[i]
                    geodb.load { [weak self] (error:Error?) -> Void in
                        if let error = error {
                            mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                        }else {
                            self?.vc.EsriMapView.map?.operationalLayers.removeAllObjects()
                            AGSLoadObjects(geodb.geodatabaseFeatureTables) { (success: Bool) in
                                if success {
                                    for featureTable in geodb.geodatabaseFeatureTables.reversed(){
                                        if featureTable.hasGeometry {
                                            let populationQuery = AGSQueryParameters()
                                            populationQuery.whereClause = "AssetID not LIKE ' '"
                                            populationQuery.geometry = self?.vc.EsriMapView.currentViewpoint(with: .boundingGeometry)?.targetGeometry
                                            featureTable.queryFeatures(with: populationQuery) { [weak self] (result, error) in
                                                if let result = result {
                                                    self?.vc.featureTable(featureTable, featureQueryDidSucceedWith: result)
                                                } else if let error = error {
                                                    mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                                                    self?.vc.featureTable(featureTable, featureQueryDidFailWith: error)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }else{
                if featureServiceURLs.count > 0 && localPaths.count > 0 {
                    self.getfeatureServerInfo(serviceURl: featureServiceURLs[0], LocalPath: localPaths[0])
                }
            }
        }else{
            if featureServiceURLs.count > 0 && localPaths.count > 0 {
                self.getfeatureServerInfo(serviceURl: featureServiceURLs[0], LocalPath: localPaths[0])
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getfeatureServerInfo(serviceURl :String, LocalPath:String){
        
        mJCLogger.log("Starting", Type: "info")
        self.gdbtask = AGSGeodatabaseSyncTask.init(url: URL(string: serviceURl)!)
        self.gdbtask?.load { [weak self] (error) -> Void in
            if let error = error {
                mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
            } else {
                guard let weakSelf = self else {
                    return
                }
                if (weakSelf.gdbtask?.featureServiceInfo?.isSyncEnabled) == true{
                    self?.DownloadFeaturedataToOffline(featureServiceInfo: (weakSelf.gdbtask?.featureServiceInfo)!, filePath: LocalPath)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func DownloadFeaturedataToOffline(featureServiceInfo: AGSArcGISFeatureServiceInfo,filePath: String){
        
        mJCLogger.log("Starting", Type: "info")
        
        self.gdbtask?.defaultGenerateGeodatabaseParameters(withExtent: self.vc.frameToExtent()) { [weak self] (params: AGSGenerateGeodatabaseParameters?, error: Error?) in
            if let params = params, let weakSelf = self {
                params.returnAttachments = false
                weakSelf.generateJob = weakSelf.gdbtask?.generateJob(with: params, downloadFileURL: URL(string: filePath)!)
                weakSelf.generateJob.start(statusHandler: { (status: AGSJobStatus) -> Void in
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
                        mJCLoader.startAnimating(status: "Downloading".localized())
                    }
                }){ [weak self] (object: AnyObject?, error: Error?) -> Void in
                    if let error = error {
                        mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                        mJCAlertHelper.showAlert((self?.vc)!, title: alerttitle, message: "\(error)", button: okay)
                    }else {
                        DispatchQueue.main.async{
                            mJCLoader.stopAnimating()
                            if ((object as? AGSGeodatabase)?.fileURL.lastPathComponent.contains(find: "ODS_GeoDB_0"))!{
                                self?.getfeatureServerInfo(serviceURl: (self?.featureServiceURLs[1])!, LocalPath: (self?.localPaths[1])!)
                            }else{
                                UserDefaults.standard.setValue("YES", forKey: "featursDownloaded")
                                self?.updateFeatureLayer(paths: (self?.localPaths)!)
                            }
                        }
                    }
                }
            }else{
                print("Could not generate default parameters : \(error)")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createEsriMapView(){
        
        mJCLogger.log("Starting", Type: "info")
        let urls = myAsset.fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = urls[urls.count - 1] as URL
        let dirPath = documentDirectoryURL.appendingPathComponent(self.BaseDir)
        let pathUrl = dirPath.appendingPathComponent("ODS_BaseMap.tpk")
        let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
        
        DispatchQueue.main.async {
            if result == "ServerUp"{
                self.vc.EsriMapView.graphicsOverlays.add(self.overlay)
                self.tiledLayer = AGSArcGISTiledLayer(url: URL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer")!)
                let map = AGSMap(basemap: AGSBasemap(baseLayer: self.tiledLayer!))
                self.vc.EsriMapView.map = map
            }else{
                if myAsset.fileManager.fileExists(atPath: pathUrl.path) == true {
                    let tileCache = AGSTileCache.init(fileURL: pathUrl)
                    let localTiledLayer = AGSArcGISTiledLayer(tileCache: tileCache)
                    let map = AGSMap(basemap: AGSBasemap(baseLayer: localTiledLayer))
                    self.vc.EsriMapView.map = map
                }
            }
        }
        self.vc.EsriMapView.touchDelegate = self.vc
        localPaths = self.createGeodatabaseFilePath()
        self.updateFeatureLayer(paths: localPaths)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Markers and Route
    func createMarkers() {
        
        mJCLogger.log("Starting", Type: "info")
        self.overlay.clearSelection()
        self.overlay.graphics.removeAllObjects()
        self.createEsriMapView()
        coOrdinateArr = NSMutableArray()
        if currentMasterView == "Notification" {
            if self.notificationListArr.count != 0 {
                coOrdinateArr = myAssetDataManager.uniqueInstance.getLocationDetailsForWorkOrders(Arr: self.notificationListArr)
            }
        }else {
            coOrdinateArr = myAssetDataManager.uniqueInstance.getLocationDetailsForWorkOrders(Arr: self.workOrdersListArr)
        }
        if coOrdinateArr.count > 0{
            for j in 0..<coOrdinateArr.count {
                let workDic = coOrdinateArr[j] as! NSDictionary
                let latitudeDob = workDic["Latitude"]
                let longitudeDob = workDic["Longitude"]
                let workOrderNum = workDic["WorkOrderNumber"] as! String
                let notificationNum = workDic["Notification"] as! String
                let indexVal = workDic["Index"] as! Int
                var graphic = AGSGraphic()
                if currentMasterView == "Notification" {
                    graphic = AGSGraphic(geometry:AGSPointMakeWGS84( latitudeDob as! Double,  longitudeDob as! Double),symbol: AGSPictureMarkerSymbol.init(image: UIImage(named: "ic_notification")!),attributes: ["Notification": notificationNum])
                    if selectedNotificationNumber == notificationNum {
                        graphic.isSelected = true
                        self.vc.bottomView.isHidden = false
                        self.createRoute(sourcelat: self.vc.currentlat, sourcelong: self.vc.currentLong, destlat:latitudeDob as! Double , destlong: longitudeDob as! Double)
                    }else {
                        graphic.isSelected = false
                    }
                }else {
                    graphic = AGSGraphic(geometry:AGSPointMakeWGS84( latitudeDob as! Double,  longitudeDob as! Double),symbol: AGSPictureMarkerSymbol.init(image: UIImage(named: "ic_WoBrief")!),
                                         attributes: ["workorder": workOrderNum])
                    if selectedworkOrderNumber == workOrderNum {
                        graphic.isSelected = true
                        DispatchQueue.main.async {
                            self.vc.bottomView.isHidden = false
                        }
                        self.vc.setDataToBottomView()
                        self.createRoute(sourcelat: self.vc.currentlat, sourcelong: self.vc.currentLong, destlat:latitudeDob as! Double , destlong: longitudeDob as! Double)
                    }else {
                        graphic.isSelected = false
                    }
                }
                graphic.zIndex = indexVal
                self.overlay.graphics.add(graphic)
            }
            var currentGraphic = AGSGraphic()
            currentGraphic = AGSGraphic(geometry:AGSPointMakeWGS84( self.vc.currentlat ,  self.vc.currentLong ),symbol: AGSPictureMarkerSymbol.init(image: UIImage(named: "ic_user")!),attributes: ["workorder": "You are here"])
            self.overlay.graphics.add(currentGraphic)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createRoute(sourcelat : Double,sourcelong : Double,destlat : Double,destlong:Double){
        
        mJCLogger.log("Starting", Type: "info")
        if ASSETMAP_TYPE == "ESRIMAP"{
            mJCLoader.startAnimating(status: "Loading_Directions".localized())
            self.routeTask = AGSRouteTask(url: URL(string: "http://route.arcgis.com/arcgis/rest/services/World/Route/NAServer/Route_World")!)
            self.routeTask?.credential = AGSCredential(user: "shubham211", password: "sknsl@11")
            self.routeTask?.load {[weak self] (error) in
                if let error = error {
                    mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                    mJCLoader.stopAnimating()
                    return
                }
                if (self?.routeTask?.loadStatus == .loaded) {
                    self?.routeTask?.defaultRouteParameters { [weak self] (params: AGSRouteParameters?, error: Error?) -> Void in
                        if let error = error {
                            mJCLoader.stopAnimating()
                            return
                        }
                        guard let parameters = params else {return}
                        parameters.outputSpatialReference = AGSSpatialReference.wgs84()
                        parameters.returnStops = true
                        parameters.returnDirections = true
                        self?.routeParameters = parameters
                        let stop1Point = AGSPointMakeWGS84(sourcelat,  sourcelong)
                        let stop1 = AGSStop(point: stop1Point)
                        stop1.name = "Origin"
                        var stop2Point : AGSPoint?
                        if destlat == 0.0 && destlong == 0.0{
                            if self?.asstpoint != nil {
                                stop2Point = self?.asstpoint
                            }else {
                                stop2Point = AGSPointMakeWGS84( destlat,  destlong)
                            }
                        }else{
                            stop2Point = AGSPointMakeWGS84( destlat,  destlong)
                        }
                        let stop2 = AGSStop(point: stop2Point!)
                        stop2.name = "Destination"
                        self?.routeParameters?.setStops([stop1, stop2])
                        self?.routeTask?.solveRoute(with: (self?.routeParameters!)!) { [weak self] (routeResult: AGSRouteResult?, error: Error?) -> Void in
                            if let error = error {
                                mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                                mJCLoader.stopAnimating()
                                let point = AGSPointMakeWGS84(destlat, destlong)
                                mJCAlertHelper.showAlert(self!.vc, title: MessageTitle, message: "Unable_to_find_the_route".localized(), button: okay)
                                UIView.animate(withDuration: 5) {
                                    let currentScale = self?.vc.EsriMapView.mapScale
                                    let targetScale = currentScale! / 2.5 // zoom in
                                    let currentCenter = self?.vc.EsriMapView.visibleArea!.extent.center
                                    self?.vc.EsriMapView.setViewpoint(AGSViewpoint(center: currentCenter!, scale: targetScale), duration: 5, curve: AGSAnimationCurve.easeInOutSine) { (finishedWithoutInterruption) in
                                        if finishedWithoutInterruption {
                                            self?.vc.EsriMapView.setViewpoint(AGSViewpoint(center: point, scale: currentScale!), duration: 5, curve: .easeInOutSine)
                                        }
                                    }
//                                    self?.vc.EsriMapView.setViewpointCenter(point, scale: 20000.0, completion: nil)
                                }
                            }else {
                                if self?.routeGraphic != nil{
                                    self?.overlay.graphics.remove(self?.routeGraphic! as Any)
                                }
                                guard let routeResult = routeResult else {return}
                                let route = routeResult.routes[0]
                                let routeSymbol = AGSSimpleLineSymbol(style: .solid, color: UIColor.purple, width: 5)
                                self?.routeGraphic = AGSGraphic(geometry: route.routeGeometry, symbol: routeSymbol, attributes: nil)
                                self?.overlay.graphics.add(self?.routeGraphic! as Any)
                                let point = AGSPointMakeWGS84(sourcelat, sourcelong)
                                DispatchQueue.main.async{
                                    UIView.animate(withDuration: 5) {
                                        let currentScale = self?.vc.EsriMapView.mapScale
                                        let targetScale = currentScale! / 2.5 // zoom in
                                        let currentCenter = self?.vc.EsriMapView.visibleArea!.extent.center
                                        self?.vc.EsriMapView.setViewpoint(AGSViewpoint(center: currentCenter!, scale: targetScale), duration: 5, curve: AGSAnimationCurve.easeInOutSine) { (finishedWithoutInterruption) in
                                            if finishedWithoutInterruption {
                                                self?.vc.EsriMapView.setViewpoint(AGSViewpoint(center: point, scale: currentScale!), duration: 5, curve: .easeInOutSine)
                                            }
                                        }
//                                        self?.vc.EsriMapView.setViewpointCenter(point, scale: 20000.0, completion: nil)
                                    }
                                }
                                mJCLoader.stopAnimating()
                            }
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createBaseMapPath()->URL{
        
        mJCLogger.log("Starting", Type: "info")
        let urls = myAsset.fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = urls[urls.count - 1] as URL
        let dirPath = documentDirectoryURL.appendingPathComponent(self.BaseDir)
        if myAsset.fileManager.fileExists(atPath: dirPath.path) == false{
            do{
                try myAsset.fileManager.createDirectory(at: dirPath,   withIntermediateDirectories: true, attributes: nil)
                
            }catch let error as NSError{
                
                print("Error while creating Folder \(error.localizedDescription)")
            }
        }
        let pathUrl = dirPath.appendingPathComponent("ODS_BaseMap.tpk")
        if myAsset.fileManager.fileExists(atPath: pathUrl.path) == false {
            let status = myAsset.fileManager.createFile(atPath: pathUrl.path, contents: nil, attributes: nil)
            if status == true{
                print("ODS_ODS_BaseMap created")
            }else{
                print("Error in creating ODS_ODS_BaseMap")
            }
        }else{
            print("ODS_ODS_BaseMap exists")
        }
        mJCLogger.log("Ended", Type: "info")
        return pathUrl
    }
    func getEsriMapRouteDetails(lat: String,long:String,WONum:String){
        
        mJCLogger.log("Starting", Type: "info")
        let graphic = AGSGraphic(geometry:AGSPointMakeWGS84(self.vc.currentlat, self.vc.currentLong),
                                 symbol: AGSPictureMarkerSymbol.init(image: UIImage(named: "map_avatar")!),
                                 attributes: ["workorder": "You are here"])
        self.overlay.graphics.add(graphic)
        self.overlay.clearSelection()
        self.selectedWo = AGSGraphic(geometry:AGSPointMakeWGS84(Double(lat)!, Double(long)!), symbol: AGSPictureMarkerSymbol.init(image: UIImage(named: "ic_WoBrief")!),attributes: ["workorder": WONum])
        self.selectedWo?.isSelected = true
        self.overlay.selectionColor = UIColor.red
        self.overlay.graphics.add(self.selectedWo!)
        let point = AGSPointMakeWGS84(Double(lat)!, Double(long)!)
        UIView.animate(withDuration: 5) {
            let currentScale = self.vc.EsriMapView.mapScale
            let targetScale = currentScale / 2.5 // zoom in
            let currentCenter = self.vc.EsriMapView.visibleArea!.extent.center
            self.vc.EsriMapView.setViewpoint(AGSViewpoint(center: currentCenter, scale: targetScale), duration: 5, curve: AGSAnimationCurve.easeInOutSine) { (finishedWithoutInterruption) in
                if finishedWithoutInterruption {
                    self.vc.EsriMapView.setViewpoint(AGSViewpoint(center: point, scale: currentScale), duration: 5, curve: .easeInOutSine)
                }
            }
//            self.vc.EsriMapView.setViewpointCenter(point, completion: nil)
        }
        self.createRoute(sourcelat: self.vc.currentlat, sourcelong: self.vc.currentLong, destlat: Double(lat)!, destlong: Double(long)!)
        mJCLogger.log("Ended", Type: "info")
    }
    private func exportTilesUsingParameters(_ params: AGSExportTileCacheParameters) {
        
        mJCLogger.log("Starting", Type: "info")
        self.job = self.exportTask.exportTileCacheJob(with: params, downloadFileURL: self.createBaseMapPath())
        self.job.start(statusHandler: { (status: AGSJobStatus) -> Void in}) { [weak self] (result: AnyObject?, error: Error?) -> Void in
            if let error = error {
                mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                mJCLogger.log("EsriMap download Error \(error.localizedDescription)", Type: "Error")
                mJCAlertHelper.showAlert(self!.vc, title: alerttitle, message: "Unable_to_download_Map_for_offline".localized(), button: okay)
                mJCLoader.stopAnimating()
            }else {
                mJCAlertHelper.showAlert(self!.vc, title: alerttitle, message: "Map_Download_Completed".localized(), button: okay)
                mJCLoader.stopAnimating()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getWorkOrderList() {
        
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getWorkorderList(){ (responseDict, error)  in
            if error == nil {
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.workOrdersListArr.removeAll()
                        let arr = (responseArr as Array<Any>).prefix(masterDataLoadingItems)
                        self.workOrdersListArr.append(contentsOf: arr)
//                        if self.workOrdersListArr.count > 0 && selectedWOIndex < self.workOrdersListArr.count{
//                            for i in 0..<responseArr.count {
//                                let workOrder = responseArr[i]
//                                workOrder.isSelectedCell = false
//                            }
//                            isfromMapScreen = true
//                            self.getNotificationList()
//                        }
                        if self.workOrdersListArr.count > 0 || self.notificationListArr.count > 0{
                            self.createMarkers()
                        }
                        DispatchQueue.main.async {
                            if DeviceType == iPhone{
                                if self.workOrdersListArr.count > 0{
                                    self.vc?.workorderLabel.text = "Total_Workorders".localized() + ": \(self.workOrdersListArr.count)"
                                }
                            }
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else {
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotificationList() {
        
        mJCLogger.log("Starting", Type: "info")
        NotificationModel.getNotificationList(){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [NotificationModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.notificationListArr.removeAll()
                        let arr = (responseArr as Array<Any>).prefix(masterDataLoadingItems)
                        self.notificationListArr.append(contentsOf: arr)
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func displayLayersFromGeodatabase() {
        mJCLogger.log("Starting", Type: "info")
        self.generatedGeodatabase.load { [weak self] (error:Error?) -> Void in
            if let error = error {
                mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self!.vc, title: alerttitle, message: error as! String, button: okay)
            }else {
                self?.vc.EsriMapView.map?.operationalLayers.removeAllObjects()
                AGSLoadObjects(self!.generatedGeodatabase.geodatabaseFeatureTables) { (success: Bool) in
                    if success {
                        for featureTable in self!.generatedGeodatabase.geodatabaseFeatureTables.reversed() {
                            if featureTable.hasGeometry {
                                let featureLayer = AGSFeatureLayer(featureTable: featureTable)
                                self?.vc.EsriMapView.map?.operationalLayers.add(featureLayer)
                            }
                        }
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
