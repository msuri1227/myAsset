//
//  FormFilledCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 1/21/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class ReviewerCell: UITableViewCell {

    
    @IBOutlet weak var formNameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var instanceIdLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var operationNumberLabel: UILabel!
    @IBOutlet weak var submittedByLabel: UILabel!
    @IBOutlet weak var submittedOnLabel: UILabel!
    @IBOutlet weak var previewCheckSheetButton: UIButton!
    @IBOutlet weak var selectOrRejectCheckSheetButton: UIButton!
    @IBOutlet var notesButton: UIButton!
    @IBOutlet var statusView: UIView!

    var indexpath = IndexPath()
    var reviewerViewModel = ReviewerListViewModel()
    var reviewerCellModel: FormReviewerResponseModel? {
        didSet{
            reviewerCellConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reviewerCellConfiguration() {
        
        formNameLabel.text = reviewerCellModel?.FormID
        versionLabel.text = reviewerCellModel?.Version
        orderNumberLabel.text = reviewerCellModel?.WoNum
        operationNumberLabel.text = reviewerCellModel?.OperationNum
        submittedByLabel.text = reviewerCellModel?.CreatedBy

        if reviewerCellModel?.CreatedOn != nil{
            let date = reviewerCellModel?.CreatedOn!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            submittedOnLabel.text = date
        }
        self.previewCheckSheetButton.tag = indexpath.row
        if !applicationFeatureArrayKeys.contains("REVIEWER_CHECKSHEET_PREVIEW_OPTION"){
            self.previewCheckSheetButton.isHidden = true
        }else{
            self.previewCheckSheetButton.isHidden = false
            previewCheckSheetButton.addTarget(self, action: #selector(previewCheckSheet(sender:)), for: UIControl.Event.touchUpInside)
        }
        self.selectOrRejectCheckSheetButton.tag = indexpath.row
        if !applicationFeatureArrayKeys.contains("REVIEWER_CHECKSHEET_STATUS_OPTION"){
            self.selectOrRejectCheckSheetButton.isHidden = true
        }else{
            self.selectOrRejectCheckSheetButton.isHidden = false
            selectOrRejectCheckSheetButton.addTarget(self, action: #selector(approveRejectSheet(sender:)), for: UIControl.Event.touchUpInside)
        }
        self.notesButton.tag = indexpath.row
        notesButton.addTarget(self, action: #selector(previouseRemarksButtonAction(sender:)), for: UIControl.Event.touchUpInside)
    }
    @objc func previewCheckSheet(sender: UIButton) {
        reviewerViewModel.reviewerVC.getPreviewCheckSheet(index: sender.tag)
    }
    @objc func approveRejectSheet(sender: UIButton) {
        reviewerViewModel.getFormDetailsToApproveOrRect(index: sender.tag)
    }
    @objc func previouseRemarksButtonAction(sender: UIButton) {
        reviewerViewModel.getPreviousRemarks(index: sender.tag)
    }

}
