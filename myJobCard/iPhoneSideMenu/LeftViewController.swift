//
//  LeftViewController.swift
//  SlideMenuDemo
//
//  Created by Ondevice Solutions on 26/02/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        

    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet var profilePetNameLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    var sideMenuImgArr = [UIImage]()
    var sideMenuListArr = [String]()
    var slideMenuType = String()
    let appDeli = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var lastSyncLabel: UILabel!
    
    var mainViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileView.layer.cornerRadius = self.profileView.frame.size.width / 2
        self.profileView.layer.borderColor = UIColor.white.cgColor
        self.profileView.layer.borderWidth = 1.0
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            self.profileNameLabel.text = userDisplayName
            self.profilePetNameLabel.text = userSystemID.lowercased()
        }
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
       
        

    }
    override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()

        if (UserDefaults.standard.value(forKey:"lastSyncDate") != nil) {
            
            let lastSyncDate = UserDefaults.standard.value(forKey:"lastSyncDate") as! Date
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(lastSyncDate.toString(format: .custom(localDateTimeFormate), timeZone: .utc, locale: .current))"
        }
        else {
            self.lastSyncLabel.text = "Last_sync".localized() + ": \(Date().toString(format: .custom(localDateTimeFormate),timeZone: .utc,locale: .current))"
        }
        
        if currentMasterView == "Notification"{

            
        }
        self.sideMenuTableView.reloadData()
    }
    
    // MARK: UITableView DataSource & Delegate Methods
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
        
    }
 
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sideMenuListArr.count
        
        
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let sideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableCell", for: indexPath) as! SideMenuTableCell
        sideMenuCell.countLabel.text = ""
        sideMenuCell.countLabel.textColor = UIColor.clear
        sideMenuCell.sideMenuImg.image = sideMenuImgArr[indexPath.row]
        sideMenuCell.sideMenuNameLbl.text = sideMenuListArr[indexPath.row]
        if sideMenuCell.sideMenuNameLbl.text == "Operations".localized(){
            sideMenuCell.countLabel.text = OprCount
            sideMenuCell.countLabel.textColor = OprColor
        }else if sideMenuCell.sideMenuNameLbl.text == "Inspection_Lot".localized(){
            if inspCount != "" || inspCount != "0" {
                sideMenuCell.countLabel.text = inspCount
                sideMenuCell.countLabel.textColor = InspColor
            }
        }else if sideMenuCell.sideMenuNameLbl.text == "Components".localized(){
            sideMenuCell.countLabel.text = cmpCount
            sideMenuCell.countLabel.textColor = cmpColor
        }else if sideMenuCell.sideMenuNameLbl.text == "Attachments".localized(){
            if currentMasterView == "Notification" && selectedTask == ""{
                sideMenuCell.countLabel.text = noAttchmentCount
                sideMenuCell.countLabel.textColor = noAttchmentColor
            }else{
                sideMenuCell.countLabel.text = attchmentCount
                sideMenuCell.countLabel.textColor = attchmentColor
            }
        }else if sideMenuCell.sideMenuNameLbl.text == "Checklists".localized(){
            sideMenuCell.countLabel.text = formCount
            sideMenuCell.countLabel.textColor = formColor
        }else if sideMenuCell.sideMenuNameLbl.text == "Record_Points".localized(){
            sideMenuCell.countLabel.text = rpCount
            sideMenuCell.countLabel.textColor = rpColor
        }else if sideMenuCell.sideMenuNameLbl.text ==  "Objects".localized(){
            sideMenuCell.countLabel.text = objectCount
            sideMenuCell.countLabel.textColor = appColor
        }else if sideMenuCell.sideMenuNameLbl.text == "Items".localized(){
            sideMenuCell.countLabel.text = ItemCount
            sideMenuCell.countLabel.textColor = ItemColor
        }else if sideMenuCell.sideMenuNameLbl.text == "Activities".localized(){
            if currentsubView == "Items" && selectedItem != ""{
                sideMenuCell.countLabel.text = ItemActvityCount
                sideMenuCell.countLabel.textColor = ItemActvityColor
            }else{
                sideMenuCell.countLabel.text = ActvityCount
                sideMenuCell.countLabel.textColor = ActvityColor
            }
        }else if sideMenuCell.sideMenuNameLbl.text == "Tasks".localized(){
            if currentsubView == "Items" && selectedItem != ""{
                sideMenuCell.countLabel.text = ItemTaskCount
                sideMenuCell.countLabel.textColor = ItemTaskColor
            }else{
                sideMenuCell.countLabel.text = TaskCount
                sideMenuCell.countLabel.textColor = TaskColor
            }
        }else if sideMenuCell.sideMenuNameLbl.text == "Causes".localized(){
            sideMenuCell.countLabel.text = ItemCauseCount
            sideMenuCell.countLabel.textColor = ItemCauseColor
        }else{
            sideMenuCell.countLabel.text = ""
        }
        if sideSelectedMenu == sideMenuCell.sideMenuNameLbl.text{
            sideMenuCell.sideMenuCellView.backgroundColor =  selectionBgColor
        }else{
            sideMenuCell.sideMenuCellView.backgroundColor = .clear
        }
        return sideMenuCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let cell = tableView.cellForRow(at: indexPath) as! SideMenuTableCell
        sideSelectedMenu = "\(cell.sideMenuNameLbl.text!)"
        self.changeViewController(index: indexPath.row, title: cell.sideMenuNameLbl.text!)

        
    }
    func changeViewController(index:Int,title:String) {
        if nil == self.mainViewController {
            self.mainViewController = myAssetDataManager.uniqueInstance.navigationController
        }
        switch title {
        case "Home".localized():
            menuDataModel.uniqueInstance.presentDashboardScreen()
        case "Work_Orders".localized():
            UserDefaults.standard.removeObject(forKey: "ListFilter")
            onlineSearch = false
            currentMasterView = "WorkOrder"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            if nil != myAssetDataManager.uniqueInstance.navigationController {
                myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            }
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
            
        case "Job_Location".localized():
            UserDefaults.standard.removeObject(forKey: "ListFilter")
            self.slideMenuController()?.changeMainViewController(self.mainViewController,                     close: true, index: index, title: title, menuType: "")
            
        case "Notifications".localized():
            UserDefaults.standard.removeObject(forKey: "ListFilter")
            onlineSearch = false
            currentMasterView = "Notification"
            let mainViewController = ScreenManager.getMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            
            if nil != myAssetDataManager.uniqueInstance.navigationController {
                myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            }
            myAssetDataManager.uniqueInstance.slideMenuController?.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
            
        case "Time_Sheet".localized():
            currentMasterView = "TimeSheet"
            
            let mainViewController = ScreenManager.getTimeSheetScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        case "Asset_Map".localized() :
            currentMasterView = "MapSplitViewController"
            self.slideMenuController()?.changeMainViewController(self.mainViewController,                     close: true, index: index, title: title, menuType: "")
        case "Overview".localized() :       currentsubView = "Overview"
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Operations".localized() :     currentsubView = "Operations"
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Components".localized() :     currentsubView = "Components"
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Inspection_Lot".localized() :     currentsubView = "Inspection Lot"
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Attachments".localized() :
            currentsubView = "Attachments"
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Checklists".localized() : self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Record_Points".localized() : self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Objects".localized() : self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "History".localized() : self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Pending".localized() :
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Items".localized() :
            currentsubView = "Items"
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Activities".localized() :
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Tasks".localized() :
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Master_Data_Refresh".localized() :
            
            mJCLoader.startAnimating(status: "Uploading".localized())
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                
                myAssetDataManager.uniqueInstance.flushAndRefreshStores(masterDataRefresh: true)
            })
        case "Equipment".localized() :
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
            
        case "Settings".localized():
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Log_Out".localized(): myAssetDataManager.uniqueInstance.logOutApp()
        case "Classification".localized():
            currentsubView = "Classification"
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "Installed_Equipments".localized():
            currentsubView = "InstalledEquipments"
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
        case "BreakDown_Report".localized():
            currentsubView = "BreakDown Report"
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index, title: title,menuType: slideMenuType)
            
            
        default:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true, index: index,title: title,menuType: slideMenuType)
        }
    }

    //MARK:-Show Alert..
    func showAlert(titleType: String, errorMessage: String) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: titleType, message: errorMessage as String, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: okay, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

