//
//  BreakdownReportTableViewCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/10/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class BreakdownReportTableViewCell: UITableViewCell {

    @IBOutlet var periodsLabel: UILabel!
    @IBOutlet var breakdownLabel: UILabel!
    @IBOutlet var downTImeLabel: UILabel!
    @IBOutlet var MTTRLabel: UILabel!
    @IBOutlet var MTBRLabel: UILabel!
    
    var breakdownReportModelClass: BreakdownReportModel? {
        didSet{
            breakdownReportCellConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func breakdownReportCellConfiguration() {
        
        backgroundColor = UIColor(named: "mjcSubViewColor")
        
        if let newBreakdownReportModel = breakdownReportModelClass{
            periodsLabel.text = newBreakdownReportModel.Period
            breakdownLabel.text = "\(String(describing: newBreakdownReportModel.ActualBreakdns))"
            downTImeLabel.text = "\(String(describing: newBreakdownReportModel.Downtime))"
            MTTRLabel.text = "\(String(describing: newBreakdownReportModel.MTTR))"
            MTBRLabel.text = "\(String(describing: newBreakdownReportModel.MTBR))"
        }
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.40
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
}
