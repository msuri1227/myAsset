//
//  CheckSheetOptionsCell.swift
//  myJobCard
//
//  Created by Suri on 27/05/21.
//  Copyright © 2021 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import FormsEngine
import mJCLib

class CheckSheetOptionsCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet var formTitleLabel: UILabel!
    @IBOutlet var optionalButton: UIButton!
    @IBOutlet var mandatoryButton: UIButton!
    @IBOutlet var singleOccurrenceButton: UIButton!
    @IBOutlet var multipleOccurrenceButton: UIButton!
    @IBOutlet var minusButtton: UIButton!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var occurrenceTxtField: UITextField!
    @IBOutlet var occurrenceFillStackView: UIStackView!
    
    @IBOutlet var viewButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    var indexPath: IndexPath!
    var formMasterModel: FormMasterMetaDataModel?{
        didSet{
            configAssignmentData()
        }
    }
    var CSAssignmentVC: CheckSheetAssignmentVC?
    override func awakeFromNib() {
        super.awakeFromNib()
        ODSUIHelper.setBorderToView(view: occurrenceTxtField, borderColor: appColor)
        occurrenceTxtField.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configAssignmentData() {
        
        formTitleLabel.text = "\(formMasterModel!.FormName) - \(formMasterModel!.Version)"
        if formMasterModel!.multiOccur == true{
            self.singleOccurrenceButton.isSelected = false
            self.multipleOccurrenceButton.isSelected = true
            self.occurrenceFillStackView.isHidden = false
        }else{
            self.singleOccurrenceButton.isSelected = true
            self.multipleOccurrenceButton.isSelected = false
            self.occurrenceFillStackView.isHidden = true
        }
        if formMasterModel!.mandatory == true{
            self.optionalButton.isSelected = false
            self.mandatoryButton.isSelected = true
        }else{
            self.optionalButton.isSelected = true
            self.mandatoryButton.isSelected = false
        }
        singleOccurrenceButton.tag = indexPath.row
        multipleOccurrenceButton.tag = indexPath.row
        occurrenceTxtField.tag = indexPath.row
        singleOccurrenceButton.addTarget(self, action: #selector(singleOccurrenceButtonAction(sender:)), for: .touchUpInside)
        multipleOccurrenceButton.addTarget(self, action: #selector(multipleOccurrenceButtonAction(sender:)), for: .touchUpInside)
        occurrenceTxtField.addTarget(self, action: #selector(occurrenceTxtFieldTxtEnd(sender:)), for: .editingChanged)
    }
    
    @IBAction func optionalButtonAction(_ sender: Any) {
        self.optionalButton.isSelected = true
        self.mandatoryButton.isSelected = false
        let tag = (sender as! UIButton).tag
        CSAssignmentVC?.selectedFormsArray[tag].mandatory = false
    }
    @IBAction func mandatoryButtonAction(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        CSAssignmentVC?.selectedFormsArray[tag].mandatory = true
        self.mandatoryButton.isSelected = true
        self.optionalButton.isSelected = false
    }
    @objc func occurrenceTxtFieldTxtEnd(sender: UITextField){
        let tag = sender.tag
        let cls = CSAssignmentVC?.selectedFormsArray[tag]
        cls?.occur = Int(sender.text ?? "") ?? 0
    }
    @objc func singleOccurrenceButtonAction(sender : UIButton) {
        self.singleOccurrenceButton.isSelected = true
        self.multipleOccurrenceButton.isSelected = false
        self.occurrenceFillStackView.isHidden = true
        self.CSAssignmentVC?.selectedFormsArray[sender.tag].multiOccur = false
        self.CSAssignmentVC?.checkSheetListTableView.reloadData()
    }
    @objc func multipleOccurrenceButtonAction(sender: UIButton) {
        self.singleOccurrenceButton.isSelected = false
        self.multipleOccurrenceButton.isSelected = true
        self.occurrenceFillStackView.isHidden = false
        self.CSAssignmentVC?.selectedFormsArray[sender.tag].multiOccur = true
        self.CSAssignmentVC?.checkSheetListTableView.reloadData()
    }
    @IBAction func minusButtonAction(_ sender: Any) {
        let value = Int(self.occurrenceTxtField.text ?? "0") ?? 0
        if value != 0{
            self.occurrenceTxtField.text = "\(value - 1)"
        }else{
            self.occurrenceTxtField.text = "0"
        }
    }
    @IBAction func plusButtonAction(_ sender: Any) {
        let value = Int(self.occurrenceTxtField.text ?? "0") ?? 0
        self.occurrenceTxtField.text = "\(value + 1)"
    }
    @objc func editButtonAction(sender: Any) {
        DispatchQueue.main.async{
            let popView = Bundle.main.loadNibNamed("EditCheckSheetOptionsView", owner: self, options: nil)?.last as! EditCheckSheetOptionsView
            let screenFrame = UIScreen.main.bounds
            popView.frame = screenFrame
            popView.popUpViewUI()
            UIApplication.shared.windows.first!.addSubview(popView)
        }
    }
    @objc func deleteButtonAction(sender: UIButton) {
        DispatchQueue.main.async {
            self.CSAssignmentVC?.selectedFormsArray.remove(at: sender.tag)
            self.CSAssignmentVC?.checkSheetListTableView.reloadData()
        }
    }
    @objc func viewButtonAction(sender: Any) {
    }
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.occurrenceTxtField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
