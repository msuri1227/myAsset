//
//  ListFilterVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 4/4/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib
class ListFilterVC: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate{
    
    //MARK:- PriorityView Outlet
    @IBOutlet var priorityView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priorityCollectionView: UICollectionView!
    
    //MARK:- StatusView Outlet
    @IBOutlet var statusView: UIView!
    @IBOutlet weak var StatusCollectionView: UICollectionView!
    
    //MARK:- OrderTypeView Outlet
    @IBOutlet var orderTypeView: UIView!
    
    //MARK:- FooterButtonView Outlet
    @IBOutlet var footerButtonView: UIView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    // MainWorkCenterView Outlets..
    @IBOutlet var mainWorkCenterView: UIView!
    @IBOutlet var mainWorkCenterTextFieldView: UIView!
    @IBOutlet var mainWorkCenterTextField: iOSDropDown!
    @IBOutlet var mainWorkCenterButton: UIButton!
    
    // plantView Outlets..
    @IBOutlet var plantView: UIView!
    @IBOutlet var plantTextFieldView: UIView!
    @IBOutlet var plantTextField: iOSDropDown!
    @IBOutlet var plantButton: UIButton!
    
    // Created By
    @IBOutlet var createdByView: UIView!
    @IBOutlet var createdByTextFieldView: UIView!
    @IBOutlet var createdByTextField: iOSDropDown!
    @IBOutlet var createdByButton: UIButton!
    
    // Control Key Outlets..
    @IBOutlet var controlKeyView: UIView!
    @IBOutlet var controlKeyTextFieldView: UIView!
    @IBOutlet var controlKeyTextField: UITextField!
    @IBOutlet var controlKeyButton: UIButton!
    
    @IBOutlet var personalRespView: UIView!
    @IBOutlet var personalRespTextFieldView: UIView!
    @IBOutlet var personalRespTextField: iOSDropDown!
    @IBOutlet var personalRespButton: UIButton!
    
    @IBOutlet var personRespTitleLabel: UILabel!
    @IBOutlet var orderTypeCollectionView: UICollectionView!
    
    @IBOutlet weak var unAssignedView: UIView!
    @IBOutlet weak var UnassignedButton: UIButton!
    @IBOutlet var createdByMeView: UIView!
    @IBOutlet var createdByMebutton: UIButton!
    
    // Planning Plant Outlets..
    @IBOutlet weak var planningPlantView: UIView!
    @IBOutlet weak var planningPlantTextFieldView: UIView!
    @IBOutlet weak var planningPlantTextField: iOSDropDown!
    @IBOutlet weak var planningPlantButton: UIButton!
    
    // Maintenance Plant Outlets..
    @IBOutlet weak var maintenancePlantView: UIView!
    @IBOutlet weak var maintenancePlantTextFieldView: UIView!
    @IBOutlet weak var maintenancePlantTextField: iOSDropDown!
    @IBOutlet weak var maintenancePlantButton: UIButton!
    
    // Main Planner Group Outlets..
    @IBOutlet weak var mainPlannerGroupView: UIView!
    @IBOutlet weak var mainPlannerGroupTextFieldView: UIView!
    @IBOutlet weak var mainPlannerGroupTextField: iOSDropDown!
    @IBOutlet weak var mainPlannerGroupButton: UIButton!
    
    // Staff ID Outlets..
    @IBOutlet weak var techIdView: UIView!
    @IBOutlet weak var techIdTextFieldView: UIView!
    @IBOutlet weak var techIdTextField: iOSDropDown!
    @IBOutlet weak var techIdButton: UIButton!
    
    @IBOutlet var teamMemberView: UIView!
    @IBOutlet var teamMemberTextFieldView: UIView!
    @IBOutlet var teamMemberTextField: iOSDropDown!
    @IBOutlet var teamMemberButton: UIButton!
    
    @IBOutlet var showOnMapView: UIView!
    @IBOutlet var showOnMapTextFieldView: UIView!
    @IBOutlet var showOnMapTextField: iOSDropDown!
    @IBOutlet var showOnMapButton: UIButton!
    
    //MARK:- Declered Variables..
    
    var delegate : filterDelegate?
    var isfrom = String()
    var childfrom = String()
    var filterViewModel = ListFilterViewModel()


    //MARK:- LifeCycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateNotificationVC.handleTap(sender:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        filterViewModel.filterVc = self
        self.setBasicView()
        ScreenManager.registerFilterVCCell(collectionView: self.priorityCollectionView)
        ScreenManager.registerFilterVCCell(collectionView: self.StatusCollectionView)
        ScreenManager.registerFilterVCCell(collectionView: self.orderTypeCollectionView)
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func setBasicView(){
        
        ODSUIHelper.setBorderToView(view:self.personalRespTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.plantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.mainWorkCenterTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.controlKeyTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.planningPlantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.maintenancePlantTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.mainPlannerGroupTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.techIdTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.createdByTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.teamMemberTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ODSUIHelper.setBorderToView(view:self.showOnMapTextFieldView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        
        self.controlKeyView.isHidden = true
        self.teamMemberView.isHidden = true
        self.showOnMapView.isHidden = true
        self.plantView.isHidden = true
        self.unAssignedView.isHidden = true
        self.filterViewModel.setPrirityValues()
        self.priorityCollectionView.reloadData()
        self.filterViewModel.setStatusValues()
        self.StatusCollectionView.reloadData()
        self.filterViewModel.setTypeValues()
        self.orderTypeCollectionView.reloadData()
        self.filterViewModel.setCreatedByValues()
        self.filterViewModel.setMainWorkCenterValues()
        self.filterViewModel.setMainPlannerGroupValues()
        self.filterViewModel.setStaffIdValues()
        self.filterViewModel.setMaintancePlantValues()
        self.filterViewModel.setPlanningPlantValues()
        self.filterViewModel.setTechIdValues()
        self.filterViewModel.setTeamMemberValues()
        self.filterViewModel.setAssetMapFilterValues()
        self.filterViewModel.setUnAssignedValues()
        self.filterViewModel.setCreatedByMeValues()
        if isfrom == "WorkOrder"{
            self.plantView.isHidden = false
            self.filterViewModel.setPlantValues()
        }else if isfrom == "Notification"{
            
        }else if isfrom == "Supervisor"{
            self.priorityView.isHidden = false
            self.statusView.isHidden = false
            self.teamMemberView.isHidden = false
            self.showOnMapView.isHidden = true
            self.orderTypeView.isHidden = true
            self.mainWorkCenterView.isHidden = true
            self.plantView.isHidden = true
            self.createdByView.isHidden = true
            self.controlKeyView.isHidden = true
            self.personalRespView.isHidden = true
            self.unAssignedView.isHidden = true
            self.createdByMeView.isHidden = true
            self.planningPlantView.isHidden = true
            self.maintenancePlantView.isHidden = true
            self.mainPlannerGroupView.isHidden = true
            self.techIdView.isHidden = true
        }else if isfrom == "WorkOrderMAP"{
            self.personalRespView.isHidden = true
            self.unAssignedView.isHidden = true
            self.mainPlannerGroupView.isHidden = true
            self.techIdView.isHidden = true
            self.teamMemberView.isHidden = true
            self.planningPlantView.isHidden = true
            self.maintenancePlantView.isHidden = true
            self.createdByMeView.isHidden = true
        }else if isfrom == "ASSETMAP"{
            self.showOnMapView.isHidden = false
            self.priorityView.isHidden = true
            self.statusView.isHidden = true
            self.orderTypeView.isHidden = true
            self.mainWorkCenterView.isHidden = true
            self.plantView.isHidden = true
            self.createdByView.isHidden = true
            self.controlKeyView.isHidden = true
            self.personalRespView.isHidden = true
            self.unAssignedView.isHidden = true
            self.createdByMeView.isHidden = true
            self.planningPlantView.isHidden = true
            self.maintenancePlantView.isHidden = true
            self.mainPlannerGroupView.isHidden = true
            self.techIdView.isHidden = true
            self.teamMemberView.isHidden = true
        }
        //Plant
        self.plantTextField.didSelect { selectedText, index, id in
            self.plantTextField.text = selectedText
        }
        //Created by
        self.createdByTextField.didSelect { selectedText, index, id in
            self.createdByTextField.text = selectedText
        }
        //Main work center
        self.mainWorkCenterTextField.didSelect { selectedText, index, id in
            self.mainWorkCenterTextField.text = selectedText
        }
        //Main Planner group
        self.mainPlannerGroupTextField.didSelect { selectedText, index, id in
            self.mainPlannerGroupTextField.text = selectedText
        }
        //Staff id
        self.personalRespTextField.didSelect { selectedText, index, id in
            self.personalRespTextField.text = selectedText
        }
        //Maintainance plant
        self.maintenancePlantTextField.didSelect { selectedText, index, id in
            self.maintenancePlantTextField.text = selectedText
        }
        //Planning plant
        self.planningPlantTextField.didSelect { selectedText, index, id in
            self.planningPlantTextField.text = selectedText
        }
        //Tech id no
        self.techIdTextField.didSelect { selectedText, index, id in
            self.techIdTextField.text = selectedText
        }
        //Team Mem
        self.teamMemberTextField.didSelect { selectedText, index, id in
            self.teamMemberTextField.text = selectedText
        }
        //Show on map
        self.showOnMapTextField.didSelect { selectedText, index, id in
            self.showOnMapTextField.text = selectedText
        }
    }
    
    //MARK: - UITapGesture Recognizer..
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        mJCLogger.log("Starting", Type: "info")
        self.allTextFieldResign()
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- CollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == priorityCollectionView {
            return self.filterViewModel.priorityListArray.count
        }else if collectionView == StatusCollectionView{
            return self.filterViewModel.statusArray.count
        }else if collectionView == orderTypeCollectionView{
            return self.filterViewModel.typeArray.count
        }else{
            return 0
        }
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        mJCLogger.log("Starting", Type: "info")
        let cell = ScreenManager.getFilterVCCell(collectionView: collectionView,indexPath:indexPath)
        if collectionView == priorityCollectionView {
            if filterViewModel.priorityListArray.count > indexPath.row{
                cell.titleLabel.text = self.filterViewModel.priorityListArray[indexPath.row]
                if self.filterViewModel.selectedPriorityArray.contains(self.filterViewModel.priorityListArray[indexPath.row]) {
                    cell.Selected = true
                }else{
                    cell.Selected = false
                }
            }
            if cell.Selected == false {
                cell.bgView.backgroundColor =  UIColor(named: "mjcViewBgColor")
            }else{
                cell.bgView.backgroundColor = selectionBgColor
            }
            return cell
        }else if collectionView == StatusCollectionView{
            let status = self.filterViewModel.statusArray[indexPath.row]
            cell.titleLabel.text = status
            if self.filterViewModel.selectedStatusArray.contains(status){
                cell.Selected = true
            }else{
                cell.Selected = false
            }
            if cell.Selected == false {
                cell.bgView.backgroundColor =  UIColor(named: "mjcViewBgColor")
            }else{
                cell.bgView.backgroundColor = selectionBgColor
            }
            return cell
        }else if collectionView == orderTypeCollectionView{
            if filterViewModel.typeArray.count > indexPath.row{
                cell.titleLabel.text = self.filterViewModel.typeArray[indexPath.row]
                if self.filterViewModel.selectedTypeArray.contains(self.filterViewModel.typeArray[indexPath.row]) {
                    cell.Selected = true
                }else{
                    cell.Selected = false
                }
            }
            if cell.Selected == false {
                cell.bgView.backgroundColor =  UIColor(named: "mjcViewBgColor")
            }else{
                cell.bgView.backgroundColor = selectionBgColor
            }
            return cell
        }
        mJCLogger.log("Ended", Type: "info")
        return UICollectionViewCell()
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        mJCLogger.log("Starting", Type: "info")
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterVCCell{
            if collectionView == orderTypeCollectionView{
                if cell.Selected == false {
                    cell.Selected = true
                    cell.bgView.backgroundColor = selectionBgColor
                    if filterViewModel.typeArray.count > indexPath.row {
                        self.filterViewModel.selectedTypeArray.append(self.filterViewModel.typeArray[indexPath.row])
                    }
                }else {
                    cell.Selected = false
                    cell.bgView.backgroundColor = UIColor(named: "mjcViewBgColor")
                    let orderType = self.filterViewModel.typeArray[indexPath.row]
                    if filterViewModel.typeArray.count > indexPath.row {
                        if let index = self.filterViewModel.selectedTypeArray.index(of: orderType){
                            self.filterViewModel.selectedTypeArray.remove(at: index)
                        }
                    }
                }
            }else if collectionView == priorityCollectionView {
                if cell.Selected == false {
                    cell.Selected = true
                    cell.bgView.backgroundColor = selectionBgColor
                    if filterViewModel.priorityListArray.count > indexPath.row {
                        self.filterViewModel.selectedPriorityArray.append(self.filterViewModel.priorityListArray[indexPath.row])
                    }
                }else {
                    cell.Selected = false
                    cell.bgView.backgroundColor = UIColor(named: "mjcViewBgColor")
                    let priority = self.filterViewModel.priorityListArray[indexPath.row]
                    if filterViewModel.priorityListArray.count > indexPath.row {
                        if let index = self.filterViewModel.selectedPriorityArray.index(of: priority){
                            self.filterViewModel.selectedPriorityArray.remove(at: index)
                        }
                    }
                }
            }else{
                let  cell = collectionView.cellForItem(at: indexPath) as! FilterVCCell
                let status = self.filterViewModel.statusArray[indexPath.row]
                if cell.Selected == false {
                    cell.Selected = true
                    cell.bgView.backgroundColor = selectionBgColor
                    self.filterViewModel.selectedStatusArray.append(status)
                }else {
                    cell.Selected = false
                    cell.bgView.backgroundColor =  UIColor(named: "mjcViewBgColor")
                    if let index = self.filterViewModel.selectedStatusArray.index(of: status){
                        self.filterViewModel.selectedStatusArray.remove(at: index)
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - TextField Resign..
    func allTextFieldResign() {
        mJCLogger.log("Starting", Type: "info")
        self.plantTextField.resignFirstResponder()
        self.createdByTextField.resignFirstResponder()
        self.mainWorkCenterTextField.resignFirstResponder()
        self.mainPlannerGroupTextField.resignFirstResponder()
        self.personalRespTextField.resignFirstResponder()
        self.maintenancePlantTextField.resignFirstResponder()
        self.planningPlantTextField.resignFirstResponder()
        self.techIdTextField.resignFirstResponder()
        self.teamMemberTextField.resignFirstResponder()
        self.showOnMapTextField.resignFirstResponder()
        mJCLogger.log("Ended", Type: "info")
    }
    
    @IBAction func controlKeySelectionButtonAction(sender: UIButton) {
    }
    //MARK: Footer Button Action..
    @IBAction func saveButtonAction(sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        var unAssignedArray = [String]()
        var createdByMeArray = [String]()
        var dict : [String: Any] = [:]
        if self.filterViewModel.selectedPriorityArray.count > 0{
            var priorityArray = [String]()
            var listArr = [PriorityListModel]()
            let predicate = NSPredicate(format: "PriorityText IN %@", self.filterViewModel.selectedPriorityArray)
            listArr = globalPriorityArray.filter{predicate.evaluate(with: $0)}
            for item in listArr {
                priorityArray.append(item.Priority)
            }
            if self.filterViewModel.selectedPriorityArray.contains("No_Priority".localized()){
                priorityArray.append("")
            }
            dict["priority"] = priorityArray
        }
        if self.filterViewModel.selectedTypeArray.count > 0{
            dict["orderType"] = self.filterViewModel.selectedTypeArray
        }
        if self.filterViewModel.selectedStatusArray.count > 0{
            dict["status"] = self.filterViewModel.selectedStatusArray
        }
        if self.filterViewModel.selectedPlantArry.count > 0{
            if let index = self.filterViewModel.selectedPlantArry.index(of: "No_Value".localized()){
                self.filterViewModel.selectedPlantArry[index] = ""
            }
            dict["plant"] = self.filterViewModel.selectedPlantArry
        }
        if self.filterViewModel.selectedCreatedByArray.count > 0{
            if let index = self.filterViewModel.selectedCreatedByArray.index(of: "No_Value".localized()){
                self.filterViewModel.selectedCreatedByArray[index] = ""
            }
            dict["createdBy"] = self.filterViewModel.selectedCreatedByArray
        }
        if self.filterViewModel.selectedmainWorkCenterArry.count > 0{
            if let index = self.filterViewModel.selectedmainWorkCenterArry.index(of: "No_Value".localized()){
                self.filterViewModel.selectedmainWorkCenterArry[index] = ""
            }
            dict["mainWorkCenter"] = self.filterViewModel.selectedmainWorkCenterArry
        }
        if self.filterViewModel.selectedmainPlantGroupArry.count > 0{
            if let index = self.filterViewModel.selectedmainPlantGroupArry.index(of: "No_Value".localized()){
                self.filterViewModel.selectedmainPlantGroupArry[index] = ""
            }
            dict["mainPlantGroup"] = self.filterViewModel.selectedmainPlantGroupArry
        }
        if self.filterViewModel.selectedPersponseArray.count > 0{
            if let index = self.filterViewModel.selectedPersponseArray.index(of: "No_Value".localized()){
                self.filterViewModel.selectedPersponseArray[index] = ""
            }
            dict["staffId"] = self.filterViewModel.selectedPersponseArray
        }
        if self.filterViewModel.selectedMaintenancePlantArray.count > 0{
            if let index = self.filterViewModel.selectedPlantArry.index(of: "No_Value".localized()){
                self.filterViewModel.selectedPlanningPlantArray[index] = ""
            }
            dict["maintenancePlant"] = self.filterViewModel.selectedPlanningPlantArray
        }
        if self.filterViewModel.selectedPlanningPlantArray.count > 0{
            if let index = self.filterViewModel.selectedPlanningPlantArray.index(of: "No_Value".localized()){
                self.filterViewModel.selectedPlanningPlantArray[index] = ""
            }
            dict["planningPlant"] = self.filterViewModel.selectedPlanningPlantArray
        }
        if self.filterViewModel.selectedTechIDArray.count > 0{
            if let index = self.filterViewModel.selectedTechIDArray.index(of: "No_Value".localized()){
                self.filterViewModel.selectedTechIDArray[index] = ""
            }
            dict["techID"] = self.filterViewModel.selectedTechIDArray
        }
        if self.filterViewModel.selectedTeamMemberArray.count > 0{
            dict["teamMember"] = self.filterViewModel.selectedTeamMemberArray
        }
        if self.filterViewModel.selectedAssetMapFilterArray.count > 0{
            dict["assetMap"] = self.filterViewModel.selectedAssetMapFilterArray
        }
        if UnassignedButton.isSelected == true && UnassignedButton.isHidden == false{
            unAssignedArray.append("UnAssigned")
            dict["unAssigned"] = unAssignedArray
        }
        if createdByMebutton.isSelected == true && createdByMebutton.isHidden == false{
            createdByMeArray.append("CreatedByMe")
            dict["createdByMe"] = createdByMeArray
        }
        UserDefaults.standard.set(dict, forKey: "ListFilter")
        
        if let delegate = delegate {
            delegate.ApplyFilter()
            self.dismiss(animated: false, completion: nil)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func cancelButtonAction(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false) {}
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func resetButtonAction(sender: UIButton) {
        
        mJCLogger.log("Starting", Type: "info")
        self.filterViewModel.selectedPriorityArray.removeAll()
        self.priorityCollectionView.reloadData()
        self.filterViewModel.selectedStatusArray.removeAll()
        self.StatusCollectionView.reloadData()
        self.filterViewModel.selectedTypeArray.removeAll()
        self.orderTypeCollectionView.reloadData()
        self.filterViewModel.selectedPlantArry.removeAll()
        self.plantTextField.text = selectStr
        self.filterViewModel.selectedCreatedByArray.removeAll()
        self.createdByTextField.text = selectStr
        self.filterViewModel.selectedmainWorkCenterArry.removeAll()
        self.mainWorkCenterTextField.text = selectStr
        self.filterViewModel.selectedmainPlantGroupArry.removeAll()
        self.mainPlannerGroupTextField.text = selectStr
        self.filterViewModel.selectedPersponseArray.removeAll()
        self.personalRespTextField.text = selectStr
        self.filterViewModel.selectedMaintenancePlantArray.removeAll()
        self.maintenancePlantTextField.text = selectStr
        self.filterViewModel.selectedPlanningPlantArray.removeAll()
        self.planningPlantTextField.text = selectStr
        self.filterViewModel.selectedTechIDArray.removeAll()
        self.techIdTextField.text = selectStr
        self.filterViewModel.selectedTeamMemberArray.removeAll()
        self.teamMemberTextField.text = selectStr
        self.filterViewModel.selectedAssetMapFilterArray.removeAll()
        self.showOnMapTextField.text = selectStr
        self.createdByMebutton.isSelected = false
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func unAssignedButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func createdByMeAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        sender.isSelected = !sender.isSelected
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK: - Not Using Methods
    @IBAction func createdByButtonAction(_ sender: Any) {
        if self.filterViewModel.createdByArray.count > 0{
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple,dataSource: self.filterViewModel.createdByArray.sorted(),cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: self.filterViewModel.selectedCreatedByArray) { [weak self] (text, index, selected, selectedList) in
                self?.filterViewModel.selectedCreatedByArray = selectedList
                self?.createdByTextField.text = selectedList.joined(separator: ";")
                if selectedList.count == 0{
                    self?.createdByTextField.text = selectStr
                }
            }
            var height = CGFloat(self.filterViewModel.createdByArray.count) * 30.0
            if height > screenHeight - 200{
                height = 180
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.createdByTextFieldView.frame.size.width, height: height)
            selectionMenu.show(style: .popover(sourceView: self.createdByTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }
    }
    @IBAction func mainWorkCenterButtonAction(sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if self.filterViewModel.mainWorkCenterListArry.count > 0{
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple,dataSource: self.filterViewModel.mainWorkCenterListArry.sorted(),cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: self.filterViewModel.selectedmainWorkCenterArry) { [weak self] (text, index, selected, selectedList) in
                self?.filterViewModel.selectedmainWorkCenterArry = selectedList
                self?.mainWorkCenterTextField.text = selectedList.joined(separator: ";")
                if selectedList.count == 0{
                    self?.mainWorkCenterTextField.text = selectStr
                }
            }
            var height = CGFloat(self.filterViewModel.mainWorkCenterListArry.count) * 30.0
            if height > screenHeight - 200{
                height = 180
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.mainWorkCenterTextFieldView.frame.size.width, height: height)
            selectionMenu.show(style: .popover(sourceView: self.mainWorkCenterTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func mainPlannerGroupButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        if self.filterViewModel.mainPlantGroupListArray.count > 0{
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple,dataSource: self.filterViewModel.mainPlantGroupListArray.sorted(),cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: self.filterViewModel.selectedmainPlantGroupArry) { [weak self] (text, index, selected, selectedList) in
                self?.filterViewModel.selectedmainPlantGroupArry = selectedList
                self?.mainPlannerGroupTextField.text = selectedList.joined(separator: ";")
                if selectedList.count == 0{
                    self?.mainPlannerGroupTextField.text = selectStr
                }
            }
            var height = CGFloat(self.filterViewModel.mainPlantGroupListArray.count) * 30.0
            if height > screenHeight - 200{
                height = 180
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.mainPlannerGroupTextFieldView.frame.size.width, height: height)
            selectionMenu.show(style: .popover(sourceView: self.mainPlannerGroupTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }
    }
    @IBAction func techIdButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        self.techIdTextField.resignFirstResponder()
        if self.filterViewModel.techIDArray.count > 0{
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple,dataSource: self.filterViewModel.techIDArray.sorted(),cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: self.filterViewModel.selectedTechIDArray) { [weak self] (text, index, selected, selectedList) in
                self?.filterViewModel.selectedTechIDArray = selectedList
                self?.techIdTextField.text = selectedList.joined(separator: ";")
                if selectedList.count == 0{
                    self?.techIdTextField.text = selectStr
                }
            }
            var height = CGFloat(self.filterViewModel.techIDArray.count) * 30.0
            if height > screenHeight - 200{
                height = 180
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.techIdTextFieldView.frame.size.width, height: height)
            selectionMenu.show(style: .popover(sourceView: self.techIdTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func planningPlantButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        planningPlantTextField.resignFirstResponder()
        if self.filterViewModel.planningPlantArray.count > 0{
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple,dataSource: self.filterViewModel.planningPlantArray.sorted(),cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: self.filterViewModel.selectedPlanningPlantArray) { [weak self] (text, index, selected, selectedList) in
                self?.filterViewModel.selectedPlanningPlantArray = selectedList
                self?.planningPlantTextField.text = selectedList.joined(separator: ";")
                if selectedList.count == 0{
                    self?.planningPlantTextField.text = selectStr
                }
            }
            var height = CGFloat(self.filterViewModel.planningPlantArray.count) * 30.0
            if height > screenHeight - 200{
                height = 180
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.planningPlantTextFieldView.frame.size.width, height: height)
            selectionMenu.show(style: .popover(sourceView: self.planningPlantTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func personalButtonAction(_ sender: UIButton) {
        mJCLogger.log("Starting", Type: "info")
        personalRespTextField.resignFirstResponder()
        if self.filterViewModel.persponseArray.count > 0{
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple,dataSource: self.filterViewModel.persponseArray.sorted(),cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: self.filterViewModel.selectedPersponseArray) { [weak self] (text, index, selected, selectedList) in
                self?.filterViewModel.selectedPersponseArray = selectedList
                self?.personalRespTextField.text = selectedList.joined(separator: ";")
                if selectedList.count == 0{
                    self?.personalRespTextField.text = selectStr
                }
            }
            var height = CGFloat(self.filterViewModel.persponseArray.count) * 30.0
            if height > screenHeight - 200{
                height = 180
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.personalRespTextFieldView.frame.size.width, height: height)
            selectionMenu.show(style: .popover(sourceView: self.personalRespTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func teamMemberButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.teamMemberTextField.resignFirstResponder()
        if self.filterViewModel.teamMemberArray.count > 0{
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple,dataSource: self.filterViewModel.teamMemberArray.sorted(),cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: self.filterViewModel.selectedTeamMemberArray) { [weak self] (text, index, selected, selectedList) in
                self?.filterViewModel.selectedTeamMemberArray = selectedList
                self?.teamMemberTextField.text = selectedList.joined(separator: ";")
                if selectedList.count == 0{
                    self?.teamMemberTextField.text = selectStr
                }
            }
            var height = CGFloat(self.filterViewModel.teamMemberArray.count) * 30.0
            if height > screenHeight - 200{
                height = 180
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.teamMemberTextFieldView.frame.size.width, height: height)
            selectionMenu.show(style: .popover(sourceView: self.teamMemberTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func plantSelectionButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        if self.filterViewModel.plantsArray.count > 0{
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple,dataSource: self.filterViewModel.plantsArray.sorted(),cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: self.filterViewModel.selectedPlantArry) { [weak self] (text, index, selected, selectedList) in
                self?.filterViewModel.selectedPlantArry = selectedList
                self?.plantTextField.text = selectedList.joined(separator: ";")
                if selectedList.count == 0{
                    self?.plantTextField.text = selectStr
                }
            }
            var height = CGFloat(self.filterViewModel.plantsArray.count) * 30.0
            if height > screenHeight - 200{
                height = 180
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.plantTextFieldView.frame.size.width, height: height)
            selectionMenu.show(style: .popover(sourceView: self.plantTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func showOnMapButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.showOnMapTextField.resignFirstResponder()
        if self.filterViewModel.assetMapFilterArray.count > 0{
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple,dataSource: self.filterViewModel.assetMapFilterArray.sorted(),cellType: .rightDetail) { (cell, name, indexPath) in
                cell.textLabel?.text = name
            }
            selectionMenu.setSelectedItems(items: self.filterViewModel.selectedAssetMapFilterArray) { [weak self] (text, index, selected, selectedList) in
                self?.filterViewModel.selectedAssetMapFilterArray = selectedList
                self?.showOnMapTextField.text = selectedList.joined(separator: ";")
                if selectedList.count == 0{
                    self?.showOnMapTextField.text = selectStr
                }
            }
            var height = CGFloat(self.filterViewModel.assetMapFilterArray.count) * 30.0
            if height > screenHeight - 200{
                height = 180
            }
            selectionMenu.cellSelectionStyle = .checkbox
            let size = CGSize(width: self.showOnMapTextFieldView.frame.size.width, height: height)
            selectionMenu.show(style: .popover(sourceView: self.showOnMapTextFieldView, size: size, arrowDirection: [.up,.down]), from: self)
        }
        mJCLogger.log("Ended", Type: "info")
    }
}

