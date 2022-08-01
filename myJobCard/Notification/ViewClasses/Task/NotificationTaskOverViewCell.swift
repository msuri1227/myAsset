//
//  //  swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/9/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NotificationTaskOverViewCell: UITableViewCell {
    
    
    //HeaderView Outlets..
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerViewLabel: UILabel!
    
    @IBOutlet var backGroundView: UIView!
    
    //TaskView Outlets..
    @IBOutlet var overViewTaskView: UIView!
    @IBOutlet var overViewTaskLabelView: UIView!
    @IBOutlet var overViewTaskLabel: UILabel!
    
    //TaskCodeView Outlets..
    @IBOutlet var overViewTaskCodeView: UIView!
    @IBOutlet var overViewTaskCodeLabelView: UIView!
    @IBOutlet var overViewTaskCodeLabel: UILabel!
    
    //TaskTextView Outlets..
    @IBOutlet var overViewTaskTextView: UIView!
    @IBOutlet var overViewTaskTextLabelView: UIView!
    @IBOutlet var overViewTaskTextLabel: UILabel!
    
    //CodeGroupView Outlets..
    @IBOutlet var overViewCodeGroupView: UIView!
    @IBOutlet var overViewCodeGroupLabelView: UIView!
    @IBOutlet var overViewCodeGroupLabel: UILabel!
    
    //PlannedStartView Outlets..
    @IBOutlet var overViewPlannedStartView: UIView!
    @IBOutlet var overViewPlannedStartLabelView: UIView!
    @IBOutlet var overViewPlannedStartLabel: UILabel!
    
    //PlannedFinishView Outlets..
    @IBOutlet var overViewPlannedFinishView: UIView!
    @IBOutlet var overViewPlannedFinishLabelView: UIView!
    @IBOutlet var overViewPlannedFinishLabel: UILabel!
    
    //CauseView Outlets..
    @IBOutlet var overViewCauseView: UIView!
    @IBOutlet var overViewCauseLabelView: UIView!
    @IBOutlet var overViewCauseLabel: UILabel!
    
    //CatalogView Outlets..
    @IBOutlet var overViewCatalogView: UIView!
    @IBOutlet var overViewCatalogLabelView: UIView!
    @IBOutlet var overViewCatalogLabel: UILabel!
    
    // StatusView Outlets..
    @IBOutlet weak var overviewStatusView: UIView!
    @IBOutlet weak var overviewStatusLabelView: UIView!
    @IBOutlet weak var overviewStatusLabel: UILabel!
    
    
    var indexPath = IndexPath()
    
    var NotificationTaskModel:NotificationTaskModel?{
        didSet{
            configureNotificationTaskOverViewCell()
        }
    }
    var notificationTaskViewModel = NotificationTaskViewModel()
    var notificationItemCausesViewModel = NotificationItemCausesViewModel()
    var partArray = Array<CodeGroupModel>()
    
    
    func configureNotificationTaskOverViewCell(){
        mJCLogger.log("Starting", Type: "info")
        if notificationItemCausesViewModel.vc?.isFromScreen == "ItemTask" {
            
            if notificationItemCausesViewModel.singleTaskArray.count > 0{
                mJCLogger.log("Response:\(notificationItemCausesViewModel.singleTaskArray[0])", Type: "Debug")
                let notificationTaskClass = notificationItemCausesViewModel.singleTaskArray[0]
                overViewTaskLabel.text = notificationTaskClass.Task
                overViewTaskCodeLabel.text = notificationTaskClass.TaskCode
                overViewTaskTextLabel.text = notificationTaskClass.TaskText
                notificationTaskViewModel.getPartValue(catalogCode: notificationTaskClass.CatalogType, codeGroup: notificationTaskClass.CodeGroup, code: notificationTaskClass.TaskCode)
                
                if notificationTaskClass.PlannedStart != nil{
                    overViewPlannedStartLabel.text =  notificationTaskClass.PlannedStart!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    overViewPlannedStartLabel.text = ""
                }
                if notificationTaskClass.PlannedFinish != nil{
                    overViewPlannedFinishLabel.text = notificationTaskClass.PlannedFinish!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    overViewPlannedFinishLabel.text = ""
                }
                
                overviewStatusLabel.text = notificationTaskClass.UserStatus
                overViewCauseLabel.text = notificationTaskClass.Cause
                overViewCatalogLabel.text = notificationTaskClass.CatalogType
                if notificationTaskViewModel.partArray.count > 0 {
                    self.overViewCodeGroupLabel.text = "\(notificationTaskViewModel.partArray[0].CodeGroup) - \(notificationTaskViewModel.partArray[0].CodeGroupText)"
                }
            }
            
        }else {
            if (notificationTaskViewModel.singleTaskArray.count > 0) {
                mJCLogger.log("Response:\(notificationTaskViewModel.singleTaskArray[0])", Type: "Debug")
                let notificationTaskClass = notificationTaskViewModel.singleTaskArray[0]
                
                overViewTaskLabel.text = notificationTaskClass.Task
                overViewTaskTextLabel.text = notificationTaskClass.TaskText
                notificationTaskViewModel.getPartValue(catalogCode: notificationTaskClass.CatalogType, codeGroup: notificationTaskClass.CodeGroup, code: notificationTaskClass.TaskCode)
                
                overviewStatusLabel.text = notificationTaskClass.UserStatus
                
                if notificationTaskClass.PlannedStart != nil{
                    overViewPlannedStartLabel.text = notificationTaskClass.PlannedStart!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    overViewPlannedStartLabel.text = ""
                }
                
                if notificationTaskClass.PlannedFinish != nil{
                    overViewPlannedFinishLabel.text =  notificationTaskClass.PlannedFinish!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                }else{
                    overViewPlannedFinishLabel.text = ""
                }
                
                overViewCauseLabel.text = notificationTaskClass.Cause
                overViewCatalogLabel.text = notificationTaskClass.CatalogType
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    
                    if self.notificationTaskViewModel.partArray.count > 0 {
                        self.overViewCodeGroupLabel.text = "\(self.notificationTaskViewModel.partArray[0].CodeGroup) - \(self.notificationTaskViewModel.partArray[0].CodeGroupText)"
                        self.overViewTaskCodeLabel.text = "\(self.notificationTaskViewModel.partArray[0].Code)-\(self.notificationTaskViewModel.partArray[0].CodeText)"
                        
                    }
                })
                
            }
        }
        
        mJCLogger.log("Ended", Type: "info")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
