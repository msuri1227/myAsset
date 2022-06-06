//
//  SignatureCaptureVC.swift
//  myJobCard
//
//  Created by Ondevice Solutionson 01/04/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class SignatureCaptureVC: UIViewController,viewModelDelegate {
    
    @IBOutlet var signMainView: UIView!
    @IBOutlet weak var signView: UIView!
    @IBOutlet var customerSelectButton: UIButton!
    @IBOutlet var signDoneButton: UIButton!
    @IBOutlet var signCancelButton: UIButton!
    @IBOutlet var signResetButton: UIButton!
    @IBOutlet var headerViewHeightConst: NSLayoutConstraint!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    let signatureView = PJRSignatureView()
    var suspendViewModel = SuspendViewModel()
    var screenType = String()
    var signatureCaptureViewModel = SignatureCaptureViewModel()
    var noteArray = [LongTextModel]()
    var woLongTextVM = woLongTextViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        signatureCaptureViewModel.signatureCaptureVc = self
        signatureCaptureViewModel.addSignatureView()
        headerViewHeightConst.constant = 0.0
        
        woLongTextVM.woObj = singleWorkOrder
        woLongTextVM.oprObj = singleOperation
        woLongTextVM.delegate = self
        woLongTextVM.userId = "\(strUser)".uppercased()
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
            woLongTextVM.getWoLongText()
        }else{
            woLongTextVM.getOprLongText()
        }
        if self.screenType == "StatusChange" && DeviceType == iPad{
            let index = self.suspendViewModel.completionFeatureListArray.firstIndex{$0.title == "Signature".localized()} ?? 0
            if index == self.suspendViewModel.completionFeatureListArray.count - 1{
                if self.suspendViewModel.suspendVc?.isFromScreen == "Hold"{
                    self.doneButton.setTitle("Hold_order".localized(), for: .normal)
                }else if self.suspendViewModel.suspendVc?.isFromScreen == "Suspend"{
                    self.doneButton.setTitle("Suspend".localized(), for: .normal)
                }else{
                    self.doneButton.setTitle("Complete".localized(), for: .normal)
                }
            }
        }
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "longTextFetch"{
            if let textArr = object as? [LongTextModel]{
                self.noteArray = textArr
            }
        }else if type == "longTextCreated"{
            if let entity = object[0] as? SODataEntityDefault{
                var entityDict = Dictionary<String,Any>()
                entityDict["collectionPath"] = woLongTextSet
                entityDict["entity"] = entity
                entityDict["type"] = "Create"
                self.suspendViewModel.entityDict["signature"] = entityDict
                self.suspendViewModel.validateCompletionFeatures()
            }
        }
    }
    @IBAction func signResetButtonAction(sender: AnyObject) {
        customerSelectButton.isSelected = false
        signatureCaptureViewModel.clearSignature()
    }
    @IBAction func signCancelButtonAction(sender: AnyObject) {
        if screenType == "StatusChange"{
            self.suspendViewModel.suspendVc?.dismissViewController()
        }else{
            self.dismiss(animated: false, completion: nil)
        }
    }
    @IBAction func signDoneButtonAction(sender: AnyObject) {
        signatureCaptureViewModel.getSignatureFromView()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func customerNotAvailbleCheckBoxButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if (sender as! UIButton).isSelected {
            (sender as! UIButton).isSelected = false
            self.signatureView.isUserInteractionEnabled = true
        }else {
            (sender as! UIButton).isSelected = true
            signatureView.clearSignature()
            self.signatureView.isUserInteractionEnabled = false
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
