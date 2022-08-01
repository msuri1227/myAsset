//
//  InspectionLotOverview.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 21/04/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class InspectionLotOverview: UIView {

    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var inspectionLotLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var inspectionStartLabel: UILabel!
    @IBOutlet weak var inspectionEndLabel: UILabel!
    @IBOutlet weak var sampleSizeLabel: UILabel!
    @IBOutlet weak var ActualInspQtyLabel: UILabel!
    @IBOutlet weak var destroyedQtyLabel: UILabel!
    @IBOutlet weak var defectiveQtyLabel: UILabel!
    @IBOutlet weak var valuationLabel: UILabel!
    @IBOutlet weak var systemStatusLabel: UILabel!
    
    @IBOutlet weak var popViewWidthConstraint: NSLayoutConstraint!
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        removeFromSuperview()
    }
    
    func popUpViewUI(){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            popViewWidthConstraint.constant = 450
        }else{
            popViewWidthConstraint.constant = 360
        }
        
        popView.layer.cornerRadius = 15
        popView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        popView.layer.borderWidth = 2.0
        popView.layer.borderColor = #colorLiteral(red: 0.337254902, green: 0.5411764706, blue: 0.6784313725, alpha: 1)
        
        closeButton.layer.cornerRadius = 24
        closeButton.clipsToBounds = true
        closeButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        mJCLogger.log("Ended", Type: "info")
       
        
    }
}
