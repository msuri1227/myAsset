//
//  DefineRequestModelClass.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/19/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class DefineRequestModelClass: NSObject {
    
    var definingRequestsArray = NSMutableArray()
    class var uniqueInstance : DefineRequestModelClass {
        struct Static {
            static let instance : DefineRequestModelClass = DefineRequestModelClass()
        }
        return Static.instance
    }

    func getHistoryPendingOprDefineRequest(type:String,type1:String,workOrderNum:String) -> String{
        var resourcePath = String()
        switch type {
        case "History" : switch type1{
        case "Operation" :
            resourcePath = "\(woHistoryOperationSet)?$filter=(WorkOrderNum eq '\(workOrderNum)')"
            break
        case "LongText" :
            resourcePath = "\(woHistoryOpLongTextSet)?$filter=(TextName eq '\(workOrderNum)') and (TextObject%20eq%20%27\(LONG_TEXT_TYPE_OPERATION)%27)&$orderby=Item"
            break
        default:
            break
        }
        break
        case "Pending" : switch type1{
        case "Operation" :
            resourcePath = "\(woPendingOperationSet)?$filter=(WorkOrderNum eq '\(workOrderNum)')"
            break
        case "LongText" :
            resourcePath = "\(woPendingOpLongTextSet)?$filter=(TextName eq '\(workOrderNum)') and (TextObject%20eq%20%27\(LONG_TEXT_TYPE_OPERATION)%27)&$orderby=Item"
            break
        default:
            break
        }
        break
        default:
            break
        }
        return resourcePath as String
    }
    func getOperationsDefineRequest(type:NSString,workorderNum :String, oprNum :String,from:String) -> NSString {
        mJCLogger.log("getOperationsDefineRequest".localized(), Type: "")
        var resourcePath = String()
        var pathtext = String()
        if from == "Supervisor"{
            pathtext = "SupervisorWOOperationSet"
        }else{
            pathtext = woOperationSet
        }
        switch type {
        case "All" :
            resourcePath = "\(pathtext)?$filter= startswith(SystemStatus,'" + "DLT" + "') ne true&$orderby=WorkOrderNum,OperationNum,SubOperation"
        case "List":
            if(workorderNum != "") {
                resourcePath = "\(pathtext)?$filter=(WorkOrderNum eq '\(workorderNum)'and startswith(SystemStatus,'" + "DLT" + "') ne true)&$orderby=OperationNum,SubOperation";
            }
            break
        case "GetOperationCount" :
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                resourcePath = "\(pathtext)" + "?$filter=(WorkOrderNum eq '" + workorderNum + "' and startswith(UserStatus,'" + "COMP" + "') ne true)&$select=OperationNum"
            }else{
                resourcePath = "\(pathtext)" + "?$filter=(WorkOrderNum eq '" + workorderNum + "' and startswith(SystemStatus,'" + "CNF" + "') ne true and startswith(SystemStatus,'" + "DLT" + "') ne true)&$select=OperationNum"
            }
            break
        case "ListSpinner":
            if(workorderNum != "") {
                resourcePath = "\(pathtext)?$filter=(WorkOrderNum%20eq%20%27" + workorderNum + "%27 and startswith(SystemStatus, 'DLT') ne true) &$select=OperationNum,WorkOrderNum,PlannofOpera,Counter&$orderby=OperationNum";
            }
            break
        case "Single":
            if(workorderNum != "" && oprNum != "") {
                resourcePath = "\(pathtext)?$filter=(WorkOrderNum%20eq%20%27" + workorderNum + "%27%20and%20OperationNum%20eq%20%27" + oprNum + "%27)"
            }
        case "deleteList":
            resourcePath = "\(pathtext)?$filter=(WorkOrderNum%20eq%20%27" + workorderNum + "%27 and startswith(SystemStatus, 'DLT') ne true)                &$select=OperationNum,WorkOrderNum&$orderby=OperationNum";
        default:
            break
        }
        mJCLogger.log("resourcePath : \(resourcePath)", Type: "Debug")
        return resourcePath as NSString
    }
    func getComponentsDefineRequest(type:String, workorderNum :String, componentNum:String, operationNum:String,from:String) -> NSString {
        mJCLogger.log("getComponentsDefineRequest".localized(), Type: "")
        var resourcePath = String()
        var settext = String()
        if from == "Supervisor"{
            settext = "SupervisorComponentSet"
        }else{
            settext = woComponentSet
        }
        switch type {
        case "List":
            resourcePath = "\(settext)?$select=WorkOrderNum,OperAct,Item,FinalIssue,ReqmtQty,WithdrawalQty,MovementType&$filter=(WorkOrderNum%20eq%20%27" + workorderNum + "%27 and Deleted eq false)&$orderby=Item"
            break
        case "Single":
            resourcePath = "\(settext)?$filter=(WorkOrderNum%20eq%20%27" + workorderNum + "%27%20and%20OperAct%20eq%20%27" + "0010" + "%27%20and%20Item%20eq%20%27" + "0001" + "%27)";
            break
        case "GetComponentCount" :
            if operationNum == "" {
                resourcePath = "\(settext)" + "?$filter= (WorkOrderNum eq '\(workorderNum)' and Deleted eq false)&$select=ReqmtQty,WithdrawalQty"
            }else{
                resourcePath = "\(settext)" + "?$filter= (WorkOrderNum eq '\(workorderNum)' and OperAct eq '\(operationNum)' and Deleted eq false )  &$select=ReqmtQty,WithdrawalQty"
            }
            break
        case "All":
            if settext == woComponentSet{
                if operationNum != ""{
                    resourcePath = "\(settext)?$filter=WorkOrderNum%20eq%20%27" + workorderNum + "%27 and OperAct%20eq%20%27" + operationNum + "%27 and Deleted eq false &$orderby=Item"
                }else{
                    resourcePath = "\(settext)?$filter=WorkOrderNum%20eq%20%27" + workorderNum + "%27 and Deleted eq false&$orderby=Item"
                }
            }else{
                if operationNum != ""{
                    resourcePath = "\(settext)?$filter=WorkOrderNum%20eq%20%27" + workorderNum + "%27 and OperAct%20eq%20%27" + operationNum + "%27&$orderby=Item"
                }else{
                    resourcePath = "\(settext)?$filter=WorkOrderNum%20eq%20%27" + workorderNum + "%27&$orderby=Item"
                }
            }
            break
        case "Operation":
            resourcePath = "\(settext)?$filter=WorkOrderNum%20eq%20%27" + workorderNum + "%27 and OperAct%20eq%20%27" + operationNum + "%27&$orderby=Item"
            break
        case "Total":
            resourcePath = "\(settext)?$filter=WorkOrderNum%20eq%20%27" + workorderNum + "%27&$orderby=Item"
            break
        case "deleteList":
            resourcePath = "\(settext)?$select=WorkOrderNum,OperAct,Item,FinalIssue,ReqmtQty,WithdrawalQty,MovementType&$filter=(WorkOrderNum%20eq%20%27" + workorderNum + "%27)&$orderby=Item"
            break
        default:
            resourcePath = "\(settext)?$filter=(WorkOrderNum%20eq%20%27" + workorderNum + "%27 and Deleted eq false)&$orderby=Item"
            break
        }
        mJCLogger.log("resourcePath : \(resourcePath)", Type: "Debug")
        return resourcePath as NSString
    }
    func getWorkOrderObject(type : String,workorderNum:String)-> String {
        mJCLogger.log("getWorkOrderObject".localized(), Type: "")
        var resourcePath = String()
        switch type {
        case "List":
            resourcePath = woObjectSet + "?$filter=WorkOrderNum%20eq%20%27" + workorderNum + "%27"
            break
        case "ObjectCount":
            resourcePath = woObjectSet + "/$count?$filter=WorkOrderNum%20eq%20%27" + workorderNum + "%27"
            break
        default:
            resourcePath = woObjectSet
            break
        }
        mJCLogger.log("resourcePath : \(resourcePath)", Type: "Debug")
        return resourcePath
    }
    func getTimeSheetData1(type : String, date : Date) -> String {
        mJCLogger.log("getTimeSheetData".localized(), Type: "")
        var resourcePath = String()
        switch type {
        case "List":
            let dateFormatter:DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'00:00:00"
            let DateInFormat:String = dateFormatter.string(from: date)
            resourcePath = catRecordSet + "?$filter=(Date eq datetime'" + DateInFormat + "')"
            break
        case "HoursList":
            let dateFormatter:DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'00:00:00"
            let DateInFormat:String = dateFormatter.string(from: date as Date)
            resourcePath = "\(catRecordSet)?$filter=(Date eq datetime'\(DateInFormat)')&$select=CatsHours"
            break
        default:
            resourcePath = catRecordSet
            break
        }
        mJCLogger.log("resourcePath : \(resourcePath)", Type: "Debug")
        return resourcePath
    }
    func getNotificationActivity(type:NSString,notificationNum :String, activityNum :String, notificationFrom :String,ItemNum:String) -> String {
        mJCLogger.log("getNotificationActivity".localized(), Type: "")
        var resourcePath = String()
        if notificationFrom == "FromWorkorder" {
            switch type {
            case "List":
                resourcePath = woNotificationActivityCollection+"?$filter=(Notification%20eq%20%27" + notificationNum + "%27 and Item eq '\(ItemNum)')" + "&$orderby=Activity"
                break
            case "Single":
                if(notificationNum != "" && activityNum != "") {
                    resourcePath = woNotificationActivityCollection + "?$filter=(Notification%20eq%20%27" + notificationNum + "%27%20and%20Activity%20eq%20%27" + activityNum + "%27 and Item eq '\(ItemNum)')"
                }
                break
            default:
                resourcePath = woNotificationActivityCollection
                break
            }
        }else {
            switch type {
            case "List":
                resourcePath = notificationActivitySet+"?$select=Activity,Item,ActivityText,Notification,TempID&$filter=(Notification%20eq%20%27" + notificationNum + "%27 and Item eq '\(ItemNum)')" + "&$orderby=Activity"
                
                break
            case "Single":
                if(notificationNum != "" && activityNum != "") {
                    resourcePath = notificationActivitySet + "?$filter=(Notification%20eq%20%27" + notificationNum + "%27%20and%20Activity%20eq%20%27" + activityNum + "%27) and Item eq '\(ItemNum)'"
                }
                break
            default:
                resourcePath = notificationActivitySet
                break
            }
        }
        mJCLogger.log("resourcePath : \(resourcePath)", Type: "Debug")
        return resourcePath
    }
    func getNotificationItems(type:NSString,notificationNum :String, itemNum :String, notificationFrom :String) -> String {
        mJCLogger.log("getNotificationItems".localized(), Type: "")
        var resourcePath = String()
        if notificationFrom == "FromWorkorder" {
            switch type {
            case "List":
                resourcePath = woNotificationItemCollection+"?$filter=(Notification%20eq%20%27" + notificationNum + "%27)"  + "&$orderby=Item"
                break
            case "Single":
                if(notificationNum != "" && itemNum != "") {
                    resourcePath = woNotificationItemCollection+"?$filter=(Notification%20eq%20%27" + notificationNum + "%27%20and%20Item%20eq%20%27" + itemNum + "%27)"
                }
                break
            default:
                resourcePath = woNotificationItemCollection
                break
            }
        }else {
            switch type {
            case "List":
                resourcePath = notificationItemSet+"?$filter=(Notification%20eq%20%27" + notificationNum + "%27)" + "&$orderby=Item"
                break
            case "Single":
                if(notificationNum != "" && itemNum != "") {
                    resourcePath = notificationItemSet + "?$filter=(Notification%20eq%20%27" + notificationNum + "%27%20and%20Item%20eq%20%27" + itemNum + "%27)"
                }
                break
            case "deleteList":
                resourcePath = notificationItemSet+"?$filter=(Notification%20eq%20%27" + notificationNum + "%27)" + "&$select=Item,TempID,Notification"
                break
            default:
                resourcePath = notificationActivitySet
                break
            }
        }
        mJCLogger.log("resourcePath : \(resourcePath)", Type: "Debug")
        return resourcePath
    }
    func getNotificationTask(type:NSString,notificationNum :String, taskNum :String, notificationFrom :String,ItemNum:String) -> String {
        mJCLogger.log("getNotificationTask".localized(), Type: "")
        var resourcePath = String()
        if notificationFrom == "FromWorkorder" {
            switch type {
            case "List":
                resourcePath =
                    woNotificationTaskCollection+"?$filter=(Notification%20eq%20%27" + notificationNum + "%27%20and%20Item%20eq%20%27" + ItemNum + "%27)&$orderby=Task"
                break
            case "Single":
                if(notificationNum != "" && taskNum != "") {
                    resourcePath =  woNotificationTaskCollection+"?$filter=(Notification%20eq%20%27" + notificationNum + "%27%20and%20Task%20eq%20%27" + taskNum + "%27)"
                }
                break
            default:
                resourcePath = woNotificationTaskCollection
                break
            }
        }else {
            switch type {
            case "List":
                resourcePath = notificationTaskSet+"?$filter=(Notification%20eq%20%27" + notificationNum + "%27%20and%20Item%20eq%20%27" + ItemNum + "%27)&$orderby=Task"
                break
            case "Single":
                if(notificationNum != "" && taskNum != "") {
                    resourcePath = notificationTaskSet + "?$filter=(Notification%20eq%20%27" + notificationNum + "%27%20and%20Task%20eq%20%27" + taskNum + "%27)"
                }
                break
            default:
                resourcePath = notificationTaskSet
                break
            }
        }
        mJCLogger.log("resourcePath : \(resourcePath)".localized(), Type: "Debug")
        return resourcePath
    }
}







