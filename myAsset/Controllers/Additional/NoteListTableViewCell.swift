//
//  NoteListTableViewCell.swift
//  WorkOrder
//
//  Created by Ondevice Solutions on 11/10/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import mJCLib
import ODSFoundation

class NoteListTableViewCell: UITableViewCell {
    
    @IBOutlet var noteLabel: UILabel!
    var noteListClass: LongTextModel?{
        didSet{
            noteListConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func noteListConfiguration() {
        mJCLogger.log("Starting", Type: "info")
        if let noteListClass = noteListClass {
            self.backgroundColor = UIColor.blue
            self.noteLabel.text = noteListClass.TextLine
        }
        mJCLogger.log("Starting", Type: "info")
    }
}
