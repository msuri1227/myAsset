//
//  NotificationGotoCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/8/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationGotoCell: UITableViewCell {

    @IBOutlet var gotoTitleLabel: UILabel!
    @IBOutlet var gotoCellButton: UIButton!
    
    var indexpath = IndexPath()
    var notiOverViewGoToModelClass: NotificationOverviewViewModel? {
        didSet{
            notiOverViewOverViewConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func notiOverViewOverViewConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        gotoTitleLabel.text = (notiOverViewGoToModelClass?.gotoListArray[indexpath.row] as? String)?.localized()
        gotoCellButton.tag = indexpath.row
        gotoCellButton.addTarget(self, action: #selector(tapOnGotoCell(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Cell Button Action..
    
    @objc func tapOnGotoCell(sender:UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let indexPath = IndexPath(row: sender.tag, section: 0)
        notiOverViewGoToModelClass?.vcNOOverview?.gotoDescriptionTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
        mJCLogger.log("Ended", Type: "info")
    }
}
