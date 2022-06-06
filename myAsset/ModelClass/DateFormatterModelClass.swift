//
//  DateFormatterModelClass.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 5/26/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class DateFormatterModelClass: NSObject {

    class var uniqueInstance : DateFormatterModelClass {
        struct Static {
            static let instance : DateFormatterModelClass = DateFormatterModelClass()
        }
        return Static.instance
    }
    func getTimeIntoMiliSecond(date : NSDate) -> Double {
        let dateFormatter = DateFormatter()
        let timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeZone = timeZone! as TimeZone
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let timeInMiliseconds = date.timeIntervalSince1970*1000
        return timeInMiliseconds
    }
    func getDateFromString(dateSting:String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeZone = timeZone! as TimeZone
        let date = dateFormatter.date(from: dateSting)
        if date == nil{
            return NSDate()
        }else{
            return date! as NSDate
        }
    }
    func getFullDateWithoutTimeZone(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
    func getDateWithoutTimeZone(date : NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateText = formatter.string(from: date as Date)
        return dateText
    }
    func getDateforOnlineSearch(date : NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateText = formatter.string(from: date as Date)
        return dateText
    }
    func getStringfromOnlineSearchDate(dateString : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeZone = timeZone! as TimeZone
        let date = dateFormatter.date(from: dateString)
        if date == nil{
            return Date()
        }else{
            return date!
        }
    }
    func getStringtoTime(time:String) -> Date{
        if time != ""{
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let timeZone = NSTimeZone(name: "UTC")
            formatter.timeZone = timeZone! as TimeZone
            let date = formatter.date(from: time)!
            return date
        }else{
            return Date()
        }
    }
    func getFullDateWithoutTimeZoneForMultipleSheetsPosting(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}
