//
//  AssetDetailsVC.swift
//  myAsset
//  Created by Mangi Reddy on 08/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class AssetDetailsVC: UIViewController, viewModelDelegate, barcodeDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var segmentBgView: UIView!
    @IBOutlet weak var assestSegment: UISegmentedControl!
    @IBOutlet weak var assetTableView: UITableView!
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var noDataLblView: UIView!
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var selectedLbl: UILabel!
    @IBOutlet weak var selectedStackView: UIStackView!
    @IBOutlet weak var tblViewBottomConst: NSLayoutConstraint!
    @IBOutlet weak var scanBtnWidthConst: NSLayoutConstraint!
    @IBOutlet weak var barCodeScanBtn: UIButton!
    
    @IBOutlet weak var writeOffBgView: UIView!
    @IBOutlet weak var notesDoneBtn: UIButton!
    @IBOutlet weak var noteTextViewBgView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var notesCancelBtn: UIButton!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var objmodel = WorkOrderObjectsViewModel()
    var inspectedArr = [WorkorderObjectModel]()
    var inspectedListArr = [WorkorderObjectModel]()
    var selectedAssetListArr = [WorkorderObjectModel]()
    var attachmentsViewModel = AttachmentsViewModel()
    var selectedEquipNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objmodel.delegate = self
        objmodel.getObjectlist()
        searchField.delegate = self
        searchField.setImage(UIImage(), for: .search, state: .normal)
        searchField.compatibleSearchTextField.backgroundColor = UIColor.white
        assetTableView.register(UINib(nibName: "SearchAssetCell_iPhone", bundle: nil), forCellReuseIdentifier: "SearchAssetCell_iPhone")
        assetTableView.rowHeight = 140
        assetTableView.estimatedRowHeight = UITableView.automaticDimension
        ODSUIHelper.setBorderToView(view:self.noteTextViewBgView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.searchView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.assetTableView.allowsMultipleSelection = true
        self.tblViewBottomConst.constant = IS_IPHONE_XS_MAX ? 64 : 0 //default 54
    }
    func dataFetchCompleted(type: String, object: [Any]) {
        if type == "assetList"{
            self.inspectedArr = self.objmodel.objectListArray
            self.inspectedListArr = self.objmodel.objectListArray
            DispatchQueue.main.async {
                self.selectedAssetListArr.removeAll()
                self.totalLbl.text = "\(self.inspectedArr.count)"
                self.assestSegment.selectedSegmentIndex = 0
                self.assestSegmentAction(self.assestSegment)
            }
        }else if type == "VerifyWriteOffCompleted"{
            DispatchQueue.main.async {
                self.writeOffBgView.isHidden = true
            }
            objmodel.getObjectlist()
        }else if type == "geoLocationUpdated"{
            var location = String()
            if let loc = object[0] as? String{
                location = loc
            }
            self.appDeli.window?.showSnackbar(message: "\(self.selectedAssetListArr.count) Asse(s) are updated! Location:(\(location))", actionButtonText: "", bgColor: appColor, actionButtonClickHandler: nil)
        }else if type == "AssetMap"{
            DispatchQueue.main.async {
                let assetLocVc = ScreenManager.getAssetLocationScreen()
                var locListArr = [Dictionary<String,Any>]()
                for item in self.objmodel.equipmentArr{
                    var dict = Dictionary<String,Any>()
                    dict["AssetID"] = "\(item.Equipment)"
                    dict["AssetDesc"] = "\(item.EquipDescription)"
                    var location = item.GEOLocation
                    location = location.replacingOccurrences(of: "x:", with: "")
                    location = location.replacingOccurrences(of: "y:", with: "")
                    let locArr = location.components(separatedBy: ",")
                    if locArr.count == 2{
                        dict["AssetLat"] = "\(locArr[0])"
                        dict["AssetLong"] = "\(locArr[1])"
                        locListArr.append(dict)
                    }
                }
                assetLocVc.locations = locListArr
                self.present(assetLocVc, animated: false)
            }
        }
    }
    //MARK: - Button Action Methods
    @IBAction func assestSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowDotMenu"), object: nil)
            self.selectedStackView.isHidden = false
            self.inspectedArr.removeAll()
            self.inspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic == ""}
            self.inspectedListArr = self.inspectedArr
            self.totalLbl.text = "\(self.inspectedArr.count)"
            self.searchField.text = ""
            selectedCountLabelUpdate(count: self.selectedAssetListArr.count)
            self.scanBtnWidthConst.constant = 57.5
            if self.inspectedArr.count == 0{
                self.noDataLblView.isHidden = false
            }
            else{
                self.noDataLblView.isHidden = true
            }
            self.assetTableView.reloadData()
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HideDotMenu"), object: nil)
            self.selectedStackView.isHidden = true
            self.inspectedArr.removeAll()
            self.inspectedArr = self.objmodel.objectListArray.filter{$0.ProcessIndic != ""}
            self.inspectedListArr = self.inspectedArr
            self.totalLbl.text = "\(self.inspectedArr.count)"
            self.searchField.text = ""
            self.scanBtnWidthConst.constant = 0
            if self.inspectedArr.count == 0{
                self.noDataLblView.isHidden = false
            }
            else{
                self.noDataLblView.isHidden = true
            }
            self.assetTableView.reloadData()
        }
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.selectedAssetListArr.removeAll()
        selectedCountLabelUpdate(count: selectedAssetListArr.count)
        assetTableView.reloadData()
        self.selectedLbl.text = ""
    }
    @IBAction func barCodeScanBtnAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        WorkOrderDataManegeClass.uniqueInstance.presentBarCodeScaner(scanObjectType: "asset", delegate: self, controller: self)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func notesDoneBtnAction(_ sender: UIButton) {
        if notesTextView.text == ""{
            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Please_enter_notes".localized(), button: okay)
        }
        else{
            self.objmodel.updateWriteOffWorkOder(list: selectedAssetListArr, status: "W", notes: self.notesTextView.text, count: 0)
        }
    }
    @IBAction func notesCancelBtnActio(_ sender: UIButton) {
        self.writeOffBgView.isHidden = true
    }
    //MARK: - Barcode Delegate
    func scanCompleted(type: String, barCode: String, object: Any){
        if type == "success"{
            self.searchField.text = barCode
            self.searchBar(searchField, textDidChange: self.searchField.text!)
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    //MARK: -  Search Bar delegate..
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchField.endEditing(true)
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        mJCLogger.log("Starting", Type: "info")
        if searchBar == searchField{
            if(searchText == "") {
                self.searchField.becomeFirstResponder()
                inspectedArr = self.inspectedListArr
                self.assetTableView.reloadData()
            }else{
                self.inspectedArr = inspectedListArr.filter{$0.Equipment.containsIgnoringCase(find: "\(searchText)") || $0.EquipmentDescription.containsIgnoringCase(find: "\(searchText)")}
                if inspectedArr.count > 0{
                    DispatchQueue.main.async{
                        self.noDataLblView.isHidden = true
                    }
                }else{
                    self.noDataLblView.isHidden = false
                }
                self.assetTableView.reloadData()
            }
        }
    }
}
extension AssetDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inspectedArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScreenManager.getInspectedCell(tableView: tableView)
        cell.selectionStyle = .none
        if self.inspectedArr.indices.contains(indexPath.row){
            let assetDetail = self.inspectedArr[indexPath.row]
            if assestSegment.selectedSegmentIndex == 0{
                cell.unInspCellModel = assetDetail
                if selectedAssetListArr.contains(assetDetail){
                    cell.checkBoxBtn.setImage(UIImage(named: "ic_check_fill"), for: .normal)
                }else{
                    cell.checkBoxBtn.setImage(UIImage(named: "ic_check_nil"), for: .normal)
                }
            }else{
                cell.inspCellModel = assetDetail
            }
            cell.checkBoxBtn.tag = indexPath.row
            cell.cameraBtn.tag = indexPath.row
            cell.rightArrowbtn.tag = indexPath.row
            
            cell.checkBoxBtn.addTarget(self, action: #selector(checkBoxClicked(sender:)), for: .touchUpInside)
            cell.cameraBtn.addTarget(self, action: #selector(assetCameraButtonAction(sender:)), for: .touchUpInside)
            cell.rightArrowbtn.addTarget(self, action: #selector(moveToOverViewButtonAction(sender:)), for: .touchUpInside)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let item = self.inspectedArr[indexPath.row]
        if !selectedAssetListArr.contains(item){
            selectedAssetListArr.append(item)
            selectedCountLabelUpdate(count: selectedAssetListArr.count)
        }else{
            if let index = self.selectedAssetListArr.index(of: item){
                selectedAssetListArr.remove(at: index)
                selectedCountLabelUpdate(count: selectedAssetListArr.count)
            }
        }
        self.assetTableView.reloadData()*/
    }
    
    @objc func checkBoxClicked(sender: UIButton){
        let item = self.inspectedArr[sender.tag]
        if !selectedAssetListArr.contains(item){
            selectedAssetListArr.append(item)
            selectedCountLabelUpdate(count: selectedAssetListArr.count)
        }else{
            if let index = self.selectedAssetListArr.index(of: item){
                selectedAssetListArr.remove(at: index)
                selectedCountLabelUpdate(count: selectedAssetListArr.count)
            }
        }
        self.assetTableView.reloadData()
    }
    @objc func assetCameraButtonAction(sender: UIButton){
        mJCLogger.log("Starting", Type: "info")
        self.selectedEquipNumber = self.inspectedArr[sender.tag].Equipment
        self.openCamera()
        mJCLogger.log("Ended", Type: "info")
    }
    @objc func moveToOverViewButtonAction(sender: UIButton){
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = ""
            flocEquipDetails.flocEquipObjText = self.inspectedArr[sender.tag].Equipment
            flocEquipDetails.classificationType = "Workorder"
            flocEquipDetails.modalPresentationStyle = .fullScreen
            self.present(flocEquipDetails, animated: false) {}
        }else{
            let flocEquipDetails = ScreenManager.getFlocEquipDetialsScreen()
            flocEquipDetails.flocEquipObjType = ""
            flocEquipDetails.flocEquipObjText = self.inspectedArr[sender.tag].Equipment
            flocEquipDetails.classificationType = "Workorder"
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Equipment"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = flocEquipDetails as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(flocEquipDetails, animated: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func selectedCountLabelUpdate(count: Int){
        if assestSegment.selectedSegmentIndex == 0{
            if selectedAssetListArr.count > 0{
                self.selectedStackView.isHidden = false
                self.selectedLbl.text = "\(selectedAssetListArr.count)"
            }
            else{
                self.selectedStackView.isHidden = true
            }
        }
    }
    //MARK: - Camera & UIImagePickerController Delegate..
    func openCamera() {
        mJCLogger.log("Starting", Type: "info")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            isSupportPortait = true
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                imagePicker.allowsEditing = true
                imagePicker.cameraCaptureMode = .photo
                self.present(imagePicker, animated: false, completion: nil)
            }
        }else {
            mJCLogger.log("There_is_no_camera_available_on_this_device".localized(), Type: "Warn")
            mJCAlertHelper.showAlert(self, title:sorrytitle, message: "There_is_no_camera_available_on_this_device".localized(), button: okay)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        mJCLogger.log("Starting", Type: "info")
        isSupportPortait = false
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        mJCLogger.log("Starting", Type: "info")
        isSupportPortait = false
        if #available(iOS 13.0, *){
            let uploadAttachmentVC = ScreenManager.getUploadAttachmentScreen()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy_HHmmss"
            let dateString = dateFormatter.string(from: NSDate() as Date)
            uploadAttachmentVC.fileType = defaultImageType
            attachmentsViewModel.selectedbutton = ""
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            attachmentsViewModel.imagePicked.image = chosenImage
            attachmentsViewModel.imageData = chosenImage.pngData()! as NSData
            uploadAttachmentVC.fileName  = "IMAGE_\(dateString)"
            uploadAttachmentVC.image = chosenImage
            uploadAttachmentVC.attachmentType = "Image"
            uploadAttachmentVC.isFromScreen = "ASSET"
            uploadAttachmentVC.objectNum = self.selectedEquipNumber!
            uploadAttachmentVC.modalPresentationStyle = .fullScreen
            self.dismiss(animated: false, completion: {
                self.present(uploadAttachmentVC, animated: false) {}
            })
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
