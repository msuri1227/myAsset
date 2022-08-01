//
//  MultipleInspectionResultCaptureVC.swift
//  myJobCard
//
//  Created by Ruby's Mac on 24/06/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class MultipleInspectionResultCaptureVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var inspectionTableView: UITableView!
    @IBOutlet var noDataLabel: UILabel!
    @IBOutlet var addResultButton: UIButton!
    @IBOutlet var totalLabel: UILabel!
    
    var inspViewModel = InspectionViewModel()
    var inspPointCharCls = InspectionCharModel()
    var addTapped = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ODSUIHelper.setCircleButtonLayout(button: addResultButton, bgColor: appColor)
        inspViewModel.inspResultVc = self
        inspViewModel.fromResultsScreen = true
        ScreenManager.registerInspectionCell(tableView: self.inspectionTableView)
        inspViewModel.getInspectionResult(lot: inspPointCharCls.InspLot, operation: inspPointCharCls.InspOper, sample: inspPointCharCls.InspPoint, Char: inspPointCharCls.InspChar, from: "resultsVC")
        self.inspectionTableView.estimatedRowHeight = 120
    }
    func updateResultsUI(){
        DispatchQueue.main.async {
            if self.inspViewModel.inspResultArray.count > 0{
                self.inspectionTableView.reloadData()
                self.inspectionTableView.isHidden = false
                self.noDataLabel.isHidden = true
            }else{
                self.noDataLabel.isHidden = false
                self.inspectionTableView.isHidden = true
            }
        }
    }
    @IBAction func backButtonAction(_ sender: Any) {
        inspViewModel.fromResultsScreen = false
        self.dismiss(animated: false, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if addTapped == true{
            return 2
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return inspViewModel.inspResultArray.count
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inspectionCell = ScreenManager.getInspectionCell(tableView: tableView)
        inspectionCell.indexPath = indexPath
        inspectionCell.inspViewModel = self.inspViewModel
        inspViewModel.charclas =  self.inspPointCharCls
        inspViewModel.fromResultsScreen = true
        inspectionCell.section = indexPath.section
        if indexPath.section == 0{
            inspectionCell.inspectionResultModel = self.inspViewModel.inspResultArray[indexPath.row]
            inspectionCell.inspectionModel = self.inspPointCharCls
        }else{
            inspectionCell.inspectionAddModel = self.inspPointCharCls
        }
        return inspectionCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            return 160
        }else{
            return 250
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            if let scope = Int(self.inspPointCharCls.Scope){
                self.totalLabel.text = "Total : \(self.inspViewModel.inspResultArray.count)/\(String(describing: scope))"
            }
        }
    }
    @IBAction func addResultButtonAction(_ sender: UIButton) {
        let scope = Int(self.inspPointCharCls.Scope)
        if  inspViewModel.inspResultArray.count >= scope ?? 0{
            mJCAlertHelper.showAlert(self, title:alerttitle, message: "Results_not_allowed".localized(), button: okay)
        }else{
            sender.isSelected = !sender.isSelected
            if sender.isSelected{
                addTapped = true
            }else{
                addTapped = false
            }
            DispatchQueue.main.async {
                self.inspectionTableView.reloadData()
                self.inspectionTableView.isHidden = false
                self.noDataLabel.isHidden = true
            }
        }
    }
}
