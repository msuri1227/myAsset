//
//  CustomNavHeader_iPhone.swift
//  myJobCard
//
//  Created by Rover Software on 22/03/19.
//  Copyright © 2019 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation

@objc protocol CustomNavigationBarDelegate: NSObjectProtocol {
    @objc optional func leftMenuButtonClicked(_ sender: UIButton?)
    @objc optional func NewJobButtonClicked(_ sender: UIButton?)
    @objc optional func refreshButtonClicked(_ sender: UIButton?)
    @objc optional func threedotmenuButtonClicked(_ sender: UIButton?)
    @objc optional func backButtonClicked(_ sender: UIButton?)
    
}

class CustomNavHeader_iPhone: UIView {
    
    weak var delegate: CustomNavigationBarDelegate?
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var menuBtn: UIButton!
    @IBOutlet var jobBtn: UIButton!
    @IBOutlet var refreshBtn: UIButton!
    @IBOutlet var dotBtn: UIButton!
    

    convenience init(viewcontroller: UIViewController,backButton: Bool = false, leftMenu: Bool,leftTitle:String,NewJobButton:Bool,refresButton:Bool,threedotmenu:Bool,leftMenuType:String) {
        
        self.init()
        commonInit()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"setNavTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CustomNavHeader_iPhone.setNavTitle(notification:)), name:NSNotification.Name(rawValue:"setNavTitle"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"HideDotMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CustomNavHeader_iPhone.HideDotMenu(notification:)), name:NSNotification.Name(rawValue:"HideDotMenu"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"ShowDotMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CustomNavHeader_iPhone.ShowDotMenu(notification:)), name:NSNotification.Name(rawValue:"ShowDotMenu"), object: nil)
        
       
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)
       
        NotificationCenter.default.addObserver(self, selector: #selector(CustomNavHeader_iPhone.backGroundSyncStarted(notification:)), name:NSNotification.Name(rawValue:"BgSyncStarted"), object: nil)

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)
            
        NotificationCenter.default.addObserver(self, selector: #selector(CustomNavHeader_iPhone.storeFlushAndRefreshDone(notification:)), name: NSNotification.Name(rawValue:"storeFlushAndRefreshDone"), object: nil)

        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let height: CGFloat = 60
        if UIScreen.main.nativeBounds.height == 2436 {
            self.frame = CGRect(x: 0, y: statusBarHeight , width: screenWidth, height: height)
        }else {
            if #available(iOS 11.0, *) {
                self.frame = CGRect(x: safeAreaInsets.left, y: statusBarHeight, width: screenWidth, height: height)
            } else {
                self.frame = CGRect(x: 0, y: statusBarHeight, width: screenWidth, height: height)
            }
        }
        self.backgroundColor = appColor
        viewcontroller.navigationController?.navigationBar.barTintColor = appColor
        if backButton == true {
            backBtn.setImage(UIImage(named: "backButton"), for: .normal)
            backBtn.addTarget(self, action: #selector(self.backButtonAction), for: .touchUpInside)
            backBtn.isHidden = false
        }
        
        if leftMenu == true{
            
            if leftMenuType == "Back"{
                menuBtn.setImage(UIImage(named: "backButton"), for: .normal)
            }else{
                menuBtn.setImage(UIImage(named: "menu"), for: .normal)
            }
            menuBtn.addTarget(self, action: #selector(self.leftMenuButtonAction(sender:)), for: .touchUpInside)
            
            menuBtn.isHidden = false
        }
        
        if leftTitle != ""{
            
            titleLbl.text = leftTitle
            titleLbl.textColor = UIColor.white
            titleLbl.textAlignment = .left
            titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
            if leftMenu == false {
                titleLbl.text = "Welcome \(leftTitle)"
                titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
            }
            titleLbl.isHidden = false
        }
        if threedotmenu == true{
            
            if leftMenu ==  false{
                
                dotBtn.setImage(UIImage(named: "LogOutWithDarkTheme"), for: .normal)
                
            }else{
                dotBtn.setImage(UIImage(named: "dotmenu"), for: .normal)
                
            }
            
            dotBtn.addTarget(self, action: #selector(self.threedotButtonButtonAction), for: .touchUpInside)
            dotBtn.isHidden = false
        }
        
        if refresButton == true{
            
            refreshBtn.setImage(UIImage(named: "ic_transmit_White"), for: .normal)
            
            refreshBtn.addTarget(self, action: #selector(self.refButtonButtonAction), for: .touchUpInside)
            refreshBtn.isHidden = false
        }
        if NewJobButton ==  true{
            
            jobBtn.setImage(UIImage(named: "ic_AddFolder"), for: .normal)
            jobBtn.addTarget(self, action: #selector(self.NewJobButtonButtonAction), for: .touchUpInside)
            jobBtn.isHidden = false
        }
    }
    
    @objc func backGroundSyncStarted(notification : NSNotification) {
        
        if DeviceType == iPhone{
            DispatchQueue.main.async {
                self.refreshBtn.showSpin()
            }
        }
    }

    @objc func storeFlushAndRefreshDone(notification : NSNotification) {

        if DeviceType == iPhone{
            DispatchQueue.main.async {
                self.refreshBtn.stopSpin()
            }
        }
        
    }
    
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomNavHeader_iPhone", owner: self, options: nil)
        mainView.clipsToBounds = true
        self.addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        titleLbl.isHidden = true
        backBtn.isHidden = true
        menuBtn.isHidden = true
        jobBtn.isHidden = true
        refreshBtn.isHidden = true
        dotBtn.isHidden = true
    }
    
    @objc func HideDotMenu(notification : NSNotification) {
        dotBtn.isHidden = true
    }
    
    @objc func ShowDotMenu(notification:NSNotification) {
        dotBtn.isHidden = false
    }
    
    
    @objc func setNavTitle(notification : NSNotification) {
        
        self.titleLbl.text = notification.object as? String
    }
    @objc func backButtonAction(sender : UIButton) {
        debugPrint("back button")
        delegate?.backButtonClicked!(sender)
        if myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count > 0 {
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.remove(at: myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.count - 1)
        }
        myAssetDataManager.uniqueInstance.navigationController?.popViewController(animated: true)
        
    }
    @objc func leftMenuButtonAction(sender : UIButton) {
        delegate?.leftMenuButtonClicked!(sender)
    }
    @objc func threedotButtonButtonAction(sender : UIButton) {
        delegate?.threedotmenuButtonClicked!(sender)
        
    }
    @objc func refButtonButtonAction(sender : UIButton) {
        delegate?.refreshButtonClicked!(sender)
    }
    @objc func NewJobButtonButtonAction(sender : UIButton) {
        delegate?.NewJobButtonClicked!(sender)
    }
}

