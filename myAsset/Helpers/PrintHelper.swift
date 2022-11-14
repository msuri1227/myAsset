//
//  printHelper.swift
//  myAsset
//
//  Created by Rover Software on 15/06/22.
//  Copyright © 2022 Ondevice Solutions. All rights reserved.
//

import Foundation
import ODSFoundation
import mJCLib
class PrintHelper{
    
    public static let appDeli = UIApplication.shared.delegate as! AppDelegate
    
    public static func createQRCodeView(asseID:String,assetDesc:String) -> UIImage{
        
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        let assetQRCodeimgview = UIImageView()
        let qrcodeImg = UIImage(qrCode: asseID)
        assetQRCodeimgview.contentMode = .scaleAspectFit
        assetQRCodeimgview.translatesAutoresizingMaskIntoConstraints = false
        assetQRCodeimgview.image = qrcodeImg
        mainView.addSubview(assetQRCodeimgview)
        
        //Image view Constraints to sent into middle
        let centerXConst = NSLayoutConstraint(item: assetQRCodeimgview, attribute: .centerX, relatedBy: .equal, toItem: mainView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConst = NSLayoutConstraint(item: assetQRCodeimgview, attribute: .centerY, relatedBy: .equal, toItem: mainView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: assetQRCodeimgview, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0)
        let widthConstraint = NSLayoutConstraint(item: assetQRCodeimgview, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.appDeli.window!.rootViewController!.view.frame.width / 2)
        assetQRCodeimgview.addConstraints([heightConstraint, widthConstraint])
        NSLayoutConstraint.activate([centerXConst, centerYConst])
        
        // asset Title lable
        let assetTitleLabel = UILabel()
        assetTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        assetTitleLabel.text = "AssetID: \(asseID)"
        assetTitleLabel.textAlignment = .center
        mainView.addSubview(assetTitleLabel)
        
        let assetTitleMargine = mainView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            assetTitleLabel.topAnchor.constraint(equalTo: assetTitleMargine.topAnchor, constant: 170),
            assetTitleLabel.leadingAnchor.constraint(equalTo: assetTitleMargine.leadingAnchor),
            assetTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            assetTitleLabel.trailingAnchor.constraint(equalTo: assetTitleMargine.trailingAnchor)
        ])
        
        let assetDescLbl = UILabel()
        assetDescLbl.translatesAutoresizingMaskIntoConstraints = false
        assetDescLbl.numberOfLines = 0
        assetDescLbl.lineBreakMode = .byWordWrapping
        assetDescLbl.text = "Description: \(assetDesc)"
        assetDescLbl.textAlignment = .center
        mainView.addSubview(assetDescLbl)
        
        let assetDescMargine = mainView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            assetDescLbl.topAnchor.constraint(equalTo: assetQRCodeimgview.topAnchor, constant: -70),
            assetDescLbl.leadingAnchor.constraint(equalTo: assetDescMargine.leadingAnchor),
            assetDescLbl.heightAnchor.constraint(equalToConstant: 40),
            assetDescLbl.trailingAnchor.constraint(equalTo: assetDescMargine.trailingAnchor)
        ])
        return mainView.toImage()
    }
    public static func printQrCode(document:Any,assetId:String){
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfo.OutputType.general
        printInfo.jobName = "\(assetId)"
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.printingItem = document
        printController.present(animated: false)
    }
}
extension UIImage {
    convenience init?(qrCode: String) {
        let data = qrCode.data(using: .ascii)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }
        self.init(ciImage: ciImage)
    }
}
