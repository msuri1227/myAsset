//
//  StoreStatusVC.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 28/01/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class StoreStatusVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var storesStatusTable: UITableView!
    var storesList = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mJCLogger.log("Starting", Type: "info")
        let headerNib = UINib.init(nibName: "SettingTableViewCell", bundle: Bundle.main)
        storesStatusTable.register(headerNib, forCellReuseIdentifier: "SettingTableViewCell")
        
        let nib = UINib(nibName: "ExpandableTableViewCell", bundle: nil)
        storesStatusTable.register(nib, forCellReuseIdentifier: "ExpandableTableViewCell")
        let storeList = ODSStoreHelper.StoreDictionary.allKeys
        for obj in storeList {
            var dic = [String : Any]()
            let boolval = mJCStoreHelper.checkStoreStatus(StoreName: obj as! String)
            dic["status"] = boolval
            dic["title"] = obj
            storesList.append(dic)
        }
        self.storesStatusTable.dataSource = self
        self.storesStatusTable.delegate = self
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storesList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let customCell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as! SettingTableViewCell
        ODSUIHelper.setCornerRadiusToView(view: customCell.cellBGView, cornerRadius: 6.0)
        customCell.sideArrImg.isHidden = true
        let dic = self.storesList[indexPath.row] as? [String:Any]
        
        customCell.settingTitleLabel.text = dic?["title"] as? String
        customCell.settingsSwitch.isOn = (dic?["status"] as? Bool)!
        customCell.expandButton.isHidden = true
        customCell.settingsSwitch.isHidden = false
        customCell.settingsSwitch.isUserInteractionEnabled = false
        mJCLogger.log("Ended", Type: "info")
        return customCell
    }
    @IBAction func backBtnAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
}
