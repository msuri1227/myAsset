//
//  NotifItemListViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 15/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class NotifItemListViewModel {
    
    var vc: NotificationItemList!
    var totalItemArray = [Any]()
    var notificationFrom = String()
    
    // MARK:- Notification Items,Activities,Tasks Data
    
    func getNotificationItemsData() {
        mJCLogger.log("Starting", Type: "info")
        if notificationFrom == "FromWorkorder"{
            NotificationItemsModel.getWoNotificationItemsList(notifNum: selectedNotificationNumber){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationItemsModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.totalItemArray = responseArr
                            if self.totalItemArray.count > 0 {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationItemsModel {
                                        notificationActivity.isSelected = false
                                    }
                                }
                                if selectedItem != "" {
                                    for i in 0..<self.totalItemArray.count {
                                        if let notificationActivity = self.totalItemArray[i] as? NotificationItemsModel {
                                            let currentItemNum = notificationActivity.Item
                                            if selectedItem == currentItemNum {
                                                notificationActivity.isSelected = true
                                                return
                                            }else {
                                                if let notificationActivity = self.totalItemArray[0] as? NotificationItemsModel {
                                                    selectedItem = notificationActivity.Item
                                                    notificationActivity.isSelected = true
                                                }
                                            }
                                        }
                                    }
                                }else{
                                    if let notificationActivity = self.totalItemArray[0] as? NotificationItemsModel {
                                        selectedItem = notificationActivity.Item
                                        notificationActivity.isSelected = true
                                    }
                                }
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.updateItemScreenUI()
                        }
                    }else {
                        self.vc?.updateItemScreenUI()
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    self.vc?.updateItemScreenUI()
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationItemsModel.getNotificationItemsList(notifNum: selectedNotificationNumber) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationItemsModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.totalItemArray = responseArr
                            if self.totalItemArray.count > 0 {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationItemsModel {
                                        notificationActivity.isSelected = false
                                    }
                                }
                                if selectedItem != "" {
                                    for i in 0..<self.totalItemArray.count {
                                        if let notificationActivity = self.totalItemArray[i] as? NotificationItemsModel {
                                            let currentItemNum = notificationActivity.Item
                                            if selectedItem == currentItemNum {
                                                notificationActivity.isSelected = true
                                                return
                                            }else {
                                                if let notificationActivity = self.totalItemArray[0] as? NotificationItemsModel {
                                                    selectedItem = notificationActivity.Item
                                                    notificationActivity.isSelected = true
                                                }
                                            }
                                        }
                                    }
                                }else {
                                    if let notificationActivity = self.totalItemArray[0] as? NotificationItemsModel {
                                        selectedItem = notificationActivity.Item
                                        notificationActivity.isSelected = true
                                    }
                                }
                            }
                            self.vc?.updateItemScreenUI()
                        }
                    }else {
                        self.vc?.updateItemScreenUI()
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    self.vc?.updateItemScreenUI()
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK:-  Task Data
    func getNotificationTasksData() {
        mJCLogger.log("Starting", Type: "info")
        var itemNumber = String()
        if self.vc.isfrom == "Tasks"{
            itemNumber = "0000"
        }else{
            itemNumber = selectedItem
        }
        let defineQuery = "$filter=(Notification%20eq%20%27" + selectedNotificationNumber + "%27%20and%20Item%20eq%20%27" + itemNumber + "%27)&$orderby=Task"
        if notificationFrom == "FromWorkorder"{
            NotificationTaskModel.getWoNotificationtaskList(notifNum: selectedNotificationNumber, filterQuery: defineQuery) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr
                        if self.totalItemArray.count > 0 {
                            for i in 0..<self.totalItemArray.count {
                                if let notificationActivity = self.totalItemArray[i] as? NotificationTaskModel {
                                    notificationActivity.isSelected = false
                                }
                            }
                            if selectedTask != "" {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationTaskModel {
                                        if selectedTask == notificationActivity.Task {
                                            self.vc.selectedTask = notificationActivity.Task
                                            notificationActivity.isSelected = true
                                            break
                                        }else {
                                            if let notificationActivity = self.totalItemArray[0] as? NotificationTaskModel {
                                                self.vc.selectedTask = notificationActivity.Task
                                                notificationActivity.isSelected = true
                                            }
                                        }
                                    }
                                }
                            }else {
                                if let notificationActivity = self.totalItemArray[0] as? NotificationTaskModel {
                                    self.vc.selectedTask = notificationActivity.Task
                                    notificationActivity.isSelected = true
                                }
                            }
                        }else {
                            
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc?.updateTaskScreenUI()
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.vc?.updateTaskScreenUI()
                        }
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.vc?.updateTaskScreenUI()
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationTaskModel.getNotificationTaskList(notifNum: selectedNotificationNumber, filterQuery: defineQuery) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr
                        if self.totalItemArray.count > 0 {
                            for i in 0..<self.totalItemArray.count {
                                if let notificationActivity = self.totalItemArray[i] as? NotificationTaskModel {
                                    notificationActivity.isSelected = false
                                }
                            }
                            if selectedTask != "" {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationTaskModel {
                                        if selectedTask == notificationActivity.Task {
                                            self.vc.selectedTask = notificationActivity.Task
                                            notificationActivity.isSelected = true
                                            break
                                        }else {
                                            if let notificationActivity = self.totalItemArray[0] as? NotificationTaskModel {
                                                self.vc.selectedTask = notificationActivity.Task
                                                notificationActivity.isSelected = true
                                            }
                                        }
                                    }
                                }
                            }else {
                                if let notificationActivity = self.totalItemArray[0] as? NotificationTaskModel {
                                    self.vc.selectedTask = notificationActivity.Task
                                    notificationActivity.isSelected = true
                                }
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc?.updateTaskScreenUI()
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.vc?.updateTaskScreenUI()
                        }
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.vc?.updateTaskScreenUI()
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotificationItemTasksData() {
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        defineQuery =  "$filter=Notification eq '\(selectedNotificationNumber)' and Item eq '\(selectedItem)'" + "&$orderby=Task" as String
        if isSingleNotification == true {
            NotificationTaskModel.getWoNoItemTaskList(notifNum: selectedNotificationNumber, itemNum: selectedItem, filterQuery: defineQuery) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr

                        if self.totalItemArray.count > 0 {
                            for i in 0..<self.totalItemArray.count {
                                if let notificationActivity = self.totalItemArray[i] as? NotificationTaskModel {
                                    notificationActivity.isSelected = false
                                }
                            }
                            if selectedItemTask != "" {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationTaskModel {
                                        if selectedItemTask == notificationActivity.Task {
                                            self.vc.selectedTask = notificationActivity.Task
                                            notificationActivity.isSelected = true
                                            break
                                        }else {
                                            if let notificationActivity = self.totalItemArray[0] as? NotificationTaskModel {
                                                self.vc.selectedTask = notificationActivity.Task
                                                notificationActivity.isSelected = true
                                            }
                                        }
                                    }
                                }
                            }else{
                                if let notificationActivity = self.totalItemArray[0] as? NotificationTaskModel {
                                    self.vc.selectedTask = notificationActivity.Task
                                    notificationActivity.isSelected = true
                                }
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc.updateItemTaskScreenUI()
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.vc.updateItemTaskScreenUI()
                        }
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.vc.updateItemTaskScreenUI()
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else {
            NotificationTaskModel.getNoItemTaskList(notifNum: selectedNotificationNumber, itemNum: selectedItem, filterQuery: defineQuery) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationTaskModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr
                        if self.totalItemArray.count > 0 {
                            for i in 0..<self.totalItemArray.count {
                                if let notificationActivity = self.totalItemArray[i] as? NotificationTaskModel {
                                    notificationActivity.isSelected = false
                                }
                            }
                            if selectedItemTask != "" {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationTaskModel {
                                        if selectedItemTask == notificationActivity.Task {
                                            self.vc.selectedTask = notificationActivity.Task
                                            notificationActivity.isSelected = true
                                            break
                                        }else {
                                            if let notificationActivity = self.totalItemArray[0] as? NotificationTaskModel {
                                                self.vc.selectedTask = notificationActivity.Task
                                                notificationActivity.isSelected = true
                                            }
                                        }
                                    }
                                }
                            }else {
                                if let notificationActivity = self.totalItemArray[0] as? NotificationTaskModel {
                                    self.vc.selectedTask = notificationActivity.Task
                                    notificationActivity.isSelected = true
                                }
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc.updateItemTaskScreenUI()
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.vc.updateItemTaskScreenUI()
                        }
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.vc.updateItemTaskScreenUI()
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
// MARK:- Activities
    func  getNotificationActivityData() {
        mJCLogger.log("Starting", Type: "info")
        var itemNumber = String()
        if self.vc.isfrom == "Activities"{
            itemNumber = "0000"
        }else{
            itemNumber = selectedItem
        }
        let defineQuery = "$filter=(Notification%20eq%20%27" + selectedNotificationNumber + "%27 and Item eq '\(itemNumber)')" + "&$orderby=Activity"
        if notificationFrom == "FromWorkorder"{
            NotificationActivityModel.getWoNotificationActivityList(notifNum: selectedNotificationNumber, filterQuery: defineQuery) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.totalItemArray = responseArr
                            if self.totalItemArray.count > 0 {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationActivityModel {
                                        notificationActivity.isSelected = false
                                    }
                                }
                                if selectedAcitivity != "" {
                                    for i in 0..<self.totalItemArray.count {
                                        if let notificationActivity = self.totalItemArray[i] as? NotificationActivityModel {
                                            if notificationActivity.Activity == selectedAcitivity {
                                                self.vc.selectedActivity = notificationActivity.Activity
                                                notificationActivity.isSelected = true
                                                return
                                            }else {
                                                if let notificationActivity = self.totalItemArray[0] as? NotificationActivityModel {
                                                    self.vc.selectedActivity = notificationActivity.Activity
                                                    notificationActivity.isSelected = true
                                                }
                                            }
                                        }
                                    }
                                }else {
                                    if let notificationActivity = self.totalItemArray[0] as? NotificationActivityModel {
                                        self.vc.selectedActivity = notificationActivity.Activity
                                        notificationActivity.isSelected = true
                                    }
                                }
                            }else {
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.updateActivityScreenUI()
                        }
                    }else {
                        self.vc?.updateActivityScreenUI()
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    self.vc?.updateActivityScreenUI()
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            NotificationActivityModel.getNotificationActivityList(notifNum: selectedNotificationNumber, filterQuery: defineQuery) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        DispatchQueue.main.async {
                            self.totalItemArray = responseArr
                            if self.totalItemArray.count > 0 {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationActivityModel {
                                        notificationActivity.isSelected = false
                                    }
                                }
                                if selectedAcitivity != "" {
                                    for i in 0..<self.totalItemArray.count {
                                        if let notificationActivity = self.totalItemArray[i] as? NotificationActivityModel {
                                            if notificationActivity.Activity == selectedAcitivity {
                                                self.vc.selectedActivity = notificationActivity.Activity
                                                notificationActivity.isSelected = true
                                                return
                                            }else {
                                                if let notificationActivity = self.totalItemArray[0] as? NotificationActivityModel {
                                                    self.vc.selectedActivity = notificationActivity.Activity
                                                    notificationActivity.isSelected = true
                                                }
                                            }
                                        }
                                    }
                                }else {
                                    if let notificationActivity = self.totalItemArray[0] as? NotificationActivityModel {
                                        self.vc.selectedActivity = notificationActivity.Activity
                                        notificationActivity.isSelected = true
                                    }
                                }
                            }else {
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                            self.vc?.updateActivityScreenUI()
                        }
                    }else {
                        self.vc?.updateActivityScreenUI()
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    self.vc?.updateActivityScreenUI()
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getNotificationItemActivityData(){
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        defineQuery =  "$filter=Notification eq '\(selectedNotificationNumber)' and Item eq '\(selectedItem)'" + "&$orderby=Activity" as String
        if isSingleNotification == true {
            NotificationActivityModel.getWoNoItemActivityList(notifNum: selectedNotificationNumber, itemNum: selectedItem, filterQuery: defineQuery) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr
                        if self.totalItemArray.count > 0{
                            for i in 0..<self.totalItemArray.count {
                                if let notificationActivity = self.totalItemArray[i] as? NotificationActivityModel {
                                    notificationActivity.isSelected = false
                                }
                            }
                            if selectedItemActivity != "" {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationActivityModel {
                                        if selectedItemActivity == notificationActivity.Activity {
                                            self.vc.selectedActivity = notificationActivity.Activity
                                            notificationActivity.isSelected = true
                                            break
                                        }else {
                                            if let notificationActivity = self.totalItemArray[0] as? NotificationActivityModel {
                                                self.vc.selectedActivity = notificationActivity.Activity
                                                notificationActivity.isSelected = true
                                            }
                                        }
                                    }
                                }
                            }else {
                                if let notificationActivity = self.totalItemArray[0] as? NotificationActivityModel {
                                    self.vc.selectedActivity = notificationActivity.Activity
                                    notificationActivity.isSelected = true
                                }
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc.updateItemActivityScreenUI()
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.vc.updateItemActivityScreenUI()
                        }
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.vc.updateItemActivityScreenUI()
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else {
            NotificationActivityModel.getNoItemActivityList(notifNum: selectedNotificationNumber, itemNum: selectedItem, filterQuery: defineQuery) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationActivityModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr
                        if(self.totalItemArray.count > 0) {
                            for i in 0..<self.totalItemArray.count {
                                if let notificationActivity = self.totalItemArray[i] as? NotificationActivityModel {
                                    notificationActivity.isSelected = false
                                }
                            }
                            if selectedItemActivity != "" {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationActivityModel {
                                        if selectedItemActivity == notificationActivity.Activity {
                                            self.vc.selectedActivity = notificationActivity.Activity
                                            notificationActivity.isSelected = true
                                            break
                                        }else {
                                            if let notificationActivity = self.totalItemArray[0] as? NotificationActivityModel {
                                                self.vc.selectedActivity = notificationActivity.Activity
                                                notificationActivity.isSelected = true
                                            }
                                        }
                                    }
                                }
                            }else {
                                if let notificationActivity = self.totalItemArray[0] as? NotificationActivityModel {
                                    self.vc.selectedActivity = notificationActivity.Activity
                                    notificationActivity.isSelected = true
                                }
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc.updateItemActivityScreenUI()
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.vc.updateItemActivityScreenUI()
                        }
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.vc.updateItemActivityScreenUI()
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    // MARK:- item Cause
    func getNotificationItemsCausesData() {
        mJCLogger.log("Starting", Type: "info")
        if isSingleNotification == true {
            NotificationItemCauseModel.getWoNoItemCauseList(notifNum: selectedNotificationNumber, itemNum: selectedItem) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr
                        if self.totalItemArray.count > 0 {
                            for i in 0..<self.totalItemArray.count {
                                if let notificationActivity = self.totalItemArray[i] as? NotificationItemCauseModel {
                                    notificationActivity.isSelected = false
                                }
                            }
                            if selectedItemCause != "" {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationItemCauseModel {
                                        if selectedItemCause == notificationActivity.Cause {
                                            self.vc.selectedItemCauses = notificationActivity.Cause
                                            notificationActivity.isSelected = true
                                            break
                                        }else {
                                            if let notificationActivity = self.totalItemArray[0] as? NotificationItemCauseModel {
                                                self.vc.selectedItemCauses = notificationActivity.Cause
                                                notificationActivity.isSelected = true
                                            }
                                        }
                                    }
                                }
                            }else {
                                if let notificationActivity = self.totalItemArray[0] as? NotificationItemCauseModel {
                                    self.vc.selectedItemCauses = notificationActivity.Cause
                                    notificationActivity.isSelected = true
                                }
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc.updateItemCauseScreenUI()
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.vc.updateItemCauseScreenUI()
                        }
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.vc.updateItemCauseScreenUI()
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else {
            NotificationItemCauseModel.getNotificationItemCauseList(notifNum: selectedNotificationNumber, itemNum: selectedItem) {(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [NotificationItemCauseModel]{
                        mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                        self.totalItemArray = responseArr
                        if self.totalItemArray.count > 0 {
                            for i in 0..<self.totalItemArray.count {
                                if let notificationActivity = self.totalItemArray[i] as? NotificationItemCauseModel {
                                    notificationActivity.isSelected = false
                                }
                            }
                            if selectedItemCause != "" {
                                for i in 0..<self.totalItemArray.count {
                                    if let notificationActivity = self.totalItemArray[i] as? NotificationItemCauseModel {
                                        if selectedItemCause == notificationActivity.Cause {
                                            self.vc.selectedItemCauses = notificationActivity.Cause
                                            notificationActivity.isSelected = true
                                            break
                                        }else{
                                            if let notificationActivity = self.totalItemArray[0] as? NotificationItemCauseModel {
                                                self.vc.selectedItemCauses = notificationActivity.Cause
                                                notificationActivity.isSelected = true
                                            }
                                        }
                                    }
                                }
                            }else {
                                if let notificationActivity = self.totalItemArray[0] as? NotificationItemCauseModel {
                                    self.vc.selectedItemCauses = notificationActivity.Cause
                                    notificationActivity.isSelected = true
                                }
                            }
                        }else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                        DispatchQueue.main.async {
                            self.vc.updateItemCauseScreenUI()
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.vc.updateItemCauseScreenUI()
                        }
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.vc.updateItemCauseScreenUI()
                    }
                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
