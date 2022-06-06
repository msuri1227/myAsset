//
//  BreakdownReportViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 15/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class BreakdownReportViewModel {
    
    var vcBreakdownReport : BreakDownReportVC?
    var breakdownReportArray = Array<Any>()
    
    func getOnlineResults(query:String) {
        
        mJCLogger.log("Starting", Type: "info")
        let httpConvMan1 = HttpConversationManager.init()
        let commonfig1 = CommonAuthenticationConfigurator.init()
        if authType == "Basic"{
            commonfig1.addUsernamePasswordProvider(myAssetDataManager.uniqueInstance)
        }else if authType == "SAML"{
            commonfig1.addSAML2ConfigProvider(myAssetDataManager.uniqueInstance)
        }
        commonfig1.configureManager(httpConvMan1)
        
        let BreakDownDict = BreakdownReportModel.getOnlineBreakdownReportList(httpConvManager: httpConvMan1!, filterQuery: query)
        if let status = BreakDownDict["Status"] as? Int{
            if status == 200 {
                if let responseDic = BreakDownDict["Response"] as? NSMutableDictionary {
                    let responseDict = formateHelperClass.getListInFormte(dictionary: responseDic, entityModelClassType: BreakdownReportModel.self)
                    if let responseArr = responseDict["data"] as? [BreakdownReportModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.breakdownReportArray.removeAll()
                        self.breakdownReportArray.append(contentsOf: responseArr)
                        DispatchQueue.main.async {
                            mJCLoader.stopAnimating()
                        }
                    }else{
                        mJCLoader.stopAnimating()
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLoader.stopAnimating()
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLoader.stopAnimating()
                mJCLogger.log("Reason : \(String(describing: BreakDownDict["Error"]))", Type: "Error")
            }
        }else{
            mJCLoader.stopAnimating()
            mJCAlertHelper.showAlert(self.vcBreakdownReport!, title: alerttitle, message: BreakDownDict["Error"] as? String, button: okay)
            mJCLogger.log("Reason : \(String(describing: BreakDownDict["Error"]))", Type: "Error")
        }
        self.vcBreakdownReport?.updateUIGetOnlineResults()
        mJCLogger.log("Ended", Type: "info")
    }
}
