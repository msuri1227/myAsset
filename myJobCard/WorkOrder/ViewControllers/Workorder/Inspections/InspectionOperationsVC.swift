//
//  InspectionOperationsVC.swift
//  myJobCard
//
//  Created By Ondevice Solutions on 06/04/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class InspectionOperationsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate {

    @IBOutlet weak var inspectionOperationListTableview: UITableView!
    @IBOutlet weak var noDataViewOperations: UIView!
    
    @IBOutlet weak var totalInspectionOprLabel: UILabel!
    var inspectionOprArray = Array<InspectionOperationModelClass>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalInspectionOprLabel.text = "Inspectio_Operations : 0".localized()
        self.inspectionOperationListTableview.register(UINib(nibName: "TotalOperationCountCell", bundle: nil), forCellReuseIdentifier: "TotalOperationCountCell_iPhone")
        self.getInspectionOperations()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if DeviceType == iPhone{
                 NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        }
    }
    func getInspectionOperations(){
      
      
        let defineQuery = "InspectionOperSet?$filter=(InspectionLot%20eq%20%27\(singleWorkOrder.InspectionLot)%27)&$orderby=Operation"
        
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
                               self.inspectionOperationListTableview.reloadData()
                               self.totalInspectionOprLabel.text = "Total :".localized() + "\(self.inspectionOprArray.count)"
                           }
                        }else{
                            DispatchQueue.main.async {
                                self.noDataViewOperations.isHidden = false
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
   
    //MARK:- Tableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.inspectionOprArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
        let totalOperationCountCell = tableView.dequeueReusableCell(withIdentifier: "TotalOperationCountCell_iPhone") as! TotalOperationCountCell
            
            totalOperationCountCell.operationCompleteImageWidthConstraint.constant = 0.0

        let inspectOprcls = inspectionOprArray[indexPath.row]
            
        totalOperationCountCell.operationCompleteImageWidthConstraint.constant = 0.0
        totalOperationCountCell.selectCheckBoxWidthConst.constant = 0.0
        totalOperationCountCell.operationNameLabel.text = inspectOprcls.Operation
        totalOperationCountCell.DescriptionLabel.text = inspectOprcls.ShortText
        totalOperationCountCell.selectOpearettionButton.tag = indexPath.row
        totalOperationCountCell.selectOpearettionButton.addTarget(self, action: #selector(self.selectInspOperationButtonClicked), for: .touchUpInside)

        return totalOperationCountCell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    //MARK:- Inspection Operation select Button Action..
    @objc func selectInspOperationButtonClicked(btn:UIButton)  {
        
        let inspectOprcls = inspectionOprArray[btn.tag]
        let InspectionsVC = self.storyboard!.instantiateViewController(withIdentifier: "InspectionsVC_iPhone") as! InspectionsVC
        InspectionsVC.inspectionLotiPhoneStr = inspectOprcls.InspectionLot
        InspectionsVC.operationiPhoneStr = inspectOprcls.Operation
        InspectionsVC.modalPresentationStyle = .fullScreen
        self.present(InspectionsVC, animated: false) {}
    }
}
