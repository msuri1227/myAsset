//
//  AboutUSVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 5/10/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit

class AboutUSVC: UIViewController {
    
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var ondiveceLogo: UIImageView!
    
    @IBOutlet var appVersionNumberLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet var linkButton: UIButton!
    @IBOutlet var websiteButton: UIButton!
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        appVersionNumberLabel.text = "Version :\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func cancelButtonAction(sender: AnyObject) {
        self.dismiss(animated: false) {}
    }
    @IBAction func ondiveceWebsiteButtonAction(sender: AnyObject) {
        let url = "http://www.ondevice.co.in.uk"
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
    
}
