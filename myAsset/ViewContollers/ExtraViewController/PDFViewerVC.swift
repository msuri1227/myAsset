//
//  PDFViewerVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 5/30/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import WebKit
import mJCLib

class PDFViewerVC: UIViewController {
    
    //MARK:- Outlets..
    @IBOutlet var backButton: UIButton!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet weak var pdfWkWebview: WKWebView!
    
    //MARK:- Declared Variables..
    var pdfHeaderName = NSString()
    var pdfURL = NSURL()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        self.headerLabel.text = pdfHeaderName as String
        let requestObj = URLRequest(url: pdfURL as URL)
        pdfWkWebview.load(requestObj)
        pdfWkWebview.allowsBackForwardNavigationGestures = true
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func backButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated:false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
}
