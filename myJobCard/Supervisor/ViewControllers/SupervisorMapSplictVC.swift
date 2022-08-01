//
//  SupervisorMapSplictVC.swift
//  myJobCard
//
//  Created by Rover Software on 24/07/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit

class SupervisorMapSplictVC: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.maximumPrimaryColumnWidth = 260
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
