//
//  AttachmentViewerVC.swift
//  myJobCard
//
//  Created by Alphaved on 16/01/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
import WebKit

class AttachmentViewerVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var attachmentView: UIView!
    @IBOutlet weak var attachmentImageview: UIImageView!
    @IBOutlet weak var attachmentWkWebview: WKWebView!
    
    //MARK:- declared Variables
    var attachmentImage = UIImage()
    var attachmenttype = String()
    var pdfURL = NSURL()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()
        if attachmenttype == "image"{
            attachmentWkWebview.isHidden = true;
            attachmentWkWebview.isUserInteractionEnabled = false
            attachmentWkWebview.backgroundColor = UIColor.white
            attachmentImageview.image = attachmentImage
        }else if attachmenttype == "pdf"{
            
            attachmentImageview.isHidden = true;
            attachmentImageview.isUserInteractionEnabled = false
            attachmentWkWebview.backgroundColor = UIColor.white
        
            let requestObj = URLRequest(url: pdfURL as URL)
            attachmentWkWebview.load(requestObj)

        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //status bar color - 13/11/19- rubi
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
    myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
        
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Cancel Button Action..
    @IBAction func cancelAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }

//...END...//
}
