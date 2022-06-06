//
//  AttendanceTypeListViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 15/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class AttendanceTypeListViewModel {
    
    var vcAttendanceTypeList: AttendanceTypeListVC?
    var attendanceTypeArray = [AttendanceTypeModel]()
    var attendanceTypeListArray = [AttendanceTypeModel]()
    var filterBy = String()
    
    func setAttendanceType(){
        
        mJCLogger.log("Starting", Type: "info")
        self.attendanceTypeArray.removeAll()
        self.attendanceTypeArray = self.attendanceTypeListArray
        mJCLogger.log("Ended", Type: "info")
    }
    func searchMethod() {
        
        mJCLogger.log("Starting", Type: "info")
        var searchPredicate = NSPredicate()
        if self.filterBy == "Id" {
            searchPredicate = NSPredicate(format: "SELF.AttAbsType contains[cd] %@",self.vcAttendanceTypeList!.searchTextfield.text!)
            let filterAttendanceArray = (self.attendanceTypeListArray as NSArray).filtered(using: searchPredicate) as! [AttendanceTypeModel]
            if filterAttendanceArray.count > 0{
                self.attendanceTypeArray.removeAll()
                self.attendanceTypeArray =  filterAttendanceArray
            }else{
                self.attendanceTypeArray.removeAll()
                self.attendanceTypeArray =  filterAttendanceArray
            }
            self.vcAttendanceTypeList?.listItemTableview.reloadData()
        }else if self.filterBy == "Description" {
            searchPredicate = NSPredicate(format: "SELF.AATypeText contains[cd] %@",self.vcAttendanceTypeList!.searchTextfield.text!)
            let filterAttendanceArray = (self.attendanceTypeListArray as NSArray).filtered(using: searchPredicate) as! [AttendanceTypeModel]
            if filterAttendanceArray.count > 0{
                self.attendanceTypeArray.removeAll()
                self.attendanceTypeArray =  filterAttendanceArray
            }else{
                self.attendanceTypeArray.removeAll()
                self.attendanceTypeArray =
                    self.attendanceTypeListArray
            }
            self.vcAttendanceTypeList?.listItemTableview.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
