//
//  AssetHierarchyOverViewVC.swift
//  myJobCard
//
//  Created By Ondevice Solutions on 30/04/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class AssetHierarchyOverViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomNavigationBarDelegate {
    
    @IBOutlet weak var assetOverViewTable: UITableView!
    @IBOutlet weak var createNewJobButton: UIButton!
    @IBOutlet var iPhoneHeader: UIView!
    
    var selectedNumber = String()
    var assetHierarchyOverviewModel = AssetHierarchyOverviewViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        assetHierarchyOverviewModel.assetHierarchyOverviewVc = self
        ODSUIHelper.setButtonLayout(button: self.createNewJobButton, cornerRadius: self.createNewJobButton.frame.width/2, bgColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        ScreenManager.registerAssetHierarchyOverViewCell(tableView: self.assetOverViewTable)
        let view = CustomNavHeader_iPhone.init(viewcontroller: self, leftMenu: true, leftTitle: "OverView ".localized() , NewJobButton: false, refresButton: true, threedotmenu: false,leftMenuType:"Back")
        self.iPhoneHeader.addSubview(view)
        if flushStatus == true{
            view.refreshBtn.showSpin()
        }
        view.delegate = self
        assetHierarchyOverviewModel.getBasicData()
        if applicationFeatureArrayKeys.contains("NO_ADD_NOTI_OPTION"){
            self.createNewJobButton.isHidden = false
        }else{
            self.createNewJobButton.isHidden = true
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func upadteUIGetBasicData() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async{
            self.assetOverViewTable.reloadData()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Tableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 830.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        mJCLogger.log("Starting", Type: "info")
        let AssetHierarchyOverviewCell = ScreenManager.getAssetHierarchyOverViewCell(tableView: tableView)
        if assetHierarchyOverviewModel.SelectedArr.count > 0 {
            if assetHierarchyOverviewModel.TypeString == "EQ"{
                AssetHierarchyOverviewCell.assetHierarchyEquipmentModel = assetHierarchyOverviewModel.SelectedArr[0] as? EquipmentModel
            }else if assetHierarchyOverviewModel.TypeString == "FL"{
                AssetHierarchyOverviewCell.assetHierarchyFuncLocModelClass = assetHierarchyOverviewModel.SelectedArr[0] as? FunctionalLocationModel
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return AssetHierarchyOverviewCell
    }
    @IBAction func createNewJobAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        let workFlowResp = myAssetDataManager.uniqueInstance.getWorkFlowForAction(event: "CRTD_NEW_JOB", orderType: "X",from:"WorkOrder")
        if let workFlowObj = workFlowResp as? LtWorkFlowModel {
            if workFlowObj.ActionType == "Screen" {
                var equipPoints: String? = ""
                var funcLocPoints: String? = ""
                if assetHierarchyOverviewModel.TypeString == "EQ"{
                    EquipmentModel.getEquipmentDetails(equipNum: selectedNumber){(response, error)  in
                        if error == nil{
                            if let equip = response["data"] as? [EquipmentModel]{
                                if equip.count > 0{
                                    let equipmentdetails = equip[0]
                                    equipPoints = equipmentdetails.Equipment
                                    funcLocPoints = equipmentdetails.FuncLocation
                                }else{
                                    mJCLogger.log("Data not found", Type: "Debug")
                                }
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }
                }else if assetHierarchyOverviewModel.TypeString == "FL"{
                    funcLocPoints = selectedNumber
                }else{
                    equipPoints = ""
                    funcLocPoints = ""
                }
                menuDataModel.presentCreateJobScreen(vc: self, equipFromPoints: equipPoints, funcLocFromPoints: funcLocPoints, isScreen: "recordpoints")
            }
        }
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
        //           let createNewJobVC = ScreenManager.getCreateJobScreen()
        //           // self.modalPresentationStyle = UIModalPresentationStyle.popover
        //           createNewJobVC.isFromEdit = false
        //           createNewJobVC.isScreen = "WorkOrder"
        //           createNewJobVC.modalPresentationStyle = .fullScreen
        //           self.present(createNewJobVC, animated: false) {}
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
}
