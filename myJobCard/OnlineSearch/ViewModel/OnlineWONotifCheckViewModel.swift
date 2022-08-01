//
//  OnlineWONotifCheckViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 24/03/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation



class OnlineWONotifCheckViewModel{
    
    var onlineWorkOrderAndNotification : OnlineWorkOrderAndNotification?
    var selectedMainWorkCenter:String?
    var selectedPlant:String?
    var searchType = String()
    var vc = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController

    func getOnlineNotificationsList(plantText:String?,mainWorkCenterText:String?,functionalLocationText:String?,equipmentText:String?){
        
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Please_Wait".localized())
        onlineSearch = true
        self.searchType = "Notifications"
        if plantText == "" && mainWorkCenterText == "" && functionalLocationText == "" && equipmentText == "" {
            mJCLoader.stopAnimating()
            mJCAlertHelper.showAlert(vc!, title: alerttitle, message: "Please_select_atleast_one_value_to_Search".localized(), button: okay)

        }else if plantText != "" || mainWorkCenterText != "" || functionalLocationText != "" || equipmentText != "" {
            var queryarr = Array<String>()
            if plantText != ""{
                let filteredArray = plantText?.components(separatedBy: " - ")
                if filteredArray?.count ?? 0 > 0{
                    self.selectedPlant = filteredArray?[0]
                    queryarr.append("Plant")
                }
            }
            if mainWorkCenterText != ""{
                let mainWrkArray = mainWorkCenterText?.components(separatedBy: " - ")
                if mainWrkArray?.count ?? 0 > 0 {
                    self.selectedMainWorkCenter = mainWrkArray?[0]
                    queryarr.append("WorkCenter")
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
            if functionalLocationText != ""{
                queryarr.append("Func")
            }
            if equipmentText != ""{
                queryarr.append("Equip")
            }
            var strQuery = String()
            strQuery = "(OnlineSearch%20eq%20%27X%27"
            for i in 0..<queryarr.count {
                if queryarr[i] == "WorkCenter"{
                    if let selecteMainWorkCenter = self.selectedMainWorkCenter{
                        strQuery = strQuery + "%20and%20" + "WorkCenter%20eq%20%27\(selecteMainWorkCenter)%27"
                    }
                }else if queryarr[i] == "Plant"{
                    if let selectPlant = self.selectedPlant{
                        strQuery = strQuery + "%20and%20" + "PlanningPlant%20eq%20%27\(selectPlant)%27"
                    }
                }else if queryarr[i] == "Func"{
                    if let functionalLocText = functionalLocationText{
                        strQuery = strQuery + "%20and%20" + "FunctionalLoc%20eq%20%27\(functionalLocText)%27"
                    }
                }else if queryarr[i] == "Equip"{
                    if let equipment = equipmentText{
                        strQuery = strQuery + "%20and%20" + "Equipment%20eq%20%27\( equipment)%27"
                    }
                }
            }
            var fromDateStr = String()
            var toDateStr = String()
            let todate = NSDate()
            let monthagoDate = todate.addingTimeInterval(TimeInterval(-NotificationTimeSpan*24*60*60))
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd"
            fromDateStr = formatter1.string(from: monthagoDate as Date)
            let fromdate = NSDate()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            toDateStr = formatter.string(from: fromdate as Date)
            if fromDateStr != "" && toDateStr != "" {
                let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
                if result == "ServerUp"{
                    let fromDate = fromDateStr + "T00:00:00"
                    let toDate = toDateStr + "T00:00:00"
                    strQuery = "$filter=" + strQuery + "%20and%20" + "CreatedOn%20eq%20datetime%27\(fromDate)%27%20and%20ChangedOn%20eq%20datetime%27\(toDate)%27)&$expand=NavNOItem"
                    let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                    dispatchQueue.async{
                        self.getOnlineResults(query: strQuery)
                    }
                }else if result == "ServerDown"{
                    mJCLoader.stopAnimating()
                    mJCAlertHelper.showAlert(vc!, title: alerttitle, message: "Unable_to_connect_with_server".localized(), button: okay)
                }else{
                    mJCLoader.stopAnimating()
                    mJCAlertHelper.showAlert(vc!, title: alerttitle, message: "The_Internet_connection_appears_to_be_offline".localized(), button: okay)
                }
            }
        }else{
            mJCLoader.stopAnimating()
            mJCAlertHelper.showAlert(vc!, title: alerttitle, message: "Please_select_atleast_one_value_to_Search".localized(), button: okay)

        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func getOnlineWorkOrdersList(plantText:String?,mainWorkCenterText:String?,functionalLocationText:String?,equipmentText:String?){
        
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Please_Wait".localized())
        onlineSearch = true
        self.searchType = "WorkOrder"
        if plantText == "" && mainWorkCenterText == "" && functionalLocationText == "" && equipmentText == "" {
            mJCLoader.stopAnimating()
            mJCAlertHelper.showAlert(vc!, title: alerttitle, message: "Please_select_atleast_one_value_to_Search".localized(), button: okay)

        }else  if plantText != "" || mainWorkCenterText != "" || functionalLocationText != "" || equipmentText != "" {
            
            var queryarr = Array<String>()
            if plantText != ""{
                let filteredArray = plantText?.components(separatedBy: " - ")
                if filteredArray?.count ?? 0 > 0{
                    self.selectedPlant = filteredArray?[0] ?? ""
                    queryarr.append("Plant")
                }
            }
            if mainWorkCenterText != ""{
                let arr = mainWorkCenterText?.components(separatedBy: " - ")
                if arr?.count ?? 0 > 0{
                    self.selectedMainWorkCenter = arr?[0] ?? ""
                    queryarr.append("WorkCenter")
                }
            }
            if functionalLocationText != ""{
                queryarr.append("Func")
            }
            if equipmentText != ""{
                queryarr.append("Equip")
            }
            var strQuery = String()
            strQuery = "(OnlineSearch%20eq%20%27X%27"
            for i in 0..<queryarr.count {
                if queryarr[i] == "WorkCenter"{
                    if let selecteMainWorkCenter = self.selectedMainWorkCenter{
                        strQuery = strQuery + "%20and%20" + "MainWorkCtr%20eq%20%27\(selecteMainWorkCenter)%27"
                    }
                }else if queryarr[i] == "Plant"{
                    if let selectPlant = self.selectedPlant{
                        strQuery = strQuery + "%20and%20" + "Plant%20eq%20%27\(selectPlant)%27"
                    }
                }else if queryarr[i] == "Func"{
                    if let functionalLocText = functionalLocationText{
                        strQuery = strQuery + "%20and%20" + "FuncLocation%20eq%20%27\(functionalLocText)%27"
                    }
                }else if queryarr[i] == "Equip"{
                    if let equipment = equipmentText{
                        strQuery = strQuery + "%20and%20" + "EquipNum%20eq%20%27\( equipment)%27"
                    }
                }
            }
            var fromDateStr = String()
            var toDateStr = String()
            let todate = NSDate()
            let monthagoDate = todate.addingTimeInterval(TimeInterval(-WorkOrderTimeSpan*24*60*60))
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd"
            fromDateStr = formatter1.string(from: monthagoDate as Date)
            let fromdate = NSDate()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            toDateStr = formatter.string(from: fromdate as Date)
            if fromDateStr != "" && toDateStr != "" {
                let result = mJCNetWorkHelper.checkInternetConnectionwithServerDetails(serverURL: serverURL)
                if result == "ServerUp"{
                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                    let fromDate = fromDateStr + "T00:00:00"
                    let toDate = toDateStr + "T00:00:00"
                    if self.searchType == "Notifications"{
                        strQuery = "$filter=" + strQuery + "%20and%20" + "CreatedOn%20eq%20datetime%27\(fromDate)%27%20and%20ChangeDtForOrderMaster%20eq%20datetime%27\(toDate)%27)&$expand=NavNOItem"
                    }else{
                        strQuery = "$filter=" + strQuery + "%20and%20" + "CreatedOn%20eq%20datetime%27\(fromDate)%27%20and%20ChangeDtForOrderMaster%20eq%20datetime%27\(toDate)%27)&$expand=NAVOPERA"
                        
                    }
                    let dispatchQueue = DispatchQueue(label: "OnlineResult", qos: .background)
                    dispatchQueue.async{
                        self.getOnlineResults(query: strQuery)
                    }
                }else if result == "ServerDown"{
                    mJCLoader.stopAnimating()
                    mJCAlertHelper.showAlert(vc!, title: alerttitle, message: "Unable_to_connect_with_server".localized(), button: okay)
                }else{
                    mJCLoader.stopAnimating()
                    mJCAlertHelper.showAlert(vc!, title: alerttitle, message: "The_Internet_connection_appears_to_be_offline".localized(), button: okay)
                }
            }
        }else{
            mJCLoader.stopAnimating()
            mJCLogger.log("Please_select_atleast_one_value_to_Search".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(vc!, title: alerttitle, message: "Please_select_atleast_one_value_to_Search".localized(), button: okay)

        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getOnlineResults(query:String) {
        let httpConvMan1 = HttpConversationManager.init()
        let commonfig1 = CommonAuthenticationConfigurator.init()
        if self.onlineWorkOrderAndNotification != nil{
            if authType == "Basic"{
                commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
            }else if authType == "SAML"{
                commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
            }
        }
        commonfig1.configureManager(httpConvMan1)
        if self.searchType == "Notifications"{
            let notifiDict = NotificationModel.getOnlineNotificationList(filterQuery: query, httpConvManager: httpConvMan1!)
            mJCLogger.log("Response :\(notifiDict)", Type: "Debug")
            if let status = notifiDict["Status"] as? Int{
                if status == 200{
                    if let dict = notifiDict["Response"] as? NSMutableDictionary{
                        let responseDict = ODSHelperClass.getListInFormte(dictionary: dict, entityModelClassType: NotificationModel.self)
                        if let responseArr = responseDict["data"] as? [NotificationModel]{
                            self.onlineWorkOrderAndNotification?.notificationArray = responseArr
                        }
                        self.onlineWorkOrderAndNotification?.searchType = "Notifications"
                        self.onlineWorkOrderAndNotification?.onlineSearchUpdateUI()
                    }
                }else{
                    self.onlineWorkOrderAndNotification?.searchType = "Notifications"
                    self.onlineWorkOrderAndNotification?.onlineSearchUpdateUI()
                }
            }
            mJCLoader.stopAnimating()
        }else{
            let  workorderDict = WoHeaderModel.getOnlineWorkOrderList(filterQuery: query, httpConvManager: httpConvMan1!)
            mJCLogger.log("Response :\(workorderDict)", Type: "Debug")
            if let status = workorderDict["Status"] as? Int{
                if status == 200{
                    if let dict = workorderDict["Response"] as? NSMutableDictionary{
                        let responseDict = ODSHelperClass.getListInFormte(dictionary: dict, entityModelClassType: WoHeaderModel.self)
                        if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                            self.onlineWorkOrderAndNotification?.workOrderArray = responseArr
                        }
                    }
                }
                self.onlineWorkOrderAndNotification?.searchType = "WorkOrder"
                self.onlineWorkOrderAndNotification?.onlineSearchUpdateUI()
            }else{
                self.onlineWorkOrderAndNotification?.searchType = "WorkOrder"
                self.onlineWorkOrderAndNotification?.onlineSearchUpdateUI()
            }
            mJCLoader.stopAnimating()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
