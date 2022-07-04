//
//  MessageTableViewCell.swift
//  YanaSDK
//
//  Created by mounika on 18/05/19.
//  Copyright © 2019 Naresh. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var responseTextView: UITextView!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    let maskLayer1 = CAShapeLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageTextView.textAlignment = .left

        selectedBackgroundView?.backgroundColor = .clear
        messageTextView.textContainerInset =
            UIEdgeInsets(top: 8,left: 10,bottom: 8,right: 10)
    }
    
    func configData(messages: NSDictionary) {
        self.messageTextView.text = messages["message"] as? String
        if let date = messages["time"] as? String {
            var tim = date.components(separatedBy: " ")
            self.dateLbl.text = tim[4] + " " +  tim[5]
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
