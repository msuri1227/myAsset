//
//  FormApprovalStatusVC.swift
//  myJobCard
//
//  Created by Ruby's Mac on 07/06/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class FormApprovalStatusVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var approvalStatusTableView: UITableView!
    @IBOutlet var noDataAvailableLabel: UILabel!
    @IBOutlet var approveStatusView: UIView!
    @IBOutlet var auditLogView: UIView!
    @IBOutlet var auditLogTableView: UITableView!
    @IBOutlet var auditLogLabel: UILabel!
    @IBOutlet var auditlogCloseButton: UIButton!
    
    var formApprovalViewModel = CheckSheetApprovalViewModel()
    var selectedformResponse = FormResponseCaptureModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formApprovalViewModel.formApprovalStatusVC = self
        self.formApprovalViewModel.getApproverStatus()
        ScreenManager.registerApprovalTableViewCell(tableView: approvalStatusTableView)
    }
    override func viewWillAppear(_ animated: Bool) {}
    func updateListUI(){
        if self.formApprovalViewModel.formApproverStatusArray.count > 0{
            DispatchQueue.main.async {
                self.approveStatusView.isHidden = false
                self.noDataAvailableLabel.isHidden = true
                self.auditLogView.isHidden = true
                self.auditLogLabel.isHidden = true
                self.approvalStatusTableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.approveStatusView.isHidden = false
                self.noDataAvailableLabel.isHidden = false
                self.auditLogView.isHidden = true
                self.auditLogLabel.isHidden = true
            }
        }
    }
    func updateAuditLogView(){
        if self.formApprovalViewModel.formApproverStatusArray.count > 0{
            DispatchQueue.main.async {
                self.auditLogView.isHidden = false
                self.auditLogLabel.isHidden = true
                self.auditLogTableView.reloadData()
            }
        }
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func auditLogCloseButtonAction(_ sender: Any) {
        self.auditLogView.isHidden = true
        self.auditLogLabel.isHidden = true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formApprovalViewModel.formApproverStatusArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        if tableView == approvalStatusTableView{
            let approvalTableViewCell = ScreenManager.getApprovalTableViewCell(tableView: tableView)
            approvalTableViewCell.formApprovalViewModel = self.formApprovalViewModel
            approvalTableViewCell.formApproverModel = formApprovalViewModel.formApproverStatusArray[indexPath.row]
            return approvalTableViewCell
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            if(cell != nil)
            {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            }
            let statusCls = formApprovalViewModel.formApproverStatusArray[indexPath.row]
            var date = String()
            if statusCls.CreatedDate != nil{
                date = statusCls.CreatedDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }
            let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: statusCls.CreatedTime)
            let str = "\(statusCls.FormContentStatus) by \(statusCls.ApproverID) on \(date) \(time) with remarks : \(statusCls.Remarks)"
            cell!.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
            cell!.textLabel?.numberOfLines = 0
            cell!.textLabel?.text = str
            return cell!
        }
    }
}
