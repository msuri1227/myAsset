//
//  MapDetailViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class MapDetailViewModel {
    
    var vc : MapDeatilsVC!
    var coOrdinateArr = NSMutableArray()
    
    //MARK:- Get WorkOrder Data..
    func getSupervisorsWorkOrderListForMarkers() {
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getSuperVisorWorkorderList(){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.vc.workOrderArray.removeAll()
                        self.vc.workOrderListArray.removeAll()
                        self.vc.workOrderArray = responseArr
                        self.vc.workOrderListArray = responseArr
                        self.plotMarkersOnMap()
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
    func map_searchTextFieldEditingChanged(searchText : String) {
        
        mJCLogger.log("Starting", Type: "info")
        if(searchText == "") {
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil){
                let dict = UserDefaults.standard.value(forKey:"ListFilter") as! Dictionary<String,Any>
                self.setWorkorderFilterQuery(dict: dict)
            }else{
                self.vc.workOrderArray.removeAll()
                for workorderItem in self.vc.workOrderListArray {
                    (workorderItem as! WoHeaderModel).isSelectedCell = false
                }
                if self.vc.workOrderListArray.count > 0{
                    let woClass = self.vc.workOrderListArray[0]
                    (woClass as! WoHeaderModel).isSelectedCell = true
                    selectedworkOrderNumber = (woClass as! WoHeaderModel).WorkOrderNum
                    self.vc.workOrderArray =  self.vc.workOrderListArray
                    singleWorkOrder = self.vc.workOrderArray[0] as! WoHeaderModel
                }
            }
            self.vc.totalWorkOrdersLbl.text = "Total_Workorders".localized() + ": \(self.vc.workOrderListArray.count)"
        }else {
            if (UserDefaults.standard.value(forKey:"ListFilter") != nil) {
                
                var filteredArray = [WoHeaderModel]()
                if searchText.isNumeric == true
                {
                    filteredArray = (self.vc.workOrderArray as! [WoHeaderModel]).filter{$0.WorkOrderNum.contains(find: searchText)}
                    if filteredArray.count == 0{
                        filteredArray = (self.vc.workOrderArray as! [WoHeaderModel]).filter{$0.EquipNum.contains(find: searchText)}
                    }
                }else {
                    filteredArray = (self.vc.workOrderArray as! [WoHeaderModel]).filter{$0.ShortText.contains(find: searchText)}
                    if filteredArray.count == 0 {
                        filteredArray = (self.vc.workOrderArray as! [WoHeaderModel]).filter{$0.FuncLocation.contains(find: searchText)}
                    }
                }
                if filteredArray.count > 0 {
                    let woClass = filteredArray[0]
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.vc.workOrderArray.removeAll()
                    self.vc.workOrderArray = filteredArray
                    singleWorkOrder = self.vc.workOrderArray[0] as! WoHeaderModel
                    self.vc.totalWorkOrdersLbl.text = "Total_Workorders".localized() + " : \(self.vc.workOrderArray.count)/\(self.vc.workOrderListArray.count)"
                } else {
                    selectedworkOrderNumber = ""
                    singleWorkOrder = WoHeaderModel()
                    self.vc.totalWorkOrdersLbl.text = "Total_Workorders".localized() + ": 0/\(self.vc.workOrderListArray.count)"
                }
            }else{
                self.vc.workOrderArray.removeAll()
                var filteredArray = [WoHeaderModel]()
                for workorderItem in self.vc.workOrderListArray{
                    (workorderItem as! WoHeaderModel).isSelectedCell = false
                }
                if searchText.isNumeric == true
                {
                    filteredArray = (self.vc.workOrderArray as! [WoHeaderModel]).filter{$0.WorkOrderNum.contains(find: searchText)}
                    if filteredArray.count == 0{
                        filteredArray = (self.vc.workOrderArray as! [WoHeaderModel]).filter{$0.EquipNum.contains(find: searchText)}
                    }
                }else {
                    filteredArray = (self.vc.workOrderArray as! [WoHeaderModel]).filter{$0.ShortText.contains(find: searchText)}
                    if filteredArray.count == 0 {
                        filteredArray = (self.vc.workOrderArray as! [WoHeaderModel]).filter{$0.FuncLocation.contains(find: searchText)}
                    }
                }
                if filteredArray.count > 0 {
                    let woClass = filteredArray[0]
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.vc.workOrderArray = filteredArray
                    singleWorkOrder = self.vc.workOrderArray[0] as! WoHeaderModel
                    self.vc.totalWorkOrdersLbl.text = "Total_Workorders".localized() + ": \(self.vc.workOrderArray.count)/\(self.vc.workOrderListArray.count)"
                }else {
                    selectedworkOrderNumber = ""
                    singleWorkOrder = WoHeaderModel()
                    self.vc.totalWorkOrdersLbl.text = "Total_Workorders".localized() + ": 0/\(self.vc.workOrderListArray.count)"
                }
            }
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Filter WorkOrder..
    func setWorkorderFilterQuery(dict : Dictionary<String,Any>){
        
        mJCLogger.log("Starting", Type: "info")
        let predicateArray = NSMutableArray()
        if dict.keys.count == 0{
            
            self.vc.workOrderArray.removeAll()
            for workorderItem in self.vc.workOrderListArray {
                (workorderItem as! WoHeaderModel).isSelectedCell = false
            }
            if self.vc.workOrderListArray.count > 0{
                let woClass = self.vc.workOrderListArray[0] as! WoHeaderModel
                woClass.isSelectedCell = true
                selectedworkOrderNumber = woClass.WorkOrderNum
                self.vc.workOrderArray = self.vc.workOrderListArray
                singleWorkOrder = woClass
                self.vc.filterCountLbl.isHidden = true
                self.vc.NoDataView.isHidden = true
                self.vc.noLabelView.text = ""
                
            }
        }else{
            
            if dict.keys.contains("priority"),let arr = dict["priority"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "Priority IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("orderType"),let arr = dict["orderType"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "OrderType IN %@", arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("status"),let arr = dict["status"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MobileObjStatus IN %@ || UserStatus In %@", arr,arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("createdBy"),let arr = dict["createdBy"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "EnteredBy IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            if dict.keys.contains("mainWorkCenter"),let arr = dict["mainWorkCenter"] as? [String]{
                if arr.count > 0{
                    let predicate = NSPredicate(format: "MainWorkCtr IN %@",arr)
                    predicateArray.add(predicate)
                }
            }
            for workorderItem in self.vc.workOrderListArray {
                (workorderItem as! WoHeaderModel).isSelectedCell = false
            }
            
            let finalPredicateArray : [NSPredicate] = predicateArray as NSArray as! [NSPredicate]
            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
            let array = self.vc.workOrderListArray.filter{compound.evaluate(with: $0)}
            self.vc.workOrderArray.removeAll()
            if array.count > 0 {
                
                if let woClass = array[0] as? WoHeaderModel {
                    woClass.isSelectedCell = true
                    selectedworkOrderNumber = woClass.WorkOrderNum
                    self.vc.workOrderArray = array
                    singleWorkOrder = self.vc.workOrderArray[0] as! WoHeaderModel
                    self.vc.filterCountLbl.isHidden = false
                    self.vc.filterCountLbl.text = "\(self.vc.workOrderArray.count)"
                }
                self.vc.NoDataView.isHidden = true
                self.vc.noLabelView.text = ""
            }
            else {
                self.vc.filterCountLbl.isHidden = false
                self.vc.filterCountLbl.text = "0"
                self.vc.NoDataView.isHidden = false
                self.vc.noLabelView.text = "No_Data_Available".localized()
                mJCLogger.log("Data not found", Type: "Debug ")
                selectedworkOrderNumber = ""
                singleWorkOrder = WoHeaderModel()
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
            mJCLogger.log("setWorkorderFilterQuery End".localized(), Type: "")
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    
    
    
    //    {
    //        mJCLogger.log("Starting", Type: "info")
    //        let selectedPriorityArray = dict.value(forKey:"Priority") as! NSArray
    //        let selectedStatusArray = dict.value(forKey:"Status") as! NSArray
    //        let selectedOrderTypeArray = dict.value(forKey:"OrderType") as! NSArray
    //        let selectedWorkCenterArray = dict.value(forKey:"WorkCenter") as! NSArray
    //        if selectedPriorityArray.count == 0 && selectedStatusArray.count == 0 && selectedOrderTypeArray.count == 0{
    //            self.vc.workOrderArray.removeAll()
    //            for workorderItem in self.vc.workOrderListArray{
    //                (workorderItem as! WoHeaderModel).isSelectedCell = false
    //            }
    //            if self.vc.workOrderListArray.count > 0 {
    //                let woClass = self.vc.workOrderListArray[0]
    //                (woClass as! WoHeaderModel).isSelectedCell = true
    //                selectedworkOrderNumber = (woClass as! WoHeaderModel).WorkOrderNum
    //                self.vc.workOrderArray = self.vc.workOrderListArray
    //                singleWorkOrder = self.vc.workOrderArray[0] as! WoHeaderModel
    //                if DeviceType == iPhone{
    //                    self.vc.filterCountLbl.isHidden = true
    //                }
    //            }
    //        }else{
    //            for workorderItem in self.vc.workOrderListArray {
    //                (workorderItem as! WoHeaderModel).isSelectedCell = false
    //            }
    //            let predicateArray = NSMutableArray()
    //            if selectedPriorityArray.count > 0 {
    //                let predicate1 = NSPredicate(format: "Priority IN %@", selectedPriorityArray as [AnyObject])
    //                predicateArray.add(predicate1)
    //            }
    //            if selectedStatusArray.count > 0 {
    //                let predicate2 = NSPredicate(format: "MobileObjStatus IN %@ || UserStatus In %@", selectedStatusArray as [AnyObject],selectedStatusArray as [AnyObject])
    //                predicateArray.add(predicate2)
    //            }
    //            if selectedOrderTypeArray.count > 0 {
    //                let predicate3 = NSPredicate(format: "OrderType IN %@", selectedOrderTypeArray as [AnyObject])
    //                predicateArray.add(predicate3)
    //            }
    //            if selectedWorkCenterArray.count > 0 {
    //                let predicate4 = NSPredicate(format: "MainWorkCtr IN %@",selectedWorkCenterArray[0] as! String)
    //                predicateArray.add(predicate4)
    //            }
    //
    //            let finalPredicateArray : [NSPredicate] = predicateArray as NSArray as! [NSPredicate]
    //            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
    //            let array = self.vc.workOrderListArray.filter{compound.evaluate(with: $0)}
    //
    //            if array.count > 0 {
    //                self.vc.workOrderArray.removeAll()
    //                let woClass = array[0]
    //                (woClass as! WoHeaderModel).isSelectedCell = true
    //                selectedworkOrderNumber = (woClass as! WoHeaderModel).WorkOrderNum
    //                self.vc.workOrderArray = array
    //                singleWorkOrder = self.vc.workOrderArray[0] as! WoHeaderModel
    //                if DeviceType == iPhone{
    //                    self.vc.filterCountLbl.isHidden = false
    //                    self.vc.filterCountLbl.text = "\(self.vc.workOrderArray.count)"
    //                }
    //                self.vc.NoDataView.isHidden = true
    //                self.vc.noLabelView.text = ""
    //            }else {
    //                if DeviceType == iPhone{
    //                    self.vc.filterCountLbl.isHidden = false
    //                    self.vc.filterCountLbl.text = "0"
    //                    self.vc.NoDataView.isHidden = false
    //                    self.vc.noLabelView.text = "No_Data_Available".localized()
    //                }
    //                selectedworkOrderNumber = ""
    //                singleWorkOrder = WoHeaderModel()
    //            }
    //            NotificationCenter.default.post(name: Notification.Name(rawValue:"dataSetSuccessfully"), object: "DataSetMasterView")
    //            mJCLogger.log("setWorkorderFilterQuery End".localized(), Type: "")
    //        }
    //        mJCLogger.log("Ended", Type: "info")
    //    }
    
    //MARK:- Markers and Route
    
    func plotMarkersOnMap() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.vc.googleMapsView.clear()
            self.coOrdinateArr = NSMutableArray()
            if self.vc.workOrderArray.count != 0 {
                self.coOrdinateArr = myAssetDataManager.uniqueInstance.getLocationDetailsForWorkOrders(Arr: self.vc.workOrderArray)
                for j in 0..<self.coOrdinateArr.count {
                    let workDic = self.coOrdinateArr[j] as! NSDictionary
                    let latitudeDob = workDic["Latitude"]
                    let longitudeDob = workDic["Longitude"]
                    let workOrderNum = workDic["WorkOrderNumber"] as! String
                    let indexVal = workDic["Index"] as! Int
                    self.createMarkers(latitudeDob : latitudeDob as! Double, longitudeDob : longitudeDob as! Double ,WorkOrderNum : workOrderNum, index: indexVal)
                }
                self.createMarkers(latitudeDob : Double(self.vc.currentlat) , longitudeDob : Double(self.vc.currentLong) ,WorkOrderNum : "", index: -0)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createMarkers(latitudeDob : Double, longitudeDob : Double ,WorkOrderNum : String , index: Int) {
        mJCLogger.log("Starting", Type: "info")
        self.vc.googleMapsView.camera = GMSCameraPosition.camera(withLatitude: latitudeDob, longitude: longitudeDob, zoom: self.vc.googleMapsView.camera.zoom)
        if WorkOrderNum == "" {
            let userMarker = GMSMarker.init()
            userMarker.position = CLLocationCoordinate2DMake(latitudeDob, longitudeDob)
            userMarker.icon = UIImage(named: "ic_user")
            self.vc.bounds = self.vc.bounds.includingCoordinate(userMarker.position)
            userMarker.map = self.vc.googleMapsView
        }else {
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitudeDob, longitude: longitudeDob))
            marker?.title = WorkOrderNum
            marker?.zIndex = Int32(index)
            if selectedworkOrderNumber == WorkOrderNum {
                marker?.icon = GMSMarker.markerImage(with: .green)
                self.vc.googleMapsView.selectedMarker = marker
            }else {
                marker?.icon = GMSMarker.markerImage(with: .red)
            }
//            if selectedWOIndex == index {
//                self.vc.selectedWoBounds = GMSCoordinateBounds()
//                self.vc.selectedWoBounds = self.vc.selectedWoBounds.includingCoordinate(marker!.position)
//            }
            marker?.map = self.vc.googleMapsView
            self.vc.bounds = self.vc.bounds.includingCoordinate(marker!.position)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createRoute(sourcelat : Double,sourcelong : Double,destlat : Double,destlong:Double){
        mJCLogger.log("Starting", Type: "info")
        let origin = "\(sourcelat),\(sourcelong)"
        let destination = "\(destlat),\(destlong)"
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(GoogleAPIKey)"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    let routes = json["routes"] as! NSArray
                    if routes.count == 0{
                        DispatchQueue.main.async{
                            let cameraPosition = GMSCameraPosition.camera(withLatitude: destlat, longitude: destlong, zoom: 10.0)
                            self.vc.googleMapsView.animate(to: cameraPosition)
                            if  self.vc.googleMapsView.selectedMarker != nil {
                                self.vc.googleMapsView.selectedMarker.icon = GMSMarker.markerImage(with: mapMarkerColor)
                            }
                        }
                        mJCLogger.log("route not found".localized(), Type: "Debug")
                    }else{
                        OperationQueue.main.addOperation({
                            for route in routes
                            {
                                let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
                                let points = routeOverviewPolyline.object(forKey: "points")
                                let path = GMSPath.init(fromEncodedPath: points! as? String)
                                let polyline = GMSPolyline.init(path: path)
                                polyline?.strokeWidth = 3
                                polyline?.map = self.vc.googleMapsView
                                let legs:NSArray = (route as! NSDictionary).value(forKey: "legs") as! NSArray
                                if legs.count > 0 {
                                    let distance = (legs[0] as! NSDictionary).value(forKey: "distance") as! NSDictionary
                                    let distancetext = distance.value(forKey: "text")
                                    let duration = (legs[0] as! NSDictionary).value(forKey: "duration") as! NSDictionary
                                    let durationtext = duration.value(forKey: "text")
                                    if DeviceType == iPad
                                    {
                                        self.vc.distanceview.isHidden = false
                                        self.vc.distancelabel.text = "  " + "Distance".localized() + ": \(distancetext!)," + "Duration".localized() + ": \(durationtext!)"
                                    }
                                }
                                if  self.vc.googleMapsView.selectedMarker != nil {
                                    self.vc.googleMapsView.selectedMarker.icon = GMSMarker.markerImage(with: mapMarkerColor)
                                }
                            }
                        })
                    }
                }catch let error as NSError{
                    print("error:\(error)")
                    mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                }
            }
        }).resume()
        mJCLogger.log("Ended", Type: "info")
    }
}
