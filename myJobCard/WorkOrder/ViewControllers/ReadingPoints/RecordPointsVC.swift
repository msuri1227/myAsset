//
//  RecordPointsVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/23/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class RecordPointsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    //MARK:- Outlets..
    
    @IBOutlet var sideHeaderLabel: UILabel!
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var noPointLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    
    //MARK:- Declared Variables.. 
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var didSelectedCell = 0
    var did_DeSelectedCell = 0
    var isfrom = String()
    var upperlimit = String()
    var lowerlimit = String()
    var recordpointsarray = NSMutableArray()
    var valuationcodeArray = NSMutableArray()
    let dropDown = DropDown()
    var recordPointModel = RecordPointsViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        recordPointModel.vcRecordPoints = self
        if DeviceType == iPhone{
            var title = String()
            if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
                title =  "\(selectedworkOrderNumber)"+"/"+"\(selectedOperationNumber)"
            }else{
                title = "\(selectedworkOrderNumber)"
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "setNavTitle"), object: title)
        }
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.showsVerticalScrollIndicator = false
        detailTableView.showsHorizontalScrollIndicator = false
        
        if isfrom == "supervisor"{
            self.detailTableView.estimatedRowHeight = 110
        }else{
            self.detailTableView.estimatedRowHeight = 155
        }
        self.detailTableView.separatorStyle = .singleLine
        self.detailTableView.tableFooterView = UIView.init(frame: .zero)
        ScreenManager.registerReadingpointsTableViewCell(tableView: self.detailTableView)
        self.detailTableView.bounces = false
        self.objectSelected()
        NotificationCenter.default.addObserver(self, selector: #selector(RecordPointsVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RecordPointsVC.recordpointsupdates(notification:)), name:NSNotification.Name(rawValue:"RecordPointsUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func objectSelected(){
        recordPointModel.curentReadingArray.removeAll()
        if selectedworkOrderNumber != "" {
            recordPointModel.curentReadingArray.append(contentsOf: currentRecordPointArray)
        }else {
            return
        }
        recordPointModel.recordPointArray.removeAllObjects()
        if finalReadingpointsArray.count > 0{
            recordPointModel.recordPointArray.addObjects(from:finalReadingpointsArray as [Any])
            self.sideHeaderLabel.text = "Total".localized() + ": \(recordPointModel.recordPointArray.count)"
            self.noPointLabel.isHidden = true
        }else{
            self.sideHeaderLabel.text = "Total".localized() + ":0"
            self.noPointLabel.isHidden = false
        }
        if recordPointModel.recordPointArray.count == 0 {
            if DeviceType == iPhone{
                self.totalView.isHidden = false
            }
            self.noPointLabel.isHidden = false
            self.detailTableView.isHidden = true
        }else{
            self.noPointLabel.isHidden = true
            self.detailTableView.isHidden = false
        }
        recordPointModel.getOperationDetails(workorderNum: singleWorkOrder.WorkOrderNum)
    }
    func updateUIGetOperationDetails() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
            self.detailTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        NotificationCenter.default.post(name: Notification.Name(rawValue:"getRecordPointCount"), object: "")
        DispatchQueue.main.async{
            self.detailTableView.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        }
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Tableview Delegate and Datasource..
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordPointModel.recordPointArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        mJCLogger.log("Starting", Type: "info")
        let ReadingpointsTableViewCell  = ScreenManager.getReadingpointsTableViewCell(tableView: tableView)
        if recordPointModel.recordPointArray.count > 0 {
            ReadingpointsTableViewCell.indexPath = indexPath
            ReadingpointsTableViewCell.recordPointViewModel = recordPointModel
            if recordPointModel.recordPointArray.count > indexPath.row{
                ReadingpointsTableViewCell.recordPointModelClass = recordPointModel.recordPointArray[indexPath.row] as? MeasurementPointModel
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return ReadingpointsTableViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let RecordClass = recordPointModel.recordPointArray[indexPath.row] as! MeasurementPointModel
        if DeviceType == iPad{
            if isfrom == "supervisor"{
                return  135
            }else{
                return  195
            }
        }else{
            if isfrom == "supervisor"{
                if RecordClass.RefCounter{
                    return 220
                }else{
                    return 190.0
                }
            }else{
                if RecordClass.RefCounter{
                    return 310.0
                }else{
                    return 285.0
                }
            }
        }
    }
    //MARK:- UITextField Delegate..
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField Did Begin Editing.")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func updateUIcreateNotificationButton(equipment: String, funcLoc: String) {
        mJCLogger.log("Starting", Type: "info")
        menuDataModel.presentCreateJobScreen(vc: self, equipFromPoints: equipment, funcLocFromPoints: funcLoc, isScreen: "recordpoints")
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUILinchartButton(senderValue : Int){
        
        mJCLogger.log("Starting", Type: "info")
        let key  = "\(senderValue)code"
        mJCLogger.log("Response :\(recordPointModel.recordPointArray.count)", Type: "Debug")
        let measuringPointClass = recordPointModel.recordPointArray[senderValue] as! MeasurementPointModel
        let chartsVC = ScreenManager.getChartScreen()
        chartsVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        chartsVC.chartType = "line"
        if measuringPointClass.ValCodeSuff == true{
            chartsVC.linechartType = "ValCodeSuff"
            chartsVC.volutionDict = recordPointModel.volutioncodeDict.value(forKey: key) as! [CodeGroupModel]
        }else if measuringPointClass.RefCounter == true{
            chartsVC.linechartType = "Counter"
        }else{
            chartsVC.linechartType = "normal"
        }
        if isfrom == "supervisor"{
            chartsVC.isfrom = "Sup";
        }else{
            chartsVC.isfrom = ""
        }
        chartsVC.measuringPoint = measuringPointClass.MeasuringPoint
        if measuringPointClass.LimitMaxChar != "" {
            let limit = measuringPointClass.LimitMaxChar.replacingOccurrences(of: ".000", with: ".")
            chartsVC.upperLimit = limit
        }else{
            chartsVC.upperLimit = "undefined"
        }
        if measuringPointClass.LimitMinChar != "" {
            let limit = measuringPointClass.LimitMinChar.replacingOccurrences(of: ".000", with: ".")
            chartsVC.lowerLimit = limit
        }else{
            chartsVC.lowerLimit = "undefined"
        }
        self.present(chartsVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIGetValutionCode(senderValue: Int, MeasValuationCodeStr:String, keyValue: String, fromStr: String){
        mJCLogger.log("Starting", Type: "info")
        if recordPointModel.volutioncodeDict.count > 0 && MeasValuationCodeStr != ""{
            if let dict = recordPointModel.volutioncodeDict.value(forKey: keyValue) as? [CodeGroupModel]{
                for item in dict{
                    if item.Code == MeasValuationCodeStr{
                        let indexPath = IndexPath(row: senderValue, section: 0)
                        DispatchQueue.main.async {
                            let cell = self.detailTableView.cellForRow(at: indexPath) as? ReadingpointsTableViewCell
                            cell?.lastReadingValueLbl.text = "\(item.Code) - \(item.CodeText)"
                            if fromStr == "Edit"{
                                cell?.newReadingTextField.text  = "\(item.Code) - \(item.CodeText)"
                            }
                        }
                        break
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func recordpointsupdates(notification : NSNotification){
        
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(recordPointModel.recordPointArray.count)", Type: "Debug")
        DispatchQueue.main.async {
            if self.recordPointModel.curentReadingArray.count > 0 {
                self.recordPointModel.curentReadingArray.removeAll()
            }
            self.recordPointModel.curentReadingArray.append(contentsOf: currentRecordPointArray)
            if self.recordPointModel.recordPointArray.count > 0 {
                self.recordPointModel.recordPointArray.removeAllObjects()
            }
            if finalReadingpointsArray.count > 0{
                
                self.recordPointModel.recordPointArray.addObjects(from:finalReadingpointsArray as [Any])
                if self.recordPointModel.recordPointArray.count == 0{
                    self.noPointLabel.isHidden = false
                    self.detailTableView.isHidden = true
                }else{
                    self.noPointLabel.isHidden = true
                    self.detailTableView.isHidden = false
                    self.sideHeaderLabel.text = "Total".localized() + " \(self.recordPointModel.recordPointArray.count)"
                }
                self.sideHeaderLabel.text = "Total".localized() + ": \(self.recordPointModel.recordPointArray.count)"
                self.noPointLabel.isHidden = true
                self.detailTableView.isHidden = false
            }else{
                self.sideHeaderLabel.text = "Total".localized() + ": 0"
                self.noPointLabel.isHidden = false
                self.detailTableView.isHidden = true
            }
            
            DispatchQueue.main.async{
                self.detailTableView.reloadData()
            }
            mJCLogger.log("recordpointsupdates End".localized(), Type: "")
        }
        mJCLogger.log("Ended", Type: "info")
    }
}

