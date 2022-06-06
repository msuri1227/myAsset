//
//  FormViewVC.swift
//  myJobCard
//
//  Created By Ondevice Solutions on 24/06/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import ODSFoundation
import FormsEngine
import mJCLib

class CheckSheetViewerVC: UIViewController,barcodeDelegate,CustomNavigationBarDelegate, WebViewHandlerDelegate,viewModelDelegate {
    
    @IBOutlet var BackButton: UIButton!
    @IBOutlet var formTitle: UILabel!
    @IBOutlet var printFormButton: UIButton!
    @IBOutlet var AttachFormButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    private var webViewHandler:WebViewHandler?
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var fromScreen = String()
    var isfromButtonAction = Bool()
    var isfromError = Bool()
    var checkSheetName = String()
    var questionImageArry = [FormQuestionImageModel]()
    var headerView = CustomNavHeader_iPhone()
    var attachmentsLoaded = true
    var formClass = FormAssignDataModel()
    var formResponseCaptureClass = FormResponseCaptureModel()
    var reviewerFormResponseClass = FormReviewerResponseModel()
    var isFromEditScreen : Bool = false
    var property = NSMutableArray()
    var attachmentArry = NSMutableArray()
    let menudropDown = DropDown()
    var dropDownString = String()
    var Formstylesheet = String()
    var Formtheme = String()
    var barcodeQuestionText = String()
    var barcodeQuestionNode = String()
    var scanedCode = String()
    var barcodeCount = Int()
    var barcodequestionDict = NSMutableDictionary()
    var delegate:formSaveDelegate?
    var createUpdateDelegate : CreateUpdateDelegate?
    var statusCategoryCls = StatusCategoryModel()
    var loadLocalCheckSheet = false
    var checkSheetViewerVM = checkSheetViewerViewModel()
    var noteArray = [LongTextModel]()
    var woLongTextVM = woLongTextViewModel()

    override func viewDidLoad() {
        mJCLogger.log("Starting", Type: "info")
        super.viewDidLoad()

        checkSheetViewerVM.delegate = self
        checkSheetViewerVM.formAssignmentType = FORM_ASSIGNMENT_TYPE
        checkSheetViewerVM.woAssigmentType = WORKORDER_ASSIGNMENT_TYPE
        checkSheetViewerVM.woObj = singleWorkOrder
        checkSheetViewerVM.oprObj = singleOperation
        checkSheetViewerVM.userId = strUser.uppercased()

        woLongTextVM.woObj = singleWorkOrder
        woLongTextVM.delegate = self
        woLongTextVM.userId = "\(strUser)".uppercased()
        self.woLongTextVM.getWoLongText()

        if DeviceType == iPad{
            formTitle.text = "\(formClass.FormID.replacingOccurrences(of: "_", with: " "))"
        }else{
            headerView = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "\(formClass.FormID.replacingOccurrences(of: "_", with: " "))", NewJobButton: true, refresButton: true, threedotmenu: true,leftMenuType:"Back")
            self.view.addSubview(headerView)
            if flushStatus == true{
                headerView.refreshBtn.showSpin()
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
            headerView.delegate = self
        }
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CheckSheetViewerVC.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CheckSheetViewerVC.backGroundSyncStarted(notification:)), name: NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
        self.createWebView()
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if self.dropDownString == "Menu"{
                if item == "Work_Orders".localized(){
                    DispatchQueue.main.async {
                        selectedworkOrderNumber = ""
                        selectedNotificationNumber = ""
                        currentMasterView = "WorkOrder"
                        let splitVC = ScreenManager.getListSplitScreen()
                        self.appDeli.window?.rootViewController = splitVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }
                }else if item == "Notifications".localized(){
                    DispatchQueue.main.async {
                        selectedworkOrderNumber = ""
                        selectedNotificationNumber = ""
                        currentMasterView = "Notification"
                        UserDefaults.standard.removeObject(forKey: "ListFilter")
                        let splitVC = ScreenManager.getListSplitScreen()
                        self.appDeli.window?.rootViewController = splitVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }
                }else if item == "Time_Sheet".localized(){
                    DispatchQueue.main.async {
                        selectedworkOrderNumber = ""
                        selectedNotificationNumber = ""
                        let timeSheetVC = ScreenManager.getTimeSheetScreen()
                        self.appDeli.window?.rootViewController = timeSheetVC
                        self.appDeli.window?.makeKeyAndVisible()
                    }
                }else if item == "Master_Data_Refresh".localized(){
                    DispatchQueue.main.async {
                        mJCLoader.startAnimating(status: "Uploading".localized())
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
                        })
                    }
                }else if item == "Asset_Map".localized(){
                    ASSETMAP_TYPE = "ESRIMAP"
                    assetmapVC.openmappage(id: "")
                }else if item == "Settings".localized(){
                    let settingsVC = ScreenManager.getSettingsScreen()
                    settingsVC.modalPresentationStyle = .fullScreen
                    self.present(settingsVC, animated: false, completion: nil)
                    
                }else if item == "Log_Out".localized(){
                    myAssetDataManager.uniqueInstance.logOutApp()
                }else if item == "Error_Logs".localized(){
                    myAssetDataManager.uniqueInstance.getFlushErrors(isFromBtn: true, count: 0)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if isCreateNotificationThroughForms == true && isFormCreatedThroughNotification == true {
            self.dismiss(animated: false) {
            }
        }
        if flushStatus == true{
            if DeviceType == iPhone{
                headerView.refreshBtn.showSpin()
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - webview Creation
    func createWebView() {
        mJCLogger.log("Starting", Type: "info")
        let webViewHandler = WebViewHandler()
        webViewHandler.delegate = self
        if DeviceType == iPad{
            let frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 100, width: self.view.frame.width, height: self.view.frame.height - 100)
            webViewHandler.webView.frame = frame
        }else{
            if screenHeight > 667{
                let frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 110, width: self.view.frame.width, height: self.view.frame.height - 70)
                webViewHandler.webView.frame = frame
            }else{
                let frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 70, width: self.view.frame.width, height: self.view.frame.height - 70)
                webViewHandler.webView.frame = frame
            }
        }
        self.view.addSubview(webViewHandler.webView)
        self.webViewHandler = webViewHandler
        var dict = [String:Any]()
        dict["fromScreen"] = fromScreen
        dict["fromError"] = isfromError
        dict["fromEdit"] = isFromEditScreen
        dict["reviewerResp"] = reviewerFormResponseClass
        dict["formResp"] = formResponseCaptureClass
        dict["formModel"] = formClass
        self.checkSheetViewerVM.getFormDetailsWithBatchRequest(options: dict)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Notification Methods
    @objc func storeFlushAndRefreshDone(notification : NSNotification) {
        if DeviceType == iPad{
            self.refreshButton.stopSpin()
        }else{
            self.headerView.refreshBtn.stopSpin()
        }
    }
    //Set form Bg sync started..
    @objc func backGroundSyncStarted(notification : Notification) {
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            self.refreshButton.showSpin()
        }else{
            self.headerView.refreshBtn.showSpin()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - view model Delegate
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "CheckSheetViewData"{
            if checkSheetViewerVM.formMasterArry.count > 0{
                self.transformForm(formDetails: checkSheetViewerVM.formMasterArry[0])
            }else{
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: somethingwrongalert, button: okay)
            }
        }else if type == "SchemaData"{
            let xmlFile = object[0] as? String ?? ""
            let checkSheetHtml = object[1] as? String ?? ""
            let checkSheetModel = object[2] as? String ?? ""
            self.xsltTransformations(xmlstr: xmlFile, formString: checkSheetHtml, modelString: checkSheetModel)
        }else if type == "WoAttachAdded"{
            if let data = object[0] as? NSData{
                mJCLoader.stopAnimating()
                DispatchQueue.main.async {
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Attachment_added_to_workorder".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            if applicationFeatureArrayKeys.contains("ATTACH_CHECKSHEET_TO_FLOC"){
                                if singleWorkOrder.FuncLocation != ""{
                                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                                    self.checkSheetViewerVM.uploadPdfToFlocAttachments(docData: data, checkSheetName: self.checkSheetName)
                                }else{
                                    if applicationFeatureArrayKeys.contains("ATTACH_CHECKSHEET_TO_EQIP"){
                                        mJCLoader.startAnimating(status: "Please_Wait".localized())
                                        self.checkSheetViewerVM.uploadPdfToEquipAttachments(docData: data, checkSheetName: self.checkSheetName)
                                    }
                                }
                            }
                        default: break
                        }
                    }
                }
                mJCLogger.log("Attachment_Added".localized(), Type: "Debug")
            }else{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Attachment_upload_fail_try_again".localized(), button: okay)
            }
        }else if type == "EquipAttachAdded"{
            if let data = object[0] as? NSData{
                mJCLoader.stopAnimating()
                DispatchQueue.main.async {
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Attachment_added_to_equipment".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:super.dismiss(animated: false, completion: nil)
                        default: break
                        }
                    }
                }
            }else{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Attachment_upload_fail_try_again".localized(), button: okay)
            }
        }else if type == "FlocAttachAdded"{
            if let data = object[0] as? NSData{
                mJCLoader.stopAnimating()
                DispatchQueue.main.async {
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Attachment_added_to_funcLocation".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            if applicationFeatureArrayKeys.contains("ATTACH_CHECKSHEET_TO_EQIP"){
                                if singleWorkOrder.EquipNum != ""{
                                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                                    self.checkSheetViewerVM.uploadPdfToEquipAttachments(docData: data, checkSheetName: self.checkSheetName)
                                }
                            }
                        default: break
                        }
                    }
                }
                mJCLogger.log("Attachment_Added".localized(), Type: "Debug")
            }else{
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Attachment_upload_fail_try_again".localized(), button: okay)
            }
        }else if type == "CheckSheetCreated"{
            let instanceId = object[0] as? String ?? ""
            let draft = object[1] as? String ?? ""
            DispatchQueue.main.async {
                if self.attachmentArry.count > 0 {
                    myAssetDataManager.uniqueInstance.uploadAllFormAttachment(formAttachmentArray: self.attachmentArry, instanceId: instanceId)
                }
            }
            if self.isfromButtonAction == true{
                DispatchQueue.main.async {
                    if DeviceType == iPad{
                        self.BackButton.isUserInteractionEnabled = true
                    }
                    mJCLoader.stopAnimating()
                    self.delegate?.formSaved(Save: true, statusCategoryCls: self.statusCategoryCls,formFrom:self.fromScreen)
                    super.dismiss(animated: true, completion: nil)
                }
            }else{
                if draft == "TRUE"{
                    mJCLogger.log("Form Saved as Draft successfully".localized(), Type: "Debug")
                    mJCLoader.stopAnimating()
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Form_Saved_successfully".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            if DeviceType == iPad{
                                self.BackButton.isUserInteractionEnabled = true
                            }
                            self.woLongTextVM.createWoLongtext(text: "Check sheet updated")
                            self.createUpdateDelegate?.EntityCreated?()
                            self.checkSheetViewerVM.getFilledCheckSheetData(formObj: self.formClass, formType: self.fromScreen, instanceId: instanceId)
                        default: break
                        }
                    }
                }else {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "setFormCountBadgeIcon"), object: "")
                    }
                    mJCLoader.stopAnimating()
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Form_Saved_successfully".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            DispatchQueue.main.async {
                                if isCreateNotificationThroughForms == true{
                                    let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                                    createNotificationVC.isFromEdit = false
                                    createNotificationVC.modalPresentationStyle = .fullScreen
                                    self.present(createNotificationVC, animated: false) {}
                                }else{
                                    super.dismiss(animated: false, completion: nil)
                                }
                            }
                        default: break
                        }
                    }
                    self.woLongTextVM.createWoLongtext(text: "Check sheet Created")
                    self.createUpdateDelegate?.EntityCreated?()
                    print("Form Saved successfully")
                    mJCLogger.log("Form Saved successfully".localized(), Type: "Debug")
                }
            }
        }else if type == "CreationFailed"{
            mJCLoader.stopAnimating()
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Fail_to_fillup_Form_try_again".localized(), button: okay)
        } else if type == "CheckSheetRespData"{
            if let respClass = object[0] as? FormResponseCaptureModel{
                self.formResponseCaptureClass = respClass
                self.isFromEditScreen = true
            }
        }else if type == "longTextFetch"{
            if let textArr = object as? [LongTextModel]{
                self.noteArray = textArr
            }
        }else if type == "longTextCreated"{
            self.woLongTextVM.getWoLongText()
        }
    }
    //MARK: - PDF Methods
    func ConvertHtmlToPdf(isfrom:String){
        mJCLogger.log("Starting", Type: "info")
        let pdfData = createPdfFile(printFormatter: self.webViewHandler!.webView.viewPrintFormatter())
        do {
            let fileURL = try! myAsset.fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Forms/\(checkSheetName).pdf")
            try pdfData.write(to: fileURL)
            if isfrom == "Attach"{
                if applicationFeatureArrayKeys.contains("ATTACH_CHECKSHEET_TO_WO"){
                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                    self.checkSheetViewerVM.uploadPdfToWoAttachments(docData: pdfData, checkSheetName: checkSheetName)
                }else if applicationFeatureArrayKeys.contains("ATTACH_CHECKSHEET_TO_FLOC"){
                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                    if singleWorkOrder.FuncLocation != ""{
                        self.checkSheetViewerVM.uploadPdfToFlocAttachments(docData: pdfData, checkSheetName: checkSheetName)
                    }else{
                        if applicationFeatureArrayKeys.contains("ATTACH_CHECKSHEET_TO_EQIP"){
                            if singleWorkOrder.EquipNum != ""{
                                self.checkSheetViewerVM.uploadPdfToEquipAttachments(docData: pdfData, checkSheetName: checkSheetName)
                            }
                        }
                    }
                }else if applicationFeatureArrayKeys.contains("ATTACH_CHECKSHEET_TO_EQIP"){
                    mJCLoader.startAnimating(status: "Please_Wait".localized())
                    if singleWorkOrder.EquipNum != ""{
                        self.checkSheetViewerVM.uploadPdfToEquipAttachments(docData: pdfData, checkSheetName: checkSheetName)
                    }
                }
            }else if isfrom == "Print"{
                handlePrinter(stringL: "\(fileURL)")
            }else{
                self.savePDF(data: pdfData)
            }
            mJCLogger.log("Ended", Type: "info")
        } catch {
            mJCLogger.log("Pdf Error \(error)", Type: "Error")
            mJCLogger.log("Ended", Type: "info")
        }
    }
    func savePDF(data:NSData) {
        mJCLogger.log("Starting", Type: "info")
        let activityController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.printFormButton
        activityController.excludedActivityTypes = [.postToFacebook,.postToTwitter,.postToWeibo,.message,.mail,.copyToPasteboard,.assignToContact,.saveToCameraRoll,.addToReadingList,.postToVimeo,.postToVimeo,.postToTencentWeibo,.airDrop,.openInIBooks,.markupAsPDF]
        self.present(activityController, animated: true, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Button Actions
    @IBAction func printFormButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.ConvertHtmlToPdf(isfrom: "Print")
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func AttachFormButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.ConvertHtmlToPdf(isfrom: "Attach")
        mJCLogger.log("Ended", Type: "info")
    }
    func transformForm(formDetails: FormMasterModel){
        
        var formString = String()
        var modelString = String()
        
        self.Formtheme = formDetails.Theme
        self.Formstylesheet =  formDetails.Stylesheet
        let formData = Data(fromHexEncodedString: formDetails.FormData)!
        let xmlstr = String(data: formData, encoding: .utf8) ?? ""
        if (xmlstr.contains(find: "barcode")){
            self.barcodeCount = (xmlstr.countInstances(of: "barcode"))
        }
        if(xmlstr.contains(find: "mjc_$")){
            let formModel = Data(fromHexEncodedString: formDetails.FormModel)!
            let list1 = ODSXMLReader().parseXMl(formModel) as! Array<String>
            modelString = String(data: formModel, encoding: .utf8) ?? ""

            let formHtml = Data(fromHexEncodedString: formDetails.FormHTML)!
            formString = String(data: formHtml, encoding: .utf8) ?? ""

            self.checkSheetViewerVM.getSchemaData(list: list1, count: 0, xmlFile: "", checkSheetModel : modelString, checkSheetHtml: formString)
        }else if  formDetails.FormHTML != "" && formDetails.FormModel != "" && loadLocalCheckSheet == false{
            let formHtml = Data(fromHexEncodedString: formDetails.FormHTML)!
            formString = String(data: formHtml, encoding: .utf8) ?? ""
            let formModel = Data(fromHexEncodedString: formDetails.FormModel)!
            modelString = String(data: formModel, encoding: .utf8) ?? ""
            self.xsltTransformations(xmlstr: xmlstr, formString: formString , modelString: modelString)
        }else if formDetails.FormData != ""{
//            formString =  XSLTtransform().transformXmltoHtml("html", xmlfile: xmlstr, loadLocal: loadLocalCheckSheet)
//            modelString = XSLTtransform().transformXmltoHtml("model", xmlfile: xmlstr, loadLocal: loadLocalCheckSheet)
//            self.xsltTransformations(xmlstr: xmlstr, formString: formString , modelString: modelString)
        }else{
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Form_Data_not_found".localized(), button: okay)
            return
        }
    }
    func xsltTransformations(xmlstr: String,formString:String,modelString:String) {
        mJCLogger.log("Starting", Type: "info")
        var formstring = formString
        var modelstring = modelString
        if isFromEditScreen ==  true{
            if  fromScreen == "Reviewer" {
                modelstring = ODSXMLReader().hex(to: self.reviewerFormResponseClass.ResponseData)
            }else{
                modelstring = ODSXMLReader().hex(to: self.formResponseCaptureClass.ResponseData)
            }
            modelstring = modelstring.replacingOccurrences(of: "<data x", with: "<model xmlns=\"http://www.w3.org/2002/xforms\"><instance><data x")
            modelstring = modelstring.replacingOccurrences(of: "</data>", with: "</data></instance></model>")
        }
        DispatchQueue.main.async{
            if DeviceType == iPad{
                self.printFormButton.isHidden = true
                self.AttachFormButton.isHidden = true
            }
        }
        var draft = String()
        if self.formResponseCaptureClass.IsDraft == "X"{
            draft = "X"
        }else if self.formResponseCaptureClass.IsDraft != "X" && self.formResponseCaptureClass.ResponseData == ""{
            if isfromButtonAction == true{
                draft = "ButtonAction"
            }else{
                draft = "NO"
            }
        }else{
            draft = ""
            DispatchQueue.main.async{
                if DeviceType == iPhone{
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
                }else{
                    self.printFormButton.isHidden = false
                    self.AttachFormButton.isHidden = false
                }
            }
        }
        if formstring != ""{
            if self.questionImageArry.count > 0{
                for item in self.questionImageArry{
                    if formstring.contains(find: item.FileName){
                        formstring = formstring.replacingOccurrences(of: item.FileName, with: "data:\(item.MediaType);base64,\(item.Base64)")
                    }
                }
            }
        }
        var dict = [String:Any]()
        dict["StyleSheet"] = self.Formstylesheet
        dict["Theme"] = self.Formtheme
        dict["SaveDraft"] = "Save_As_Draft".localized()
        dict["Save"] = "Save".localized()
        var jsUpdateRequired = false
        if (UserDefaults.standard.value(forKey:"JsUpdate") != nil){
            jsUpdateRequired = true
            UserDefaults.standard.removeObject(forKey: "JsUpdate")
        }
        dict["DeleteJs"] = jsUpdateRequired
        if fromScreen == "Reviewer" {
            checkSheetName = "\(reviewerFormResponseClass.WoNum)_\(reviewerFormResponseClass.FormID)_\(reviewerFormResponseClass.Version)"
            dict["fromEdit"] = ""
            dict["FileName"] = checkSheetName
        }else {
            if singleWorkOrder.WorkOrderNum == ""{
                checkSheetName = "\(formClass.FormID)_\(formClass.Version)"
            }else{
                checkSheetName = "\(singleWorkOrder.WorkOrderNum)_\(formClass.FormID)_\(formClass.Version)"
            }
            dict["fromEdit"] = draft
            dict["FileName"] = checkSheetName
        }

        formstring = formstring.trimmingCharacters(in: .whitespacesAndNewlines)
        formstring = formstring.replacingOccurrences(of: "\n", with: "")
        formstring = formstring.replacingOccurrences(of: "\r", with: "")
        formstring = formstring.replacingOccurrences(of:" /", with: "/")
        formstring = formstring.replacingOccurrences(of:" \"", with: "\"")
        formstring = formstring.replacingOccurrences(of:" '", with: "'")
        formstring = formstring.replacingOccurrences(of:"&lt;", with: "<")
        formstring = formstring.replacingOccurrences(of:"&gt;", with: ">")

        modelstring = modelstring.replacingOccurrences(of: "\"", with: "\\\"")
        modelstring = modelstring.trimmingCharacters(in: .whitespacesAndNewlines)
        modelstring = modelstring.replacingOccurrences(of: "\n", with: "")
        modelstring = modelstring.replacingOccurrences(of:"  ", with: "")
        modelstring = modelstring.replacingOccurrences(of: "\r", with: "")


        dict["Form"] = formstring
        dict["FormModel"] = modelstring
        let formhtmlDict = HtmlHelper.convertFormIntoHtml(options: dict)
        if let error = formhtmlDict["error"] as? Bool{
            if error == false{
                let htmlStr = formhtmlDict["Html"] as? String ?? ""
                self.loadHTML(htmlStr)
            }else{
                mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Form_Data_not_found".localized(), button: okay)
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    private func loadHTML(_ file: String) {
        mJCLogger.log("Starting", Type: "info")
        guard let webViewHandler = webViewHandler else {return}
        let url = NSURL(fileURLWithPath: documentPath)
        let filePath = url.appendingPathComponent("Forms/\(checkSheetName).html")
        let html = try? String(contentsOfFile: filePath?.path ?? "", encoding: String.Encoding.ascii)
        if html != nil{
            DispatchQueue.main.async{
                let request = URLRequest(url: filePath!)
                webViewHandler.load(request)
            }
        }else{
            mJCLoader.stopAnimating()
            mJCAlertHelper.showAlert(self, title: MessageTitle, message: "Something_went_wrong_please_try_again".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }

    // MARK: - Methods called form JS
    func MediaData(_ filename: String,_ content :String,_ size:String,_ type :String,_ questionText : String){
        mJCLogger.log("Starting", Type: "info")

        let property = NSMutableArray()
        var prop : SODataProperty! = SODataPropertyDefault(name: "InstanceId")
        prop!.value = "" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FormId")
        prop!.value = "\(self.formClass.FormID)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Version")
        prop!.value = "\(self.formClass.Version)" as NSObject
        property.add(prop!)
        
        let counter = String.random(length: 4, type: "Number")
        prop = SODataPropertyDefault(name: "AttachCounter")
        prop!.value = "\(counter)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "FileName")
        prop!.value = "\(filename)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "Description")
        prop!.value = "\(filename)" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "MIMETYPE")
        prop!.value = "application/x-doctype" as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ObjectNum")
        prop!.value = singleWorkOrder.WorkOrderNum as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "OperationNum")
        prop!.value = selectedOperationNumber as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "ImageData")
        if content.contains(find: "base64,"){
            let str = content.components(separatedBy: "base64,")
            prop!.value = str[1] as NSObject
            property.add(prop!)
        }else{
            prop!.value = content as NSObject
            property.add(prop!)
        }
        
        prop = SODataPropertyDefault(name: "CreatedOn")
        prop!.value = Date().localDate() as NSObject
        property.add(prop!)
        
        prop = SODataPropertyDefault(name: "CreatedBy")
        prop!.value = userPersonnelNo as NSObject
        property.add(prop!)
        
        attachmentArry.add(property);
        mJCLogger.log("Ended", Type: "info")
    }
    func filledFormData(_ filledform: String,_ instanceID : String,_ Draft: String){
        
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Saving_form".localized())
        var form = filledform
        
        let barcodekeys = barcodequestionDict.allKeys
        for key in barcodekeys{
            if form.contains(find: "<\(key)/>"){
                form =  form.replacingOccurrences(of: "<\(key)/>", with: "<\(key)>\(barcodequestionDict.value(forKey: key as! String)!)</\(key)>")
            }
        }
        let hexString = ODSXMLReader().string(toHex: form)
        if form.contains(find: "<mjc_create_notification>X</mjc_create_notification>"){
            isCreateNotificationThroughForms = true
            if formClass.PostNotification == true {
                if formResponseCaptureClass.IsDraft == "X" || formResponseCaptureClass.ResponseData != "" {
                    self.UpdateFormData(XMLString: hexString!, instanceId: instanceID, Draft: Draft)
                }else{
                    self.createNewForm(XMLString: hexString!, instanceId: instanceID, Draft: Draft)
                }
            }else{
                let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                createNotificationVC.isFromEdit = false
                createNotificationVC.modalPresentationStyle = .fullScreen
                self.present(createNotificationVC, animated: false) {}
            }
        }else{
            isCreateNotificationThroughForms = false
            if formResponseCaptureClass.IsDraft == "X" || formResponseCaptureClass.ResponseData != "" {
                self.UpdateFormData(XMLString: hexString!, instanceId: instanceID, Draft: Draft)
            }else{
                self.createNewForm(XMLString: hexString!, instanceId: instanceID, Draft: Draft)
            }
        }
        if DeviceType == iPad{
            DispatchQueue.main.async {
                self.BackButton.isUserInteractionEnabled = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Open Barcode ..
    func openBarCodeScaner(_ QuestionText: String){
        mJCLogger.log("Starting", Type: "info")
        let QTextArr = QuestionText.components(separatedBy: "/") as NSArray
        barcodeQuestionNode = QuestionText
        barcodeQuestionText = QTextArr.lastObject as! String
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "checksheet", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            mJCLogger.log("Starting", Type: "info")
            DispatchQueue.main.async{
                let str = "$(\"input[name=\'\(self.barcodeQuestionNode)\']\").val(\"\(barCode)\");" as String
                self.webViewHandler?.callJavascript(javascriptString: str, callback: { success,result in
                })
            }
            scanedCode = barCode;
            barcodequestionDict.setObject(scanedCode, forKey: barcodeQuestionText as NSCopying)
            self.dismiss(animated: true, completion: nil)
            mJCLogger.log("Ended", Type: "info")
        }
    }
    //MARK: - Saving And update CheckSheet
    func createNewForm(XMLString : String,instanceId: String, Draft: String) {
        var dict = [String:Any]()
        dict["fromScreen"] = fromScreen
        dict["userID"] = strUser.uppercased()
        dict["fromEdit"] = Draft
        dict["XMLString"] = XMLString
        dict["formModel"] = formClass
        dict["attachmentArry"] = attachmentArry
        self.checkSheetViewerVM.createNewForm(options: dict)
        mJCLogger.log("Ended", Type: "info")
    }
    func UpdateFormData(XMLString : String,instanceId: String, Draft: String){

        mJCLogger.log("Starting", Type: "info")

        let formclass = self.formResponseCaptureClass

        (formclass.entity.properties["ResponseData"] as! SODataProperty).value = "\(XMLString)" as NSObject
        self.formResponseCaptureClass.ResponseData = "\(XMLString)"
        if Draft != "TRUE"{
            (formclass.entity.properties["IsDraft"] as! SODataProperty).value = "" as NSObject
        }
        (formclass.entity.properties["ModifiedOn"] as! SODataProperty).value = Date().localDate() as NSObject
        var flushReq = Bool()
        if self.attachmentArry.count > 0 {
            flushReq = false
        }else{
            flushReq = true
        }
        FormResponseCaptureModel.updateResponseCaptureEntry(entity: formclass.entity, flushRequired: flushReq,options: nil, completionHandler: { (response, error) in
            if(error == nil) {
                DispatchQueue.main.async {
                    mJCLoader.stopAnimating()
                    mJCLogger.log("Form Updated successfully".localized(), Type: "Debug")
                    self.createUpdateDelegate?.EntityCreated?()
                    let params = Parameters(
                        title: MessageTitle,
                        message: "Form_Saved_successfully".localized(),
                        cancelButton: okay
                    )
                    mJCAlertHelper.showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            if Draft == "TRUE"{
                                DispatchQueue.main.async {
                                    if self.attachmentArry.count > 0 {
                                        myAssetDataManager.uniqueInstance.uploadAllFormAttachment(formAttachmentArray: self.attachmentArry, instanceId: formclass.InstanceID)
                                    }
                                    if DeviceType == iPad{
                                        DispatchQueue.main.async {
                                            self.BackButton.isUserInteractionEnabled = true
                                        }
                                    }
                                    self.checkSheetViewerVM.getFilledCheckSheetData(formObj: self.formClass, formType: self.fromScreen, instanceId: self.formResponseCaptureClass.InstanceID)
                                }
                            }else{
                                DispatchQueue.main.async {
                                    if isCreateNotificationThroughForms == true{
                                        let createNotificationVC = ScreenManager.getCreateNotificationScreen()
                                        createNotificationVC.isFromEdit = false
                                        createNotificationVC.modalPresentationStyle = .fullScreen
                                        self.present(createNotificationVC, animated: false) {}
                                    }else{
                                        super.dismiss(animated: false, completion: nil)
                                    }
                                }
                            }
                        default: break
                        }
                    }
                }
            }else{
                if DeviceType == iPad{
                    DispatchQueue.main.async {
                        self.BackButton.isUserInteractionEnabled = true
                    }
                }
                mJCLoader.stopAnimating()
                mJCLogger.log(" Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                mJCAlertHelper.showAlert(self, title: alerttitle, message: "Failed_to_update_form_please_try_again".localized(), button: okay)
            }
        })
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Js handler ..
    func didReceiveMessage(message: Any) {
        mJCLogger.log("Starting", Type: "info")
        if let messageDictionary = message as? [String:AnyObject] {
            if let msgfrom = messageDictionary["isfrom"] as? String{
                if msgfrom == "barcode"{
                    if let Quetiontext = messageDictionary["QuestionText"] as? String{
                        self.openBarCodeScaner(Quetiontext)
                    }
                }else if msgfrom == "formSave" || msgfrom == "formDraft"{
                    var filledForm = String()
                    var insranceID = String()
                    var Draft = String()
                    if let filledform = messageDictionary["filledform"] as? String{
                        filledForm = filledform
                    }
                    if let instanceId = messageDictionary["instanceID"] as? String{
                        insranceID = instanceId
                    }
                    if let draft = messageDictionary["Draft"] as? String{
                        Draft = draft
                    }
                    self.filledFormData(filledForm, insranceID, Draft)
                }else if msgfrom == "formAttach"{
                    var fileName = String()
                    var fileContent = String()
                    var fileSize = String()
                    var fileType = String()
                    var QuestionText = String()
                    if let filename = messageDictionary["filename"] as? String{
                        fileName = filename
                    }
                    if let content = messageDictionary["content"] as? String{
                        fileContent = content
                    }
                    if let size = messageDictionary["size"] as? String{
                        fileSize = size
                    }
                    if let type = messageDictionary["type"] as? String{
                        fileType = type
                    }
                    if let questiontext = messageDictionary["QuestionText"] as? String{
                        QuestionText = questiontext
                    }
                    self.MediaData(fileName, fileContent, fileSize, fileType, QuestionText)
                }else if msgfrom == "AttachementBinded"{
                    mJCLoader.stopAnimating()
                }else if msgfrom == "AttachementBinded"{
                    mJCLoader.stopAnimating()
                }else if msgfrom == "FormLoaded"{
                    if self.isFromEditScreen == true && self.checkSheetViewerVM.checkSheetAttachArray.count > 0{
                        do {
                            if let theJSONData = try? JSONSerialization.data(
                                withJSONObject: self.checkSheetViewerVM.checkSheetAttachArray,
                                options: []) {
                                let theJSONText = String(data: theJSONData,
                                                         encoding: .ascii)
                                let str = "setformAttachments('\(theJSONText!)')"
                                DispatchQueue.main.async{
                                    self.attachmentsLoaded = false
                                    self.webViewHandler?.callJavascript(javascriptString: str, callback: { success,result in
                                    })
                                }
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                    }else{
                        mJCLoader.stopAnimating()
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func didReceiveParameters(parameters: [String : Any]) {

    }
    //MARK: - Menu Button Actions
    @IBAction func BackButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        super.dismiss(animated: false, completion: nil)
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func HomeButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        singleWorkOrder = WoHeaderModel()
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        currentMasterView = "Dashboard"
        let dashboard = ScreenManager.getDashBoardScreen()
        self.appDeli.window?.rootViewController = dashboard
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func MenuButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if isSupervisor == "X"{
            menuarr = ["Supervisor_View".localized(),"Team".localized(),"Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(),"Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "SupervisorView"),#imageLiteral(resourceName: "TeamSupView"),#imageLiteral(resourceName: "WorkNotSM1"),#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
        }else{
            menuarr = ["Work_Orders".localized(),"Notifications".localized(), "Master_Data_Refresh".localized(),"Asset_Map".localized(),"Error_Logs".localized(),"Settings".localized(), "Log_Out".localized()]
            imgArray = [#imageLiteral(resourceName: "WorkNotSM1"),#imageLiteral(resourceName: "ic_notification"),#imageLiteral(resourceName: "ic_transmit_black"),#imageLiteral(resourceName: "AssetMapSM"),#imageLiteral(resourceName: "PendingNF"),#imageLiteral(resourceName: "SettingsSupView1"),#imageLiteral(resourceName: "LogOutBlack")]
        }
        if applicationFeatureArrayKeys.count > 0{
            if !applicationFeatureArrayKeys.contains("DASH_ASSET_HIE_TILE"){
                if let index =  menuarr.firstIndex(of: "Asset_Map".localized()){
                    menuarr.remove(at: index)
                    imgArray.remove(at: index)
                }
            }
        }
        menudropDown.dataSource = menuarr
        customizeDropDown(imgArry: imgArray)
        menudropDown.anchorView = sender as! UIButton
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        self.dropDownString = "Menu"
        menudropDown.show()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func RefreshButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func MapButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        currentMasterView = "MapSplitViewController"
        selectedworkOrderNumber = ""
        selectedNotificationNumber = ""
        ASSETMAP_TYPE = ""
        let mapSplitVC = ScreenManager.getMapSplitScreen()
        self.appDeli.window?.rootViewController = mapSplitVC
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func CreateNewJobButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                let createNewJobVC = ScreenManager.getCreateJobScreen()
                createNewJobVC.isFromEdit = false
                createNewJobVC.isScreen = "WorkOrder"
                createNewJobVC.modalPresentationStyle = .fullScreen
                self.present(createNewJobVC, animated: false) {}
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func customizeDropDown(imgArry: [UIImage]) {
        mJCLogger.log("Starting", Type: "info")
        menudropDown.showImage = true
        menudropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownWithImageCell else { return }
            cell.logoImageView.image = imgArry[index]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
        self.dismiss(animated: false, completion: nil)
        super.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.CreateNewJobButtonAction(UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.RefreshButtonAction(UIButton())
        mJCLogger.log("Ended", Type: "info")
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){
        var menuarr = [String]()
        var imgArray = [UIImage]()
        if self.formResponseCaptureClass.IsDraft == "X"{
        }else if self.formResponseCaptureClass.IsDraft != "X" && self.formResponseCaptureClass.ResponseData == ""{
        }else{
            if DeviceType == iPhone{
                menuarr = ["Print_Form".localized(),"Attach_Form".localized()]
                imgArray = [#imageLiteral(resourceName: "ic_printe_black"),#imageLiteral(resourceName: "AttachementsNF")]
            }
        }
        if menuarr.count == 0{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "No_Options_Available".localized(), button: okay)
        }
        menudropDown.dataSource = menuarr
        customizeDropDown(imgArry: imgArray)
        menudropDown.anchorView = sender
        menudropDown.cellHeight = 40.0
        menudropDown.width = 200.0
        menudropDown.backgroundColor = UIColor.white
        menudropDown.textColor = appColor
        menudropDown.show()
        menudropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "Print_Form".localized() {
                self.ConvertHtmlToPdf(isfrom: "Print")
            }else if item == "Attach_Form".localized() {
                self.ConvertHtmlToPdf(isfrom: "Attach")
            }
        }
    }
    override func dismiss(animated flag: Bool, completion: (() -> Void)?){
        mJCLogger.log("Starting", Type: "info")
        if self.presentedViewController != nil {
            super.dismiss(animated: flag, completion: completion)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - PDF converter
    func createPdfFile(printFormatter: UIViewPrintFormatter) -> NSData {
        mJCLogger.log("Starting", Type: "info")
        let renderer = UIPrintPageRenderer()
        renderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        let pdfPageFrame = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = pdfPageFrame.insetBy(dx: 0, dy: 20)
        renderer.setValue(pdfPageFrame, forKey: "paperRect")
        renderer.setValue(printable, forKey: "printableRect")
        mJCLogger.log("Ended", Type: "info")
        return renderer.printToPDF()
    }
    //MARK: - Printer Methods
    func handlePrinter(stringL: String){
        mJCLogger.log("Starting", Type: "info")
        let pdfPath = URL(string: stringL)
        if UIPrintInteractionController.canPrint(pdfPath!) {
            let printInfo = UIPrintInfo(dictionary: nil)
            printInfo.jobName = pdfPath!.lastPathComponent
            printInfo.outputType = .photo
            let printController = UIPrintInteractionController.shared
            printController.printInfo = printInfo
            printController.showsNumberOfCopies = false
            printController.printingItem = pdfPath
            printController.present(animated: true, completionHandler: nil)
            mJCLogger.log("Ended", Type: "info")
        }
    }
    func backButtonClicked(_ sender: UIButton?){}
}
