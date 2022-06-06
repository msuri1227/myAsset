//
//  InformationVC.swift
//  MyJobCard
//
//  Created by Navdeep Singla on 02/01/20.
//  Copyright © 2020 Pratik Patel. All rights reserved.
//

import UIKit

class InformationVC: UIViewController {

    @IBOutlet weak var infoPopView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var workOrderNumLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var prorityLbl: UILabel!
    @IBOutlet weak var orderTypeLbl: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var createdOnLbl: UILabel!
    
//    var selectedWoInfoIndex = Int()
    var SelectedObj = SingleOperationModelClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.infoPopView.layer.cornerRadius = 8
        self.infoPopView.layer.masksToBounds = true
        self.closeBtn.layer.cornerRadius = 6
        self.closeBtn.layer.masksToBounds = true
                
        self.descriptionlbl.text = SelectedObj.ShortText
        self.prorityLbl.text = SelectedObj.Priority
        self.workOrderNumLbl.text =  "Work Order : \(SelectedObj.WorkOrderNum)"
//        self.createdOnLbl.text = SelectedObj.


    }
    

    @IBAction func CloseBtnAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
