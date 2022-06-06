//
//  SignatureCaptureViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutionson 04/04/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import mJCLib

class SignatureCaptureViewModel{
    
    var signatureCaptureVc :  SignatureCaptureVC?
    var signatureImage = UIImage()
    var noteProperty = NSMutableArray()
    var attachmentProperty = NSMutableArray()
    
    func addSignatureView(){
        
        signatureCaptureVc?.signView.subviews.forEach { $0.removeFromSuperview() }
        signatureCaptureVc!.signatureView.frame = CGRect(x: 0, y: 0, width:signatureCaptureVc!.signView.frame.size.width, height:signatureCaptureVc!.signView.frame.size.height)
        signatureCaptureVc?.signatureView.tag = 11111
        signatureCaptureVc?.signView.addSubview(signatureCaptureVc!.signatureView)
        signatureCaptureVc?.signView.bringSubviewToFront(signatureCaptureVc!.signatureView)
    }
    func clearSignature(){
        signatureCaptureVc?.signatureView.clearSignature()
    }
    func getSignatureFromView(){
        
        if signatureCaptureVc!.customerSelectButton.isSelected == false{
            if signatureCaptureVc!.signatureView.isDrawImage(){
                signatureImage = signatureCaptureVc!.signatureView.getSignatureImage()
                self.uploadWorkOrderAttachment()
            }else{
                mJCAlertHelper.showAlert(signatureCaptureVc!, title: alerttitle, message: "You_have_not_take_signature_Please_take_signature".localized(), button: okay)
            }
        }else{
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                signatureCaptureVc?.woLongTextVM.createWoLongtext(text: "Customer_not_available!".localized(),requiredEntity: true)
            }else{
                signatureCaptureVc?.woLongTextVM.createOprLongtext(text: "Customer_not_available!".localized(),requiredEntity: true)
            }
        }
    }
    func uploadWorkOrderAttachment() {
        
        mJCLogger.log("Starting", Type: "info")
        
        self.attachmentProperty = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "BINARY_FLG")
        prop!.value = "" as NSObject
        self.attachmentProperty.add(prop!)
        
        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "Customer signature" as NSObject
        self.attachmentProperty.add(prop!)
        
        let timeInMiliseconds = DateFormatterModelClass.uniqueInstance.getTimeIntoMiliSecond(date: NSDate())
        
        prop = SODataPropertyDefault(name: "DocID")
        prop!.value = "L\(timeInMiliseconds)" as NSObject
        self.attachmentProperty.add(prop!)
        
        prop = SODataPropertyDefault(name: "FILE_NAME")
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3" {
            prop!.value = "Customer_signature_\(selectedworkOrderNumber).png" as NSObject
        }else{
            prop!.value = "Customer_signature_\(selectedworkOrderNumber)_\(selectedOperationNumber).png" as NSObject
        }
        self.attachmentProperty.add(prop!)
        
        let imgData = signatureImage.pngData()
        
        if imgData?.count != nil {
            
            let fileSize = String(imgData!.count)
            prop = SODataPropertyDefault(name: "FILE_SIZE")
            prop!.value = fileSize as NSObject
            self.attachmentProperty.add(prop!)
            let base64String = imgData!.base64EncodedString(options: .lineLength64Characters)
            prop = SODataPropertyDefault(name: "Line")
            prop!.value = base64String as NSObject?
            self.attachmentProperty.add(prop!)
            
        }
        prop = SODataPropertyDefault(name: "MIMETYPE")
        prop!.value = "image/png" as NSObject
        self.attachmentProperty.add(prop!)
        
        prop = SODataPropertyDefault(name: "WorkOrderNum")
        prop!.value = selectedworkOrderNumber as NSObject
        self.attachmentProperty.add(prop!)
        
        let entity = SODataEntityDefault(type: workOrderAttachmentUploadentity)
        for prop in self.attachmentProperty {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name ?? ""] = proper
        }
        var entityDict = Dictionary<String,Any>()
        entityDict["collectionPath"] = uploadWOAttachmentContentSet
        entityDict["entity"] = entity
        entityDict["type"] = "Create"
        self.signatureCaptureVc!.suspendViewModel.entityDict["signature"] = entityDict
        
        self.signatureCaptureVc!.suspendViewModel.validateCompletionFeatures()
        
        mJCLogger.log("Ended", Type: "info")
    }
}
