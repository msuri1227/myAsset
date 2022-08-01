//
//  StatusCollectionCell.swift
//  myJobCard
//
//  Created by Rover Software on 02/04/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class StatusCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var StatuButton: UIButton!
    @IBOutlet weak var StatusImg: UIImageView!
    @IBOutlet var statusTitle: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var counterLabel: UILabel!
    var Selected: Bool = false
    
    // MVVM Change
    
    var detailViewModel = DetailViewModel()
    var singleNotifViewModel = SingleNotificationViewModel()
    var notificationTaskViewModelRef = NotificationTaskViewModel()
    var notificationItemCausesViewRef = NotificationItemCausesViewModel()
    var indexpath = IndexPath()
    
    var singleOperationClass: WoOperationModel?{
        didSet{
            workOrderCellConfiguration()
        }
    }
    var singleNotificationClass: NotificationModel?{
        didSet{
            notifCellConfiguration()
        }
    }
    var singleViewNotificationClass: NotificationModel?{
        didSet{
            singleNotifCellConfiguration()
        }
    }
    
    var notificatonTaskClass : NotificationTaskModel?{
        didSet{
            notificationTaskStatusConfiguration()
        }
    }
    var notificatonItemTaskClass : NotificationTaskModel?{
        didSet{
            notificationItemTaskStatusConfiguration()
        }
    }
    
    func workOrderCellConfiguration() {
        
        let validStatusClass = detailViewModel.allowedStatusCatagoryArray[indexpath.row]
        if((UserDefaults.standard.value(forKey:"active_details")) != nil){
            let activedetails = UserDefaults.standard.value(forKey: "active_details") as! NSDictionary
            if let activeWOnum = activedetails.value(forKey: "WorkorderNum") as? String{
                let activeOprNum = activedetails.value(forKey: "OperationNum") as? String
                if WORKORDER_ASSIGNMENT_TYPE != "3" && WORKORDER_ASSIGNMENT_TYPE != "4"{
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        if DOWNLOAD_CREATEDBY_WO == "X" {
                            detailViewModel.validateCond = (activeWOnum == selectedworkOrderNumber && activeOprNum == selectedOperationNumber) && (singleWorkOrder.PersonResponsible == singleOperation.PersonnelNo)
                        }else {
                            detailViewModel.validateCond = (activeWOnum == selectedworkOrderNumber && activeOprNum == selectedOperationNumber)
                        }
                        if detailViewModel.validateCond {
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }else{
                            if DOWNLOAD_CREATEDBY_WO == "X" {
                                detailViewModel.validateCond = (validStatusClass.StatusCode == "ACCP" || validStatusClass.StatusCode == "REJC" || validStatusClass.StatusCode == "TRNS") && (singleWorkOrder.PersonResponsible == singleOperation.PersonnelNo)
                            }else {
                                detailViewModel.validateCond = (validStatusClass.StatusCode == "ACCP" || validStatusClass.StatusCode == "REJC" || validStatusClass.StatusCode == "TRNS")
                            }
                            if detailViewModel.validateCond {
                                self.StatuButton.isEnabled = true
                                self.StatusImg.alpha = 1.0
                            }else{
                                self.StatuButton.isEnabled = false
                                self.StatusImg.alpha = 0.5
                            }
                        }
                    }else{
                        if DOWNLOAD_CREATEDBY_WO == "X" {
                            detailViewModel.validateCond = (activeWOnum == selectedworkOrderNumber)
                        }else {
                            detailViewModel.validateCond = (activeWOnum == selectedworkOrderNumber && singleWorkOrder.PersonResponsible == userPersonnelNo)
                        }
                        if detailViewModel.validateCond {
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }else{
                            if DOWNLOAD_CREATEDBY_WO == "X" {
                                detailViewModel.validateCond = (validStatusClass.StatusCode == "ACCP" || validStatusClass.StatusCode == "REJC" || validStatusClass.StatusCode == "TRNS") && (singleWorkOrder.PersonResponsible == userPersonnelNo)
                            }else {
                                detailViewModel.validateCond = (validStatusClass.StatusCode == "ACCP" || validStatusClass.StatusCode == "REJC" || validStatusClass.StatusCode == "TRNS")
                            }
                            if detailViewModel.validateCond {
                                self.StatuButton.isEnabled = true
                                self.StatusImg.alpha = 1.0
                            }else{
                                self.StatuButton.isEnabled = false
                                self.StatusImg.alpha = 0.5
                            }
                        }
                    }
                }else{
                    if DOWNLOAD_CREATEDBY_WO == "X" {
                        if singleWorkOrder.PersonResponsible == userPersonnelNo {
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }else {
                            self.StatuButton.isEnabled = false
                            self.StatusImg.alpha = 0.5
                        }
                    }else {
                        self.StatuButton.isEnabled = true
                        self.StatusImg.alpha = 1.0

                    }
                }
            }else{
                if DOWNLOAD_CREATEDBY_WO == "X" {
                    if singleWorkOrder.PersonResponsible == userPersonnelNo {
                        self.StatuButton.isEnabled = true
                        self.StatusImg.alpha = 1.0
                    }else {
                        self.StatuButton.isEnabled = false
                        self.StatusImg.alpha = 0.5
                    }
                }else {
                    self.StatuButton.isEnabled = true
                    self.StatusImg.alpha = 1.0
                }
            }
        }else{
            if DOWNLOAD_CREATEDBY_WO == "X" {
                if WORKORDER_ASSIGNMENT_TYPE != "3" && WORKORDER_ASSIGNMENT_TYPE != "4"{
                    if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                        detailViewModel.validateCond = (singleWorkOrder.PersonResponsible == singleOperation.PersonnelNo)
                        if detailViewModel.validateCond {
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }else {
                            self.StatuButton.isEnabled = false
                            self.StatusImg.alpha = 0.5
                        }
                    }else{
                        detailViewModel.validateCond = (singleWorkOrder.PersonResponsible == userPersonnelNo)
                        if detailViewModel.validateCond {
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }else {
                            self.StatuButton.isEnabled = false
                            self.StatusImg.alpha = 0.5
                        }
                    }
                }
            }else {
                self.StatuButton.isEnabled = true
                self.StatusImg.alpha = 1.0
            }
        }
        self.StatuButton.addTarget(self, action: #selector(self.AllStatusButtonAction(sender:)), for: .touchUpInside)
    }
    
    func notifCellConfiguration() {
        let validStatusClass = detailViewModel.allowedStatusCatagoryArray[indexpath.row]
        var validateCond = detailViewModel.validateCond
        if((UserDefaults.standard.value(forKey:"active_details")) != nil){
            let activedetails = UserDefaults.standard.value(forKey: "active_details") as! NSDictionary
            if let activeNonum = activedetails.value(forKey: "Notification") as? String{
                if NOTIFICATION_ASSIGNMENT_TYPE != "2"{
                    if DOWNLOAD_CREATEDBY_NOTIF == "X" {
                        validateCond = (activeNonum == selectedNotificationNumber && singleNotification.Partner == userPersonnelNo)
                    }else {
                        validateCond = (activeNonum == selectedNotificationNumber)
                    }
                    if validateCond{
                        self.StatuButton.isEnabled = true
                        self.StatusImg.alpha = 1.0
                    }else{
                        if DOWNLOAD_CREATEDBY_NOTIF == "X" {
                            validateCond = (validStatusClass.StatusCode == "ACCP" || validStatusClass.StatusCode == "REJC") && (singleNotification.Partner == userPersonnelNo)
                        }else {
                            validateCond = (validStatusClass.StatusCode == "ACCP" || validStatusClass.StatusCode == "REJC")
                        }
                        if validateCond{
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }else{
                            self.StatuButton.isEnabled = false
                            self.StatusImg.alpha = 0.5
                        }
                    }
                }else{
                    if DOWNLOAD_CREATEDBY_NOTIF == "X" {
                        validateCond = (validStatusClass.StatusCode == "ACCP" || validStatusClass.StatusCode == "REJC") && (singleNotification.Partner == userPersonnelNo)
                    }else {
                        validateCond = true
                    }
                    if validateCond{
                        self.StatuButton.isEnabled = true
                        self.StatusImg.alpha = 1.0
                    }else{
                        self.StatuButton.isEnabled = false
                        self.StatusImg.alpha = 0.5
                    }
                }
            }else{
                if DOWNLOAD_CREATEDBY_NOTIF == "X" {
                    if singleNotification.Partner == userPersonnelNo {
                        self.StatuButton.isEnabled = true
                        self.StatusImg.alpha = 1.0
                    }else {
                        self.StatuButton.isEnabled = false
                        self.StatusImg.alpha = 0.5
                    }
                }else {
                    self.StatuButton.isEnabled = true
                    self.StatusImg.alpha = 1.0
                }
            }
        }else{
            if DOWNLOAD_CREATEDBY_NOTIF == "X" {
                if singleNotification.Partner == userPersonnelNo {
                    self.StatuButton.isEnabled = true
                    self.StatusImg.alpha = 1.0
                }else {
                    self.StatuButton.isEnabled = false
                    self.StatusImg.alpha = 0.5
                }
            }else {
                self.StatuButton.isEnabled = true
                self.StatusImg.alpha = 1.0
            }
        }
        self.StatuButton.addTarget(self, action: #selector(self.AllStatusButtonAction(sender:)), for: .touchUpInside)
    }
    
    func singleNotifCellConfiguration() {
        
        let validStatusClass = singleNotifViewModel.vc.statusArray[indexpath.row] as! StatusCategoryModel
        
        var validateCond = singleNotifViewModel.vc.validateCond
        
        if singleNotifViewModel.vc.allowedStatusArray.contains(validStatusClass.StatusCode) {

            if((UserDefaults.standard.value(forKey:"active_details")) != nil){
                let activedetails = UserDefaults.standard.value(forKey: "active_details") as! NSDictionary
                if let activeNonum = activedetails.value(forKey: "Notification") as? String{


                    if WORKORDER_ASSIGNMENT_TYPE != "1" && WORKORDER_ASSIGNMENT_TYPE != "4"{
                        if DOWNLOAD_CREATEDBY_NOTIF == "X" {
                            validateCond = (activeNonum == selectedNotificationNumber) && (singleNotification.Partner == userPersonnelNo)
                        }
                        else {
                            validateCond = (activeNonum == selectedNotificationNumber)
                        }

                        if validateCond{
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }else{

                            if DOWNLOAD_CREATEDBY_NOTIF == "X" {
                                validateCond = (validStatusClass.StatusCode == "ACCP" || validStatusClass.StatusCode == "REJC") && (singleNotification.Partner == userPersonnelNo)
                            }
                            else {
                                validateCond = (validStatusClass.StatusCode == "ACCP" || validStatusClass.StatusCode == "REJC")

                            }
                            if validateCond{
                                self.StatuButton.isEnabled = true
                                self.StatusImg.alpha = 1.0
                            }else{
                                self.StatuButton.isEnabled = false
                                self.StatusImg.alpha = 0.5
                            }
                        }
                    }else{
                        if DOWNLOAD_CREATEDBY_NOTIF == "X" {
                            if singleNotification.Partner == userPersonnelNo {
                                self.StatuButton.isEnabled = true
                                self.StatusImg.alpha = 1.0
                            }
                            else {
                                self.StatuButton.isEnabled = false
                                self.StatusImg.alpha = 0.5
                            }
                        }
                        else {
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0

                        }
                    }
                }else{

                    if DOWNLOAD_CREATEDBY_NOTIF == "X" {
                        if singleNotification.Partner == userPersonnelNo {
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }
                        else {
                            self.StatuButton.isEnabled = false
                            self.StatusImg.alpha = 0.5
                        }
                    }
                    else {
                        self.StatuButton.isEnabled = true
                        self.StatusImg.alpha = 1.0

                    }
                }

            }else{

                if DOWNLOAD_CREATEDBY_NOTIF == "X" {

                    if singleNotification.Partner == userPersonnelNo {
                        self.StatuButton.isEnabled = true
                        self.StatusImg.alpha = 1.0
                    }
                    else {
                        self.StatuButton.isEnabled = false
                        self.StatusImg.alpha = 0.5
                    }
                }
                else {
                    self.StatuButton.isEnabled = true
                    self.StatusImg.alpha = 1.0

                }
            }
            
        }else{
            self.StatuButton.isEnabled = false
            self.StatusImg.alpha = 0.5
        }
        self.StatuButton.addTarget(self, action: #selector(self.StatusButtonAction(sender:)), for: .touchUpInside)
    }
    func notificationTaskStatusConfiguration(){
        
        let validStatusClass = notificationTaskViewModelRef.vc.statusArray[indexpath.row] as! StatusCategoryModel
        if validStatusClass.ImageResKey == "TBC" || validStatusClass.ImageResKey == ""{
            self.StatuButton.setImage(UIImage(named:"MOBI"), for: .normal)
        }else{
            self.StatuButton.setImage(UIImage(named:validStatusClass.ImageResKey), for: .normal)
        }
        self.statusTitle.text = validStatusClass.StatusDescKey
        
        self.StatuButton.isEnabled = false
        self.StatusImg.alpha = 0.5
        self.StatuButton.tag = indexpath.row
        if notificationTaskViewModelRef.vc.allowedStatusArray.contains(validStatusClass.StatusCode) {
            if NOTIFICATION_ASSIGNMENT_TYPE == "1"{
                if((UserDefaults.standard.value(forKey:"active_details")) != nil){
                    let activedetails = UserDefaults.standard.value(forKey: "active_details") as! NSDictionary
                    if let activeNonum = activedetails.value(forKey: "Notification") as? String{
                        if activeNonum == selectedNotificationNumber{
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }
                    }
                }
            }else{
                if isActiveNotification{
                    self.StatuButton.isEnabled = true
                    self.StatusImg.alpha = 1.0
                }
            }
        }
        self.StatuButton.addTarget(self, action: #selector(self.taskStatusButtonAction(sender:)), for: .touchUpInside)
    }
    func notificationItemTaskStatusConfiguration(){
        
        let validStatusClass = notificationItemCausesViewRef.vc.statusArray[indexpath.row] as! StatusCategoryModel
        if validStatusClass.ImageResKey == "TBC" || validStatusClass.ImageResKey == ""{
            self.StatuButton.setImage(UIImage(named:"MOBI"), for: .normal)
        }else{
            self.StatuButton.setImage(UIImage(named:validStatusClass.ImageResKey), for: .normal)
        }
        
        self.statusTitle.text = validStatusClass.StatusDescKey
        self.StatuButton.isEnabled = false
        self.StatusImg.alpha = 0.5
        self.StatuButton.tag = indexpath.row
        
        if notificationItemCausesViewRef.vc.allowedStatusArray.contains(validStatusClass.StatusCode) {
            
            if NOTIFICATION_ASSIGNMENT_TYPE == "1"{
                if((UserDefaults.standard.value(forKey:"active_details")) != nil){
                    let activedetails = UserDefaults.standard.value(forKey: "active_details") as! NSDictionary
                    
                    if let activeNonum = activedetails.value(forKey: "Notification") as? String{
                        if activeNonum == selectedNotificationNumber{
                            self.StatuButton.isEnabled = true
                            self.StatusImg.alpha = 1.0
                        }
                    }
                }
            }else{
                if isActiveNotification{
                    self.StatuButton.isEnabled = true
                    self.StatusImg.alpha = 1.0
                }
            }
            
        }
        self.StatuButton.addTarget(self, action: #selector(self.itemTaskStatusButtonAction(sender:)), for: .touchUpInside)
    }
    
    
    @objc func StatusButtonAction(sender:UIButton) {

        let index = sender.tag
        singleNotifViewModel.UpdateStatus(index: index)

    }
    
    @objc func taskStatusButtonAction(sender:UIButton) {

        let index = sender.tag
        notificationTaskViewModelRef.UpdateStatus(index: index)

    }
    @objc func itemTaskStatusButtonAction(sender:UIButton) {

        let index = sender.tag
        notificationItemCausesViewRef.UpdateStatus(index: index)

    }
    @objc func AllStatusButtonAction(sender:UIButton) {
        let index = sender.tag
        if currentMasterView == "WorkOrder"{
            self.detailViewModel.updateObjectStatus(index: index, type: "WorkOrder", selectedWO: selectedworkOrderNumber, selectedOpr: selectedOperationNumber, selectedNo: selectedNotificationNumber)
        }else{
            self.detailViewModel.updateObjectStatus(index: index, type: "Notification", selectedWO: selectedworkOrderNumber, selectedOpr: selectedOperationNumber, selectedNo: selectedNotificationNumber)
        }
    }
}


