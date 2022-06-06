//
//  TabCell.swift
//  PolioPager
//
//  Created by Yuiga Wada on 2019/08/22.
//  Copyright © 2019 Yuiga Wada. All rights reserved.
//

import UIKit

// imageが優先される
public struct TabItem {
    var title: String?
    var image: UIImage?
    var font: UIFont
    var cellWidth: CGFloat?
    var backgroundColor: UIColor
    var normalColor: UIColor
    var highlightedColor: UIColor

    public init(title: String? = nil,
                image: UIImage? = nil,
                font: UIFont = .boldSystemFont(ofSize: 14),
                cellWidth: CGFloat? = nil,
                backgroundColor: UIColor = .black,
                normalColor: UIColor = .black, // .red, //for debug.
                highlightedColor: UIColor = .black) {
        self.title = title
        self.image = image
        self.font = font
        self.cellWidth = cellWidth
        self.backgroundColor = backgroundColor
        self.normalColor = normalColor
        self.highlightedColor = highlightedColor
    }
}

public protocol TabCellDelegate {
    func moveTo(index: Int)
    var pageViewController: PageViewController { get set }
}

class TabCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet var selectedView: UIView!
    @IBOutlet var cellView: UIView!
    
    public var index: Int = 0
    public var delegate: TabCellDelegate?
    
    var indexPath = IndexPath()
    var detailViewModel = DetailViewModel()
    var tabModelClass : TabItem? {
        didSet{
            tabDataConfiguration()
        }
    }
    var detailModelClass : TabItem? {
        didSet{
            detailTabDataConfiguration()
        }
    }
    var suspendModel: TabItem?{
        didSet{
            suspendVcCollecionCellConfiguration()
        }
    }
    var flocEquipModel: TabItem?{
        didSet{
            flocEquipCollecionCellConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.sizeToFit()
        imageView.contentMode = .scaleAspectFill
        setupGesture()
    }
    
    override func layoutSubviews() {
        backgroundColor = .clear
        super.layoutSubviews()
    }
    
    private func setupGesture() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
        
        addGestureRecognizer(singleTapGesture)
    }
    
    @objc func singleTap(_ gesture: UITapGestureRecognizer) {
        guard let delegate = delegate else { return }
        delegate.moveTo(index: index)
    }
    
    func tabDataConfiguration() {
        DispatchQueue.main.async { [self] in
            if let team = tabModelClass {
                index = indexPath.row
                countLabel.layer.cornerRadius = countLabel.frame.size.height/2
                countLabel.layer.masksToBounds = true
                titleLabel.textColor = appColor
                titleLabel.font = team.font
                imageView.image = team.image
                titleLabel.isHidden = false
                titleLabel.text = team.title
                titleLabel.font = .systemFont(ofSize: 16)
                selectedView.tag = indexPath.row
                isUserInteractionEnabled = true
                if selectedIndex == indexPath.row{
                    selectedView.backgroundColor = appColor
                }else{
                    self.selectedView.backgroundColor = .white
                }
                countLabel.isHidden = true
            }
        }
    }
    func detailTabDataConfiguration() {

        DispatchQueue.main.async { [self] in
            if let item = detailModelClass {
                countLabel.layer.cornerRadius = countLabel.frame.size.height/2
                countLabel.layer.masksToBounds = true
                titleLabel.textColor = appColor
                titleLabel.isHidden = false
                titleLabel.text = item.title
                titleLabel.font = .systemFont(ofSize: 16)
                imageView.image = item.image
                selectedView.tag = indexPath.row
                isUserInteractionEnabled = true
                countLabel.isHidden = true
                if titleLabel.text == "History_Pending".localized() || titleLabel.text == "Overview".localized() {
                    countLabel.isHidden = true
                }
                if currentMasterView == "WorkOrder" {
                    if titleLabel.text == "Operations".localized() {
                        if OprCount != "" && OprCount != "0"{
                            countLabel.text = OprCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = OprColor
                        }
                    }
                    if titleLabel.text == "Inspection_Lot".localized(){
                        if inspCount != "" && inspCount != "0" {
                            countLabel.text = inspCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = InspColor
                        }
                    }else  if titleLabel.text == "Components".localized() {
                        if cmpCount != "" && cmpCount != "0"{
                            countLabel.text = cmpCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = cmpColor
                        }
                    }
                    if titleLabel.text == "Attachments".localized() {
                        if attchmentCount != "" && attchmentCount != "0"{
                            countLabel.text = attchmentCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = attchmentColor
                        }
                    }
                    if titleLabel.text == "Checklists".localized() {
                        if formCount != "" && formCount != "0"{
                            countLabel.text = formCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = formColor
                        }
                    }
                    if titleLabel.text == "Record_Points".localized() {
                        if rpCount != "" && rpCount != "0"{
                            countLabel.text = rpCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = rpColor
                        }
                    }
                    if titleLabel.text == "Objects".localized() {
                        if objectCount != "" && objectCount != "0"{
                            countLabel.isHidden = false
                            countLabel.text = objectCount
                            countLabel.backgroundColor = appColor
                        }
                    }
                }else if currentMasterView == "Notification"{
                    if titleLabel.text == "Items".localized() {
                        if ItemCount != "" && ItemCount != "0"{
                            countLabel.text = ItemCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = appColor
                        }
                    }
                    if titleLabel.text == "Activities".localized() {
                        if ActvityCount != "" && ActvityCount != "0"{
                            countLabel.text = ActvityCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = appColor
                        }
                    }
                    if titleLabel.text == "Tasks".localized() {
                        if TaskCount != "" && TaskCount != "0"{
                            countLabel.text = TaskCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = appColor
                        }
                    }
                    if titleLabel.text == "Attachments".localized() {
                        if noAttchmentCount != "" && noAttchmentCount != "0"{
                            countLabel.text = noAttchmentCount
                            countLabel.isHidden = false
                            countLabel.backgroundColor = appColor
                        }
                    }
                }
            }
        }
    }
    func suspendVcCollecionCellConfiguration(){
        DispatchQueue.main.async { [self] in
            countLabel.isHidden = true
            titleLabel.isHidden = false
            isUserInteractionEnabled = true
            titleLabel.textColor = appColor
            titleLabel.text = suspendModel?.title
            titleLabel.font = .systemFont(ofSize: 16)
            imageView.image = suspendModel?.image
        }
    }
    func flocEquipCollecionCellConfiguration(){
        DispatchQueue.main.async { [self] in
            countLabel.isHidden = true
            titleLabel.isHidden = false
            isUserInteractionEnabled = true
            titleLabel.textColor = appColor
            titleLabel.text = flocEquipModel?.title
            titleLabel.font = .systemFont(ofSize: 16)
            imageView.image = flocEquipModel?.image
        }
    }
}
