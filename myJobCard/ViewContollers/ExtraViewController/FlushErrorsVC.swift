//
//  FlushErrorsVC.swift
//  myJobCard
//
//  Created by Rover Software on 15/12/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib


class FlushErrorsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var errorlistTable: UITableView!
    @IBOutlet var cancelButton: UIButton!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        errorlistTable.dataSource = self
        errorlistTable.delegate = self
        errorlistTable.bounces = false
        errorlistTable.isEditing = false
        errorlistTable.separatorStyle = .none
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flushErrorsArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        mJCLogger.log("Starting", Type: "info")
        let cell = self.errorlistTable.dequeueReusableCell(withIdentifier: "FlushErrorTableViewCell") as! FlushErrorTableViewCell
        cell.contentView.layer.cornerRadius = 3.0
        cell.contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.contentView.layer.shadowOpacity = 0.2
        cell.contentView.layer.shadowRadius = 2
        let dict = flushErrorsArray[indexPath.row] as! NSMutableDictionary
        mJCLogger.log("Response:\(flushErrorsArray.count)", Type: "Debug")
        cell.idLabel.text = "\(dict.value(forKey: "RequestID") as? Int32 ?? 0)"
        cell.objKeyLabel.text = "\(dict.value(forKey: "objecttext") as? String ?? "")"
        cell.messageText.text = MessageTitle + " : \(dict.value(forKey: "errorMsg") as? String ?? "Message")"
        cell.editButton.tag = indexPath.row
        cell.ignoreButton.tag = indexPath.row
        cell.clearButton.tag = indexPath.row
        cell.clearButton.addTarget(self, action:#selector(FlushErrorsVC.editAction(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
        return cell
    }
    @objc func editAction(sender: UIButton!) {
        
        mJCLogger.log("Starting", Type: "info")
        let dict = flushErrorsArray[sender.tag]
        let entity = (dict as AnyObject).value(forKey: "entity") as! SODataEntityDefault
        let storeName = (dict as AnyObject).value(forKey: "Store") as! String
        mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: "\(entity.resourcePath!)/AffectedEntity", storeName: storeName){(response,error) in
            if error == nil{
                mJCLogger.log("Response:\(response.count)", Type: "Debug")
                self.errorCorrectionHandling(responseDict: response, errorDict: dict as! NSMutableDictionary)
            }else{
                mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func ignoreAction(sender: UIButton!) {
        
    }
    @objc func ClearAction(sender: UIButton!) {
        mJCLogger.log("Starting", Type: "info")
        let dict = flushErrorsArray[sender.tag]
        let entity = (dict as AnyObject).value(forKey: "entity") as! SODataEntityDefault
        let storeName = (dict as AnyObject).value(forKey: "Store") as! String
        
        mJCLogger.log("Ended", Type: "info")
    }
    
    func errorCorrectionHandling(responseDict:NSMutableDictionary,errorDict:NSMutableDictionary){
        
        mJCLogger.log("Starting", Type: "info")
        if (errorDict as AnyObject).value(forKey: "RequestURL") as! String == woHeader{
            let responseDict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: responseDict), entityModelClassType: WoHeaderModel.self)
            if let responseArr = responseDict["data"] as? [WoHeaderModel]{
                if responseArr.count > 0 {
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    DispatchQueue.main.async{
                        let createWorkOrderVC = ScreenManager.getCreateWorkOrderScreen()
                        createWorkOrderVC.isFromEdit = true
                        createWorkOrderVC.isFromError = true
                        createWorkOrderVC.errorWorkorder = responseArr[0]
                        createWorkOrderVC.modalPresentationStyle = .fullScreen
                        self.present(createWorkOrderVC, animated: false) {}
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else if (errorDict as AnyObject).value(forKey: "RequestURL") as! String == woOperationSet{
            let oprDict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: responseDict), entityModelClassType: WoOperationModel.self)
            if let responseArr = oprDict["data"] as? [WoOperationModel]{
                if responseArr.count > 0 {
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    DispatchQueue.main.async{
                        let editOperationVC = ScreenManager.getCreateOperationScreen()
                        editOperationVC.isFromScreen = "Operation"
                        editOperationVC.isFromEdit = true
                        editOperationVC.isFromError = true
                        editOperationVC.errorOperation = responseArr[0]
                        editOperationVC.modalPresentationStyle = .fullScreen
                        self.present(editOperationVC, animated: false) {}
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else if (errorDict as AnyObject).value(forKey: "RequestURL") as! String == uploadWOAttachmentContentSet{
            
            let attachDict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: responseDict), entityModelClassType: UploadedAttachmentsModel.self)
            if let arr = attachDict["data"] as? [UploadedAttachmentsModel]{
                mJCLogger.log("Response:\(arr[0])", Type: "Debug")
                let attchcls = arr[0]
                let workorder = attchcls.WorkOrderNum
                DispatchQueue.main.async{
                    self.dismiss(animated: false, completion: nil)
                }
                UserDefaults.standard.set("\(workorder)", forKey: "FromError")
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else if (errorDict as AnyObject).value(forKey: "RequestURL") as! String == responseCaptureSet{

            let formDict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: responseDict), entityModelClassType: FormResponseCaptureModel.self)
            if let array = formDict["data"] as? [FormResponseCaptureModel]{
                mJCLogger.log("Response:\(array[0])", Type: "Debug")
                let formcls = array[0]
                DispatchQueue.main.async{
                    let newformsVC = ScreenManager.getCheckSheetViewerScreen()
                    newformsVC.formResponseCaptureClass = formcls
                    newformsVC.isFromEditScreen = true
                    newformsVC.modalPresentationStyle = .fullScreen
                    self.present(newformsVC, animated: false) {}
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }

        }else if (errorDict as AnyObject).value(forKey: "RequestURL") as! String == measurementPointReadingSet{

            let measurDict = formateHelperClass.getListInFormte(dictionary: responseDict , entityModelClassType: MeasurementPointModel.self)
            if let array = measurDict["data"] as? [MeasurementPointModel]{
                mJCLogger.log("Response:\(array[0])", Type: "Debug")
                let measurCls = array[0]
                let workorder = measurCls.WOObjectNum
                DispatchQueue.main.async{
                    self.dismiss(animated: false, completion: nil)
                }
                UserDefaults.standard.set("\(workorder)", forKey: "FromMeasureError")
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
            
        }else if (errorDict as AnyObject).value(forKey: "RequestURL") as! String == notificationHeaderSet{
            
            let responseDict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: responseDict), entityModelClassType: NotificationModel.self)
            if let responseArr = responseDict["data"] as? [NotificationModel]{
                if responseArr.count > 0 {
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    DispatchQueue.main.async{
                        let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                        createNotificationVC.isFromEdit = true
                        createNotificationVC.isFromError = true
                        createNotificationVC.errorNotifiation = responseArr[0]
                        createNotificationVC.modalPresentationStyle = .fullScreen
                        self.present(createNotificationVC, animated: false) {
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else if (errorDict as AnyObject).value(forKey: "RequestURL") as! String == woConfirmationSet{
            let responseDict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: responseDict), entityModelClassType: WoConfirmationModel.self)
            if let responseArr = responseDict["data"] as? [WoConfirmationModel]{
                if responseArr.count > 0 {
                    mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                    DispatchQueue.main.async{
                        let finalConfirVc = ScreenManager.getCreateFinalConfirmationScreen()
                        finalConfirVc.screenType = "errorEdit"
                        finalConfirVc.errorConfirEntity = responseArr[0]
                        finalConfirVc.modalPresentationStyle = .fullScreen
                        self.present(finalConfirVc, animated: false) {}
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }

        }else{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Sorry_We_Can't_Edit_This_Error".localized(), button: okay)
        }

//        else if (errorDict as AnyObject).value(forKey: "RequestURL") as! String == catRecordSet{
//
//            let timeSheetDict = formateHelperClass.getListInFormte(dictionary: NSMutableDictionary(dictionary: responseDict), entityModelClassType: TimeSheetModel.self)
//            mJCLogger.log("Response:\(timeSheetDict.count)", Type: "Debug")
//            if(timeSheetDict["data"] as AnyObject).count > 0{
//                if let timeSheetDictArraay = timeSheetDict["data"] as? [TimeSheetModel]{
//                    DispatchQueue.main.async{
//                        let addTimeEntryVC = ScreenManager.getCreateTimeSheetScreen()
//                        addTimeEntryVC.screenType = "EditTimeSheet"
//                        addTimeEntryVC.isFromError = true
//                        addTimeEntryVC.timeSheetClass = timeSheetDictArraay[0]
//                        addTimeEntryVC.modalPresentationStyle = .fullScreen
//                        self.present(addTimeEntryVC, animated: false) {}
//                    }
//                }else{
//                    mJCLogger.log("Data not found", Type: "Debug")
//                }
//            }else{
//                mJCLogger.log("Data not found", Type: "Debug")
//            }
//        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func ClearLogsButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        for i in 0..<flushErrorsArray.count{
            let dict = flushErrorsArray[i]
            let entity = (dict as AnyObject).value(forKey: "entity") as! SODataEntityDefault
            let storeName = (dict as AnyObject).value(forKey: "Store") as? String
            if storeName != ""{
                mJCOfflineHelper.deleteOfflineEntity(entity: entity, storeName: storeName!,options: nil){(response,error) in
                    if error == nil{
                        DispatchQueue.main.async{
                            mJCLogger.log("Logs Clear Successfully", Type: "Debug")
                            self.errorlistTable.reloadData()
                            self.dismiss(animated: true, completion: nil)
                        }
                    }else{
                        mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
