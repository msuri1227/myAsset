//
//  AssetHierarchyVc.swift
//  myJobCard
//
//  Created By Ondevice Solutions on 28/04/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class AssetHierarchyVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var AssetHierarchyTableView: UITableView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var PlantLabel: UILabel!
    @IBOutlet weak var SectionLabel: UILabel!
    @IBOutlet weak var WorkcentreLabel: UILabel!
    @IBOutlet weak var PartNumberLabel: UILabel!
    @IBOutlet weak var ManufaturerLabel: UILabel!
    @IBOutlet weak var SerialNumberLabel: UILabel!
    @IBOutlet weak var TypeLabel: UILabel!
    @IBOutlet weak var ModelNumberLabel: UILabel!
    @IBOutlet weak var SuperiorFuncLocationLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var searchInView: UIView!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var indentation: Int = 0
    var selectedEQ = EquipmentModel()
    var selectedFL = FunctionalLocationModel()
    var planningPlant = String()
    var workCenter = String()
    var fromFuncLocation = String()
    var fromEquipment = String()
    var assetHierarViewModel = AssetHierarViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        assetHierarViewModel.vc = self
        if DeviceType == iPhone{
            let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "Asset_Hierarchy".localized() , NewJobButton: false, refresButton: true, threedotmenu: false,leftMenuType:"Back")
            self.view.addSubview(view)
            if flushStatus == true{
                view.refreshBtn.showSpin()
            }
            view.delegate = self
        }else{
            self.searchViewHeightConstraint.constant = 5.0
            self.searchView.isHidden = true
            self.searchTextField.delegate = self
        }
        ScreenManager.registerTreeViewCell(tableView: self.AssetHierarchyTableView)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"TreeNodeButtonClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AssetHierarchyVC.ExpandCollapseNode(notification:)), name:NSNotification.Name(rawValue:"TreeNodeButtonClicked"), object: nil)
        self.assetHierarViewModel.AssetHierarchy()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:  Node/Data Functions
    @objc func ExpandCollapseNode(notification: NSNotification)
    {
        mJCLogger.log("Starting", Type: "info")
        if let tree = notification.value(forKey: "object") as? TreeViewNode{
            mJCLoader.startAnimating(status: "Fetching_Data..".localized())
            let defineQuery = "$filter=(HierLevel eq \(tree.nodeLevel! + 1) and ParentId eq '\(tree.nodeName!)') or (HierLevel eq \(tree.nodeLevel! + 2)) &$orderby=HierLevel,ObjectId"
            AssetHierarchyModel.getAssetHierarchyList(filterQuery:defineQuery){ (responseDict, error)  in
                if error == nil{
                    if let responseArr = responseDict["data"] as? [AssetHierarchyModel]{
                        mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                        let data = self.assetHierarViewModel.setChildData(array: responseArr)
                        let nodes = TreeViewLists.LoadInitialNodes(dataList: data, datalevel: tree.nodeLevel! + 1)
                        if tree.isExpanded == true{
                            self.assetHierarViewModel.LoadChildDisplayArray(nodes: nodes, selectedNode: tree)
                        }else{
                            self.assetHierarViewModel.removeChildDisplayArray(nodes: nodes, selectedNode: tree)
                        }
                        DispatchQueue.main.async {
                            mJCLoader.stopAnimating()
                            self.AssetHierarchyTableView.reloadData()
                        }
                    }else{
                        mJCLoader.stopAnimating()
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    DispatchQueue.main.async{
                        mJCLoader.stopAnimating()
                        if error?.code == 10{
                            mJCAlertHelper.showAlert(self, title: alerttitle, message: "Store_not_found_to_fetch_the_data".localized(), button: okay)
                        }
                    }
                    mJCLogger.log("\(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func updateUIDetails(nodeDetail:Any){
        if let EquipDetails = nodeDetail as? EquipmentModel{
            selectedEQ = EquipDetails
            DispatchQueue.main.async {
                self.DescriptionLabel.text = EquipDetails.EquipDescription
                self.CategoryLabel.text = EquipDetails.EquipCategory
                self.StatusLabel.text = EquipDetails.SystemStatus
                self.LocationLabel.text = EquipDetails.Location
                self.PlantLabel.text = EquipDetails.MaintPlant
                self.SectionLabel.text = EquipDetails.PlantSection
                self.WorkcentreLabel.text = EquipDetails.WorkCenter
                self.PartNumberLabel.text = EquipDetails.ManufPartNo
                self.ManufaturerLabel.text = EquipDetails.Manufacturer
                self.SerialNumberLabel.text = EquipDetails.ManufSerialNo
                self.TypeLabel.text = EquipDetails.ObjectType
                self.ModelNumberLabel.text = EquipDetails.ModelNumber
                self.SuperiorFuncLocationLabel.text = EquipDetails.FuncLocation
            }
        }else if let FuncDetails = nodeDetail as? FunctionalLocationModel{
            selectedFL = FuncDetails
            DispatchQueue.main.async {
                self.DescriptionLabel.text = FuncDetails.Description
                self.CategoryLabel.text = FuncDetails.FunctLocCat
                self.StatusLabel.text = FuncDetails.SystemStatus
                self.LocationLabel.text = FuncDetails.Location
                self.PlantLabel.text = FuncDetails.MaintPlant
                self.SectionLabel.text = FuncDetails.PlantSection
                self.WorkcentreLabel.text = FuncDetails.WorkCenter
                self.PartNumberLabel.text = FuncDetails.ManufPartNo
                self.ManufaturerLabel.text = FuncDetails.Manufacturer
                self.SerialNumberLabel.text = FuncDetails.ManufSerialNo
                self.TypeLabel.text = FuncDetails.ObjectType
                self.ModelNumberLabel.text = FuncDetails.ModelNumber
                self.SuperiorFuncLocationLabel.text = FuncDetails.SupFunctLoc
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
    }
    //MARK:  Table View Methods
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.assetHierarViewModel.displayArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        mJCLogger.log("Starting", Type: "info")
        let node: TreeViewNode = self.assetHierarViewModel.displayArray[indexPath.row]
        mJCLogger.log("Response:\(self.assetHierarViewModel.displayArray.count)", Type: "Debug")
        let cell  = ScreenManager.getTreeViewCell(tableView: self.AssetHierarchyTableView)
        cell.indexPath = indexPath
        cell.assetHierViewModel = assetHierarViewModel
        cell.treeViewModelClass = node
        cell.treeNode = node
        cell.setNeedsDisplay()
        mJCLogger.log("Ended", Type: "info")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPad{
            if self.assetHierarViewModel.displayArray.indices.contains(indexPath.row){
                let node: TreeViewNode = self.assetHierarViewModel.displayArray[indexPath.row]
                self.assetHierarViewModel.getNodeDetails(node: node)
            }else{
                mJCLogger.log("selected index not found", Type: "Debug")
            }
        }else if DeviceType == iPhone{
            mJCLogger.log("Response:\(self.assetHierarViewModel.displayArray.count)", Type: "Debug")
            let node: TreeViewNode = self.assetHierarViewModel.displayArray[indexPath.row]
            let num = node.nodeName
            let type = node.nodeType
            let createNewJobVC = ScreenManager.getAssetHierarchyOverViewScreen()
            createNewJobVC.modalPresentationStyle = .fullScreen
            createNewJobVC.selectedNumber = num ?? ""
            createNewJobVC.assetHierarchyOverviewModel.TypeString = type ?? ""
            self.present(createNewJobVC, animated: false) {}
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {}
    @IBAction func BackButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func moreButtonAction(sender: AnyObject) {}
    @IBAction func refreshButtonButton(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func addNewJobButtonAction(sender: AnyObject) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                let createNewJobVC = ScreenManager.getCreateJobScreen()
                createNewJobVC.modalPresentationStyle = .fullScreen
                if selectedEQ.Equipment != ""{
                    createNewJobVC.equipmentfrompoints = selectedEQ.Equipment
                    createNewJobVC.funclocfrompoints = selectedEQ.FuncLocation
                }else if selectedFL.FunctionalLoc != "" {
                    createNewJobVC.funclocfrompoints = selectedFL.FunctionalLoc
                }else{
                    createNewJobVC.equipmentfrompoints = ""
                    createNewJobVC.funclocfrompoints = ""
                }
                createNewJobVC.isScreen = "recordpoints"
                createNewJobVC.isFromEdit = false
                self.present(createNewJobVC, animated: false) {}
            }else{
                mJCLogger.log("Data not found", Type: "Debug")
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func HomeButtonAction(_ sender: Any) {
        
        mJCLogger.log("Starting", Type: "info")
        singleWorkOrder = WoHeaderModel()
        selectedNotificationNumber = ""
        currentMasterView = "Dashboard"
        let dashboard = ScreenManager.getDashBoardScreen()
        self.appDeli.window?.rootViewController = dashboard
        self.appDeli.window?.makeKeyAndVisible()
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- custom Navigation Delegate
    func leftMenuButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    func NewJobButtonClicked(_ sender: UIButton?){
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
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func refreshButtonClicked(_ sender: UIButton?){
        mJCLogger.log("Starting", Type: "info")
        mJCLoader.startAnimating(status: "Uploading".localized())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: false)
        })
        mJCLogger.log("Ended", Type: "info")
    }
    func threedotmenuButtonClicked(_ sender: UIButton?){}
    func backButtonClicked(_ sender: UIButton?){}
    
    @IBAction func searchButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        if(searchTextField.text == "") {
            self.searchTextField.endEditing(true)
            self.searchTextField.becomeFirstResponder()
        }
        let searchEle = self.assetHierarViewModel.displayArray.filter{($0.nodeName == "\(searchTextField.text!)")}
        if searchEle.count > 0{
            mJCLogger.log("Response:\(self.assetHierarViewModel.displayArray.count)", Type: "Debug")
            let index = self.assetHierarViewModel.displayArray.firstIndex(of: searchEle[0])
            let node = searchEle[0]
            node.isExpanded = true
            self.assetHierarViewModel.displayArray[index!] = node
            if index! <= self.assetHierarViewModel.displayArray.count{
                DispatchQueue.main.async{
                    self.AssetHierarchyTableView.reloadData()
                }
                let indexPath  = IndexPath(row: index!, section: 0)
                if self.AssetHierarchyTableView.isValidIndexPath(indexPath: indexPath){
                    self.AssetHierarchyTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        }else{
            mJCLogger.log("Data not found", Type: "Debug")
        }
        mJCLogger.log("Ended", Type: "info")
    }
    @IBAction func scanButtonAction(_ sender: Any) {}
}
