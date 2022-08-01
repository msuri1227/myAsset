//
//  SupervisorTimeSheetVC.swift
//  myJobCard
//
//  Created by Rover Software on 30/06/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class SupervisorTimeSheetVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var totalEntries: UILabel!
    @IBOutlet var timeSheetTableView: UITableView!
    
    var technicianid = String()
    var TechnicianName = String()
    var superTimeViewModel = SuperTimeSheetViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mJCLogger.log("Starting", Type: "info")
        superTimeViewModel.vc = self
        self.timeSheetTableView.bounces = false
        self.timeSheetTableView.delegate = self
        self.timeSheetTableView.dataSource = self
        self.timeSheetTableView.estimatedRowHeight = 130.0
        self.timeSheetTableView.separatorStyle = .none
        ScreenManager.registerTimeSheetsCell(tableView: self.timeSheetTableView)
        self.superTimeViewModel.gettimesheetreacords()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:- UITableview Delegate & DataSource..
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.superTimeViewModel.timeSheetArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mJCLogger.log("Starting", Type: "info")
        let timeSheetsCell = ScreenManager.getTimeSheetsCell(tableView: tableView)
        let timeSheetClass = self.superTimeViewModel.timeSheetArray[indexPath.row]
        timeSheetsCell.indexPath = indexPath as NSIndexPath
        timeSheetsCell.superTimeViewModel = superTimeViewModel
        timeSheetsCell.supTimesheetClass = timeSheetClass
        mJCLogger.log("Ended", Type: "info")
        return timeSheetsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        mJCLogger.log("Starting", Type: "info")
        let timeSheetClass = self.superTimeViewModel.timeSheetArray[indexPath.row] 
        
        if timeSheetClass.isExpand == true {
            mJCLogger.log("Ended", Type: "info")
            return 150.0
        }else {
            mJCLogger.log("Ended", Type: "info")
            return 80.0
        }
    }
    //MARK:- UITableview Cell Button Action..
    @objc func timeSheetClickButtonAction(sender : UIButton) {
        mJCLogger.log("Starting", Type: "info")
        let timeSheetClass = self.superTimeViewModel.timeSheetArray[sender.tag] 
        if timeSheetClass.isExpand == true {
            timeSheetClass.isExpand = false
        }else {
            timeSheetClass.isExpand = true
        }
        timeSheetTableView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
