//
//  AssetMapVC.swift
//  myAsset
//
//  Created by Rover Software on 15/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
import CoreLocation

class AssetLocationVC: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {
    
    @IBOutlet var googleMapsView: GMSMapView!
    var currentLocation = CLLocation()
    var locations = [Dictionary<String,Any>]()
    var coOrdinateArr = NSMutableArray()
    var locationManager: CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }else {
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_on_location_services".localized() , button: okay)
        }
        self.googleMapsView.delegate = self
        self.googleMapsView.isMyLocationEnabled = true
        self.googleMapsView.settings.myLocationButton = true
        self.createMarkers()
    }
    func plotMarkersOnMap() {
//        DispatchQueue.main.async { [self] in
//            self.googleMapsView.clear()
//            for item in self.locations{
//                var longitude = String()
//                var latitude = String()
//                var longitudeDob = Double()
//                var latitudeDob = Double()
//                let coOrdinateDic = Dictionary<String,Any>()
//                let AssetID = item["AssetID"] as? String ?? ""
//                let AssetDesc = item["AssetDesc"] as? String ?? ""
//                let geoLocation = item["AssetLoc"] as? String ?? ""
//                let coOrdinatesArr = geoLocation.components(separatedBy: ",")
//                if coOrdinatesArr.count == 2 {
//                    let firstIndex = coOrdinatesArr[0]
//                    let secondeIndex = coOrdinatesArr[1]
//                    let longitudeArr = firstIndex.components(separatedBy: ":")
//                    let latitudeArr = secondeIndex.components(separatedBy: ":")
//                    if longitudeArr.count == 2 {
//                        longitude = longitudeArr[1]
//                        longitude = longitude.replacingOccurrences(of: " ", with: "")
//                    }
//                    if latitudeArr.count == 2{
//                        latitude = latitudeArr[1]
//                        latitude = latitude.replacingOccurrences(of: " ", with: "")
//                    }
//                    if longitude != "" && latitude != "" {
//                        longitudeDob = Double(longitude) ?? 0.0
//                        latitudeDob = Double(latitude) ?? 0.0
//                        coOrdinateDic.setValue(latitudeDob, forKey: "Latitude")
//                        coOrdinateDic.setValue(longitudeDob, forKey: "Longitude")
//                        coOrdinateDic.setValue(AssetID, forKey: "AssetID")
//                        coOrdinateDic.setValue(AssetDesc, forKey: "AssetDesc")
//                        self.coOrdinateArr.add(coOrdinateDic)
//                    }
//                }
//            }
//        }
    }
    func createMarkers() {
        DispatchQueue.main.async {
            for item in self.locations{
                let assetID = "\(item["AssetID"] ?? "")"
                let assetDesc = "\(item["AssetDesc"] ?? "")"
                let assetLat = "\(item["AssetLat"] ?? "")"
                let assetLong = "\(item["AssetLong"] ?? "")"
                if assetLat != "" && assetLong != "" {
                    let latitude = Double(assetLat) ?? 0.0
                    let longitude =  Double(assetLong) ?? 0.0
                    let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                    marker?.title = assetID
                    marker?.snippet = assetDesc
                    marker?.map = self.googleMapsView
                }
            }
            self.googleMapsView.camera = GMSCameraPosition.camera(withLatitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude, zoom: 0.0)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    //MARK: - Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mJCLogger.log("Starting", Type: "info")
        if (status == CLAuthorizationStatus.denied) {
            print("The user denied authorization")
            mJCLogger.log("The user denied authorization".localized(), Type: "")
        }else if (status == CLAuthorizationStatus.notDetermined) {
            locationManager.requestWhenInUseAuthorization()
            print("NotDetermined Location")
            mJCLogger.log("NotDeterminedLocation".localized(), Type: "Error")
        }else if (status == CLAuthorizationStatus.restricted) {
            print("Restricted to use Location")
            mJCLogger.log("Restricted to use Location".localized(), Type: "Error")
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
        self.currentLocation = locations[locations.count - 1]
        self.locationManager.stopUpdatingLocation()
        self.googleMapsView.camera = GMSCameraPosition.camera(withLatitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude, zoom: 0.0)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - GMSMapView Delegate method
    func mapView(_ mapView: GMSMapView!, didTap marker: GMSMarker!) -> Bool {
        return false
    }
    func mapView(_ mapView: GMSMapView!, didTapAt coordinate: CLLocationCoordinate2D) {
    }
}
