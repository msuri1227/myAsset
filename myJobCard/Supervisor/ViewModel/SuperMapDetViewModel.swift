//
//  SuperMapDetViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 16/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class SuperMapDetViewModel {
    
    var vc : SupervisorMapDetailVC!
    var waypointsArray: Array<String> = []
    var totalWorkOrderArr = [WoHeaderModel]()
    var markersArray: Array<GMSMarker> = []
    var coOrdinateArr = NSMutableArray()
    
    func markersShowOnMap() {
        
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
            self.vc.googleMapsView.clear()
        }
        coOrdinateArr = NSMutableArray()
        if self.totalWorkOrderArr.count != 0 {
            coOrdinateArr = myAssetDataManager.uniqueInstance.getLocationDetailsForWorkOrders(Arr: totalWorkOrderArr)
            for j in 0..<coOrdinateArr.count {
                let workDic = coOrdinateArr[j] as! NSDictionary
                let latitudeDob = workDic["Latitude"]
                let longitudeDob = workDic["Longitude"]
                let workOrderNum = workDic["WorkOrderNumber"] as! String
                let indexVal = workDic["Index"] as! Int
                self.createMarkersOnMap(latitudeDob : latitudeDob as! Double, longitudeDob : longitudeDob as! Double ,WorkOrderNum : workOrderNum, index: indexVal)
            }
            self.createMarkersOnMap(latitudeDob : Double(self.vc.currentlat) , longitudeDob : Double(self.vc.currentLong) ,WorkOrderNum : "", index: -0)
//            if selectedWOIndex != 0 {
//                let update = GMSCameraUpdate.fit(self.vc.selectedMarkerBounds, withPadding: 30)
//                self.vc.googleMapsView.animate(with: update)
//            }else {
//                let update = GMSCameraUpdate.fit(self.vc.bounds, withPadding: 100)
//                DispatchQueue.main.async{
//                    self.vc.googleMapsView.animate(with: update)
//                }
//            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createMarkersOnMap(latitudeDob : Double, longitudeDob : Double ,WorkOrderNum : String , index: Int) {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            self.vc.googleMapsView.camera = GMSCameraPosition.camera(withLatitude: latitudeDob, longitude: longitudeDob, zoom: self.vc.googleMapsView.camera.zoom)
        }
        if WorkOrderNum == "" {
            DispatchQueue.main.async {
                let userMarker = GMSMarker.init()
                userMarker.position = CLLocationCoordinate2DMake(latitudeDob, longitudeDob)
                userMarker.icon = UIImage(named: "ic_user")
                self.vc.bounds = self.vc.bounds.includingCoordinate(userMarker.position)
                userMarker.map = self.vc.googleMapsView
            }
        }else {
            DispatchQueue.main.async {
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitudeDob, longitude: longitudeDob))
                marker?.title = WorkOrderNum
                marker?.zIndex = Int32(index)
                if selectedworkOrderNumber == WorkOrderNum {
                    marker?.icon = GMSMarker.markerImage(with: .green)
                    self.vc.googleMapsView.selectedMarker = marker
                }else {
                    marker?.icon = GMSMarker.markerImage(with: .red)
                }
//                if selectedWOIndex == index {
//                    self.vc.selectedMarkerBounds = GMSCoordinateBounds()
//                    self.vc.selectedMarkerBounds = self.vc.selectedMarkerBounds.includingCoordinate(marker!.position)
//                }
                marker?.map = self.vc.googleMapsView
                self.vc.bounds = self.vc.bounds.includingCoordinate(marker!.position)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getroutedetails(lat: String,long:String,WONum:String) {
        
        mJCLogger.log("Starting", Type: "info")
        
        DispatchQueue.main.async{
            if long != "" && lat != ""{
                let array = [[
                    "latitude" : self.vc.currentlat,
                    "longitude" : self.vc.currentLong
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
                    if location.latitude == self.vc.currentlat && location.longitude == self.vc.currentLong {
                        DispatchQueue.main.async{
                            marker.icon = UIImage(named: "ic_user")
                            bounds = bounds.includingCoordinate(marker.position)
                            marker.map = self.vc.googleMapsView
                        }
                    }else{
                        DispatchQueue.main.async{
                            marker.title = WONum
                            marker.icon = GMSMarker.markerImage(with: mapMarkerColor)
                            bounds = bounds.includingCoordinate(marker.position)
                            marker.map = self.vc.googleMapsView
                            self.vc.googleMapsView.selectedMarker = marker
                        }
                    }
                }
                DispatchQueue.main.async{
                    let camera = GMSCameraUpdate.fit(bounds, with:  UIEdgeInsets(top: 100, left: 100, bottom: 220, right: 100))
                    self.vc.googleMapsView.animate(with: camera)
                    self.vc.distanceview.isHidden = true
                    self.vc.woLat = Double(lat)!
                    self.vc.woLong = Double(long)!
                    self.createRoute(sourcelat: self.vc.currentlat, sourcelong: self.vc.currentLong, destlat: Double(lat)!, destlong: Double(long)!)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func createRoute(sourcelat : Double,sourcelong : Double,destlat : Double,destlong:Double) {
        
        mJCLogger.log("Starting", Type: "info")
        
        let origin = "\(sourcelat),\(sourcelong)"
        let destination = "\(destlat),\(destlong)"
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(GoogleAPIKey)"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            DispatchQueue.main.sync{
                if(error != nil){
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }else{
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String : AnyObject] {
                            if let routes = json["routes"] as? NSArray {
                                for route in routes
                                {
                                    if let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as? NSDictionary {
                                        let points = routeOverviewPolyline.object(forKey: "points")
                                        let path = GMSPath.init(fromEncodedPath: points! as? String)
                                        let polyline = GMSPolyline.init(path: path)
                                        polyline?.strokeWidth = 3
                                        polyline?.map = self.vc.googleMapsView
                                        if let legs:NSArray = (route as! NSDictionary).value(forKey: "legs") as? NSArray {
                                            if let distance = (legs[0] as! NSDictionary).value(forKey: "distance") as? NSDictionary {
                                                let distancetext = distance.value(forKey: "text")
                                                let duration = (legs[0] as! NSDictionary).value(forKey: "duration") as! NSDictionary
                                                let durationtext = duration.value(forKey: "text")
                                                self.vc.distanceview.isHidden = false
                                                self.vc.distancelabel.text = "  Distance".localized() + ": \(distancetext!)," + "Duration".localized() + ": \(durationtext!)"
                                                mJCLogger.log("createRoute Done", Type: "info")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }catch let error as NSError{
                        print("error:\(error)")
                        mJCLogger.log("Reason : \(String(describing: error.localizedDescription))", Type: "Error")
                    }
                }
            }
        }).resume()
        mJCLogger.log("Ended", Type: "info")
    }
}
