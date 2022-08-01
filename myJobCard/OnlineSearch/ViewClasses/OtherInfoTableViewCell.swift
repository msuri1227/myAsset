//
//  OtherInfoTableViewCell.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 11/09/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class OtherInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var equipmentDesLbl: UILabel!
    @IBOutlet weak var functionalLocaLbl: UILabel!
    @IBOutlet weak var functionalLocLbl: UILabel!
    @IBOutlet weak var basicStartLbl: UILabel!
    @IBOutlet weak var dueDatelbl: UILabel!
    @IBOutlet weak var createdOnLbl: UILabel!
    @IBOutlet weak var personResponsiableLbl: UILabel!
    @IBOutlet weak var businessAreaLbl: UILabel!
    @IBOutlet weak var controllingAreaLbl: UILabel!
    @IBOutlet weak var mainWorkCenterLbl: UILabel!
    @IBOutlet weak var equipmentBtn: UIButton!
    @IBOutlet weak var equipmentarkerBtn: UIButton!
    @IBOutlet weak var functionalLocaBtn: UIButton!
    @IBOutlet weak var functionalLocMarkerBtn: UIButton!
    
    var indexpath = IndexPath()
    var personRespArray = [PersonResponseModel]()
    var onlineWoOtherInfoViewModel = OnlineSearchWorkOrderOverviewViewModel()
    var onlineWoOtherInfoModelClass: WoHeaderModel? {
        didSet{
            onlineWoOtherInfoOverViewConfiguration()
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

    func onlineWoOtherInfoOverViewConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        equipmentBtn.setTitle(onlineWoOtherInfoModelClass?.EquipNum, for: .normal)
        equipmentLabel.text = onlineWoOtherInfoModelClass?.EquipNum
        equipmentDesLbl.text = onlineWoOtherInfoModelClass?.TechObjDescription
        functionalLocLbl.text = onlineWoOtherInfoModelClass?.FuncLocation
        functionalLocaLbl.text = onlineWoOtherInfoModelClass?.FuncLocation
        functionalLocaBtn.setTitle(onlineWoOtherInfoModelClass?.FuncLocation, for: .normal)
        
        if onlineWoOtherInfoModelClass?.BasicStrtDate != nil{
            basicStartLbl.text = onlineWoOtherInfoModelClass?.BasicStrtDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            basicStartLbl.text = ""
        }
        
        if onlineWoOtherInfoModelClass?.BasicFnshDate != nil{
            dueDatelbl.text = onlineWoOtherInfoModelClass?.BasicFnshDate!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            dueDatelbl.text = ""
        }
        
        if onlineWoOtherInfoModelClass?.CreatedOn != nil{
            createdOnLbl.text = onlineWoOtherInfoModelClass?.CreatedOn!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
        }else{
            createdOnLbl.text = ""
        }
        
        businessAreaLbl.text = onlineWoOtherInfoModelClass?.BusArea ?? "" + " - " + onlineWoOtherInfoModelClass!.BusAreaText
        controllingAreaLbl.text = onlineWoOtherInfoModelClass?.ControllingArea
        mainWorkCenterLbl.text = onlineWoOtherInfoModelClass?.MainWorkCtr
        
        if onlineWoOtherInfoModelClass?.PersonResponsible != ""{
            let newpredict = NSPredicate(format: "SELF.PersonnelNo == %@",onlineWoOtherInfoModelClass!.PersonResponsible)
            let newfilterar = onlineWoOtherInfoViewModel.personResponsibleArray.filtered(using: newpredict) as! [PersonResponseModel]
            if newfilterar.count > 0{
                let details = newfilterar[0]
                 personResponsiableLbl.text = details.SystemID
                onlineWoOtherInfoViewModel.responsiblePerson = details.SystemID
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
                 personResponsiableLbl.text = ""
            }
        }else{
             mJCLogger.log("Data not found", Type: "Debug")
             personResponsiableLbl.text = ""
        }
        equipmentBtn.tag = indexpath.row
        functionalLocaBtn.tag = indexpath.row
        equipmentarkerBtn.tag = indexpath.row
        functionalLocMarkerBtn.tag = indexpath.row
        
        equipmentBtn.addTarget(self, action:#selector(self.assetEquipmentButtonAction(sender:)), for: .touchUpInside)
        functionalLocaBtn.addTarget(self, action: #selector(self.assetFunctionLocationButtonAction(sender:)), for: .touchUpInside)
        equipmentarkerBtn.addTarget(self, action: #selector(self.equipmentMapButtonAction(sener:)), for: .touchUpInside)
        functionalLocMarkerBtn.addTarget(self, action:#selector(self.funlocMapbuttonAction(sender:)), for: .touchUpInside)
        mJCLogger.log("Ended", Type: "info")
    }
    
    @objc func equipmentMapButtonAction(sener: UIButton){
        mJCLogger.log("Starting", Type: "info")
        onlineWoOtherInfoViewModel.vcOnlineWoOverview?.updateUIEquipmentMapButton()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func funlocMapbuttonAction(sender : UIButton){
        mJCLogger.log("Starting", Type: "info")
        onlineWoOtherInfoViewModel.vcOnlineWoOverview?.updateUIFunlocMapButton()
        mJCLogger.log("Ended", Type: "info")
    }
    //Equipment Button Action..
    @objc func assetEquipmentButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("asset_Equipment_Button_Action".localized(), Type: "")
        if sender.titleLabel?.text != "" && sender.titleLabel?.text != nil {
            onlineWoOtherInfoViewModel.equipmentServiceCall(btnTitle: (sender.titleLabel?.text)!)
        }else{
            mJCLogger.log("Equipment_Not_Found".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(onlineWoOtherInfoViewModel.vcOnlineWoOverview!, title: MessageTitle, message: "Equipment_Not_Found".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //Function Location Button Action..
    @objc func assetFunctionLocationButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("asset_Function_Location_Button_Action".localized(), Type: "")
        if sender.titleLabel?.text != "" && sender.titleLabel?.text != nil {
            onlineWoOtherInfoViewModel.funcLocServiceCall(btnTitle: (sender.titleLabel?.text)!)
        }else{
            mJCLogger.log("Functional_Location_Not_Found".localized(), Type: "Debug")
            mJCAlertHelper.showAlert(onlineWoOtherInfoViewModel.vcOnlineWoOverview!, title: MessageTitle, message: "Functional_Location_Not_Found".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
}
