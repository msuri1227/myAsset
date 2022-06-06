//
//  CheckSheetView.swift
//  myJobCard
//
//  Created by Suri on 16/11/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import AVFoundation
import ODSFoundation
import FormsEngine
import mJCLib

class CheckSheetInfoView: UIView {
    @IBOutlet var CheckSheetinfoViewHeaderView: UIView!
    @IBOutlet var CheckSheetinfoViewHeaderLabel: UILabel!

    //BackGroundView Outlets..
    @IBOutlet var backGroundView: UIView!

    //CheckSheetinfoDescriptionVie Outlets..
    @IBOutlet var CheckSheetinfoDescriptionView: UIView!
    @IBOutlet var CheckSheetinfoDescriptionLabelView: UIView!
    @IBOutlet var CheckSheetinfoDescriptionNameLabel: UILabel!

    //CheckSheetinfoCatagoryView Outlets..
    @IBOutlet var CheckSheetinfoCatagoryView: UIView!
    @IBOutlet var CheckSheetinfoCatagoryLabelView: UIView!
    @IBOutlet var CheckSheetinfoCatagoryLabel: UILabel!

    //CheckSheetinfoFunctionalAreaView: Outlets..
    @IBOutlet var CheckSheetinfoFunctionalAreaView: UIView!
    @IBOutlet var CheckSheetinfoFunctionalAreaLabelView: UIView!
    @IBOutlet var CheckSheetinfoFunctionalAreaLabel: UILabel!

    //CheckSheetinfoSubAreaView Outlets..
    @IBOutlet var CheckSheetinfoSubAreaView: UIView!
    @IBOutlet var CheckSheetinfoSubAreaLabelView: UIView!
    @IBOutlet var CheckSheetinfoSubAreaLabel: UILabel!

    @IBOutlet var viewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var OKBtn: UIButton!

    @IBAction func OKBtnAction(_ sender: Any) {
        self.isHidden = true
    }
    func setFrame(){
        let screenFrame = UIScreen.main.bounds
        self.frame = screenFrame
        if DeviceType == iPad{
            viewWidthConstraint.constant = 414
        }else{
            viewWidthConstraint.constant = 350
        }
    }
    func setCheckSheetData(checkSheetObj: FormMasterMetaDataModel){
        CheckSheetinfoCatagoryLabel.text = checkSheetObj.FormCategory
        CheckSheetinfoDescriptionNameLabel.text = checkSheetObj.Description
        CheckSheetinfoFunctionalAreaLabel.text = checkSheetObj.FunctionalArea
        CheckSheetinfoSubAreaLabel.text = checkSheetObj.SubArea
    }
}
