//
//  HomeViewController.swift
//  MyJobCard
//
//  Created by Rover Software on 20/03/19.
//  Copyright © 2019 Pratik Patel. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController,SlideMenuControllerSelectDelegate,SlideMenuControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()

    }

    @IBAction func MenuButtonAction(_ sender: Any) {
            openLeft()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


