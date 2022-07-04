//
//   swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import AssetsLibrary
import MediaPlayer
import AVKit
import MobileCoreServices
import AVFoundation
import UserNotifications
import ODSFoundation
import mJCLib

class AttachmentsViewModel{
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var attachementArray = [AttachmentModel]()
    var compIDArray = [String]()
    var docPath = String()
    var imagePicked = UIImageView()
    var imageData = NSData()
    var newFileName = String()
    var vc: WorkOrderAttachmentVC?
    weak var photoUploadEntity: SODataEntity?
    var property = NSMutableArray()
    var selectedbutton = String()
    var uploadedAttachmentArray = Array<UploadedAttachmentsModel>()
    var urlDoc = NSURL()
    var clodeFileName = String()
    var documentController : UIDocumentInteractionController!
    
    //Get Upload Attachment List..
    func getUploadAttachment() {
        mJCLogger.log("Starting", Type: "info")
        var defineQuery = String()
        if vc!.fromScreen == "WORKORDER"{
            defineQuery = "$filter=(WorkOrderNum%20eq%20%27" + (vc!.objectNum) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        }else if vc!.fromScreen == "EQUIPMENT"{
            defineQuery = "$filter=(Equipment%20eq%20%27" + (vc!.objectNum) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        }else if vc!.fromScreen == "FUNCTIONALLOCATION"{
            defineQuery =  "$filter=(FuncLocation%20eq%20%27" + (vc!.objectNum) + "%27 and BINARY_FLG ne 'N')&$orderby=FILE_NAME"
        }
        UploadedAttachmentsModel.getWoUploadAttachmentListWith(filterQuery: defineQuery) {(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [UploadedAttachmentsModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    self.uploadedAttachmentArray.removeAll()
                    if self.vc!.fromScreen == "WORKORDER"{
                        self.uploadedAttachmentArray = responseArr.filter{$0.FuncLocation == "" && $0.Equipment == ""}
                    }else{
                        self.uploadedAttachmentArray = responseArr
                    }
                    for item in self.uploadedAttachmentArray{
                        if self.compIDArray.contains(item.FILE_NAME) && item.BINARY_FLG != "N" {
                            (item.entity.properties["BINARY_FLG"] as! SODataProperty).value = "N" as NSObject
                            UploadedAttachmentsModel.updateUploadedWoAttachmentEntity(entity: item.entity, flushRequired: true,options: nil){(response, error) in
                                if error == nil{
                                    if let index = self.uploadedAttachmentArray.index(of: item){
                                        self.uploadedAttachmentArray.remove(at: index)
                                        self.vc?.getUploadAttachmentUI()
                                    }
                                    print("uploaded attachmenent deleted")
                                    mJCLogger.log("Update Done", Type: "Debug")
                                    
                                }else{
                                    mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                                }
                            }
                        }
                    }
                    self.vc?.getUploadAttachmentUI()
                    self.vc?.getAttachmentUI()
                }
                else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.vc?.getUploadAttachmentUI()
                self.vc?.getAttachmentUI()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Get Attachment List..
    func getAttachment() {
        mJCLogger.log("Starting", Type: "info")
        var classNameArr = [AttachmentTypeModel]()
        if vc!.fromScreen == "WORKORDER"{
            classNameArr = attachmentTypeListArray.filter{$0.ObjectCategory == "\(vc!.fromScreen)" && $0.ObjectType == "\(singleWorkOrder.OrderType)"}
            if classNameArr.count == 0{
                classNameArr = attachmentTypeListArray.filter{$0.ObjectCategory == "\(vc!.fromScreen)" && $0.ObjectType == "X"}
            }
        }else{
            classNameArr = attachmentTypeListArray.filter{$0.ObjectCategory == "\(vc!.fromScreen)" && $0.ObjectType == "X"}
        }
        var defineQuery = String()
        if classNameArr.count > 0{
            defineQuery = "$filter=(endswith(ObjectKey, '" + vc!.objectNum + "') eq true) and ClassName eq '\(classNameArr[0].ClassName)'&$orderby=DocCount" as String
        }else{
            defineQuery = "$filter=(endswith(ObjectKey, '" + vc!.objectNum + "') eq true)&$orderby=DocCount" as String
        }
        self.attachementArray.removeAll()
        AttachmentModel.getWoAttachmentList(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [AttachmentModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    if responseArr.count > 0 {
                        self.attachementArray = responseArr
                        self.compIDArray.removeAll()
                        for item in self.attachementArray{
                            self.compIDArray.append(item.CompID)
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else {
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                self.getUploadAttachment()
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                self.getUploadAttachment()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func uploadUrlWOAttachment() {
        
        mJCLogger.log("Starting", Type: "info")
        
        property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BINARY_FLG")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "\(vc!.urlDescriptionTextField.text!)" as NSObject
        property.add(prop!)
        
        let tempDocID = String.random(length: 15, type: "Number")
        prop = SODataPropertyDefault(name: "DocID")
        prop!.value = "L\(tempDocID)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_NAME")
        prop!.value = "\(vc!.urlDescriptionTextField.text!)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_SIZE")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "URL")
        prop!.value = "\(vc?.urlTextView.text ?? "")" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MIMETYPE")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        self.property.add(prop!)
        
        if vc!.fromScreen == "EQUIPMENT"{
            prop = SODataPropertyDefault(name: "Equipment")
            prop!.value =  vc!.objectNum as NSObject
            property.add(prop!)
        }else if vc!.fromScreen == "FUNCTIONALLOCATION"{
            prop = SODataPropertyDefault(name: "FuncLocation")
            prop!.value =  vc!.objectNum as NSObject
            property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "TempID")
        if selectedworkOrderNumber.contains(find: "L"){
            prop!.value = selectedworkOrderNumber as NSObject
        }else{
            prop!.value = "" as NSObject
        }
        property.add(prop!)
        
        let entity = SODataEntityDefault(type: workOrderAttachmentUploadentity)
        
        for prop in  property {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name as Any] = proper
            print("Key : \(proper.name ?? "")")
            print("vlue: \(proper.value)")
            mJCLogger.log("Key : \(proper.name)", Type: "Debug")
            print("=================")
        }
        
        photoUploadEntity = entity
        
        UploadedAttachmentsModel.uploadWoAttachmentEntity(entity:  photoUploadEntity!, collectionPath: uploadWOAttachmentContentSet,flushRequired: true, options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                mJCLogger.log("Photo Upload successfully".localized(), Type: "Debug")
                NotificationCenter.default.post(name: Notification.Name(rawValue: "setAttachmentBadgeIcon"), object: false)
                DispatchQueue.main.async {

                    self.vc?.urlTextView.text = ""
                    self.vc?.urlDescriptionTextField.text = ""
                    self.vc?.urlView.isHidden = true
                }
                    self.getUploadAttachment()
                    mJCLoader.stopAnimating()
                
            }else {
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    
    func toAbsolutePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let dirPath = paths.first else {
            return ""
        }
        return dirPath
    }
    //MARK:- Delete timeSheet Record..
    func deleteUploadedAttachmentRecord(tag:Int,from:String)  {
        mJCLogger.log("Starting", Type: "info")
        
        var entity = SODataEntityDefault()
        if from == "Upload"{
            let uploadedAttachmentsclass =  uploadedAttachmentArray[tag]
            entity = uploadedAttachmentsclass.entity
            (entity.properties["BINARY_FLG"] as! SODataProperty).value = "Y" as NSObject
        }else{
            let attachmentModelClass =  attachementArray[tag]
            entity = attachmentModelClass.entity
        }
        
        AttachmentModel.deleteWoAttachmentEntity(entity: entity, options: nil, completionHandler: { (response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    var isShowBadgeIcon = Bool()
                    if  self.uploadedAttachmentArray.count == 0 {
                        isShowBadgeIcon = true
                    }
                    else {
                        isShowBadgeIcon = false
                    }
                    if from == "Upload"{
                        self.uploadedAttachmentArray.remove(at: tag)
                        self.vc?.getUploadAttachmentUI()
                    }else{
                        self.attachementArray.remove(at: tag)
                        self.vc?.getAttachmentUI()
                    }
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"setAttachmentBadgeIcon"), object: isShowBadgeIcon)
                    mJCLogger.log("record deleted successfully!".localized(), Type: "Debug")
                }
            }
            else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
}
