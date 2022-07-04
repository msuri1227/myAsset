//
//  manualCheckSheetViewModel.swift
//  myJobCard
//
//  Created by Suri on 13/05/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import FormsEngine
import mJCLib

class manualCheckSheetViewModel {

    weak var delegate: viewModelDelegate?
    
    var manualCheckListArray = [FormAssignDataModel]()
    var formAssignmentType = String()
    var woAssigmentType = String()
    var woObj = WoHeaderModel()
    var oprObj = WoOperationModel()

    func getManualCheckSheetData(){
        var defineQuery = String()
        if woAssigmentType == "1" || woAssigmentType == "3"{
            defineQuery = "$filter=(WorkOrderNum eq '\(woObj.WorkOrderNum)')"
        }else{
            defineQuery = "$filter=(WorkOrderNum eq '\(oprObj.WorkOrderNum)' and OprNum eq '\(oprObj.OperationNum)')"
        }
        FormAssignDataModel.getFormManualAssignmentData(filterQuery: defineQuery){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [FormAssignDataModel]{
                    self.manualCheckListArray.removeAll()
                    self.manualCheckListArray = responseArr
                }
                self.delegate?.dataFetchCompleted?(type: "ManualCheckSheetList", object: [])
            }else{
                
            }
        }
    }
    func createEntities(entityList:[Any],index:Int){
        if let entity = entityList[index] as? SODataEntityDefault{
            FormAssignDataModel.createFormManualAssignmentEntry(entity: entity, flushRequired: true,options: nil){ (response, error) in
                if error == nil{
                    if index == entityList.count - 1{
                        DispatchQueue.main.async {
                            mJCLoader.stopAnimating()
                            let params = Parameters(
                                title: MessageTitle,
                                message: "Check sheets added successfully",
                                cancelButton: okay
                            )
                            mJCAlertHelper.showAlertWithHandler(parameters: params) { buttonIndex in
                                switch buttonIndex {
                                case 0: self.delegate?.dataFetchCompleted?(type: "Dismiss", object: [])
                                default: break
                                }
                            }
                        }
                    }else{
                        self.createEntities(entityList: entityList, index: index + 1)
                    }
                }else{
                    if index == entityList.count - 1{
                        self.delegate?.dataFetchCompleted?(type: "Dismiss", object: [])
                    }else{
                        self.createEntities(entityList: entityList, index: index + 1)
                    }
                }
            }
        }
    }
    func deleteCheckSheet(tag:Int)  {
        mJCLogger.log("Starting", Type: "info")
        let entity = (self.manualCheckListArray[tag]).entity
        FormAssignDataModel.deleteFormManualAssignmentEntry(entity: entity, options: nil){ (response, error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.getManualCheckSheetData()
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}

