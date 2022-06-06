//
//  opFilter.swift
//  myJobCard
//
//  Created by Suri on 29/07/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class OperationFiltersViewModel {

    var dBVc: DashboardStyle2?
    
    public func applyOperationFilter(firstFilterItem:String,secondFilterItem:String,thirdFilterArr:[String],fourthFilterArr:[String],from:String) -> Dictionary<String,Any>{
        var finalDict = Dictionary<String,Any>()
        if thirdFilterArr.count > 0 && fourthFilterArr.count > 0{
            
            var countarr = Array<Int>()
            var colorArr = Array<UIColor>()
            var legendArr = Array<String>()
            var filteredArr = [WoOperationModel]()

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
                        var filterarray = [WoOperationModel]()
                        switch secondFilterItem {
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.MobileStatus == "\(fourthFilterItem)"}
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.WoPriority == %@", priority);
                            predicateArr.add(PriorityPredicate)

                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}
                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{ $0.WoPriority == "\(priority)" && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.Status.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.WoPriority == "\(priority)"}
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MobileStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)

                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{ $0.MobileStatus.contains(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.UserStatus.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.SystemStatus.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.SystemStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}
                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{ $0.SystemStatus.contains(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.OrderType.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.OrderType == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.WorkCenter.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)" }
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.PlanningPlant == "\(fourthFilterItem)" }
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)" }
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.WorkCenter == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{ $0.WorkCenter == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.PlanningPlant.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.PlanningPlant == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{ $0.PlanningPlant == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.MaintenancePlant.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MaintPlanningPlant == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.Date.value:
                        var filterarray = [WoOperationModel]()
                        
                        let predicateArr = NSMutableArray()
                        
                        switch thirdFilterItem {
                        case Filters.PlannedForToday.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                            predicateArr.add(datePredicate)
                        case Filters.PlannedForTomorrow.value:
                           let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                            predicateArr.add(datePredicate)
                        case Filters.PlannedforNextWeek.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                            predicateArr.add(datePredicate)
                        case Filters.OverdueForLastTwodays.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                            let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                            predicateArr.add(overduePredicate)
                        case Filters.OverdueForAWeek.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                            let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                            predicateArr.add(overduePredicate)
                        case Filters.AllOverdue.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                            predicateArr.add(overduePredicate)
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
                            let predicate = NSPredicate(format: "SELF.WoPriority == %@", priority);
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
                        case Filters.OrderType.value:
                            let predicate = NSPredicate(format: "SELF.OrderType == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.WorkCenter.value:
                            let predicate = NSPredicate(format: "SELF.WorkCenter == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlanningPlant.value:
                            let predicate = NSPredicate(format: "SELF.PlanningPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MaintenancePlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlanningPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.FunctionalLocation.value:
                            let predicate = NSPredicate(format: "SELF.FuncLocation contains[cd] %@" ,"\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.Equipment.value:
                            let predicate = NSPredicate(format: "SELF.Equipment contains[cd] %@" ,"\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlannerGroup.value:
                            let predicate = NSPredicate(format: "SELF.PlannerGroup == %@","\(fourthFilterItem)");
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
                        default:
                            print("Filter Not Found")
                        }
                        
                        let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                        let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                        filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.FunctionalLocation.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{$0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MobileStatus.contains(find: "\(fourthFilterItem)") }
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.FuncLoc contains[cd] %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{$0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }

                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{$0.FuncLoc.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.Equipment.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{$0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MobileStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{$0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{$0.Equipment.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.PlannerGroup.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)") }
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.PlannerGroup == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.TechID.value:
                        var filterarray = [WoOperationModel]()
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
                                filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.WoPriority == "\(priority)" }
                            case Filters.Status.value:
                                filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.MobileStatus.contains(find: "\(fourthFilterItem)") }
                            case Filters.UserStatus.value:
                                filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.SystemStatus.value:
                                filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.OrderType.value:
                                filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.OrderType == "\(fourthFilterItem)"}
                            case Filters.WorkCenter.value:
                                filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.WorkCenter == "\(fourthFilterItem)"}
                            case Filters.PlanningPlant.value:
                                filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                            case Filters.MaintenancePlant.value:
                                filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                            case Filters.Date.value:
                                let predicateArr = NSMutableArray()
                                let PriorityPredicate = NSPredicate(format: "SELF.Equipment == %@", "\(equipCls.Equipment)");
                                predicateArr.add(PriorityPredicate)
                                switch fourthFilterItem {
                                case Filters.PlannedForToday.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                    predicateArr.add(datePredicate)
                                case Filters.PlannedForTomorrow.value:
                                   let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                    predicateArr.add(datePredicate)
                                case Filters.PlannedforNextWeek.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                    predicateArr.add(datePredicate)
                                case Filters.OverdueForLastTwodays.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                    let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.OverdueForAWeek.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                    let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.AllOverdue.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                default:
                                    print("Filter Not Found")
                                }
                                let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                                let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                            case Filters.FunctionalLocation.value:
                                filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)" && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                            case Filters.Equipment.value:
                                filterarray = allOperationsArray.filter{  $0.Equipment == "\(equipCls.Equipment)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                            case Filters.PlannerGroup.value:
                                filterarray = allOperationsArray.filter{  $0.Equipment == "\(equipCls.Equipment)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                            case Filters.Location.value:
                                filterarray = allOperationsArray.filter{  $0.Equipment == "\(equipCls.Equipment)" && $0.Location == "\(fourthFilterItem)"}
                            default:
                                print("Filter Not Found")
                            }
                            if (filterarray.count > 0){
                                if from == "DB"{
                                    countarr.append(filterarray.count)
                                    colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                    legendArr.append("\(thirdFilterItem) - \(fourthFilterItem)")
                                    dBVc!.finalFiltervalues["\(thirdFilterItem) - \(fourthFilterItem)"] = filterarray
                                }else{
                                    filteredArr.append(contentsOf: filterarray)
                                }
                            }
                        }
                    case Filters.Location.value:
                        var filterarray = [WoOperationModel]()
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
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.WoPriority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.SystemStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.WorkCenter == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.PlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.Location == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.LatestSchStartDate >= %@ and SELF.LatestSchFinishDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allOperationsArray.filter{compound.evaluate(with: $0)}

                        case Filters.FunctionalLocation.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.FuncLoc.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.Equipment.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.PlannerGroup.value:
                            filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.PlannerGroup == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allOperationsArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.Equipment == "\(equipCls.Equipment)"}
                            }
                        default:
                            print("Filter Not Found")
                        }
                        if (filterarray.count > 0){
                            if from == "DB"{
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
                    print("Filter Not Found")
                }
                print("Filter Not Found")
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
            var filteredArr = [WoOperationModel]()
            switch firstFilterItem {
            case Filters.Priority.value:
                for pri in thirdFilterArr{
                    var priority = ""
                    let priorityArr = globalPriorityArray.filter{ $0.PriorityText == pri}
                    if priorityArr.count > 0{
                        let priorityCls = priorityArr[0]
                        priority = priorityCls.Priority
                    }
                    let filterarray = allOperationsArray.filter{ $0.WoPriority == priority}
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
                    let filterarray = allOperationsArray.filter{$0.MobileStatus.contains(find: status)}
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
                    let filterarray = allOperationsArray.filter{$0.UserStatus.contains(find: status)}
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
                    let filterarray = allOperationsArray.filter{$0.SystemStatus.contains(find: status)}
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
            case Filters.OrderType.value:
                for orderType in thirdFilterArr{
                    let filterarray = allOperationsArray.filter{$0.OrderType == "\(orderType)"}
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
                    let filterarray = allOperationsArray.filter{$0.WorkCenter == "\(workcenter)"}
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
            case Filters.PlanningPlant.value:
                for plant in thirdFilterArr{
                    let filterarray = allOperationsArray.filter{$0.PlanningPlant == "\(plant)"}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(plant)")
                            self.dBVc!.finalFiltervalues["\(plant)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.MaintenancePlant.value:
                for plant in thirdFilterArr{
                    let filterarray = allOperationsArray.filter{$0.MaintPlanningPlant == "\(plant)"}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(plant)")
                            self.dBVc!.finalFiltervalues["\(plant)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.Date.value:
                
                for thirdFilterItem in thirdFilterArr{
                    switch thirdFilterItem {
                    case Filters.PlannedForToday.value:
                        let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let predicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", currentDate as CVarArg);
                        let filterarray = allOperationsArray.filter{predicate.evaluate(with: $0) }
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
                        let predicate = NSPredicate(format: "SELF.LatestSchStartDate == %@", tomorroDate as CVarArg);
                        let filterarray = allOperationsArray.filter{predicate.evaluate(with: $0) }
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
                        let predicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,futureDate as CVarArg)
                        let filterarray = allOperationsArray.filter{predicate.evaluate(with: $0) }
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
                        let predicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                        let filterarray = allOperationsArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.OverdueForLastTwodays.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.OverdueForLastTwodays.value)"] = filterarray
                            }
                        }
                    case Filters.OverdueForAWeek.value:
                        let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                        let predicate = NSPredicate(format: "(SELF.LatestSchFinishDate <= %@ and SELF.LatestSchStartDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                        let filterarray = allOperationsArray.filter{predicate.evaluate(with: $0) }
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
                        let predicate = NSPredicate(format: "SELF.LatestSchFinishDate < %@",currentDate as CVarArg)
                        let filterarray = allOperationsArray.filter{predicate.evaluate(with: $0) }
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
                    default:
                        print("Filter Not Found")
                    }
                }
            case Filters.FunctionalLocation.value:
                for funcLoc in thirdFilterArr{
                    let filterarray = allOperationsArray.filter{ $0.FuncLoc.containsIgnoringCase(find: "\(funcLoc)")}
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
                for equip in thirdFilterArr{
                    let filterarray = allOperationsArray.filter{ $0.Equipment.containsIgnoringCase(find: "\(equip)")}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(equip)")
                            self.dBVc!.finalFiltervalues["\(equip)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.PlannerGroup.value:
                for group in thirdFilterArr{
                    let filterarray = allOperationsArray.filter{ $0.PlannerGroup == "\(group)"}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(group)")
                            self.dBVc!.finalFiltervalues["\(group)"] = filterarray
                        }
                    }
                }
            case Filters.TechID.value:
                for techId in thirdFilterArr{
                    let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(techId)"}
                    if equipArr.count > 0{
                        let equipCls = equipArr[0]
                        let filterarray = allOperationsArray.filter{ $0.Equipment == "\(equipCls.Equipment)"}
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(techId)")
                                self.dBVc!.finalFiltervalues["\(techId)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    }
                }
            case Filters.Location.value:
                for location in thirdFilterArr{
                    let filterarray = allOperationsArray.filter{ $0.Location == "\(location)"}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(location)")
                            self.dBVc!.finalFiltervalues["\(location)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
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
