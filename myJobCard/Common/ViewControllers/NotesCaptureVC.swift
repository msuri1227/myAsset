//
//  NotesCaptureVC.swift
//  myJobCard
//
//  Created by Ondevice Solutionson 01/04/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class NotesCaptureVC: UIViewController,UITableViewDataSource,UITableViewDelegate,viewModelDelegate {
    
    @IBOutlet var noteListView: UIView!
    @IBOutlet var noteListViewHeightConst: NSLayoutConstraint!
    @IBOutlet var noteListTableView: UITableView!
    
    @IBOutlet var noteMainView: UIView!
    @IBOutlet var noteView: UIView!
    @IBOutlet var noteTextView: UITextView!
    
    @IBOutlet var headerViewHeightConst: NSLayoutConstraint!
    @IBOutlet var headerLabel: UILabel!
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    // VariableDeclaration
    var suspendViewModel = SuspendViewModel()
    var screenType = String()

    var noteArray = [LongTextModel]()
    var woLongTextVM = woLongTextViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
        DispatchQueue.main.async {
            self.noteTextView.becomeFirstResponder()
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
    }
    func setViewLayouts(){
        ODSUIHelper.setBorderToView(view:self.noteView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.noteListTableView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
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
                self.suspendViewModel.entityDict["notes"] = entityDict
                self.suspendViewModel.validateCompletionFeatures()
            }
        }
    }
    //MARK:- UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        mJCLogger.log("Starting", Type: "info")
        let noteListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NoteListTableViewCell") as! NoteListTableViewCell
        noteListTableViewCell.backgroundColor = UIColor.blue
        let noteListClass = self.noteArray[indexPath.row]
        noteListTableViewCell.noteLabel.sizeToFit()
        noteListTableViewCell.noteLabel.numberOfLines = 0
        noteListTableViewCell.noteLabel.text = noteListClass.TextLine
        return noteListTableViewCell
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    @IBAction func noteRefreshButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        noteTextView.text = ""
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func noteCancelButtonAction(sender: AnyObject) {
        if screenType == "StatusChange"{
            self.suspendViewModel.suspendVc?.dismissViewController()
        }else{
            self.dismiss(animated: false, completion: nil)
        }
    }
    @IBAction func noteDoneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if noteTextView.text == "" {
            mJCLogger.log("Please_enter_notes".localized(), Type: "Warn")
            //.showAlert(self, title: alerttitle, message: "Please_enter_notes".localized(), button: okay)
            self.suspendViewModel.validateCompletionFeatures()
        }else {
            self.noteTextView.resignFirstResponder()
            
            if WORKORDER_ASSIGNMENT_TYPE == "1" || WORKORDER_ASSIGNMENT_TYPE == "3"{
                self.woLongTextVM.createWoLongtext(text: noteTextView.text,requiredEntity: true)
            }else{
                self.woLongTextVM.createOprLongtext(text: noteTextView.text,requiredEntity: true)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(_ sender: Any) {
    }
}
