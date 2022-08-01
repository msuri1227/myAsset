//
//  LongTextListVC.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/10/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class LongTextListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIGestureRecognizerDelegate ,viewModelDelegate{
    
    //MARK:- Outlets..
    @IBOutlet var backButton: UIButton!
    @IBOutlet var headerView: UIView!
    @IBOutlet var noteListView: UIView!
    @IBOutlet var noteListTableView: UITableView!
    @IBOutlet weak var noteSaveBtn: UIButton!
    @IBOutlet weak var prevNoteLabel: UILabel!
    
    //AddNewNoteView Outlets..
    @IBOutlet var addNewNoteView: UIView!
    @IBOutlet var noteTextViewView: UIView!
    @IBOutlet var noteTaxtView: UITextView!
    @IBOutlet var noNoteLabel: UILabel!
    
    //FooterButtonView Outlets..
    @IBOutlet var footerButtonView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    
    @IBOutlet var speakOutButton: UIButton!
    @IBOutlet weak var MainScrollView: UIScrollView!

    
    //MARK: - Variable Declaration..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var fromScreen = String()
    var keyBoardHeight = CGFloat()
    var isAddNewNote = Bool()
    var woNum = String()
    var compObj = WoComponentModel()
    var noteArray = [LongTextModel]()
    var itemNum = String()
    var activityNum = String()
    var taskNum = String()
    var itemCause = String()
    var woLongTextVM = woLongTextViewModel()
    var noLongTextVM = noLongTextViewModel()

    //MARK: - LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")

        self.noteTaxtView.delegate = self
        if currentMasterView == "WorkOrder"{
            woLongTextVM.delegate = self
            woLongTextVM.userId = "\(strUser)".uppercased()
        }else{
            noLongTextVM.delegate = self
            noLongTextVM.userId = "\(strUser)".uppercased()
        }

        self.setViewLayouts()
        self.getLongText()

        let tap = UITapGestureRecognizer(target: self, action: #selector(LongTextListVC.handleTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        if DeviceType == iPad{
            NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification,object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(LongTextListVC.textToSpeechEnded(notification:)), name:NSNotification.Name(rawValue:"textToSpeechEnded"), object: nil)
        mJCLogger.log("Starting", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Starting", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func getLongText(){

        if currentMasterView == "WorkOrder"{
            woLongTextVM.woObj = singleWorkOrder
            woLongTextVM.oprObj = singleOperation
        }else{
            noLongTextVM.noObj = singleNotification
        }
        switch fromScreen{
        case "woOverView": self.woLongTextVM.getWoLongText()
        case "woOverViewOnline":
            self.noteSaveBtn.isHidden = true
            self.backButton.setTitle("Back".localized(), for: .normal)
            self.woLongTextVM.getWoLongText()
        case "woOperation":
            if singleOperation.SubOperation == ""{
                self.woLongTextVM.getOprLongText()
            }else{
                self.woLongTextVM.getSubOprLongText()
            }
        case "woOperationOnline":
            self.noteSaveBtn.isHidden = true
            self.backButton.setTitle("Back".localized(), for: .normal)
            self.woLongTextVM.getWoLongText()
        case "woComponent":
            self.woLongTextVM.woObj.WorkOrderNum = self.woNum
            self.woLongTextVM.compObj  = self.compObj
            self.woLongTextVM.getWoComponentLongtext()
        case "woHistoryPending": self.woLongTextVM.getWoLongText()

        case "noOverView": self.noLongTextVM.getNoLongText()
        case "noOverViewOnline":
            self.noteSaveBtn.isHidden = true
            self.backButton.setTitle("Back".localized(), for: .normal)
        case "noItem": self.noLongTextVM.getItemLongText(itemNum: itemNum)
        case "noItemTask": self.noLongTextVM.getTaskText(itemNum: itemNum, taskNum: taskNum)
        case "noItemActivity": self.noLongTextVM.getActivityLongText(itemNum: itemNum, activityNum: activityNum)
        case "noItemCause": self.noLongTextVM.getItemCauseLongtext(itemNum: itemNum, itemCause: itemCause)
        case "noTask": self.noLongTextVM.getTaskText(taskNum: taskNum)
        case "noActivity": self.noLongTextVM.getActivityLongText(activityNum: activityNum)
        case "woNoOverView": self.noLongTextVM.woNotification = true
            self.noLongTextVM.getNoLongText()
        case "woNoItem":
            self.noLongTextVM.woNotification = true
            self.noLongTextVM.getItemLongText(itemNum: itemNum)
        case "woNoItemTask":
            self.noLongTextVM.woNotification = true
            self.noLongTextVM.getTaskText(itemNum: itemNum, taskNum: taskNum)
        case "woNoItemActivity":
            self.noLongTextVM.woNotification = true
            self.noLongTextVM.getActivityLongText(itemNum: itemNum, activityNum: activityNum)
        case "woNoTask":
            self.noLongTextVM.woNotification = true
            self.noLongTextVM.getTaskText(taskNum: taskNum)
        case "woNoActivity":
            self.noLongTextVM.woNotification = true
            self.noLongTextVM.getActivityLongText( activityNum: activityNum)
        case "woNoItemCause":
            self.noLongTextVM.woNotification = true
            self.noLongTextVM.getItemCauseLongtext(itemNum: itemNum, itemCause: itemCause)
        case "noHistoryPending":self.noLongTextVM.getNoLongText()
        default:
            print("Filter Not Found")
        }
    }
    func createLongText(text:String){

        woLongTextVM.woObj = singleWorkOrder
        woLongTextVM.oprObj = singleOperation
        print(fromScreen)
        switch fromScreen{
        case "woOverView": self.woLongTextVM.createWoLongtext(text: text)
        case "woOperation":
            if singleOperation.SubOperation == ""{
                self.woLongTextVM.createOprLongtext(text: text)
            }else{
                self.woLongTextVM.createSubOprLongtext(text: text)
            }
        case "woComponent": self.woLongTextVM.createCompLongtext(text: text)

        case "noOverView": self.noLongTextVM.createNoLongtext(text: text)
        case "noItem": self.noLongTextVM.createItemLongtext(itemNum: self.itemNum, text: text)
        case "noItemTask","noTask": self.noLongTextVM.createTaskLongtext(itemNum: self.itemNum, taskNum: self.taskNum, text: text)
        case "noItemActivity","noActivity": self.noLongTextVM.createActivityLongtext(itemNum: self.itemNum, activityNum: self.activityNum, text: text)
        case "noItemCause": self.noLongTextVM.createItemCauseLongtext(itemNum: self.itemNum, itemCause: self.itemCause, text: text)

        case "woNoOverView": self.noLongTextVM.woNotification = true
            self.noLongTextVM.createNoLongtext(text: text)
        case "woNoItem": self.noLongTextVM.woNotification = true
            self.noLongTextVM.createItemLongtext(itemNum: self.itemNum, text: text)
        case "woNoItemTask","woNoTask": self.noLongTextVM.woNotification = true
            self.noLongTextVM.createTaskLongtext(itemNum: self.itemNum, taskNum: self.taskNum, text: text)
        case "woNoItemActivity","woNoActivity": self.noLongTextVM.woNotification = true
            self.noLongTextVM.createActivityLongtext(itemNum: self.itemNum, activityNum: self.activityNum, text: text)
        case "woNoItemCause": self.noLongTextVM.woNotification = true
            self.noLongTextVM.createItemCauseLongtext(itemNum: self.itemNum, itemCause: self.itemCause, text: text)
        default:
            print("Filter Not Found")
        }
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "longTextFetch"{
            if let textArr = object as? [LongTextModel]{
                self.noteArray = textArr
            }
        }else if type == "longTextCreated"{
            self.getLongText()
        }
        DispatchQueue.main.async {
            if self.noteArray.count == 0{
                self.noteListView.isHidden = true
                self.noNoteLabel.isHidden = false
            }else{
                self.noNoteLabel.isHidden = true
                self.noteListView.isHidden = false
                self.noteListTableView.reloadData()
            }
        }
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyBoardHeight = keyboardRectangle.height
        }
    }
    @objc func keyboardWillHide(notification:NSNotification) {
        keyBoardHeight = 0
    }
    //MARK: - UITapGesture Recognizer..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        mJCLogger.log("Starting", Type: "info")
        self.noteTaxtView.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - UITableView Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        mJCLogger.log("Starting", Type: "info")
        let noteListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NoteListTableViewCell") as! NoteListTableViewCell
        let noteListClass = self.noteArray[indexPath.row]
        noteListTableViewCell.noteListClass = noteListClass
        mJCLogger.log("Starting", Type: "info")
        return noteListTableViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //MARK: - UITextView Delegate..
    func textViewDidBeginEditing(_ textView: UITextView) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Ended", Type: "info")
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func backButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        ReadAndWriteModelclass.uniqueInstance.stopspeaking()
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Footer Button Action..
    @IBAction func doneButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        noteTaxtView.resignFirstResponder()
        if noteTaxtView.text!.isEmpty || noteTaxtView.text == ""{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_note".localized(), button: okay)
        }else{
            let text = noteTaxtView.text?.trimmingCharacters(in: CharacterSet.whitespaces)
            if text == ""{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_note".localized(), button: okay)
            }else{
                if self.noteTaxtView.text.count > 0{
                    self.createLongText(text: noteTaxtView.text)
                    self.noteTaxtView.text = ""
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        noteTaxtView.resignFirstResponder()
        ReadAndWriteModelclass.uniqueInstance.stopspeaking()
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func refreshButtonAction(sender: AnyObject){
        mJCLogger.log("Starting", Type: "info")
        self.noteTaxtView.text = ""
        mJCLogger.log("Ended", Type: "info")
    }
    func setViewLayouts() {
        ODSUIHelper.setBorderToView(view:self.noteTextViewView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view: self.noteTextViewView, borderWidth: 2.0)
        self.noteListTableView.separatorStyle = .none
        self.noteListTableView.estimatedRowHeight = 40.0
        self.noteListTableView.rowHeight = UITableView.automaticDimension
        self.noteListTableView.bounces = false
    }
    @IBAction func speakOutButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        if self.speakOutButton.titleLabel?.text == "Read_Out".localized(){
            self.speakOutButton.setTitle("Stop".localized(), for: .normal)
            self.speakOutButton.setTitleColor(UIColor.red, for: .normal)
            self.speakOutButton.setImage(UIImage(named:"ic_close"), for: .normal)
            var readstring = String()
            for item in self.noteArray{
                readstring += item.TextLine + "\n"
            }
            ReadAndWriteModelclass.uniqueInstance.ReadText(text: readstring)
        }else if self.speakOutButton.titleLabel?.text == "Stop".localized(){
            self.speakOutButton.setTitle("Read_Out".localized(), for: .normal)
            self.speakOutButton.setTitleColor(appColor, for: .normal)
            self.speakOutButton.setImage(UIImage(named:"ic_speaker"), for: .normal)
            ReadAndWriteModelclass.uniqueInstance.stopspeaking()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func textToSpeechEnded(notification: NSNotification) {
        mJCLogger.log("Starting", Type: "info")
        self.speakOutButton.setTitle("Read_Out".localized(), for: .normal)
        self.speakOutButton.setTitleColor(appColor, for: .normal)
        self.speakOutButton.setImage(UIImage(named:"ic_speaker"), for: .normal)
        mJCLogger.log("Ended", Type: "info")
    }
}
