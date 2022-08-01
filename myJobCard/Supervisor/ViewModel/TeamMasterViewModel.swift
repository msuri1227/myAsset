//
//  TeamMasterViewModel.swift
//  myJobCard
//
//  Created by Khaleel on 14/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

//import Foundation
import UIKit
import mJCLib
import ODSFoundation

class TeamMasterViewModel {
    
    var vc : TeamMasterVC!
    var workorderListArray = [WoHeaderModel]()
    
    //Get WorkOrder List..
    func getSupervisorWorkOrderList() {
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getSuperVisorWorkorderList(){ (responseDict, error)  in
            if error == nil{
                self.workorderListArray.removeAll()
                if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        self.workorderListArray = responseArr
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
                self.getTechnicianList()
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getTechnicianList(){
        
        mJCLogger.log("Starting", Type: "info")
        SupervisorTechnicianModel.getSupervisorTechncianDetails(){ (responseDict, error)  in
            if error == nil{
                if let responseArr = responseDict["data"] as? [SupervisorTechnicianModel]{
                    if responseArr.count > 0 {
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        alltechnicianListArray = responseArr
                        DispatchQueue.main.async {
                            self.vc.totalWorkOrderLabel.text = "Total_Members".localized() + ": \(alltechnicianListArray.count)"
                        }
                        for technncian in alltechnicianListArray{
                            let filterArr = self.workorderListArray.filter{$0.Technician == technncian.Technician}
                            if filterArr.count > 0{
                                technncian.TechnicianWorkordercount = filterArr.count
                            }else{
                                technncian.TechnicianWorkordercount = 0
                            }
                        }
                        DispatchQueue.main.sync {
                            self.vc.techniciantable.delegate = self.vc
                            self.vc.techniciantable.dataSource = self.vc
                            self.vc.techniciantable.reloadData()
                            if DeviceType == iPad{
                                let indexPath = IndexPath(row: 0, section: 0)
                                if self.vc.techniciantable.isValidIndexPath(indexPath: indexPath){
                                    self.vc.techniciantable.selectRow(at: indexPath, animated: false, scrollPosition: .top)
                                }
                                if self.vc.techniciantable.isValidIndexPath(indexPath: indexPath){
                                    self.vc.tableView(self.vc.techniciantable, didSelectRowAt: indexPath)
                                }
                                self.vc.performSegue(withIdentifier: "showDetail", sender: WorkOrderCell.self)
                            }
                        }
                    }else {
                        mJCLogger.log("Data not found", Type: "Debug")
                        DispatchQueue.main.sync {
                            self.vc.techniciantable.delegate = self.vc
                            self.vc.techniciantable.dataSource = self.vc
                            self.vc.techniciantable.reloadData()
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
