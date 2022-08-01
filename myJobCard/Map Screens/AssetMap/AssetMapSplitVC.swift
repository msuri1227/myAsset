//
//  MapSplitViewController.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 1/7/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit

class AssetMapSplitVC: UISplitViewController {
    
    var work_Orders = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.maximumPrimaryColumnWidth = 260
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
