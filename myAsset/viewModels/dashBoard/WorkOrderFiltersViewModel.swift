//
//  woFilter.swift
//  myJobCard
//
//  Created by Suri on 29/07/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class WorkOrderFiltersViewModel {

    var dBVc: DashboardStyle2?
public func applyWoFilter(firstFilterItem:String,secondFilterItem:String,thirdFilterArr:[String],fourthFilterArr:[String],from:String) -> Dictionary<String,Any>{
        var finalDict = Dictionary<String,Any>()
        if thirdFilterArr.count > 0 && fourthFilterArr.count > 0{
            
            var countarr = [Int]()
            var colorArr = [UIColor]()
            var legendArr = [String]()
            var filteredArr = [WoHeaderModel]()

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
                        var filterarray = [WoHeaderModel]()
                        switch secondFilterItem {
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)") }
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" &&    $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.Priority == "\(priority)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{$0.Priority == "\(priority)" && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{$0.Priority == "\(priority)" && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.Priority == %@", priority);
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.Priority == %@", priority);
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.Priority == %@", priority);
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)" }
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{$0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.Location == "\(thirdFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus.contains(find: "\(thirdFilterItem)") && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.MobileObjStatus contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MobileObjStatus contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MobileObjStatus contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: "\(thirdFilterItem)") && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{$0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.SysStatus.contains(find: "\(thirdFilterItem)") && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.SysStatus contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.SysStatus contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.SysStatus contains[cd] %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.MobileObjStatus == "\(thirdFilterItem)" && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.OrderType == "\(thirdFilterItem)" && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.OrderType contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.OrderType contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.OrderType == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.MainWorkCtr == "\(thirdFilterItem)" && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.MainWorkCtr == %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MainWorkCtr == %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MainWorkCtr == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlanningPlant == "\(thirdFilterItem)" && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.MaintPlanningPlant == %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MaintPlanningPlant == %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let predicate = NSPredicate(format: "SELF.MaintPlanningPlant == %@", thirdFilterItem);
                            predicateArr.add(predicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.ResponsiblPlannerGrp == "\(thirdFilterItem)" && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.ResponsiblPlannerGrp == %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.ResponsiblPlannerGrp == %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.ResponsiblPlannerGrp == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.MaintPlant == "\(thirdFilterItem)" && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.MaintPlant == %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MaintPlant == %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MaintPlant == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.Priority == "\(priority)"}
                            case Filters.Status.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.UserStatus.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.SystemStatus.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                            case Filters.OrderType.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.OrderType == "\(fourthFilterItem)"}
                            case Filters.WorkCenter.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                            case Filters.MantActivityType.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                            case Filters.PlanningPlant.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                            case Filters.PlannerGroup.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                            case Filters.MaintenancePlant.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.MaintPlant == "\(fourthFilterItem)"}
                            case Filters.Location.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.Location == "\(fourthFilterItem)"}
                            case Filters.FunctionalLocation.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                            case Filters.Equipment.value:
                                filterarray = allworkorderArray.filter{ $0.EquipNum == "\(equipCls.Equipment)" && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                            case Filters.InspectionLot.value:
                                let predicateArr = NSMutableArray()
                                let priorityPredicate = NSPredicate(format: "SELF.EquipNum == %@", "\(thirdFilterItem)");
                                predicateArr.add(priorityPredicate)
                                if fourthFilterItem == Filters.InspectionCompleted.value{
                                    let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                    var woNoArr = [String]()
                                    if oprArr.count > 0{
                                        let woArr = oprArr.unique{$0.WorkOrderNum}
                                        for item in woArr{
                                            woNoArr.append(item.WorkOrderNum)
                                        }
                                        let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                        predicateArr.add(predicate)
                                    }
                                }else if fourthFilterItem == Filters.InspectionPending.value{
                                    let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                    var woNoArr = [String]()
                                    if oprArr.count > 0{
                                        let woArr = oprArr.unique{$0.WorkOrderNum}
                                        for item in woArr{
                                            woNoArr.append(item.WorkOrderNum)
                                        }
                                        let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                        predicateArr.add(predicate)
                                    }
                                }
                                let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                                let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                            case Filters.CreatedOrAssigned.value:
                                let predicateArr = NSMutableArray()
                                let PriorityPredicate = NSPredicate(format: "SELF.EquipNum == %@", "\(thirdFilterItem)");
                                predicateArr.add(PriorityPredicate)
                                if fourthFilterItem == Filters.AssignedToMe.value{
                                    let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                    predicateArr.add(predicate)
                                }else if fourthFilterItem == Filters.CreatedByMe.value{
                                    let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                    predicateArr.add(predicate)
                                }
                                let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                                let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                            case Filters.Date.value:
                                let predicateArr = NSMutableArray()
                                let PriorityPredicate = NSPredicate(format: "SELF.EquipNum == %@", thirdFilterItem);
                                predicateArr.add(PriorityPredicate)
                                switch fourthFilterItem {
                                case Filters.PlannedForToday.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                    predicateArr.add(datePredicate)
                                case Filters.PlannedForTomorrow.value:
                                   let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                    predicateArr.add(datePredicate)
                                case Filters.PlannedforNextWeek.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                    predicateArr.add(datePredicate)
                                case Filters.OverdueForLastTwodays.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                    let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.OverdueForAWeek.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                    let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.AllOverdue.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                    predicateArr.add(overduePredicate)
                                case Filters.CreatedInLast30Days.value:
                                    let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                    let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                    let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                    predicateArr.add(predicate)
                                case Filters.SchedulingComplaint.value:
                                    let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                    predicateArr.add(predicate)
                                case Filters.SchedulingNonComplaint.value:
                                    let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                    predicateArr.add(predicate)
                                default:
                                    print("Filter Not Found")
                                }
                                let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                                let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                                filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                    case Filters.Date.value:
                        var filterarray = [WoHeaderModel]()
                        let predicateArr = NSMutableArray()
                        switch thirdFilterItem {
                        case Filters.PlannedForToday.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                            predicateArr.add(datePredicate)
                        case Filters.PlannedForTomorrow.value:
                           let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                            predicateArr.add(datePredicate)
                        case Filters.PlannedforNextWeek.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                            predicateArr.add(datePredicate)
                        case Filters.OverdueForLastTwodays.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                            let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                            predicateArr.add(overduePredicate)
                        case Filters.OverdueForAWeek.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                            let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                            predicateArr.add(overduePredicate)
                        case Filters.AllOverdue.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                            predicateArr.add(overduePredicate)
                        case Filters.CreatedInLast30Days.value:
                            let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                            let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                            let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                            predicateArr.add(predicate)
                        case Filters.SchedulingComplaint.value:
                            let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                            predicateArr.add(predicate)
                        case Filters.SchedulingNonComplaint.value:
                            let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
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
                            let predicate = NSPredicate(format: "SELF.MobileObjStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.UserStatus.value:
                            let predicate = NSPredicate(format: "SELF.UserStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.SystemStatus.value:
                            let predicate = NSPredicate(format: "SELF.SysStatus contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.OrderType.value:
                            let predicate = NSPredicate(format: "SELF.OrderType == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.WorkCenter.value:
                            let predicate = NSPredicate(format: "SELF.MainWorkCtr == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MantActivityType.value:
                            let predicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlanningPlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlanningPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlannerGroup.value:
                            let predicate = NSPredicate(format: "SELF.ResponsiblPlannerGrp == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MaintenancePlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                let predicate = NSPredicate(format: "SELF.EquipNum == %@","\(equipCls.Equipment)");
                                predicateArr.add(predicate)
                            }
                        case Filters.Location.value:
                            let predicate = NSPredicate(format: "SELF.Location == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.FunctionalLocation.value:
                            let predicate = NSPredicate(format: "SELF.FuncLocation contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.Equipment.value:
                            let predicate = NSPredicate(format: "SELF.EquipNum contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.InspectionLot.value:
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                        case Filters.CreatedOrAssigned.value:
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
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
                        filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                    case Filters.Location.value:
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{$0.Location == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{$0.Location == "\(thirdFilterItem)" && $0.MobileObjStatus == "\(fourthFilterItem)"}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{$0.Location == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{$0.Location == "\(thirdFilterItem)" && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.Location == "\(thirdFilterItem)" && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.Location == %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.Location == %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.Location == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                    case Filters.FunctionalLocation.value:
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Location.contains(find: "\(fourthFilterItem)")}
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.FuncLocation contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.FuncLocation contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.FuncLocation contains[cd] %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.MantActivityType.value:
                            filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintActivityTypeText == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{$0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{$0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{$0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.EquipNum.containsIgnoringCase(find: "\(thirdFilterItem)") && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)")}
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.EquipNum contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.EquipNum contains[cd] %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.EquipNum contains[cd] %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                    case Filters.MantActivityType.value:
                        var filterarray = [WoHeaderModel]()
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
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.Priority == "\(priority)"}
                        case Filters.Status.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.MobileObjStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.UserStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.UserStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.SystemStatus.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.SysStatus.contains(find: "\(fourthFilterItem)")}
                        case Filters.OrderType.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.OrderType == "\(fourthFilterItem)"}
                        case Filters.WorkCenter.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.MainWorkCtr == "\(fourthFilterItem)"}
                        case Filters.PlanningPlant.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.MaintPlanningPlant == "\(fourthFilterItem)"}
                        case Filters.PlannerGroup.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.ResponsiblPlannerGrp == "\(fourthFilterItem)"}
                        case Filters.MaintenancePlant.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.MaintPlant == "\(fourthFilterItem)"}
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.EquipNum == "\(equipCls.Equipment)"}
                            }
                        case Filters.Location.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.Location == "\(fourthFilterItem)"}
                        case Filters.FunctionalLocation.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.FuncLocation.containsIgnoringCase(find: "\(fourthFilterItem)") }
                        case Filters.Equipment.value:
                            filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == "\(thirdFilterItem)" && $0.EquipNum.containsIgnoringCase(find: "\(fourthFilterItem)") }
                        case Filters.InspectionLot.value:
                            let predicateArr = NSMutableArray()
                            let priorityPredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@", "\(thirdFilterItem)");
                            predicateArr.add(priorityPredicate)
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.CreatedOrAssigned.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@", "\(thirdFilterItem)");
                            predicateArr.add(PriorityPredicate)
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
                        case Filters.Date.value:
                            let predicateArr = NSMutableArray()
                            let PriorityPredicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@", thirdFilterItem);
                            predicateArr.add(PriorityPredicate)
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                            let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                            let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                            filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                    case Filters.CreatedOrAssigned.value:
                        var filterarray = [WoHeaderModel]()
                        let predicateArr = NSMutableArray()
                        if thirdFilterItem == Filters.AssignedToMe.value{
                            let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
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
                            let predicate = NSPredicate(format: "SELF.OrderType == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.WorkCenter.value:
                            let predicate = NSPredicate(format: "SELF.MainWorkCtr == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MantActivityType.value:
                            let predicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlanningPlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlanningPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlannerGroup.value:
                            let predicate = NSPredicate(format: "SELF.ResponsiblPlannerGrp == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MaintenancePlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                let predicate = NSPredicate(format: "SELF.EquipNum == %@","\(equipCls.Equipment)");
                                predicateArr.add(predicate)
                            }
                        case Filters.Location.value:
                            let predicate = NSPredicate(format: "SELF.Location == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.FunctionalLocation.value:
                            let predicate = NSPredicate(format: "SELF.FuncLocation contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.Equipment.value:
                            let predicate = NSPredicate(format: "SELF.EquipNum contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.InspectionLot.value:
                            if fourthFilterItem == Filters.InspectionCompleted.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }else if fourthFilterItem == Filters.InspectionPending.value{
                                let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                                var woNoArr = [String]()
                                if oprArr.count > 0{
                                    let woArr = oprArr.unique{$0.WorkOrderNum}
                                    for item in woArr{
                                        woNoArr.append(item.WorkOrderNum)
                                    }
                                    let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                    predicateArr.add(predicate)
                                }
                            }
                        case Filters.Date.value:
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                        default:
                            print("Filter Not Found")
                        }
                        let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                        let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                        filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
                    case Filters.InspectionLot.value:
                        var filterarray = [WoHeaderModel]()
                        let predicateArr = NSMutableArray()
                        if thirdFilterItem == Filters.InspectionCompleted.value{
                            let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                            var woNoArr = [String]()
                            if oprArr.count > 0{
                                let woArr = oprArr.unique{$0.WorkOrderNum}
                                for item in woArr{
                                    woNoArr.append(item.WorkOrderNum)
                                }
                                let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                predicateArr.add(predicate)
                            }
                        }else if thirdFilterItem == Filters.InspectionPending.value{
                            let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                            var woNoArr = [String]()
                            if oprArr.count > 0{
                                let woArr = oprArr.unique{$0.WorkOrderNum}
                                for item in woArr{
                                    woNoArr.append(item.WorkOrderNum)
                                }
                                let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                                predicateArr.add(predicate)
                            }
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
                            let predicate = NSPredicate(format: "SELF.OrderType == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.WorkCenter.value:
                            let predicate = NSPredicate(format: "SELF.MainWorkCtr == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MantActivityType.value:
                            let predicate = NSPredicate(format: "SELF.MaintActivityTypeText == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlanningPlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlanningPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.PlannerGroup.value:
                            let predicate = NSPredicate(format: "SELF.ResponsiblPlannerGrp == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.MaintenancePlant.value:
                            let predicate = NSPredicate(format: "SELF.MaintPlant == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.TechID.value:
                            let equipArr = self.dBVc!.style2ViewModel.equipmentArr.filter{$0.TechIdentNo == "\(fourthFilterItem)"}
                            if equipArr.count > 0{
                                let equipCls = equipArr[0]
                                let predicate = NSPredicate(format: "SELF.EquipNum == %@","\(equipCls.Equipment)");
                                predicateArr.add(predicate)
                            }
                        case Filters.Location.value:
                            let predicate = NSPredicate(format: "SELF.Location == %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.FunctionalLocation.value:
                            let predicate = NSPredicate(format: "SELF.FuncLocation contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.Equipment.value:
                            let predicate = NSPredicate(format: "SELF.EquipNum contains[cd] %@","\(fourthFilterItem)");
                            predicateArr.add(predicate)
                        case Filters.CreatedOrAssigned.value:
                            if fourthFilterItem == Filters.AssignedToMe.value{
                                let predicate = NSPredicate(format: "SELF.PersonResponsible == %@", userPersonnelNo as CVarArg);
                                predicateArr.add(predicate)
                            }else if fourthFilterItem == Filters.CreatedByMe.value{
                                let predicate = NSPredicate(format: "SELF.EnteredBy == %@", userDisplayName as CVarArg);
                                predicateArr.add(predicate)
                            }
                        case Filters.Date.value:
                            switch fourthFilterItem {
                            case Filters.PlannedForToday.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedForTomorrow.value:
                               let tomorroDate = Date(fromString: Date().adjust(.day, offset: 1).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                                predicateArr.add(datePredicate)
                            case Filters.PlannedforNextWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let futureDate = Date(fromString: Date().adjust(.day, offset: 7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let datePredicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                                predicateArr.add(datePredicate)
                            case Filters.OverdueForLastTwodays.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.OverdueForAWeek.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overDueDate = Date(fromString: Date().adjust(.day, offset: -7).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -7)
                                let overduePredicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.AllOverdue.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let overduePredicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                                predicateArr.add(overduePredicate)
                            case Filters.CreatedInLast30Days.value:
                                let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                                let lastDate = Date(fromString: Date().localDate().adjust(.day, offset: -30).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -30)
                                let predicate = NSPredicate(format: "(SELF.CreatedOn >= %@ and SELF.CreatedOn < %@)", lastDate as CVarArg,currentDate as CVarArg)
                                predicateArr.add(predicate)
                            case Filters.SchedulingComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            case Filters.SchedulingNonComplaint.value:
                                let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                                predicateArr.add(predicate)
                            default:
                                print("Filter Not Found")
                            }
                        default:
                            print("Filter Not Found")
                        }
                        let finalPredicateArray : [NSPredicate] = predicateArr as NSArray as! [NSPredicate]
                        let compound : NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: finalPredicateArray)
                        filterarray = allworkorderArray.filter{compound.evaluate(with: $0)}
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
            var filteredArr = [WoHeaderModel]()
            switch firstFilterItem {
            case Filters.Priority.value:
                for pri in thirdFilterArr{
                    var priority = ""
                    let priorityArr = globalPriorityArray.filter{ $0.PriorityText == pri}
                    if priorityArr.count > 0{
                        let priorityCls = priorityArr[0]
                        priority = priorityCls.Priority
                    }
                    let filterarray = allworkorderArray.filter{ $0.Priority == priority}
                    if from == "DB"{
                        countarr.append(filterarray.count)
                        colorArr.append(myAssetDataManager.setPriorityFilterColor(priority: priority))
                        legendArr.append("\(pri)")
                        self.dBVc!.finalFiltervalues["\(pri)"] = filterarray
                    }else{
                        filteredArr.append(contentsOf: filterarray)
                    }
                }
            case Filters.Status.value:
                for status in thirdFilterArr{
                    let filterarray = allworkorderArray.filter{$0.MobileObjStatus.contains(find: status)}
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
                    let filterarray = allworkorderArray.filter{ $0.UserStatus.contains(find: status)}
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
                    let filterarray = allworkorderArray.filter{$0.SysStatus.contains(find: status)}
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
                    let filterarray = allworkorderArray.filter{ $0.OrderType == orderType}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(orderType)")
                            self.dBVc!.finalFiltervalues["\(orderType)"] = filterarray}else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                    }
                }
            case Filters.WorkCenter.value:
                for workcenter in thirdFilterArr{
                    let filterarray = allworkorderArray.filter{ $0.MainWorkCtr == workcenter}
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
            case Filters.MantActivityType.value:
                for activityType in thirdFilterArr{
                    let filterarray = allworkorderArray.filter{ $0.MaintActivityTypeText == activityType}
                    if (filterarray.count > 0){
                        if from == "DB"{
                            countarr.append(filterarray.count)
                            colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                            legendArr.append("\(activityType)")
                            self.dBVc!.finalFiltervalues["\(activityType)"] = filterarray
                        }else{
                            filteredArr.append(contentsOf: filterarray)
                        }
                    }
                }
            case Filters.PlanningPlant.value:
                for status in thirdFilterArr{
                    let filterarray = allworkorderArray.filter{$0.MaintPlanningPlant == status}
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
                    let filterarray = allworkorderArray.filter{$0.ResponsiblPlannerGrp == status}
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
                    let filterarray = allworkorderArray.filter{$0.MaintPlant == status}
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
                        let filterarray = allworkorderArray.filter{$0.EquipNum == "\(equipCls.Equipment)"}
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
                    let filterarray = allworkorderArray.filter{$0.Location == status}
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
                    let filterarray = allworkorderArray.filter{ $0.FuncLocation.containsIgnoringCase(find: "\(funcLoc)")}
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
                    let filterarray = allworkorderArray.filter{$0.EquipNum.containsIgnoringCase(find: "\(funcLoc)")}
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
                        let filterarray = allworkorderArray.filter{ $0.PersonResponsible == userPersonnelNo}
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
                    }else if type == Filters.Unassignged.value {
                        let filterarray = allworkorderArray.filter{ $0.EnteredBy == userDisplayName}
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
            case Filters.InspectionLot.value:
                for thirdFilterItem in thirdFilterArr{
                    if thirdFilterItem == Filters.InspectionCompleted.value{
                        let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && $0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                        var woNoArr = [String]()
                        if oprArr.count > 0{
                            let woArr = oprArr.unique{$0.WorkOrderNum}
                            for item in woArr{
                                woNoArr.append(item.WorkOrderNum)
                            }
                            let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                            let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
                            if (filterarray.count > 0){
                                if from == "DB"{
                                    countarr.append(filterarray.count)
                                    colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                    legendArr.append("\(Filters.InspectionCompleted.value)")
                                    self.dBVc!.finalFiltervalues["\(Filters.InspectionCompleted.value)"] = filterarray
                                }else{
                                    filteredArr.append(contentsOf: filterarray)
                                }
                            }
                        }
                    }else if thirdFilterItem == Filters.InspectionPending.value{
                        let oprArr = allOperationsArray.filter{$0.SystemStatus.contains(find: OPR_INSP_ENABLE_STATUS) && !$0.SystemStatus.contains(find: OPR_INSP_RESULT_RECORDED_STATUS)}
                        var woNoArr = [String]()
                        if oprArr.count > 0{
                            let woArr = oprArr.unique{$0.WorkOrderNum}
                            for item in woArr{
                                woNoArr.append(item.WorkOrderNum)
                            }
                            let predicate = NSPredicate(format: "WorkOrderNum IN %@", woNoArr as [AnyObject])
                            let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
                            if (filterarray.count > 0){
                                if from == "DB"{
                                    countarr.append(filterarray.count)
                                    colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                    legendArr.append("\(Filters.InspectionPending.value)")
                                    self.dBVc!.finalFiltervalues["\(Filters.InspectionPending.value)"] = filterarray
                                }else{
                                    filteredArr.append(contentsOf: filterarray)
                                }
                            }
                        }
                    }
                }
            case Filters.Date.value:
                for thirdFilterItem in thirdFilterArr{
                    switch thirdFilterItem {
                    case Filters.PlannedForToday.value:
                        let currentDate = Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let predicate = NSPredicate(format: "SELF.BasicStrtDate == %@", currentDate as CVarArg);
                        let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
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
                        let predicate = NSPredicate(format: "SELF.BasicStrtDate == %@", tomorroDate as CVarArg);
                        let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
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
                        let predicate = NSPredicate(format: "(SELF.BasicStrtDate >= %@ and SELF.BasicFnshDate <= %@)", currentDate as CVarArg,futureDate as CVarArg)
                        let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
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
                        let currentDate =  Date(fromString: Date().toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate()
                        let overDueDate = Date(fromString: Date().adjust(.day, offset: -2).toString(format: .custom(localDateFormate)), format: .custom(localDateFormate), timeZone: .utc, locale: .current) ?? Date().localDate().adjust(.day, offset: -2)
                        let predicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)",currentDate as CVarArg,overDueDate as CVarArg)
                        let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
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
                        let predicate = NSPredicate(format: "(SELF.BasicFnshDate <= %@ and SELF.BasicStrtDate >= %@)", currentDate as CVarArg,overDueDate as CVarArg)
                        let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
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
                        let predicate = NSPredicate(format: "SELF.BasicFnshDate < %@",currentDate as CVarArg)
                        let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
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
                        let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
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
                    case Filters.SchedulingComplaint.value:
                        let predicate = NSPredicate(format: "SELF.ActlFnshDate <= SELF.BasicFnshDate")
                        let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.SchedulingComplaint.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.SchedulingComplaint.value)"] = filterarray
                            }else{
                                filteredArr.append(contentsOf: filterarray)
                            }
                        }
                    case Filters.SchedulingNonComplaint.value:
                        let predicate = NSPredicate(format: "SELF.ActlFnshDate >= SELF.BasicFnshDate")
                        let filterarray = allworkorderArray.filter{predicate.evaluate(with: $0) }
                        if (filterarray.count > 0){
                            if from == "DB"{
                                countarr.append(filterarray.count)
                                colorArr.append(myAssetDataManager.setColor(count: colorArr.count))
                                legendArr.append("\(Filters.SchedulingNonComplaint.value)")
                                self.dBVc!.finalFiltervalues["\(Filters.SchedulingNonComplaint.value)"] = filterarray
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
