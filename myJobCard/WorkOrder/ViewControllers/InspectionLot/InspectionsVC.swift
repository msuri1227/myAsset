//
//  InspectionsVC.swift
//  myJobCard
//
//  Created By Ondevice Solutions on 03/04/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class InspectionsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var operationListView: UIView!
    @IBOutlet weak var operationListTableView: UITableView!
    @IBOutlet weak var inspectionPointsTabelView: UITableView!
    @IBOutlet weak var noDataViewOperations: UIView!
    @IBOutlet weak var noDataViewCharaCteristics: UIView!
    @IBOutlet weak var totalInspctioOprLabel: UILabel!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var totalPointLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UIButton!
    @IBOutlet weak var functionLocationLabel: UIButton!
    @IBOutlet weak var pointDescription: UILabel!
    @IBOutlet weak var CharCountLabel: UILabel!
    @IBOutlet weak var previouButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    
    var inspViewModel = InspectionViewModel()
    var selectedInspLot = String()
    var selectedInspOpr = String()

    override func viewDidLoad() {
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        inspViewModel.inspVc = self
        inspViewModel.fromResultsScreen = false
        ScreenManager.registerInspectionCell(tableView: self.inspectionPointsTabelView)
        if DeviceType == iPad{
            self.operationListTableView.estimatedRowHeight = 50
            self.operationListTableView.dataSource = self
            self.operationListTableView.delegate = self
            self.inspectionPointsTabelView.estimatedRowHeight = 120
            self.inspectionPointsTabelView.dataSource = self
            self.inspectionPointsTabelView.delegate = self
            ScreenManager.registerTotalOperationCountCell(tableView: self.operationListTableView)
            NotificationCenter.default.addObserver(self, selector: #selector(objectSelected), name: NSNotification.Name(rawValue: "objectSelected"), object: nil)
            self.objectSelected()
        }else{
            NotificationCenter.default.addObserver(self, selector: #selector(self.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.storeFlushAndRefreshDone(notification:)), name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            inspViewModel.getInspectionPoints(lot: selectedInspLot, Opr: selectedInspOpr)
        }
        inspViewModel.getQmResultArray()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true{
            if DeviceType == iPhone{
                self.refreshButton.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func objectSelected(){
        if DeviceType == iPad{
            inspViewModel.inspOprArray.removeAll()
            inspViewModel.inspPointCharArray.removeAll()
            if singleWorkOrder.InspectionLot != "000000000000"{
                inspViewModel.getInspectionOperations(from: "")
            }else{
                self.getInspectionUpdateUI()
            }
        }else{

        }
        mJCLogger.log("Ended", Type: "info")
    }

    @objc func backGroundSyncStarted(notification : NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            if flushStatus == true{
                self.refreshButton.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func storeFlushAndRefreshDone(notification: NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            self.refreshButton.stopSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    

    @IBAction func pointPreviewButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(inspViewModel.inspOprPointArray.count)", Type: "Debug")
        mJCLogger.log("Response :\(inspViewModel.currentPointIndex)", Type: "Debug")
        
        if inspViewModel.currentPointIndex > 0{
            
            inspViewModel.currentPointIndex = inspViewModel.currentPointIndex - 1
            let pointDetails = inspViewModel.inspOprPointArray[inspViewModel.currentPointIndex - 1]
            DispatchQueue.main.async {
                
                self.totalPointLabel.text = "\(self.inspViewModel.currentPointIndex) / \(self.inspViewModel.inspOprPointArray.count)"
                self.pointDescription.text = "\(pointDetails.InspPoint) - \(pointDetails.PointDesc)"
                if pointDetails.Equipment != ""{
                    self.equipmentLabel.isHidden = false
                    self.equipmentLabel.setTitle("\(pointDetails.Equipment)", for: .normal)
                }else{
                    self.equipmentLabel.isHidden = true
                }
                if pointDetails.FunctLoc != ""{
                    self.functionLocationLabel.isHidden = false
                    self.functionLocationLabel.setTitle("\(pointDetails.FunctLoc)", for: .normal)
                }else{
                    self.functionLocationLabel.isHidden = true
                }
                if self.inspViewModel.currentPointIndex == 1{
                    self.previouButton.isHidden = true
                }
                self.nextButton.isHidden = false
                self.inspViewModel.getPointCharasterstics(lot: pointDetails.InspLot, operation: pointDetails.InspOper, Point: pointDetails.InspPoint)
                self.inspViewModel.getInspectionResult(lot: pointDetails.InspLot, operation: pointDetails.InspOper, sample: pointDetails.InspPoint, Char: "", from: "")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func pointNextButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Response :\(inspViewModel.inspOprPointArray.count)", Type: "Debug")
        mJCLogger.log("Response :\(inspViewModel.currentPointIndex)", Type: "Debug")
        
        if inspViewModel.currentPointIndex  < inspViewModel.inspOprPointArray.count{
            inspViewModel.currentPointIndex = inspViewModel.currentPointIndex + 1
            
            let pointDetails = inspViewModel.inspOprPointArray[inspViewModel.currentPointIndex - 1]
            DispatchQueue.main.async {
                
                self.totalPointLabel.text = "\(self.inspViewModel.currentPointIndex) / \(self.inspViewModel.inspOprPointArray.count)"
                self.pointDescription.text = "\(pointDetails.InspPoint) - \(pointDetails.PointDesc)"
                if pointDetails.Equipment != ""{
                    self.equipmentLabel.isHidden = false
                    self.equipmentLabel.setTitle("\(pointDetails.Equipment)", for: .normal)
                }else{
                    self.equipmentLabel.isHidden = true
                }
                if pointDetails.FunctLoc != ""{
                    self.functionLocationLabel.isHidden = false
                    self.functionLocationLabel.setTitle("\(pointDetails.FunctLoc)", for: .normal)
                }else{
                    self.functionLocationLabel.isHidden = true
                }
                if self.inspViewModel.currentPointIndex == self.inspViewModel.inspOprPointArray.count{
                    self.nextButton.isHidden = true
                }
                self.previouButton.isHidden = false
                self.inspViewModel.getPointCharasterstics(lot: pointDetails.InspLot, operation: pointDetails.InspOper, Point: pointDetails.InspPoint)
                self.inspViewModel.getInspectionResult(lot: pointDetails.InspLot, operation: pointDetails.InspOper, sample: pointDetails.InspPoint, Char:"", from: "")
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mJCLogger.log("Starting", Type: "info")
        if tableView == operationListTableView{
            return inspViewModel.inspOprArray.count
        }else if tableView == inspectionPointsTabelView{
            return inspViewModel.inspPointCharArray.count
        }else{
            return 0
        }
     }
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if tableView == operationListTableView{
            let totalOperationCountCell = ScreenManager.getTotalOperationCountCell(tableView: tableView)
            totalOperationCountCell.indexPath = indexPath
            totalOperationCountCell.inspViewModel = self.inspViewModel
            totalOperationCountCell.woInspOperationModelClass = inspViewModel.inspOprArray[indexPath.row]
            return totalOperationCountCell
        }else if tableView == inspectionPointsTabelView {
            let InspectionCell = ScreenManager.getInspectionCell(tableView: tableView)
            InspectionCell.indexPath = indexPath
            InspectionCell.inspViewModel = self.inspViewModel
            InspectionCell.inspViewModel.fromResultsScreen = false
            InspectionCell.section = indexPath.section
            inspViewModel.charclas = inspViewModel.inspPointCharArray[indexPath.row]
            InspectionCell.inspectionModel = inspViewModel.inspPointCharArray[indexPath.row]
            return InspectionCell
        }
        mJCLogger.log("Ended", Type: "info")
         return UITableViewCell()
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            if tableView == inspectionPointsTabelView{
                return 160
            }else{
                return UITableView.automaticDimension
            }
        }else{
            if tableView == inspectionPointsTabelView{
                return 250
            }else{
                return UITableView.automaticDimension
            }
        }
     }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func refreshButtonAction(_ sender: Any) {
        myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
    }
    func getInspectionUpdateUI(){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("Response :\(self.inspViewModel.inspOprArray.count)", Type: "Debug")
            if self.inspViewModel.inspOprArray.count > 0 {
                self.noDataViewOperations.isHidden = true
                self.noDataViewCharaCteristics.isHidden = true
                self.operationListTableView.reloadData()
                self.operationListTableView.isHidden = false
                self.totalInspctioOprLabel.text = "Inspection_Operations :".localized()  + "\(self.inspViewModel.inspOprArray.count)"
            }else{
                self.noDataViewOperations.isHidden = false
                self.noDataViewCharaCteristics.isHidden = false
                self.totalPointLabel.isHidden = true
                self.pointDescription.isHidden = true
                self.equipmentLabel.isHidden = true
                self.functionLocationLabel.isHidden = true
                self.nextButton.isHidden = true
                self.previouButton.isHidden = true
                self.CharCountLabel.isHidden = true
                self.totalInspctioOprLabel.text = "Inspection_Operations :".localized()  + "0"
                self.operationListTableView.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getInspectionPointsUI(pointDetails :InspectionPointModel){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            
            if self.inspViewModel.inspOprPointArray.count > 0{
                self.inspectionPointsTabelView.isHidden = false
                self.inspViewModel.currentPointIndex = 1
                self.previouButton.isHidden = true
                self.totalPointLabel.isHidden = false
                self.CharCountLabel.isHidden = false
                if self.inspViewModel.currentPointIndex == self.inspViewModel.inspOprPointArray.count{
                    self.nextButton.isHidden = true
                }else{
                    self.nextButton.isHidden = false
                }
                self.totalPointLabel.text = "\(self.inspViewModel.currentPointIndex) / \(self.inspViewModel.inspOprPointArray.count)"
                self.pointDescription.text = "\(pointDetails.InspPoint) - \(pointDetails.PointDesc)"
               
                if pointDetails.Equipment != ""{
                    self.equipmentLabel.isHidden = false
                    self.equipmentLabel.setTitle("\(pointDetails.Equipment)", for: .normal)
                }else{
                    self.equipmentLabel.isHidden = true
                }
                if pointDetails.FunctLoc != ""{
                    self.functionLocationLabel.isHidden = false
                    self.functionLocationLabel.setTitle("\(pointDetails.FunctLoc)", for: .normal)
                }else{
                    self.functionLocationLabel.isHidden = true
                }
            }else{
                self.noDataViewCharaCteristics.isHidden = false
                self.inspectionPointsTabelView.isHidden = false
                self.totalPointLabel.isHidden = true
                self.pointDescription.isHidden = true
                self.equipmentLabel.isHidden = true
                self.functionLocationLabel.isHidden = true
                self.nextButton.isHidden = true
                self.previouButton.isHidden = true
                self.CharCountLabel.isHidden = true
             }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func getPointCharastersticsUI(){
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("Response :\(self.inspViewModel.inspPointCharArray.count)", Type: "Debug")
            if self.inspViewModel.inspPointCharArray.count > 0 {
                self.noDataViewCharaCteristics.isHidden = true
                self.CharCountLabel.text = "Total_Char :".localized()  + "\(self.inspViewModel.inspPointCharArray.count)"
                self.inspectionPointsTabelView.reloadData()
            }else{
                self.noDataViewCharaCteristics.isHidden = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
