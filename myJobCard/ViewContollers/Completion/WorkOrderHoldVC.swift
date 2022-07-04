//
//  WorkOrderHoldVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/23/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class WorkOrderHoldVC: UIViewController,UITextViewDelegate,UITextFieldDelegate,viewModelDelegate {
    
    //MARK:- Outlets
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var holdNoteView: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var holdNoteTextView: UITextView!
    @IBOutlet var holdNoteTextViewView: UIView!
    @IBOutlet var holdReasonButtonView: UIView!
    @IBOutlet var holdReasonButton: UIButton!
    @IBOutlet var headerViewHeightConst: NSLayoutConstraint!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    var subStringArr = NSMutableArray()
    
    //MARK:- Declared Variables..
    let dropDown = DropDown()
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    
    var holdReasonArray = [ReasonCodeModel]()
    var holdReasonListArray = [String]()
    var holdReason = String()
    var holdNote = String()
    var screenType = String()
    var statusCategoryCls = StatusCategoryModel()
    var holdViewModel = HoldViewModel()
    var suspendViewModel = SuspendViewModel()
    
    var noteArray = [LongTextModel]()
    var woLongTextVM = woLongTextViewModel()
    
    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        
        self.holdViewModel.holdVc = self
        self.headerViewHeightConst.constant = 0.0
        self.holdViewModel.getHoldReasonData()
        self.holdNoteTextView.delegate = self
        self.holdViewModel.setViewLayouts()
        
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
            let index = self.suspendViewModel.completionFeatureListArray.firstIndex{$0.title == "Notes".localized()} ?? 0
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
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.holdReasonButton.setTitle(item, for: .normal)
            self.dropDown.hide()
        }
        if WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5"{
            self.headerLabel.text = "Hold_Operation".localized()  + " : \(selectedworkOrderNumber)/\(selectedOperationNumber)"
        }else{
            self.headerLabel.text = "Hold_WorkOrder".localized()  + ": \(selectedworkOrderNumber)"
        }
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
                self.suspendViewModel.holdReason = self.holdReason
                self.suspendViewModel.entityDict["notes"] = entityDict
                self.suspendViewModel.validateCompletionFeatures()
            }
        }
    }
    //MARK:- Notification deinit..
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @IBAction func backButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Footer Button Action..
    @IBAction func holdRefreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.holdReasonListArray.count > 0 {
            self.holdReasonButton.setTitle(self.holdReasonListArray[0], for: .normal)
            self.holdNoteTextView.text = ""
            mJCLogger.log("Ended", Type: "info")
        }
    }
    @IBAction func holdCancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.screenType == "StatusChange"{
            self.suspendViewModel.suspendVc?.dismissViewController()
        }else{
            self.dismiss(animated: false, completion: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func holdDoneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        self.holdReason = self.holdReasonButton.titleLabel?.text ?? ""
        self.holdNote = self.holdNoteTextView.text!
        if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
            self.woLongTextVM.createWoLongtext(text: self.holdNote,requiredEntity: true)
        }else{
            self.woLongTextVM.createOprLongtext(text: self.holdNote,requiredEntity: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Hold Field Button Action..
    @IBAction func holdReasonButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.holdReasonListArray.count > 0 {
            dropDown.anchorView = self.holdReasonButtonView
            let arr : [String] = self.holdReasonListArray as NSArray as! [String]
            dropDown.dataSource = arr
            dropDown.show()
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
