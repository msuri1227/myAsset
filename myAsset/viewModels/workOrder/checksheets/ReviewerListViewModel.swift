//
//  ReviewerListViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 27/07/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class ReviewerListViewModel {
    
    var reviewerVC: ReviewerVC!
    var selectedIndex = Int()
    func getRevieweList(){
        let defineQuery = ""
        FormReviewerResponseModel.getFormReviewerResponseList(filterQuery: defineQuery){ (response, error) in
            if error == nil{
                if let responseArr = response["data"] as? [FormReviewerResponseModel]{
                    if responseArr.count > 0{
                        self.reviewerVC.reviewerRespArr = responseArr
                        self.reviewerVC.mainReviewerRespArr = responseArr
                    }
                }
                self.reviewerVC.updateUI()
            }
        }
    }
    func getFormApproverList(reviewerObj:FormReviewerResponseModel,from:String) {
        
        let filterQuery = "$filter=(FormID eq '\(reviewerObj.FormID)' and Version eq '\(reviewerObj.Version)' and FormInstanceID eq '\(reviewerObj.InstanceID)' and ApproverID eq '\(strUser)' and FormSubmittedBy eq '\(reviewerObj.ModifiedBy)' and Counter eq '\(reviewerObj.Counter)')"
        FormResponseApprovalStatusModel.getFormResponseApprovalStatusData(filterQuery:filterQuery){ (response, error) in
            if error == nil{
                if let responseArr = response["data"] as? [FormResponseApprovalStatusModel]{
                    if responseArr.count > 0{
                        self.reviewerVC.approverRespObj = responseArr[0]
                        self.reviewerVC.approverRespArr = responseArr
                    }
                    if from == "Approve"{
                        self.reviewerVC.updateApprroveRejectView()
                    }else if from == "Remarks"{
                        self.reviewerVC.updateRemarksListView()
                    }
                }
            }
        }
    }
    func getFormDetailsToApproveOrRect(index:Int) {
        selectedIndex = index
        self.getFormApproverList(reviewerObj: reviewerVC.reviewerRespArr[index], from: "Approve")
    }
    func getPreviousRemarks(index:Int){
        selectedIndex = index
        self.getFormApproverList(reviewerObj: reviewerVC.reviewerRespArr[index], from: "Remarks")
    }
    func createApproverStatus() {
        
        mJCLoader.startAnimating(status: "Please Wait....")
        
        let reviewrClass = self.reviewerVC.reviewerRespArr[selectedIndex]
        
        let formEntityArray = NSMutableArray()
        
        var prop : SODataProperty! = SODataPropertyDefault(name: "FormID")
        prop!.value = reviewrClass.FormID as NSObject
        formEntityArray.add(prop!)
        
        prop = SODataPropertyDefault(name: "FormInstanceID")
        prop!.value = reviewrClass.InstanceID as NSObject
        formEntityArray.add(prop!)
        
        prop = SODataPropertyDefault(name: "Version")
        prop!.value = reviewrClass.Version as NSObject
        formEntityArray.add(prop!)
        
        prop = SODataPropertyDefault(name: "ApproverID")
        prop!.value = "\(strUser)" as NSObject
        formEntityArray.add(prop!)
        
        prop = SODataPropertyDefault(name: "FormSubmittedBy")
        prop!.value = reviewrClass.CreatedBy as NSObject
        formEntityArray.add(prop!)
        
        prop = SODataPropertyDefault(name: "Counter")
        prop!.value = reviewrClass.Counter as NSObject
        formEntityArray.add(prop!)
        
        prop = SODataPropertyDefault(name: "Remarks")
        prop!.value = self.reviewerVC.remarksTextView.text! as NSObject
        formEntityArray.add(prop!)
        
        prop = SODataPropertyDefault(name: "FormContentStatus")
        let statusArray = myAssetDataManager.uniqueInstance.getStatuses(statusVisible: "", StatuscCategory: checkSheetLevel , ObjectType: "X")
        if self.reviewerVC.approveButton.isSelected == true{
            let arr = statusArray.filter{$0.StatusCode == "APPR"}
            if arr.count > 0{
                let stausCls = arr[0]
                prop!.value = stausCls.StatusDescKey as NSObject
            }
        }else if self.reviewerVC.rejectButton.isSelected == true{
            let arr = statusArray.filter{$0.StatusCode == "REJC"}
            if arr.count > 0{
                let stausCls = arr[0]
                prop!.value = stausCls.StatusDescKey as NSObject
            }
        }
        formEntityArray.add(prop!)
        
        prop = SODataPropertyDefault(name: "CreatedDate")
        let datestr = Date().localDate()
        prop.value = datestr as NSObject
        formEntityArray.add(prop)
        
        prop = SODataPropertyDefault(name: "CreatedTime")
        let basicTime = SODataDuration()
        let time = Date().toString(format: .custom("HH:mm"))
        let basicTimeArray = time.components(separatedBy:":")
        basicTime.hours = Int(basicTimeArray[0]) as NSNumber?
        basicTime.minutes = Int(basicTimeArray[1]) as NSNumber?
        basicTime.seconds = 0
        prop.value = basicTime
        formEntityArray.add(prop)
        
        if self.reviewerVC.correctionRequiredButton.isSelected == true{
            prop = SODataPropertyDefault(name: "IterationRequired")
            prop!.value = "X" as NSObject
            formEntityArray.add(prop!)
        }
        
        let entity = SODataEntityDefault(type: approverCheckSheetCreateEntity)
        
        for prop in formEntityArray {
            let proper = prop as! SODataProperty
            entity?.properties[proper.name ?? ""] = proper
        }
        
        FormResponseApprovalStatusModel.createFormResponseApprovalStatusEntry(entity: entity!, collectionPath: "FormResponseApprovalStatusSet",  flushRequired: false, options: nil){ (response, error) in
            
            if error == nil{
                mJCLoader.stopAnimating()
                DispatchQueue.main.async {
                    self.reviewerVC!.checkSheetReviewBgView.isHidden = true
                }
                mJCLogger.log("Approver Posted", Type: "Debug")
            }else{
                mJCLoader.stopAnimating()
            }
        }
    }
    
    func updateApproverStatus() {
        
        mJCLoader.startAnimating(status: "Please Wait....")
        (self.reviewerVC.approverRespObj.entity.properties["Remarks"] as! SODataProperty).value = self.reviewerVC.remarksTextView.text!  as NSObject
        if self.reviewerVC.correctionRequiredButton.isSelected == true{
            (self.reviewerVC.approverRespObj.entity.properties["IterationRequired"] as! SODataProperty).value = "X" as NSObject
        }
        FormResponseApprovalStatusModel.updateFormResponseApprovalStatusEntry(entity: self.reviewerVC.approverRespObj.entity,  flushRequired: true, options: nil){ (response, error) in
            if error == nil{
                mJCLoader.stopAnimating()
                DispatchQueue.main.async {
                    self.reviewerVC!.checkSheetReviewBgView.isHidden = true
                }
            }else{
                mJCLoader.stopAnimating()
            }
        }
    }
}
