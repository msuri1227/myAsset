//
//  InspectedVC.swift
//  myAsset
//
//  Created by Ruby's Mac on 07/06/22.
//

import UIKit
import ODSFoundation
import mJCLib

class InspectedVC: UIViewController {

    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var inspectionTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    var assetIdArr = [" 20092 20092","20093"," 20095","20097","20098","20098"]
    var assetArr = [" 10092 10092 10092","10093"," 20099","20001","20012","20098"]
    var assetClsArr = ["polycon systems","Lg Refregrator Lg Refregrator Lg Refregrator Lg Refregrator","samsungSplit Ac","Lg Washing Machine","Orient Air Coller","20098"]
    var descArr = ["2000-office equipments 2000-office equip","2000-office equipments 2000-office equipment","2000-office equipments 2000-office equipment","2000-office equipments 2000-office equipment","22000-office equipments 2000-office equipment","20098"]
    var funcLocArr = ["BLDG-AAb-Ab-02 BLDG-AAb-Ab-02","BLDG-AAb-Ab-023","BLDG-AAb-Ab-0234","BLDG-AAb-Ab-029","BLDG-AAb-Ab-026","20098"]
    var serialNumArr = ["g678nggbdg g678nggbdg","h678nggbdg","y678nggbdg","k678nggbdg","l678nggbdg","20098"]
    
    var woObjectViewModel = WorkOrderObjectsViewModel()
    var selectedArr:[Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inspectionTableView.estimatedRowHeight = 160.0
        ODSUIHelper.setBorderToView(view:self.searchView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.totalLbl.text = "\(assetIdArr.count)"
        self.inspectionTableView.allowsMultipleSelection = true
    }
    
    func reloadTableData() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("Response :\(self.woObjectViewModel.objectListArray.count)", Type: "Debug")
            if self.woObjectViewModel.objectListArray.count > 0 && selectedworkOrderNumber != ""{
                self.inspectionTableView.reloadData()
            }else{
                
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK: - Button Action Methods
    @IBAction func barcodeScanTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func scanBtnTapped(_ sender: UIButton) {
    }

}

//MARK: - Tableview Datasource & Delegate Methods
extension InspectedVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assetIdArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScreenManager.getInspectedCell(tableView: tableView)
//        cell.assetLbl.text = assetArr[indexPath.row]
//        cell.descLbl.text = descArr[indexPath.row]
//        cell.funcLocLbl.text = funcLocArr[indexPath.row]
//        cell.serialNumLbl.text = serialNumArr[indexPath.row]
//        
        cell.rightArrowbtn.isHidden = false
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didselectTapped")
    }
}
