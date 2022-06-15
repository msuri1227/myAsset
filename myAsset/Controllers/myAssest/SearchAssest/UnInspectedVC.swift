//
//  UnInspectedVC.swift
//  myAsset
//
//  Created by Ruby's Mac on 07/06/22.
//

import UIKit
import ODSFoundation
import mJCLib


class UnInspectedVC: UIViewController {
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var selectedLbl: UILabel!
    @IBOutlet weak var selectedSV: UIStackView!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var unInspTableView: UITableView!
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
        //woObjectViewModel.unInspectVC = self
        woObjectViewModel.getObjectlist()
        unInspTableView.register(UINib(nibName: "SearchAssetCell_iPhone", bundle: nil), forCellReuseIdentifier: "SearchAssetCell_iPhone")
        unInspTableView.estimatedRowHeight = 160.0
        ODSUIHelper.setBorderToView(view:self.searchView, borderColor: UIColor(named: "mjcViewUIBorderColor") ?? UIColor.blue)
        self.totalLbl.text = "\(assetIdArr.count)"
        self.unInspTableView.allowsMultipleSelection = true
        selectedSV.isHidden = true
        // Do any additional setup after loading the view.
        
        reloadTableData()
    }
    @IBAction func barcodeScanTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func scanBtnTapped(_ sender: UIButton) {
    }

    @IBAction func closeBtnTapped(_ sender: UIButton) {
        selectedSV.isHidden = true
        
    }
    
    func reloadTableData() {
        mJCLogger.log("Starting", Type: "info")
        DispatchQueue.main.async {
            mJCLogger.log("Response :\(self.woObjectViewModel.objectListArray.count)", Type: "Debug")
            if self.woObjectViewModel.objectListArray.count > 0 && selectedworkOrderNumber != ""{
                self.unInspTableView.reloadData()
            }else{
                
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
}

extension UnInspectedVC:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assetIdArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAssetCell_iPhone") as! SearchAssetCell_iPhone? else {
          fatalError()
        }
        //cell.assetIdLbl.text = assetIdArr[indexPath.row]
        //cell.assetClassLbl.text = assetClsArr[indexPath.row]
//        cell.assetLbl.text = assetArr[indexPath.row]
//        cell.descLbl.text = descArr[indexPath.row]
//        cell.funcLocLbl.text = funcLocArr[indexPath.row]
//        cell.serialNumLbl.text = serialNumArr[indexPath.row]
        if selectedArr.contains(indexPath.row){
            cell.checkBoxBtn.setImage(UIImage(named: "ic_check_fill"), for: .normal)
        }else{
            cell.checkBoxBtn.setImage(UIImage(named: "ic_check_nil"), for: .normal)
        }
        cell.rightArrowbtn.isHidden = false
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didselectTapped")
       let cell:SearchAssetCell_iPhone = tableView.cellForRow(at: indexPath) as! SearchAssetCell_iPhone
        if selectedArr.contains(indexPath.row){
            let myInd = self.selectedArr.firstIndex(of: indexPath.row)
            //self.selectedArr.append(myInd!)
           // cell.checkBoxSelBtn.setImage(UIImage(named: "ic_check_nill"), for:.normal)
            self.selectedArr.remove(at: myInd!)
            self.selectedLbl.text = "\(selectedArr.count)"
            selectedSV.isHidden = true
//            self.selectedArr.removeAll()

        }else{
            selectedSV.isHidden = false
            selectedArr.append(indexPath.row)
            self.selectedLbl.text = "\(selectedArr.count)"
            //cell.checkBoxSelBtn.setImage(UIImage(named: "ic_check_fill"), for:.normal)
        }
        self.unInspTableView.reloadData()
    }
    
}
