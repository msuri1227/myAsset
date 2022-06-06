//
//  protocals.swift
//  myAsset
//
//  Created by Suri on 16/09/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import FormsEngine
import mJCLib

protocol reloadDelegate: class {
    func tableReload(_ Create: Bool,Update:Bool)
}
public protocol globalDataFetchCompleteDelegate
{
    func globalDataFetchCompleteCompleted()
}
@objc protocol checkSheetSelectionDelegate: class {
    @objc optional func checkSheetSelected(list:[FormMasterMetaDataModel],masterList:[FormMasterMetaDataModel])
}
protocol FuncLocEquipSelectDelegate: class {
    func FuncLocOrEquipSelected(selectedObj:String,EquipObj:EquipmentModel,FuncObj:FunctionalLocationModel)
}
protocol attendanceTypeDelegate: class {
    func attendanceTypeSelected(value:String)
}
protocol FuncOrEquipmentSelectedDelegate: class {
    func FuctionOrEquipment(funcSelectd:Bool,equipSelected:Bool,equipmentObjSelected:AnyObject)
}
protocol personResponsibleDelegate {
    func didSelectPersonRespData(_ result: String,_ objcet:AnyObject,_ respType: String?)
}
protocol ImageAnnotationDelegate {
    func updatedImgData(imgData:NSData,FileName:String,Description:String)
}
@objc protocol CreateUpdateDelegate{
    @objc optional func EntityCreated()
    @objc optional func EntityUpdated()
}
protocol taskAttachmentDelegate: class {
    func updateTaskAttachment(count:Int)
}
protocol timeSheetDelegate {
    func timeSheetAdded(statusCategoryCls: StatusCategoryModel)
}
protocol filterDelegate {
    func ApplyFilter()
}
protocol SelectComponetDelegate: class {
    func setSeleceditem(selectedItem: ComponentAvailabilityModel)
}
protocol formSaveDelegate: class {
    func formSaved(Save: Bool,statusCategoryCls:StatusCategoryModel,formFrom:String)
}
protocol formFilledDelegate: class {
    func formFilled()
}
protocol operationCreationDelegate: class {
    func operation(_ Create: Bool,Update:Bool)
}
protocol annotationDelegate: class {
    func updatedImgData(imgData:NSData,FileName:String,Description:String)
}
@objc protocol listSelectionDelegate {
    @objc optional func listObjectSelected()
}
@objc protocol viewModelDelegate: class {
    @objc optional func dataFetchCompleted(type:String,object:[Any])
    @objc optional func updateUI(type:String)
    @objc optional func setBadgeCount(type:String,count:String,badgeColor:UIColor)
}
@objc protocol barcodeDelegate: class {
    @objc optional func scanCompleted(type:String,barCode:String,object:Any)
}

