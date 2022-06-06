//
//  PersonResponsibleListViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 13/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class PersonResponsibleListViewModel {
    
    var personResponVC : PersonResponsibleListVC?
    var personResponsibleArray = [PersonResponseModel]()
    var personResponsibleListArray = [PersonResponseModel]()
    var filterBy = String()
    
    //MARK:- Get Person Responsible List..
    func getPersonResponsibleList() {
        mJCLogger.log("Starting", Type: "info")
        if self.personResponVC?.isFrom == "Capacity"{
            let defineQuery = "$filter=(OperationWorkCenter%20eq%20%27\(singleOperation.WorkCenter)%27)&$orderby=PersonnelNo"
            PersonResponseModel.getPersonResponseList(filterQuery:defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [PersonResponseModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.personResponsibleArray = responseArr
                        self.personResponsibleListArray = responseArr
                        self.personResponVC?.updateUIGetPersonResponsibleList()
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            PersonResponseModel.getPersonResponseList(){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [PersonResponseModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.personResponsibleArray = responseArr
                        self.personResponsibleListArray = responseArr
                        self.personResponVC?.updateUIGetPersonResponsibleList()
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
