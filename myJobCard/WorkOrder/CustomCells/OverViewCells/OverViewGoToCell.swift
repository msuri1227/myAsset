//
//  OverViewGoToCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 10/28/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib

class OverViewGoToCell: UITableViewCell {

    @IBOutlet var gotoDetailLabel: UILabel!
    @IBOutlet var cellClickButton: UIButton!
    
    var indexpath = IndexPath()
    var woOverViewGoToModel: WorkOrderOverviewViewModel? {
        didSet{
            woOverViewConfiguration()
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
    
    func woOverViewConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        gotoDetailLabel.text = (woOverViewGoToModel?.gotoArray[indexpath.row] as? String)?.localized()
        cellClickButton.tag = indexpath.row
        cellClickButton.addTarget(self, action: #selector(tapOnGotoCell(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Goto TableView Button Action..
     @objc func tapOnGotoCell(sender:UIButton) {
        
        mJCLogger.log("Starting", Type: "info")

            let indexPath = IndexPath(row: sender.tag, section: 0)
            woOverViewGoToModel?.vcOverview!.overViewTablView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
        mJCLogger.log("Ended", Type: "info")
    }

}
