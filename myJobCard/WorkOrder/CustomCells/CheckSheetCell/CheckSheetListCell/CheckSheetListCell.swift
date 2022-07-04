//
//  CheckSheetListCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 20/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib



class CheckSheetListCell: UITableViewCell {

   
    @IBOutlet var checkSheetNameLabel: UILabel!
    @IBOutlet var checkSheetVersionLabel: UILabel!
    @IBOutlet var checkSheetCategoryLabel: UILabel!
    @IBOutlet var checkSheetViewButton: UIButton!
    @IBOutlet var bgView: UIView!

    var checkSheetAvailabilityModel: FormMasterMetaDataModel?{
        didSet{
            manulCheckSheetConfiguration()
        }
    }
    var formApproverModel: ApproverMasterDataModel?{
        didSet{
            formApproverConfiguration()
        }
    }
    var onClickCheckSheetBtn : (()->Void)?
    var formApprovalViewModel = CheckSheetApprovalViewModel()
    var indexpath = IndexPath()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func manulCheckSheetConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let checkSheet = checkSheetAvailabilityModel{
            checkSheetNameLabel.text = checkSheet.FormName
            checkSheetVersionLabel.text = checkSheet.Version
            checkSheetCategoryLabel.text = checkSheet.FormCategory
            if self.formApprovalViewModel.checkSheetAvailabilityVC.selectedCheckSheetList.count > 0{
                if self.formApprovalViewModel.checkSheetAvailabilityVC.selectedCheckSheetList.contains(checkSheet){
                    self.bgView.backgroundColor = UIColor.lightGray
                }else{
                    self.bgView.backgroundColor = UIColor.white
                }
            }else{
                self.bgView.backgroundColor = UIColor.white
            }
            checkSheetViewButton.isHidden = false
            checkSheetViewButton.tag = indexpath.row
            checkSheetViewButton.addTarget(self, action: #selector(viewCheckSheetButtonAction), for: UIControl.Event.touchUpInside)
        }
       
        mJCLogger.log("Ended", Type: "info")
    }
    
    func formApproverConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let formApprover = formApproverModel{
            checkSheetNameLabel.text = "\(formApprover.FirstName)" + " " + "\(formApprover.LastName)"
            checkSheetVersionLabel.text = formApprover.UserSystemID
            checkSheetCategoryLabel.text = "\(formApprover.Plant) / \(formApprover.WorkCenter)"
            checkSheetViewButton.isHidden = true
            if self.formApprovalViewModel.checkSheetAvailabilityVC.selectedApprovers.count > 0{
                if self.formApprovalViewModel.checkSheetAvailabilityVC.selectedApprovers.contains(formApprover){
                    self.bgView.backgroundColor = UIColor.lightGray
                }else{
                    self.bgView.backgroundColor = UIColor.white
                }
            }else{
                self.bgView.backgroundColor = UIColor.white
            }
            checkSheetViewButton.tag = indexpath.row
            checkSheetViewButton.addTarget(self, action: #selector(viewCheckSheetButtonAction), for: UIControl.Event.touchUpInside)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- Form Cell Button Action..
    @objc func viewCheckSheetButtonAction(btn:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        print("viewCheckSheetButtonAction")
        mJCLogger.log("Ended", Type: "info")
        self.onClickCheckSheetBtn?()
    }
}
