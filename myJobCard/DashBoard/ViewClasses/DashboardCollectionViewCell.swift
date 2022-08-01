//
//  myCollectionViewCell.swift
//  testgrid
//
//  Created by Rover Software on 23/05/17.
//  Copyright © 2017 Rover Software. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class DashboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var AddImage: UIImageView!
    @IBOutlet var centerImage: UIImageView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var workOrderSearchBtn: UIButton!

    @IBOutlet weak var CenterButton: UIButton!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet var assettitleview: UIView!
    @IBOutlet var hierachyview: UIView!
    @IBOutlet var assetMapView: UIView!
    @IBOutlet var hierachyButton: UIButton!
    @IBOutlet var assetMapButton: UIButton!

    @IBOutlet var button1View: UIView!
    @IBOutlet var button1ImageView: UIImageView!

    @IBOutlet var button2View: UIView!
    @IBOutlet var button2ImageView: UIImageView!
}

