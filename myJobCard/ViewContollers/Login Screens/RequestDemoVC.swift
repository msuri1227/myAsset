//
//  RequestDemoVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/20/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit

class RequestDemoVC: UIViewController {
    
    //MARK:- Outlets..
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    
    //MARK:- Declared Variables..
    var headerString = String()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(headerString == "Request_Demo".localized()) {
            descriptionLabel.text = "reset_password_label_text".localized()
            websiteLabel.text = "Website".localized() + ": www.ondevice.co.in.uk"
            emailLabel.text = "Email".localized() + ": info@ondevice.co.uk"
            headerLabel.text = "Request_Demo".localized()
        }else if(headerString == "Reset_Password".localized()) {
            descriptionLabel.text = "request_demo_label".localized()
            websiteLabel.isHidden = true
            emailLabel.isHidden = true
            headerLabel.text = "Reset_Password".localized()
        }
        

    }

    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //MARK:- Cancel Button Action..
    @IBAction func cancelButtonAction(sender: AnyObject) {
        
        self.dismiss(animated: false) {}
    }
}
