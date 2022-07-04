//
//  AssetHierarchyOverviewViewModel.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 15/02/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import mJCLib
import ODSFoundation

class AssetHierarchyOverviewViewModel {
    
    var assetHierarchyOverviewVc: AssetHierarchyOverViewVC?
    let SelectedArr = NSMutableArray()
    var TypeString = String()
    
    func getBasicData() {
        if TypeString == "EQ"{
            var equipmenntarr = [EquipmentModel]()
            if totalEquipmentArray.count == 0{
                EquipmentModel.getEquipmentDetails(equipNum: self.assetHierarchyOverviewVc!.selectedNumber){ (response, error)  in
                    if error == nil{
                        if let equipArr = response["data"] as? [EquipmentModel]{
                            equipmenntarr = equipArr
                            if equipmenntarr.count > 0{
                                self.SelectedArr.removeAllObjects()
                                self.SelectedArr.add(equipmenntarr[0])
                            }else{
                                self.SelectedArr.removeAllObjects()
                                self.SelectedArr.add(EquipmentModel())
                            }
                        }else{
                            self.SelectedArr.removeAllObjects()
                            self.SelectedArr.add(EquipmentModel())
                            mJCLogger.log("Equipment Data not found", Type: "Debug")
                        }
                        self.assetHierarchyOverviewVc?.upadteUIGetBasicData()
                    }else{
                        self.SelectedArr.removeAllObjects()
                        self.SelectedArr.add(EquipmentModel())
                        self.assetHierarchyOverviewVc?.upadteUIGetBasicData()
                        mJCLogger.log("Equipment Data not found", Type: "Debug")
                    }
                }
            }else{
                let searchPredicate = NSPredicate(format: "SELF.Equipment == %@",self.assetHierarchyOverviewVc!.selectedNumber)
                equipmenntarr = (totalEquipmentArray as NSArray).filtered(using: searchPredicate) as! [EquipmentModel]
                if equipmenntarr.count > 0{
                    self.SelectedArr.removeAllObjects()
                    self.SelectedArr.add(equipmenntarr[0])
                }else{
                    self.SelectedArr.removeAllObjects()
                    self.SelectedArr.add(EquipmentModel())
                }
                self.assetHierarchyOverviewVc?.upadteUIGetBasicData()
            }
        }else if TypeString == "FL"{
            var functionLocationArray = [FunctionalLocationModel]()
            if funcLocationArray.count == 0{
                FunctionalLocationModel.getFuncLocationDetails(funcLocation: self.assetHierarchyOverviewVc!.selectedNumber){ (response, error)  in
                    if error == nil{
                        if let flocArr = response["data"] as? [FunctionalLocationModel]{
                            functionLocationArray = flocArr
                            if functionLocationArray.count > 0{
                                self.SelectedArr.removeAllObjects()
                                self.SelectedArr.add(functionLocationArray[0])
                            }else{
                                self.SelectedArr.removeAllObjects()
                                self.SelectedArr.add( FunctionalLocationModel())
                            }
                        }else{
                            self.SelectedArr.removeAllObjects()
                            self.SelectedArr.add( FunctionalLocationModel())
                            mJCLogger.log("floc Data not found", Type: "Debug")
                        }
                        self.assetHierarchyOverviewVc?.upadteUIGetBasicData()
                    }else{
                        self.SelectedArr.removeAllObjects()
                        self.SelectedArr.add( FunctionalLocationModel())
                        self.assetHierarchyOverviewVc?.upadteUIGetBasicData()
                        mJCLogger.log("floc Data not found", Type: "Debug")
                    }
                }
            }else{
                let searchPredicate = NSPredicate(format: "SELF.FunctionalLoc == %@",self.assetHierarchyOverviewVc!.selectedNumber)
                functionLocationArray = (funcLocationArray as NSArray).filtered(using: searchPredicate) as! [FunctionalLocationModel]
                if functionLocationArray.count > 0{
                    self.SelectedArr.removeAllObjects()
                    self.SelectedArr.add(functionLocationArray[0])
                }else{
                    self.SelectedArr.removeAllObjects()
                    self.SelectedArr.add(functionLocationArray[0])
                }
                self.assetHierarchyOverviewVc?.upadteUIGetBasicData()
            }
        }
    }
}
