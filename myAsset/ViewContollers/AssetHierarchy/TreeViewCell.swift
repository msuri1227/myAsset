//
//  TreeViewCell.swift
//  TreeView1
//
//  Created by Cindy Oakes on 5/19/16.
//  Copyright © 2016 Cindy Oakes. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class TreeViewCell: UITableViewCell
{
    
    //MARK:  Properties & Variables
    
    @IBOutlet weak var treeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var treeButtonWidthConstant: NSLayoutConstraint!
    
    var treeNode: TreeViewNode!
    var indexPath = IndexPath()
    var assetHierViewModel = AssetHierarViewModel()
    
    var treeViewModelClass : TreeViewNode? {
        didSet{
            treeViewDataConfiguration()
        }
    }
    
    
    //MARK:  Draw Rectangle for Image
    
    override func draw(_ rect: CGRect) {
        mJCLogger.log("Starting", Type: "info")
        var cellFrame: CGRect = self.titleLabel.frame
        var cellFrame1: CGRect = self.descriptionLabel.frame
        var buttonFrame: CGRect = self.treeButton.frame
        var imgframe: CGRect = self.typeImg.frame
        let indentation: Int = self.treeNode.nodeLevel! * 25
        cellFrame.origin.x = buttonFrame.size.width + imgframe.size.width + CGFloat(indentation) + 5
        buttonFrame.origin.x = 2 + CGFloat(indentation)
        cellFrame1.origin.x =  buttonFrame.size.width + imgframe.size.width + CGFloat(indentation) + 5
        imgframe.origin.x = buttonFrame.size.width + 2 + CGFloat(indentation)
        self.titleLabel.frame = cellFrame
        self.descriptionLabel.frame = cellFrame1
        self.treeButton.frame = buttonFrame
        self.typeImg.frame = imgframe
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:  Set Background image
    
    func setTheButtonBackgroundImage(backgroundImage: UIImage)
    {
        mJCLogger.log("Starting", Type: "info")
        self.treeButton.setBackgroundImage(backgroundImage, for: .normal)
        mJCLogger.log("Ended", Type: "info")
    }
    
    //MARK:  Expand Node
    
    @IBAction func expand(sender: AnyObject)
    {
        mJCLogger.log("Starting", Type: "info")
        if (self.treeNode != nil)
        {
            if self.treeNode.nodeChildren != nil
            {
                if self.treeNode.isExpanded == true
                {
                    self.treeNode.isExpanded = false
                }
                else
                {
                    self.treeNode.isExpanded = true
                }
            }
            else
            {
                self.treeNode.isExpanded = false
            }
            
            self.isSelected = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TreeNodeButtonClicked"), object: self.treeNode)
            
        }
        mJCLogger.log("Ended", Type: "info")
    }
    
    func treeViewDataConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let node = treeViewModelClass {
            
            
            let type = node.nodeType!
            
            self.titleLabel.text = "\(node.nodeName ?? "" as String)"
            self.descriptionLabel.text = "\(node.nodeDesc ?? ""  as String)"
            
            if (node.isExpanded == true)
            {
                self.treeButton.setImage(UIImage(named: "DownArrow"), for: .normal)
            }
            else
            {
                self.treeButton.setImage(UIImage(named: "next_arrow"), for: .normal)
            }
            if node.nodeChildren?.count == nil{
                self.treeButton.isHidden = true
            }else{
                self.treeButton.isHidden = false
            }
            if type == "EQ"{
                self.typeImg.image = UIImage(named: "components")
            }else if type == "FL"{
                self.typeImg.image = UIImage(named: "location")
            }else{
                self.typeImg.isHidden = true
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
