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
    
    var inspViewModel = InspectionViewModel()
    
    override func viewDidLoad() {
        
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        ScreenManager.registerTotalOperationCountCell(tableView: self.inspectionOperationListTableview)
        inspViewModel.inspOprVc = self
        inspViewModel.getInspectionOperations(from: "Operations")
        mJCLogger.log("Ended", Type: "info")
    }
    func updateInspectionOperationUI() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            if self.inspViewModel.inspOprArray.count > 0 {
                self.noDataViewOperations.isHidden = true
                self.inspectionOperationListTableview.reloadData()
                self.totalInspectionOprLabel.text = "Total :".localized() + "\(self.inspViewModel.inspOprArray.count)"
            }else{
                self.noDataViewOperations.isHidden = false
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if DeviceType == iPhone{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Tableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        mJCLogger.log("Starting", Type: "info")
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mJCLogger.log("Starting", Type: "info")
        return inspViewModel.inspOprArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let totalOperationCountCell = ScreenManager.getTotalOperationCountCell(tableView: tableView)
        totalOperationCountCell.indexPath = indexPath
        totalOperationCountCell.inspViewModel = inspViewModel
        totalOperationCountCell.woInspOperationModelClass = inspViewModel.inspOprArray[indexPath.row]
        mJCLogger.log("Ended", Type: "info")
        return totalOperationCountCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func updateInspOperationDetails(tagValue: Int) {
        mJCLogger.log("Starting", Type: "info")
        let inspectOprcls = inspViewModel.inspOprArray[tagValue]
        let inspectionsVC = ScreenManager.getInspectionLotScreen()
        inspectionsVC.selectedInspLot = inspectOprcls.InspectionLot
        inspectionsVC.selectedInspOpr = inspectOprcls.Operation
        inspectionsVC.modalPresentationStyle = .fullScreen
        self.present(inspectionsVC, animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
}
