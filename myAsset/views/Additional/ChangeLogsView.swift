//
//  OnlineNotification.swift
//  myJobCard
//
//  Created by Ondevice Solutions on 12/05/20.
//  Copyright © 2020 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class ChangeLogsView: UIView,UITableViewDelegate,UITableViewDataSource{
    

    @IBOutlet var chageLogTableView: UITableView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var noDataView: UIView!

    var versionChangesArray = [String]()

    func loadNibView(){

        self.chageLogTableView.register(UINib(nibName: "chageLogTableCell", bundle: nil), forCellReuseIdentifier: "chageLogTableCell")
        self.chageLogTableView.delegate = self
        self.chageLogTableView.dataSource = self

        if let path = Bundle.main.path(forResource: "changes", ofType: "plist") {
            if let rootDict = NSDictionary(contentsOfFile: path){
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                let buildversion  = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
                if let versionChangesArr =  rootDict["\(version)_\(buildversion)"] as? [String]{
                    versionChangesArray = versionChangesArr.filter{$0 != ""}
                    DispatchQueue.main.async {
                        if self.versionChangesArray.count > 0{
                            self.chageLogTableView.reloadData()
                            self.chageLogTableView.isHidden = false
                            self.noDataView.isHidden = true
                        }else{
                            self.chageLogTableView.isHidden = true
                            self.noDataView.isHidden = false
                        }
                    }
                }
            }
        }
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        removeFromSuperview()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.versionChangesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.chageLogTableView.dequeueReusableCell(withIdentifier: "chageLogTableCell") as! chageLogTableCell
        cell.featureTextLabel.text = self.versionChangesArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

