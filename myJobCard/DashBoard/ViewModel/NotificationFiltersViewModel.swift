//
//  noFilter.swift
//  myJobCard
//
//  Created by Suri on 29/07/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class NotificationFiltersViewModel {
    

    var dBVc: DashboardStyle2?
    
public func applyNoFilter(firstFilterItem:String,secondFilterItem:String,thirdFilterArr:[String],fourthFilterArr:[String],from:String) -> Dictionary<String,Any>{
        var finalDict = Dictionary<String,Any>()
        if thirdFilterArr.count > 0 && fourthFilterArr.count > 0{
            var countarr = Array<Int>()
            var colorArr = Array<UIColor>()
            var legendArr = Array<String>()
            var filteredArr = [NotificationModel]()
            for thirdFilterItem in thirdFilterArr{
                for fourthFilterItem in fourthFilterArr{
                    switch firstFilterItem {
                    case Filters.Priority.value:
                        var priority = ""
                        if thirdFilterItem != Filters.NoPriority.value{
                            let priorityArr = globalPriorityArray.filter{ $0.PriorityText == thirdFilterItem}
                            if priorityArr.count > 0{
                                let priorityCls = priorityArr[0]
                                priority = priorityCls.Priority
                            }
                        }
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.MobileStatus == "\(fourthFilterItem)"}
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.Priority == "\(priority)" && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.Priority == %@", priority);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.Priority == %@", priority);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.Status.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)" }
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)") }
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)") }
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.MobileStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.MobileStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.UserStatus.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.FunctionalLoc.contains(find: "\(fourthFilterItem)") }
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment.contains(find: "\(fourthFilterItem)") }
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.SystemStatus.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{$0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{$0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{$0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{$0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{$0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{$0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{$0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.SystemStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.SystemStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.NotificationType.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{ $0.NotificationType == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.NotificationType == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.NotificationType == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.WorkCenter.value:
                        var filterarray = [NotificationModel]()
                        let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == thirdFilterItem}
                        if wrkctrclsArray.count > 0 {
                            let wrkcls = wrkctrclsArray[0]
                            switch secondFilterItem {
                            case Filters.Priority.value:
                                var priority = ""
                                if thirdFilterItem != Filters.NoPriority.value{
                                    let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    if priorityArr.count > 0{
                                        let priorityCls = priorityArr[0]
                                        priority = priorityCls.Priority
                                    }
                                }
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.Priority == "\(priority)"}
                            case Filters.Status.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.UserStatus.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.SystemStatus.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.NotificationType.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.NotificationType == "\(fourthFilterItem)"}
                            case Filters.PlanningPlant.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                            case Filters.PlannerGroup.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                            case Filters.MaintenancePlant.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.MaintPlant == "\(fourthFilterItem)"}
                            case Filters.TechID.value:
                                let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                                if equipArr.count > 0{
                                    let equipCls = equipArr[0]
                                    filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.Equipment == "\(equipCls.Equipment)"}
                                }
                            case Filters.WorkorderConversion.value:
                                switch fourthFilterItem {
                                case Filters.WorkorderCreated.value:
                                    filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.WorkOrderNum != ""}
                                case Filters.WorkorderNotCreated.value:
                                    filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.WorkOrderNum == ""}
                                default:
                                    print("Filter Not Found")
                                }
                            case Filters.Location.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.Location == "\(fourthFilterItem)"}
                            case Filters.FunctionalLocation.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                            case Filters.Equipment.value:
                                filterarray = allNotficationArray.filter{ $0.WorkCenter == "\(wrkcls.ObjectID)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                            case Filters.CreatedOrAssigned.value:
                                let predicateArr = NSMutableArray()
                                let predicate = NSPredicate(format: "SELF.WorkCenter == %@", wrkcls.ObjectID);
                                predicateArr.add(predicate)
                                if fourthFilterItem == Filters.AssignedToMe.value{
                                    let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                    predicateArr.add(predicate)
                                }else if fourthFilterItem == Filters.CreatedByMe.value{
                                    let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                    predicateArr.add(predicate)
                                }
                                let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                                let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                            case Filters.Date.value:
                                let predicateArr = NSMutableArray()
                                let predicate = NSPredicate(format: "SELF.WorkCenter == %@", wrkcls.ObjectID);
                                predicateArr.add(predicate)
                                switch fourthFilterItem {
                                case Filters.PlannedForToday.value:
                                    let currentDate = Date().localDate()
                                    let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                    predicateArr.add(datePredicate)
                                case Filters.PlannedForTomorrow.value:
                                   let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                    predicateArr.add(datePredicate)
                                case Filters.PlannedforNextWeek.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                    predicateArr.add(datePredicate)
                                case Filters.OverdueForLastTwodays.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                    let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.OverdueForAWeek.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                    let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.AllOverdue.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.CreatedInLast30Days.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                    let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                    predicateArr.add(predicate)
                                default:
                                   print("Filter Not Found")
                                }
                                let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                                let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                            default:
                                print("Filter Not Found")
                            }
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.PlanningPlant.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)") }
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)") }
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)") }
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.PlanningPlant == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.PlanningPlant == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.PlannerGroup.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)") }
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)") }
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)") }
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.PlannerGroup == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.PlannerGroup == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.MaintenancePlant.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.MaintPlant == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.MaintPlant == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.TechID.value:
                        var filterarray = [NotificationModel]()
                        let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(thirdFilterItem)"}
                        if equipArr.count > 0{
                            let equipCls = equipArr[0]
                            switch secondFilterItem {
                            case Filters.Priority.value:
                                var priority = ""
                                if thirdFilterItem != Filters.NoPriority.value{
                                    let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                    if priorityArr.count > 0{
                                        let priorityCls = priorityArr[0]
                                        priority = priorityCls.Priority
                                    }
                                }
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.Priority == "\(priority)"}
                            case Filters.Status.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.UserStatus.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.SystemStatus.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.NotificationType.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.NotificationType == "\(fourthFilterItem)"}
                            case Filters.WorkCenter.value:
                                let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                                if wrkctrclsArray.count > 0 {
                                    let wrkcls = wrkctrclsArray[0]
                                    filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                                }
                            case Filters.PlanningPlant.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                            case Filters.PlannerGroup.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                            case Filters.MaintenancePlant.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.MaintPlant == "\(fourthFilterItem)"}
                            case Filters.WorkorderConversion.value:
                                switch fourthFilterItem {
                                case Filters.WorkorderCreated.value:
                                    filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.WorkOrderNum != ""}
                                case Filters.WorkorderNotCreated.value:
                                    filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.WorkOrderNum == ""}
                                default:
                                    print("Filter Not Found")
                                }
                            case Filters.Location.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.Location == "\(fourthFilterItem)"}
                            case Filters.FunctionalLocation.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                            case Filters.Equipment.value:
                                filterarray = allNotficationArray.filter{$0.Equipment == "\(equipCls.Equipment)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                            case Filters.CreatedOrAssigned.value:
                                let predicateArr = NSMutableArray()
                                let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(thirdFilterItem)"}
                                if equipArr.count > 0{
                                    let equipCls = equipArr[0]
                                    let predicate = NSPredicate(format: "SELF.Equipment == %@", "\(equipCls.Equipment)");
                                    predicateArr.add(predicate)
                                }

                                if fourthFilterItem == Filters.AssignedToMe.value{
                                    let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                    predicateArr.add(predicate)
                                }else if fourthFilterItem == Filters.CreatedByMe.value{
                                    let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                    predicateArr.add(predicate)
                                }
                                let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                                let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                            case Filters.Date.value:
                                let predicateArr = NSMutableArray()
                                let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(thirdFilterItem)"}
                                if equipArr.count > 0{
                                    let equipCls = equipArr[0]
                                    let predicate = NSPredicate(format: "SELF.Equipment == %@", "\(equipCls.Equipment)");
                                    predicateArr.add(predicate)
                                }
                                switch fourthFilterItem {
                                case Filters.PlannedForToday.value:
                                    let currentDate = Date().localDate()
                                    let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                    predicateArr.add(datePredicate)
                                case Filters.PlannedForTomorrow.value:
                                   let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                    predicateArr.add(datePredicate)
                                case Filters.PlannedforNextWeek.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                    predicateArr.add(datePredicate)
                                case Filters.OverdueForLastTwodays.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                    let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.OverdueForAWeek.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                    let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.AllOverdue.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.CreatedInLast30Days.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                    let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                    predicateArr.add(predicate)
                                default:
                                   print("Filter Not Found")
                                }
                                let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                                let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                            default:
                                print("Filter Not Found")
                            }
                            if (filterarray.count > 0){
                                if from  == "DB"{
                                    countarr.append(filterarray.count)
                                    colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                    legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                    dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                }else{
                                    filteredArr.append(contentsOf: filterarray)
                                }
                            }
                        }
                    case Filters.Date.value:
                        var filterarray = [NotificationModel]()
                        let predicateArr = NSMutableArray()
                        switch thirdFilterItem {
                        case Filters.PlannedForToday.value:
                            let currentDate = Date().localDate()
                            let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                            predicateArr.add(datePredicate)
                        case Filters.PlannedForTomorrow.value:
                           let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                            predicateArr.add(datePredicate)
                        case Filters.PlannedforNextWeek.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                            predicateArr.add(datePredicate)
                        case Filters.OverdueForLastTwodays.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                            let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                            predicateArr.add(overduePredicate)
                        case Filters.OverdueForAWeek.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                            let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                            predicateArr.add(overduePredicate)
                        case Filters.AllOverdue.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                            predicateArr.add(overduePredicate)
                        case Filters.CreatedInLast30Days.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                            let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                            predicateArr.add(predicate)
                        default:
                           print("Filter Not Found")
                        }
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            let predicate = NSPredicate(format: "SELF.Priority == %@", priority);
                            predicateArr.add(predicate)
                        case Filters.Status.value:
                            let predicate = NSPredicate(format: "SELF.MobileStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.UserStatus.value:
                            let predicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.SystemStatus.value:
                            let predicate = NSPredicate(format: "SELF.SystemStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.NotificationType.value:
                            let predicate = NSPredicate(format: "SELF.NotificationType == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                let predicate = NSPredicate(format: "SELF.WorkCenter == %@","\(wrkcls.ObjectID)");
                                predicateArr.add(predicate)
                            }
                        case Filters.PlanningPlant.value:
                            let predicate = NSPredicate(format: "SELF.PlanningPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlannerGroup.value:
                            let predicate = NSPredicate(format: "SELF.PlannerGroup == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MaintenancePlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                let predicate = NSPredicate(format: "SELF.Equipment == %@","\(equipCls.Equipment)");
                                predicateArr.add(predicate)
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                let predicate = NSPredicate(format: "SELF.WorkOrderNum != %@","");
                                predicateArr.add(predicate)
                            case Filters.WorkorderNotCreated.value:
                                let predicate = NSPredicate(format: "SELF.WorkOrderNum == %@","");
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            let predicate = NSPredicate(format: "SELF.Location contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.FunctionalLocation.value:
                            let predicate = NSPredicate(format: "SELF.FunctionalLoc contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.Equipment.value:
                            let predicate = NSPredicate(format: "SELF.Equipment contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.CreatedOrAssigned.value:
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                        default:
                            print("Filter Not Found")
                        }
                        let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                        let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                        filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.Location.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.Location == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.Location == %@", "\(thirdFilterItem)");
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.FunctionalLocation.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        case Filters.Equipment.value:
                            filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)")}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.FunctionalLoc contains[cd] %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.FunctionalLoc contains[cd] %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.Equipment.value:
                        var filterarray = [NotificationModel]()
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.NotificationType.value:
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.NotificationType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(wrkcls.ObjectID)"}
                            }
                        case Filters.PlanningPlant.value:
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.WorkorderConversion.value:
                            switch fourthFilterItem {
                            case Filters.WorkorderCreated.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WorkOrderNum != ""}
                            case Filters.WorkorderNotCreated.value:
                                filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WorkOrderNum == ""}
                            default:
                                print("Filter Not Found")
                            }
                        case Filters.Location.value:
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allNotficationArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.FunctionalLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.Equipment contains[cd] %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.Equipment contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.WorkorderConversion.value:
                        var filterarray = [NotificationModel]()
                        let predicateArr = NSMutableArray()
                        switch thirdFilterItem {
                        case Filters.WorkorderCreated.value:
                            let predicate = NSPredicate(format: "SELF.WorkOrderNum != %@","");
                            predicateArr.add(predicate)
                        case Filters.WorkorderNotCreated.value:
                            let predicate = NSPredicate(format: "SELF.WorkOrderNum == %@","");
                            predicateArr.add(predicate)
                        default:
                            print("Filter Not Found")
                        }
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            let predicate = NSPredicate(format: "SELF.Priority == %@", priority);
                            predicateArr.add(predicate)
                        case Filters.Status.value:
                            let predicate = NSPredicate(format: "SELF.MobileStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.UserStatus.value:
                            let predicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.SystemStatus.value:
                            let predicate = NSPredicate(format: "SELF.SystemStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.NotificationType.value:
                            let predicate = NSPredicate(format: "SELF.NotificationType == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                let predicate = NSPredicate(format: "SELF.WorkCenter == %@","\(wrkcls.ObjectID)");
                                predicateArr.add(predicate)
                            }
                        case Filters.PlanningPlant.value:
                            let predicate = NSPredicate(format: "SELF.PlanningPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlannerGroup.value:
                            let predicate = NSPredicate(format: "SELF.PlannerGroup == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MaintenancePlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                let predicate = NSPredicate(format: "SELF.Equipment == %@","\(equipCls.Equipment)");
                                predicateArr.add(predicate)
                            }
                        case Filters.Location.value:
                            let predicate = NSPredicate(format: "SELF.Location contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.FunctionalLocation.value:
                            let predicate = NSPredicate(format: "SELF.FunctionalLoc contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.Equipment.value:
                            let predicate = NSPredicate(format: "SELF.Equipment contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.CreatedOrAssigned.value:
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                        case Filters.Date.value:
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        default:
                            print("Filter Not Found")
                        }
                        let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                        let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                        filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.CreatedOrAssigned.value:
                        var filterarray = [NotificationModel]()
                        let predicateArr = NSMutableArray()
                        if thirdFilterItem == Filters.AssignedToMe.value{
                            let predicate = NSPredicate(format: "SELF.Partner == %@", userPersonnelNo as CVarArg);
                            predicateArr.add(predicate)
                        }else if thirdFilterItem == Filters.CreatedByMe.value{
                            let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                            predicateArr.add(predicate)
                        }
                        switch secondFilterItem {
                        case Filters.Priority.value:
                            var priority = ""
                            if thirdFilterItem != Filters.NoPriority.value{
                                let priorityArr = globalPriorityArray.filter{ $0.PriorityText == fourthFilterItem}
                                if priorityArr.count > 0{
                                    let priorityCls = priorityArr[0]
                                    priority = priorityCls.Priority
                                }
                            }
                            let predicate = NSPredicate(format: "SELF.Priority == %@", priority);
                            predicateArr.add(predicate)
                        case Filters.Status.value:
                            let predicate = NSPredicate(format: "SELF.MobileObjStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.UserStatus.value:
                            let predicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.SystemStatus.value:
                            let predicate = NSPredicate(format: "SELF.SysStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.OrderType.value:
                            let predicate = NSPredicate(format: "SELF.NotificationType == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.WorkCenter.value:
                            let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == fourthFilterItem}
                            if wrkctrclsArray.count > 0 {
                                let wrkcls = wrkctrclsArray[0]
                                let predicate = NSPredicate(format: "SELF.WorkCenter == %@","\(wrkcls.ObjectID)");
                                predicateArr.add(predicate)
                            }
                        case Filters.PlanningPlant.value:
                            let predicate = NSPredicate(format: "SELF.PlanningPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlannerGroup.value:
                            let predicate = NSPredicate(format: "SELF.PlannerGroup == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MaintenancePlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                let predicate = NSPredicate(format: "SELF.Equipment == %@","\(equipCls.Equipment)");
                                predicateArr.add(predicate)
                            }
                        case Filters.Location.value:
                            let predicate = NSPredicate(format: "SELF.Location == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.FunctionalLocation.value:
                            let predicate = NSPredicate(format: "SELF.FunctionalLoc contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.Equipment.value:
                            let predicate = NSPredicate(format: "SELF.Equipment contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.Date.value:
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            default:
                               print("Filter Not Found")
                            }
                        default:
                            print("Filter Not Found")
                        }
                        let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                        let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                        filterarray = allNotficationArray.filter{compound.evaluate(with: $0)}
                        if (filterarray.count > 0){
                            if from  == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    default:
                        print("Filter Not Found")
                    }
                }
            }
            finalDict["count"] = countarr
            finalDict["color"] = colorArr
            finalDict["legend"] = legendArr
            finalDict["List"] = filteredArr
            return finalDict
        }else if fourthFilterArr.count == 0{
            var countarr = Array<Int>()
            var colorArr = Array<UIColor>()
            var legendArr = Array<String>()
            var filteredArr = [NotificationModel]()
            switch firstFilterItem {
            case Filters.Priority.value:
                for pri in thirdFilterArr{
                    var priority = ""
                    let priorityArr = globalPriorityArray.filter{ $0.PriorityText == pri}
                    if priorityArr.count > 0{
                        let priorityCls = priorityArr[0]
                        priority = priorityCls.Priority
                    }
                    let filterarray = allNotficationArray.filter{ $0.Priority == priority}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setPriorityFilterColor(priority: priority))
                            legendArr.append("\(pri)")
                            self.dBVc!.finalFiltervalues["\(pri)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.Status.value:
                for status in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{$0.MobileStatus.contains(find: status)}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(status)")
                            self.dBVc!.finalFiltervalues["\(status)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.UserStatus.value:
                for status in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{ $0.UserStatus.contains(find: status)}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(status)")
                            self.dBVc!.finalFiltervalues["\(status)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.SystemStatus.value:
                for status in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{$0.SystemStatus.contains(find: status)}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(status)")
                            self.dBVc!.finalFiltervalues["\(status)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.NotificationType.value:
                for orderType in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{ $0.NotificationType == orderType}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(orderType)")
                            self.dBVc!.finalFiltervalues["\(orderType)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.WorkCenter.value:
                for workcenter in thirdFilterArr{
                    let wrkctrclsArray = globalWorkCtrArray.filter{$0.WorkCenter == workcenter}
                    if wrkctrclsArray.count > 0 {
                        let wrkcls = wrkctrclsArray[0]
                        let filterarray = allNotficationArray.filter{ $0.WorkCenter == wrkcls.ObjectID}
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(workcenter)")
                                self.dBVc!.finalFiltervalues["\(workcenter)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    }
                }
            case Filters.WorkorderConversion.value:
                for type in thirdFilterArr{
                    if type == Filters.WorkorderCreated.value {
                        let filterarray = allNotficationArray.filter{ $0.WorkOrderNum != ""}
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(type)")
                                self.dBVc!.finalFiltervalues[type] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    }else if type == Filters.WorkorderNotCreated.value {
                        let filterarray = allNotficationArray.filter{ $0.WorkOrderNum == ""}
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(type)")
                                self.dBVc!.finalFiltervalues[type] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    }
                }
            case Filters.PlanningPlant.value:
                for status in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{$0.PlanningPlant == status}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(status)")
                            self.dBVc!.finalFiltervalues["\(status)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.PlannerGroup.value:
                for status in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{$0.PlannerGroup == status}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(status)")
                            self.dBVc!.finalFiltervalues["\(status)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.MaintenancePlant.value:
                for status in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{$0.MaintPlant == status}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(status)")
                            self.dBVc!.finalFiltervalues["\(status)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.TechID.value:
                for status in thirdFilterArr{
                    let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(status)"}
                    if equipArr.count > 0{
                        let equipCls = equipArr[0]
                        let filterarray = allNotficationArray.filter{$0.Equipment == "\(equipCls.Equipment)"}
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(status)")
                                self.dBVc!.finalFiltervalues["\(status)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    }
                }
            case Filters.Location.value:
                for status in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{$0.Location == status}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(status)")
                            self.dBVc!.finalFiltervalues["\(status)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.FunctionalLocation.value:
                for funcLoc in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{ $0.FunctionalLoc.containsIgnoringCase(find: "\(funcLoc)")}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(funcLoc)")
                            self.dBVc!.finalFiltervalues["\(funcLoc)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.Equipment.value:
                for funcLoc in thirdFilterArr{
                    let filterarray = allNotficationArray.filter{$0.Equipment.containsIgnoringCase(find: "\(funcLoc)")}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(funcLoc)")
                            self.dBVc!.finalFiltervalues["\(funcLoc)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.CreatedOrAssigned.value:
                for type in thirdFilterArr{
                    if type == Filters.AssignedToMe.value {
                        let filterarray = allNotficationArray.filter{ $0.Partner == userPersonnelNo}
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(type)")
                                self.dBVc!.finalFiltervalues[type] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    }else if type == Filters.CreatedByMe.value {
                        let filterarray = allNotficationArray.filter{ $0.EnteredBy == userDisplayName}
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(type)")
                                self.dBVc!.finalFiltervalues[type] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    }
                }
            case Filters.Date.value:
                for thirdFilterItem in thirdFilterArr{
                    switch thirdFilterItem {
                    case Filters.PlannedForToday.value:
                        let currentDate = Date().localDate()
                        let predicate = NSPredicate(format: "SELF.RequiredStartDate == %@", currentDate as CVarArg);
                        let filterarray = allNotficationArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.PlannedForToday.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.PlannedForToday.value)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.PlannedForTomorrow.value:
                       let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let predicate = NSPredicate(format: "SELF.RequiredStartDate == %@", tomorroDate as CVarArg);
                        let filterarray = allNotficationArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.PlannedForTomorrow.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.PlannedForTomorrow.value)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.PlannedforNextWeek.value:
                        let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let predicate = NSPredicate(format: "(SELF.RequiredStartDate >= %@ and SELF.RequiredEndDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                        let filterarray = allNotficationArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.PlannedforNextWeek.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.PlannedforNextWeek.value)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.OverdueForLastTwodays.value:
                        let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                        let predicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                        let filterarray = allNotficationArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.OverdueForLastTwodays.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.OverdueForLastTwodays.value)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.OverdueForAWeek.value:
                        let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                        let predicate = NSPredicate(format: "(SELF.RequiredEndDate <= %@ and SELF.RequiredStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                        let filterarray = allNotficationArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.OverdueForAWeek.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.OverdueForAWeek.value)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.AllOverdue.value:
                        let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let predicate = NSPredicate(format: "SELF.RequiredEndDate < %@",currentDate as CVarArg)
                        let filterarray = allNotficationArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.AllOverdue.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.AllOverdue.value)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.CreatedInLast30Days.value:
                        let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                        let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                        let filterarray = allNotficationArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.CreatedInLast30Days.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.CreatedInLast30Days.value)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    default:
                       print("Filter Not Found")
                    }
                }
            default:
                print("Filter Not Found")
            }
            finalDict["count"] = countarr
            finalDict["color"] = colorArr
            finalDict["legend"] = legendArr
            finalDict["List"] = filteredArr
            return finalDict
        }
        return Dictionary<String,Any>()
    }
}
