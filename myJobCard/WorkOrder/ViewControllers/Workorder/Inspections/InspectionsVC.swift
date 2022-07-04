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

    @IBOutlet weak var lotDetailsTopView: UIView!
    @IBOutlet weak var operationListView: UIView!
    @IBOutlet weak var operationListTableView: UITableView!
    @IBOutlet weak var inspectionPointsView: UIView!
    @IBOutlet weak var inspectionPointsTabelView: UITableView!
    @IBOutlet weak var CharastersticsView: UIView!
    @IBOutlet weak var CharateristicsTableView: UITableView!
    @IBOutlet weak var inspectionPointDetails: UIView!
    @IBOutlet weak var inspectionPointTitle: UILabel!
    @IBOutlet weak var inspectionPointCharateristicsView: UIView!
    @IBOutlet weak var bottomViewHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var noDataViewOperations: UIView!
    @IBOutlet weak var noDataViewCharaCteristics: UIView!
    
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var pointsBackButton: UIButton!
    @IBOutlet weak var totalInspctioOprLabel: UILabel!
    @IBOutlet var headerView: UIView!
    
    @IBOutlet weak var totalPointLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var pointNumber: UILabel!
    @IBOutlet weak var functionLocationLabel: UILabel!
    @IBOutlet weak var pointDescription: UILabel!
    @IBOutlet weak var CharCountLabel: UILabel!
    
    @IBOutlet weak var previouButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    var viewtitle = String()
    var inspectionOprArray = Array<InspectionOperationModelClass>()
    var inspectionOprPointArray = Array<InspectionPointModelClass>()
    var inspectionPointCharArray = Array<InspectionCharModelClass>()
    var inspectionResultArray = Array<InspectionResultModelClass>()
    var qmResultArray = Array<QMResultModelClass>()
    var currentPointIndex = Int()
    
    var inspectionLotiPhoneStr = String()
    var operationiPhoneStr = String()
    var cellIndex = Int()
    var property = NSMutableArray()
    var saveInspectionEntity : SODataEntity?
    var statusStr = String()
    var selectedCellIndex = 0
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if DeviceType == iPad{
            self.operationListTableView.estimatedRowHeight = 50
            self.operationListTableView.dataSource = self
            self.operationListTableView.delegate = self
            self.inspectionPointsTabelView.estimatedRowHeight = 120
            self.inspectionPointsTabelView.dataSource = self
            self.inspectionPointsTabelView.delegate = self
            self.operationListTableView.register(UINib(nibName: "TotalOperationCountCell", bundle: nil), forCellReuseIdentifier: "TotalOperationCountCell_iPhone")
            self.inspectionPointsTabelView.register(UINib(nibName: "InspectionCell", bundle: nil), forCellReuseIdentifier: "InspectionCell")
        }else{
            self.inspectionPointsTabelView.register(UINib(nibName: "inspectionCell_iPhone", bundle: nil), forCellReuseIdentifier: "InspectionCell")
        }
        viewtitle = "Points".localized()
        self.getQmResultArray()
    }

    override func viewWillAppear(_ animated: Bool) {
       if DeviceType == iPad{
            self.getInspectionOperations()
        }else{
            self.getInspectionPoints(lot: self.inspectionLotiPhoneStr, Opr: self.operationiPhoneStr)
        }
    }
    func getInspectionOperations(){
      
        var defineQuery = String()
        if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4") && WO_OP_OBJS_DISPLAY == "X"{
            defineQuery = "InspectionOperSet?$filter=(InspectionLot%20eq%20%27" + singleWorkOrder.InspectionLot + "%27 and Operation%20eq%20%27" + selectedOperationNumber + "%27)&$orderby=Operation"
        }else{
            defineQuery = "InspectionOperSet?$filter=(InspectionLot%20eq%20%27\(singleWorkOrder.InspectionLot)%27)&$orderby=Operation"
        }
        
        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "InspectionOperSet"}
        
        if storeArray.count > 0{
            
            let store = storeArray[0]
            
            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: defineQuery, storeName: store.AppStoreName, entitySetClassType: InspectionOperationModelClass.self) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [InspectionOperationModelClass]{
                        if responseArr.count > 0 {
                            self.inspectionOprArray = responseArr
                            DispatchQueue.main.async {
                               self.noDataViewOperations.isHidden = true
                               self.noDataViewCharaCteristics.isHidden = true
                               self.operationListTableView.reloadData()
                               self.totalInspctioOprLabel.text = "Inspection_Operations :".localized()  + "\(self.inspectionOprArray.count)"
                           }
                           let opr = self.inspectionOprArray[0]
                           self.selectedCellIndex = 0
                           self.getInspectionPoints(lot: opr.InspectionLot, Opr: opr.Operation)
                           
                        }else{
                            DispatchQueue.main.async {
                                self.noDataViewOperations.isHidden = false
                                self.noDataViewCharaCteristics.isHidden = false
                            }
                        }
                    }
                }
                else {
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
   
    }
    func getInspectionPoints(lot:String, Opr:String){
      
        let defineQuery = "InspectionPointSet?$filter=(InspLot eq '\(lot)' and InspOper eq '\(Opr)')&$orderby=InspPoint"
        
        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "InspectionPointSet"}
        
        if storeArray.count > 0{
            
            let store = storeArray[0]
            
            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: defineQuery, storeName: store.AppStoreName, entitySetClassType: InspectionPointModelClass.self) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [InspectionPointModelClass]{
                        if responseArr.count > 0 {
                            self.inspectionOprPointArray = responseArr
                            let pointDetails = self.inspectionOprPointArray[0]
                                DispatchQueue.main.async {
                                     self.inspectionPointsTabelView.isHidden = false
                                    self.currentPointIndex = 1
                                    self.previouButton.isHidden = true
                                    if self.currentPointIndex == self.inspectionOprPointArray.count{
                                        self.nextButton.isHidden = true
                                    }else{
                                        self.nextButton.isHidden = false
                                    }
                                    self.totalPointLabel.text = "\(self.currentPointIndex) / \(self.inspectionOprPointArray.count)"
                                    self.pointDescription.text = "\(pointDetails.InspPoint) - \(pointDetails.PointDesc)"
                                    self.equipmentLabel.text = "\(pointDetails.Equipment)"
                                    self.functionLocationLabel.text = "\(pointDetails.FunctLoc)"
                                    self.getPointCharasterstics(lot: pointDetails.InspLot, operation: pointDetails.InspOper, Point: pointDetails.InspPoint)
                                    self.getInspectionResult(lot: pointDetails.InspLot, operation: pointDetails.InspOper, sample: pointDetails.InspPoint)
                                }
                         
                        }else{
                            DispatchQueue.main.async {
                                self.noDataViewCharaCteristics.isHidden = false
                                self.inspectionPointsTabelView.isHidden = true
                                self.totalPointLabel.text = "0/0"
                                self.pointDescription.text = ""
                                self.equipmentLabel.text = ""
                                self.functionLocationLabel.text = ""
                                self.nextButton.isHidden = true
                                self.previouButton.isHidden = true
                                self.CharCountLabel.text = "Total_Char :".localized() + "0"
                             }
                        }
                    }
                }
                else {
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
            
        }
        
    }
    func getPointCharasterstics(lot:String,operation:String,Point:String){
      
        let defineQuery = "InspectionCharSet?$filter=(InspLot eq '\(lot)' and InspOper eq '\(operation)' and InspPoint eq '\(Point)')&$orderby=InspChar"

        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "InspectionCharSet"}
        
        if storeArray.count > 0{
            
            let store = storeArray[0]
            
            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: defineQuery, storeName: store.AppStoreName, entitySetClassType: InspectionCharModelClass.self) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [InspectionCharModelClass]{
                        if responseArr.count > 0 {
                            self.inspectionPointCharArray = responseArr
                            DispatchQueue.main.async {
                                self.noDataViewCharaCteristics.isHidden = true
                                self.CharCountLabel.text = "Total_Char :".localized()  + "\(self.inspectionPointCharArray.count)"
                                self.inspectionPointsTabelView.reloadData()

                            }
                        }else{
                            DispatchQueue.main.async {
                                self.noDataViewCharaCteristics.isHidden = false
                            }
                        }
                    }
                }
                else {
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
            
        }
        
        
    }
    func getInspectionResult(lot:String,operation:String,sample:String){

        let defineQuery = "InspectionResultsGetSet?$filter=(InspLot eq '\(lot)' and InspOper eq '\(operation)' and InspSample eq '\(sample)')"

        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "InspectionResultsGetSet"}
        
        if storeArray.count > 0{
            
            let store = storeArray[0]
            
            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: defineQuery, storeName: store.AppStoreName, entitySetClassType: InspectionResultModelClass.self) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [InspectionResultModelClass]{
                        if responseArr.count > 0 {
                            self.inspectionResultArray = responseArr
                            DispatchQueue.main.async {
                                self.inspectionPointsTabelView.reloadData()
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.noDataViewCharaCteristics.isHidden = false
                            }
                        }
                    }
                }
                else {
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
            
        }
        
    }

    @IBAction func pointPreviewButtonAction(_ sender: Any) {
       
        if self.currentPointIndex > 0{
            
            self.currentPointIndex = self.currentPointIndex - 1
            
            let pointDetails = self.inspectionOprPointArray[self.currentPointIndex - 1]
            DispatchQueue.main.async {
                
                self.totalPointLabel.text = "\(self.currentPointIndex) / \(self.inspectionOprPointArray.count)"
                self.pointDescription.text = "\(pointDetails.InspPoint) - \(pointDetails.PointDesc)"
                self.equipmentLabel.text = "\(pointDetails.Equipment)"
                self.functionLocationLabel.text = "\(pointDetails.FunctLoc)"
                if self.currentPointIndex == 1{
                    self.previouButton.isHidden = true
                }
                self.nextButton.isHidden = false
                self.getPointCharasterstics(lot: pointDetails.InspLot, operation: pointDetails.InspOper, Point: pointDetails.InspPoint)
                self.getInspectionResult(lot: pointDetails.InspLot, operation: pointDetails.InspOper, sample: pointDetails.InspPoint)
            }
        }
        

    }
    
    @IBAction func pointNextButtonAction(_ sender: Any) {
        
        if self.currentPointIndex  < self.inspectionOprPointArray.count{
            self.currentPointIndex = self.currentPointIndex + 1
            let pointDetails = self.inspectionOprPointArray[self.currentPointIndex - 1]
            DispatchQueue.main.async {
                
                self.totalPointLabel.text = "\(self.currentPointIndex) / \(self.inspectionOprPointArray.count)"
                self.pointDescription.text = "\(pointDetails.InspPoint) - \(pointDetails.PointDesc)"
                self.equipmentLabel.text = "\(pointDetails.Equipment)"
                self.functionLocationLabel.text = "\(pointDetails.FunctLoc)"
                if self.currentPointIndex == self.inspectionOprPointArray.count{
                    self.nextButton.isHidden = true
                }
                self.previouButton.isHidden = false
                self.getPointCharasterstics(lot: pointDetails.InspLot, operation: pointDetails.InspOper, Point: pointDetails.InspPoint)
                self.getInspectionResult(lot: pointDetails.InspLot, operation: pointDetails.InspOper, sample: pointDetails.InspPoint)
            }
        }
    
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         
         return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        if tableView == operationListTableView{
            return self.inspectionOprArray.count
        }else if tableView == inspectionPointsTabelView{
            return self.inspectionPointCharArray.count
        }else{
            return 0
        }
        
     }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
            return 0

    }
     
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            return UIView()

    }
    
                             
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == operationListTableView{
             
             let totalOperationCountCell = tableView.dequeueReusableCell(withIdentifier: "TotalOperationCountCell_iPhone") as! TotalOperationCountCell
            let inspectOprcls = inspectionOprArray[indexPath.row]
            if selectedCellIndex == indexPath.row{
                totalOperationCountCell.transPerantView.isHidden = false
                totalOperationCountCell.sideIndicatorView.backgroundColor = UIColor(red: 77.0/255.0, green: 125.0/255.0, blue: 155.0/255.0, alpha: 1)
            }else{
                totalOperationCountCell.transPerantView.isHidden = true
                totalOperationCountCell.sideIndicatorView.backgroundColor = UIColor.clear
            }
            totalOperationCountCell.selectOperationButtonLeadingConstant.constant = 0.0
            
            totalOperationCountCell.operationCompleteImageWidthConstraint.constant = 0.0
            totalOperationCountCell.selectCheckBoxWidthConst.constant = 0.0
            totalOperationCountCell.operationNameLabel.text = inspectOprcls.Operation
            totalOperationCountCell.DescriptionLabel.text = inspectOprcls.ShortText
            totalOperationCountCell.selectOpearettionButton.tag = indexPath.row
            totalOperationCountCell.selectOpearettionButton.addTarget(self, action: #selector(self.selectInspOperationButtonClicked), for: .touchUpInside)
            
            return totalOperationCountCell
        }else if tableView == inspectionPointsTabelView {
            
            let InspectionCell = tableView.dequeueReusableCell(withIdentifier: "InspectionCell") as! InspectionCell
            InspectionCell.remarkTextView.layer.cornerRadius = 2.0
            InspectionCell.remarkTextView.layer.masksToBounds = true
            InspectionCell.remarkTextView.layer.borderWidth = 1.0
            InspectionCell.remarkTextView.layer.borderColor = UIColor(red: 77.0/255.0, green: 125.0/255.0, blue: 155.0/255.0, alpha: 1).cgColor
            InspectionCell.resultTextField.layer.borderWidth = 1.0
            InspectionCell.resultTextField.layer.cornerRadius = 2.0
            InspectionCell.resultTextField.layer.borderColor = UIColor(red: 77.0/255.0, green: 125.0/255.0, blue: 155.0/255.0, alpha: 1).cgColor
            InspectionCell.resultButton.isHidden = true
            InspectionCell.AddButton.isHidden = true
            InspectionCell.hiStoryButton.isHidden = true
            InspectionCell.resultSaveButton.isHidden = true
            if DeviceType == iPad{
                InspectionCell.propertyViewHeightConstraint_iPad.constant = 0
            }else{
                InspectionCell.property1ViewHeightConstraint_iPhone.constant = 0
                InspectionCell.property2ViewHeightConstraint_iPhone.constant = 0
            }
            
            let inspectCharcls = self.inspectionPointCharArray[indexPath.row]
            InspectionCell.resultSaveButton.isHidden = true
            InspectionCell.editButton.isHidden = true
            InspectionCell.resultTextField.isUserInteractionEnabled = false
            InspectionCell.remarkTextView.isUserInteractionEnabled = false
            if self.inspectionPointCharArray.count > 0{

                InspectionCell.charateisticNumberLabel.text = inspectCharcls.InspChar + " - " + inspectCharcls.CharDescr
                InspectionCell.targetlabel.text = inspectCharcls.TargetVal + " / " + inspectCharcls.LwTolLmt + " - " + inspectCharcls.UpTolLmt

                InspectionCell.statusLabel.text = inspectCharcls.Status + " - " + inspectCharcls.StatusDesc
                
                InspectionCell.AddButton.tag = indexPath.row
                InspectionCell.editButton.tag = indexPath.row
                InspectionCell.hiStoryButton.tag = indexPath.row
                InspectionCell.resultButton.tag = indexPath.row
                InspectionCell.resultSaveButton.tag = indexPath.row

                InspectionCell.AddButton.addTarget(self, action: #selector(InspectionsVC.addAction(sender:)), for: .touchUpInside)
                InspectionCell.editButton.addTarget(self, action: #selector(InspectionsVC.editAction(sender:)), for: .touchUpInside)
                InspectionCell.hiStoryButton.addTarget(self, action: #selector(InspectionsVC.historyAction(sender:)), for: .touchUpInside)
                InspectionCell.resultButton.addTarget(self, action: #selector(InspectionsVC.resultAction(sender:)), for: .touchUpInside)
                InspectionCell.resultSaveButton.addTarget(self, action: #selector(InspectionsVC.resultSaveAction(sender:)), for: .touchUpInside)
                
                
                if self.inspectionResultArray.count > 0{
                            
                    var filterArr = Array<InspectionResultModelClass>()
                    if inspectCharcls.Scope == "1"{
                        filterArr = self.inspectionResultArray.filter{$0.InspLot == "\(inspectCharcls.InspLot)" && $0.InspSample == "\(inspectCharcls.InspPoint)" && $0.InspOper == "\(inspectCharcls.InspOper)" && $0.InspChar == "\(inspectCharcls.InspChar)"}
                    }else{
                        filterArr = self.inspectionResultArray.filter{$0.InspLot == "\(inspectCharcls.InspLot)" && $0.InspSample == "\(inspectCharcls.InspPoint)" && $0.InspOper == "\(inspectCharcls.InspOper)" && $0.InspChar == "\(inspectCharcls.InspChar)"}
                    }
                   
                               
                    if filterArr.count > 0{
                        let inspectResultcls = filterArr[0]
                        InspectionCell.editButton.isHidden = false
                        InspectionCell.remarkTextView.text = inspectResultcls.Remark

                       
                        let lowerlimt = Double(inspectCharcls.LwTolLmt) ?? 0.0
                        let upperlimt = Double(inspectCharcls.UpTolLmt) ?? 0.0
                        let result = Double(inspectResultcls.ResValue) ?? 0.0
                        if lowerlimt < result && upperlimt > result{
                            InspectionCell.sideIndicatorCharacteristicView.backgroundColor =  UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1)
                        }else{
                            InspectionCell.sideIndicatorCharacteristicView.backgroundColor =  UIColor(red: 220.0/255.0, green: 34.0/255.0, blue: 80.0/255.0, alpha: 1)
                        }
                        if inspectCharcls.CharType == "02" {
                                                   
                           if inspectResultcls.Code1 != ""{
                               let arr = self.qmResultArray.filter{$0.Charnum == "\(inspectCharcls.InspChar)" && $0.SelectedSet == "\(inspectCharcls.SelectedSet)" && $0.Code == "\(inspectResultcls.Code1)"}
                               if arr.count > 0{
                                   let cls = arr[0]
                                InspectionCell.resultTextField.text = cls.Code + " - " + cls.Description
                               }
                           }
                        InspectionCell.sideIndicatorCharacteristicView.backgroundColor =  UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1)
                       }else{
                           InspectionCell.resultTextField.text = inspectResultcls.ResValue
                       }
                        
                        
                    }else{
                        
                        
                        if inspectCharcls.CharType == "02"{
                            InspectionCell.resultSaveButton.isHidden = false
                            InspectionCell.editButton.isHidden = true
                            InspectionCell.resultTextField.isUserInteractionEnabled = false
                            InspectionCell.remarkTextView.isUserInteractionEnabled = true
                            InspectionCell.resultTextField.text = ""
                            InspectionCell.remarkTextView.text = ""
                            InspectionCell.resultButton.isHidden = false
                        }else{
                            InspectionCell.resultSaveButton.isHidden = false
                            InspectionCell.editButton.isHidden = true
                            InspectionCell.resultButton.isHidden = true
                            InspectionCell.resultTextField.isUserInteractionEnabled = true
                            InspectionCell.remarkTextView.isUserInteractionEnabled = true
                            InspectionCell.resultTextField.text = ""
                            InspectionCell.remarkTextView.text = ""
                        }
                    }
            
                }else{
                    if inspectCharcls.CharType == "02"{
                        InspectionCell.resultTitle.text = "Valuation"
                        InspectionCell.resultSaveButton.isHidden = false
                        InspectionCell.editButton.isHidden = true
                        InspectionCell.resultTextField.isUserInteractionEnabled = false
                        InspectionCell.remarkTextView.isUserInteractionEnabled = true
                        InspectionCell.resultButton.isHidden = false
                    }else{
                        InspectionCell.resultSaveButton.isHidden = false
                        InspectionCell.resultButton.isHidden = true
                        InspectionCell.editButton.isHidden = true
                        InspectionCell.resultTextField.isUserInteractionEnabled = true
                        InspectionCell.remarkTextView.isUserInteractionEnabled = true
                    }
                    
                }
            }
               
            return InspectionCell
        }
         
         return UITableViewCell()
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{

        if DeviceType == iPad{

            if tableView == inspectionPointsTabelView{

                return 155

            }else{

                return UITableView.automaticDimension

            }

        }else{

            if tableView == inspectionPointsTabelView{

                return 245

            }else{

                return UITableView.automaticDimension

            }

        }

           

     }
    
    //MARK:- Inspection Operation select Button Action..
    @objc func selectInspOperationButtonClicked(btn:UIButton)  {
        let opr = self.inspectionOprArray[btn.tag]
        self.selectedCellIndex = btn.tag
        self.getInspectionPoints(lot: opr.InspectionLot, Opr: opr.Operation)
        self.operationListTableView.reloadData()
    }
    
    @objc func addAction(sender : UIButton) {
        print(sender.tag)
        let tag = sender.tag
        mJCLogger.log("Add Button Action".localized(), Type: "")
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = self.inspectionPointsTabelView.cellForRow(at: indexPath) as! InspectionCell
        cell.resultTextField.text = ""
        cell.remarkTextView.text = ""
        cell.resultTextField.isUserInteractionEnabled = true
        cell.resultTextField.becomeFirstResponder()
        cell.remarkTextView.isUserInteractionEnabled = true

    }
    @objc func editAction(sender : UIButton) {
        print(sender.tag)
        let tag = sender.tag
        mJCLogger.log("Edit Button Action".localized(), Type: "")
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = self.inspectionPointsTabelView.cellForRow(at: indexPath) as! InspectionCell
        
        let charclas =   self.inspectionPointCharArray[tag]
        
        if charclas.CharType == "02"{
            cell.resultTextField.isUserInteractionEnabled = false
            cell.resultButton.isHidden = false
        }else{
            cell.resultTextField.isUserInteractionEnabled = true
            cell.resultButton.isHidden = true
        }
        cell.remarkTextView.isUserInteractionEnabled = true
        cell.editButton.isHidden = true
        cell.resultSaveButton.isHidden = false
        cell.resultSaveButton.setTitle("Update".localized(), for: .normal)
       
    }
    @objc func historyAction(sender : UIButton) {
    
        mJCLogger.log("History Button Tapped".localized(), Type: "")
    }
    @objc func resultAction(sender : UIButton) {
      
        let inspectCharcls = self.inspectionPointCharArray[sender.tag]
        
        let arr = self.qmResultArray.filter{$0.Charnum == "\(inspectCharcls.InspChar)" && $0.SelectedSet == "\(inspectCharcls.SelectedSet)"}
        if arr.count > 0{
            DispatchQueue.main.async {
                self.showDropDownDetails(sender: sender, qmResultArray: arr)
            }
        }
    }
    func getQmResultArray(){
       
        let  defineQuery = "LTQmResultTableSet?$filter=(Equipment eq '\(singleWorkOrder.EquipNum)')&$orderby=Code asc"
        
        let storeArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "LTQmResultTableSet"}
        
        if storeArray.count > 0{
            
            let store = storeArray[0]
            
            mJCOfflineHelper.getODataEntriesfromOffline(queryRequest: defineQuery, storeName: store.AppStoreName, entitySetClassType: QMResultModelClass.self) { (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [QMResultModelClass]{
                        if responseArr.count > 0 {
                            self.qmResultArray.removeAll()
                            self.qmResultArray = responseArr
                        }
                    }
                }
                else {
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
            
        }
                    
    }
    func showDropDownDetails(sender:UIButton,qmResultArray:[QMResultModelClass]){
        
        let menudropDown = DropDown()
        var menuarr = [String]()
        
        for resultObj in qmResultArray {
            
            menuarr.append(resultObj.Code + " - " + resultObj.Description)
        }
        
        menudropDown.dataSource = menuarr
        menudropDown.anchorView = sender
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = UIColor(red:86.0/255.0,  green:138.0/255.0,  blue:173.0/255.0, alpha:1)
        menudropDown.show()
        
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let indexPath = IndexPath(row: sender.tag, section: 0)
             let cell = self.inspectionPointsTabelView.cellForRow(at: indexPath) as! InspectionCell
            cell.resultTextField.text = item
            menudropDown.hide()
        }
    }
    

    @objc func resultSaveAction(sender : UIButton) {
    
        mJCLogger.log("Result Save Button Tapped".localized(), Type: "")
        self.cellIndex = sender.tag
        
        let title = sender.titleLabel?.text
        if title == "Update".localized(){
            self.UpdateInspectionResult(index:sender.tag)
        }else{
            
            self.saveInspectionResult(index: sender.tag)
        }
        
        
    }
    //  MARK:- Update Inspection Result
    func UpdateInspectionResult(index: Int) {
       
        if (isActiveWorkOrder == true){
           
            let charclas =   self.inspectionPointCharArray[index]
            let cell = self.inspectionPointsTabelView.cellForRow(at: NSIndexPath(row: index, section: 0) as IndexPath) as! InspectionCell
            var filterArr = Array<InspectionResultModelClass>()
           
                if charclas.Scope == "1"{
                    filterArr = self.inspectionResultArray.filter{$0.InspLot == "\(charclas.InspLot)" && $0.InspSample == "\(charclas.InspPoint)" && $0.InspOper == "\(charclas.InspOper)" && $0.InspChar == "\(charclas.InspChar)"}
                }else{
                    filterArr = self.inspectionResultArray.filter{$0.InspLot == "\(charclas.InspLot)" && $0.InspSample == "\(charclas.InspPoint)" && $0.InspOper == "\(charclas.InspOper)" && $0.InspChar == "\(charclas.InspChar)"} //  && $0.ResNo == "0001"
                }
     
             
                if filterArr.count > 0{

                  let result = filterArr[0]
                    
                    if result.ResValue == cell.resultTextField.text && result.Remark ==  cell.remarkTextView.text{
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_update_atleast_one_value".localized(), button: okay)
                        return
                    }
                    else if cell.resultTextField.text?.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil{
                        mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_proper_result".localized(), button: okay)
                        return
                    }
                    
                    (result.entity.properties["Remark"] as! SODataProperty).value =  cell.remarkTextView.text as NSObject?

                     if charclas.CharType == "02" {
                    
                        let arr1 = cell.resultTextField.text!.components(separatedBy: " - ")
                        
                        let arr = qmResultArray.filter{$0.Code == "\(arr1[0])" && $0.Description == "\(arr1[1])"}
                        if arr.count > 0{
                            let qmobj = arr[0]
                            (result.entity.properties["Code1"] as! SODataProperty).value =  qmobj.Code as NSObject?
                            (result.entity.properties["Description"] as! SODataProperty).value =  qmobj.Description as NSObject?
                            (result.entity.properties["CodeGrp1"] as! SODataProperty).value =  qmobj.CodeGroup as NSObject?
                        }
                        
                    }else{
                        (result.entity.properties["ResValue"] as! SODataProperty).value =  cell.resultTextField.text as NSObject?
                    }
                    let StoreArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "InspectionResultsGetSet"}
                    if StoreArray.count > 0{
                        mJCOfflineHelper.updateOfflineEntity(entity: result.entity, storeName: StoreArray[0].AppStoreName,flushDelegate: myJobCardDataManager.uniqueInstance, refreshDelegate: myJobCardDataManager.uniqueInstance,flushRequired: true ,options: nil, completionHandler: { (response, error) in

                        if(error == nil){

                            self.getInspectionResult(lot: charclas.InspLot, operation: charclas.InspOper, sample: charclas.InspPoint)
                        }
                        else{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Something_went_wrong".localized(), button: okay)
                        }
                    })
                    }
                }
            }else{
                if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4"{
                    mJCAlertHelper.showAlert(self, title: "Inactive_Operation".localized(), message: "You_are_not_actively_working_on_the_selected_Operation_hence_this_action_is_not_allowed".localized(), button: okay)
                }else{
                    mJCAlertHelper.showAlert(self, title: "Inactive_Work_Order".localized(), message: "You_are_not_actively_working_on_the_selected_Work_Order_hence_this_action_is_not_allowed".localized(), button: okay)
                }
            }
    }
    
    //  MARK:- Save Inspection Result
        
    func saveInspectionResult(index : Int) {
       
        if (isActiveWorkOrder == true) {
         
            let charclas =   self.inspectionPointCharArray[index]
            let cell = self.inspectionPointsTabelView.cellForRow(at: NSIndexPath(row: index, section: 0) as IndexPath) as! InspectionCell
                if cell.resultTextField.text == ""{
                    mJCAlertHelper.showAlert(self, title: errorTitle, message: "Please_add_result".localized(), button: okay)
                    return
                }else if cell.resultTextField.text?.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil{
                    mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Please_enter_valid_result".localized(), button: okay)
                    return
                }
        
            self.property = NSMutableArray()
            
            var prop = SODataPropertyDefault(name: "ResValue")

            if charclas.CharType == "02" {
               
                let arr1 = cell.resultTextField.text!.components(separatedBy: " - ")
                let arr = qmResultArray.filter{$0.Code == "\(arr1[0])" && $0.Description == "\(arr1[1])"}
                
                if arr.count > 0{
                    
                    let qmobj = arr[0]
                    
                    prop = SODataPropertyDefault(name: "Code1")
                    prop!.value = qmobj.Code as NSObject?
                    self.property.add(prop!)
                    
                    prop = SODataPropertyDefault(name: "Description")
                    prop!.value = qmobj.Description as NSObject?
                    self.property.add(prop!)

                    prop = SODataPropertyDefault(name: "CodeGrp1")
                    prop!.value = qmobj.CodeGroup as NSObject?
                    self.property.add(prop!)
                }
            }else{
                prop!.value = cell.resultTextField.text as NSObject?
                self.property.add(prop!)
            }

            prop = SODataPropertyDefault(name: "Remark")
            prop!.value = cell.remarkTextView.text as NSObject?
            self.property.add(prop!)
            
            prop = SODataPropertyDefault(name: "InspLot")
            prop!.value = charclas.InspLot as NSObject?
            self.property.add(prop!)
    
            prop = SODataPropertyDefault(name: "InspOper")
            prop!.value = charclas.InspOper as NSObject?
            self.property.add(prop!)
    
            prop = SODataPropertyDefault(name: "InspChar")
            prop!.value = charclas.InspChar as NSObject?
            self.property.add(prop!)
        
            prop = SODataPropertyDefault(name: "InspSample")
            prop!.value = charclas.InspPoint as NSObject?
            self.property.add(prop!)
        
            prop = SODataPropertyDefault(name: "Inspector")
            prop!.value = userLoginName.uppercased() as NSObject?
            self.property.add(prop!)
        

            let resno = myJobCardDataManager.uniqueInstance.getObjectByAppendingZero(Max: 4, Num: "\((Int(self.inspectionResultArray.count) ) + 1)")
        
            prop = SODataPropertyDefault(name: "ResNo")
            prop!.value = resno as NSObject?
            self.property.add(prop!)

           print("===== SaveInspection Key Value ======")

           let entity = SODataEntityDefault(type: DefineRequest_SaveInspectionResult)
           for prop in self.property {

               let proper = prop as! SODataProperty
               entity?.properties[proper.name] = proper

               print("Key : \(proper.name)")
               print("Value :\(proper.value!)")
               print("......................")
           }
            let StoreArray = offlinestoreDefineReqArray.filter{$0.EntitySet == "InspectionResultsGetSet"}
            
            if StoreArray.count > 0{
                mJCOfflineHelper.createOfflineEntity(entity: entity!, collectionPath: "InspectionResultsGetSet", storeName: StoreArray[0].AppStoreName, flushDelegate: myJobCardDataManager.uniqueInstance, refreshDelegate: myJobCardDataManager.uniqueInstance,flushRequired: true,options: nil, completionHandler: { (response, error) in

               DispatchQueue.main.async {

                   if(error == nil) {

                       print("Result successfully")
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"setInspectionCountNotification"), object: "")

                    self.getInspectionResult(lot: charclas.InspLot, operation: charclas.InspOper, sample: charclas.InspPoint)
                   }
                   else {

                       DispatchQueue.main.async {
                           mJCLogger.log("Error : \(error?.localizedDescription)", Type: "Error")
                        mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_save_Inspection_Result_try_again".localized(), button: okay)
                       }
                   }
                }
            })
                
            }
        }else{
           if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4"{
                mJCAlertHelper.showAlert(self, title: "Inactive_Operation".localized(), message: "You_are_not_actively_working_on_the_selected_Operation_hence_this_action_is_not_allowed".localized(), button: okay)
           }else{
                mJCAlertHelper.showAlert(self, title: "Inactive_Work_Order".localized(), message: "You_are_not_actively_working_on_the_selected_Work_Order_hence_this_action_is_not_allowed".localized(), button: okay)
           }
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
