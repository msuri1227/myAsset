//
//  OperationDatesCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/10/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class OperationDatesCell: UITableViewCell {
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var mainDetailsView: UIView!
    
    //DatesEarliest_Schd_StartDateView Outlets..
    @IBOutlet var datesEarliest_Schd_StartDateView: UIView!
    @IBOutlet var datesEarliest_Schd_StartDateLabelView: UIView!
    @IBOutlet var datesEarliest_Schd_StartDateLabel: UILabel!

    //DatesEarliest_Schd_StartTimeView Outlets..
    @IBOutlet var datesEarliest_Schd_StartTimeView: UIView!
    @IBOutlet var datesEarliest_Schd_StartTimeLabelView: UIView!
    @IBOutlet var datesEarliest_Schd_StartTimeLabel: UILabel!
    
    //DatesEarliest_Schd_FinishDateView Outlets..
    @IBOutlet var datesEarliest_Schd_FinishDateView: UIView!
    @IBOutlet var datesEarliest_Schd_FinishDateLabelView: UIView!
    @IBOutlet var datesEarliest_Schd_FinishDateLabel: UILabel!
    
    //DatesEarliest_Schd_FinishTimeView Outlets..
    @IBOutlet var datesEarliest_Schd_FinishTimeView: UIView!
    @IBOutlet var datesEarliest_Schd_FinishTimeLabelView: UIView!
    @IBOutlet var datesEarliest_Schd_FinishTimeLabel: UILabel!
    
    //DatesLatest_Schd_StartDateView Outlets..
    @IBOutlet var datesLatest_Schd_StartDateView: UIView!
    @IBOutlet var datesLatest_Schd_StartDateLabelView: UIView!
    @IBOutlet var datesLatest_Schd_StartDateLabel: UILabel!
    
    //DatesLatest_Schd_StartTimeView Outlets..
    @IBOutlet var datesLatest_Schd_StartTimeView: UIView!
    @IBOutlet var datesLatest_Schd_StartTimeLabelView: UIView!
    @IBOutlet var datesLatest_Schd_StartTimeLabel: UILabel!
    
    //DatesLatest_Schd_FinishDateView Outlets..
    @IBOutlet var datesLatest_Schd_FinishDateView: UIView!
    @IBOutlet var datesLatest_Schd_FinishDateLabelView: UIView!
    @IBOutlet var datesLatest_Schd_FinishDateLabel: UILabel!
    
    //DatesLatest_Schd_FinishTimeView Outlets..
    @IBOutlet var datesLatest_Schd_FinishTimeView: UIView!
    @IBOutlet var datesLatest_Schd_FinishTimeLabelView: UIView!
    @IBOutlet var datesLatest_Schd_FinishTimeLabel: UILabel!
    
    //DatesExecution_StartDateView Outlets..
    @IBOutlet var datesExecution_StartDateView: UIView!
    @IBOutlet var datesExecution_StartDateLabelView: UIView!
    @IBOutlet var datesExecution_StartDateLabel: UILabel!
    
    //DatesExecution_StartTimeView Outlets..
    @IBOutlet var datesExecution_StartTimeView: UIView!
    @IBOutlet var datesExecution_StartTimeLabelView: UIView!
    @IBOutlet var datesExecution_StartTimeLabel: UILabel!

    //DatesExecution_FinishDateView Outlets..
    @IBOutlet var datesExecution_FinishDateView: UIView!
    @IBOutlet var datesExecution_FinishDateLabelView: UIView!
    @IBOutlet var datesExecution_FinishDateLabel: UILabel!
    
    //DatesExecution_FinishTimeView Outlets..
    @IBOutlet var datesExecution_FinishTimeView: UIView!
    @IBOutlet var datesExecution_FinishTimeLabelView: UIView!
    @IBOutlet var datesExecution_FinishTimeLabel: UILabel!
    
    var operationVCModel = OperationOverViewModel()
    var indexPath: NSIndexPath!
    var operationClass: WoOperationModel?{
        didSet{
            operationDatesConfiguration()
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

    func operationDatesConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let singleOperalClass = operationClass {
            
            if singleOperalClass.EarlSchStartExecDate != nil{
                self.datesEarliest_Schd_StartDateLabel.text = singleOperalClass.EarlSchStartExecDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.datesEarliest_Schd_StartDateLabel.text = ""
            }
            self.datesEarliest_Schd_StartTimeLabel.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleOperalClass.EarlSchStartExecTime)
            if singleOperalClass.EarlSchFinishExecDate != nil{
                self.datesEarliest_Schd_FinishDateLabel.text = singleOperalClass.EarlSchFinishExecDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.datesEarliest_Schd_FinishDateLabel.text = ""
            }
            self.datesEarliest_Schd_FinishTimeLabel.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleOperalClass.EarlSchFinishExecTime)
            
            if singleOperalClass.LatestSchStartDate != nil{
                self.datesLatest_Schd_StartDateLabel.text = singleOperalClass.LatestSchStartDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.datesLatest_Schd_StartDateLabel.text = ""
            }
            
            self.datesLatest_Schd_StartTimeLabel.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleOperalClass.LatestSchStartTime)
            
            if singleOperalClass.LatestSchFinishDate != nil{
                self.datesLatest_Schd_FinishDateLabel.text = singleOperalClass.LatestSchFinishDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.datesLatest_Schd_FinishDateLabel.text = ""
            }
            
            self.datesLatest_Schd_FinishTimeLabel.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleOperalClass.LatestSchFinishTime)
            self.datesExecution_FinishTimeLabel.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleOperalClass.ActFinishExectime)
            self.datesExecution_StartTimeLabel.text = ODSDateHelper.getTimeFromSODataDuration(dataDuration: singleOperalClass.ActStartExecTime)
           
            if singleOperalClass.ActStartExecDate != nil{
                self.datesExecution_StartDateLabel.text =  singleOperalClass.ActStartExecDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.datesExecution_StartDateLabel.text = ""
            }
            if singleOperalClass.ActFinishExecDate != nil{
                self.datesExecution_FinishDateLabel.text =  singleOperalClass.ActFinishExecDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
            }else{
                self.datesExecution_FinishDateLabel.text = ""
            }
            
        }
        mJCLogger.log("Starting", Type: "info")
    }

}
