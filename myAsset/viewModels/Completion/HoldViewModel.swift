//
//  HoldViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutionson 19/04/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//


import Foundation
import ODSFoundation
import mJCLib

class HoldViewModel{

    var holdVc :  WorkOrderHoldVC?

    func setViewLayouts(){
        ODSUIHelper.setBorderToView(view:self.holdVc!.holdReasonButtonView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.holdVc!.holdNoteTextViewView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
    }
    //MARK:- get Hold Reason Data..
    func getHoldReasonData() {
        mJCLogger.log("Starting", Type: "info")
        ReasonCodeModel.getResonCodeList(status: STATUS_HOLD){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [ReasonCodeModel]{
                    mJCLogger.log("Response :\(responseArr.count)", Type: "Debug")
                    DispatchQueue.main.async {
                        self.holdVc!.holdReasonArray = responseArr
                        for itemCount in 0..<responseArr.count {
                            let reasonCodeSetClass = responseArr[itemCount]
                            self.holdVc!.holdReasonListArray.append(reasonCodeSetClass.Reason)
                        }
                        if self.holdVc!.holdReasonListArray.count > 0 {
                            self.holdVc!.holdReasonButton.setTitle(self.holdVc!.holdReasonListArray[0], for: .normal)
                        }
                        else {
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
