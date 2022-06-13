//
//  InspUninspVC.swift
//  myAsset
//
//  Created by Ruby's Mac on 07/06/22.
//

import UIKit
import ODSFoundation
import mJCLib
import AVFoundation

class InspUninspVC: UIViewController,TabCellDelegate,PageViewParent,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var selectedBar: UIView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var statusbarView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    public var initialIndex: Int = 0
    public lazy var pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private var initialized: Bool = false
    
    //MARK:- Declared Variables..
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    let menudropDown = DropDown()
    var dropDownString = String()
    
    var tabItemArray = Array<TabItem>()
    var tabVCArray = [UIViewController]()
    var flocEquipObjType = String()
    var flocEquipObjText = String()
    var classificationType = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialIndex = 0
        selectedIndex = 0
        pageViewController.parentVC = self
        self.setupCell()
        self.setupPageView()
        if DeviceType == iPhone{
            selectedBar.isHidden = true
        }else{
            selectedBar.isHidden = false
        }
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if flushStatus == true {
            if DeviceType == iPad {
                // self.refreshButton.showSpin()
            }
        }
        pageViewController.setTabItem(tabItems())
        defer { initialized = true }
        guard !initialized else { super.viewWillAppear(animated);
            return }
        pageViewController.pageView = self.pageView
        pageViewController.selectedBar = self.selectedBar
        setupPageComponent()
        pageViewController.setupAnimator()
        setPages(viewControllers())
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
    func customizeDropDown(imgArry: [UIImage]) {
        mJCLogger.log("Starting", Type: "info")
        menudropDown.showImage = true
        menudropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownWithImageCell else { return }
            cell.logoImageView.image = imgArry[index]
        }
        mJCLogger.log("Ended", Type: "info")
    }
    private func setupCell() {
        mJCLogger.log("Starting", Type: "info")
        ScreenManager.registerTabCell(collectionView: self.menuCollectionView)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = (1 / 1366) * pageViewController.eachLineSpacing  * view.frame.width
        layout.scrollDirection = .horizontal
        layout.sectionInset = pageViewController.sectionInset
        self.menuCollectionView.collectionViewLayout = layout
        mJCLogger.log("Ended", Type: "info")
    }
    private func setupPageView() {
        mJCLogger.log("Starting", Type: "info")
        pageViewController.view.frame = pageView.frame
        pageViewController.isPageFrom = ""
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = true
        pageView.addSubview(pageViewController.view)
        pageViewController.initialIndex = initialIndex
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: - Page Swiper Methods
    func tabItems() -> [TabItem] {
        self.tabItemArray.removeAll()
        mJCLogger.log("Starting", Type: "info")
        let OverviewTab  = TabItem(title: "Inspected".localized(), image: UIImage(named: "overview"), cellWidth: 130.0)
        let installedEquipTab  = TabItem(title: "Un-Inspected".localized(), image: UIImage(named: "components"), cellWidth: 130.0)
        
        tabItemArray.append(OverviewTab)
        tabItemArray.append(installedEquipTab)
        return tabItemArray
    }
    private func setupPageComponent() {
        mJCLogger.log("Starting", Type: "info")
        menuCollectionView.backgroundColor = pageViewController.tabBackgroundColor
        menuCollectionView.scrollsToTop = false
        mJCLogger.log("Ended", Type: "info")
    }
    func viewControllers() -> [UIViewController] {
        mJCLogger.log("Starting", Type: "info")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad_Storyboard", bundle: nil)
        let inspeVC = storyBoard.instantiateViewController(withIdentifier: "InspectedVC") as! InspectedVC
        self.present(inspeVC, animated: true, completion: nil)
        
        let unInspe = storyBoard.instantiateViewController(withIdentifier: "UnInspectedVC") as! UnInspectedVC
        self.present(unInspe, animated: true, completion: nil)
        
        tabVCArray = [inspeVC,unInspe]
        return tabVCArray
    }
    private func setPages(_ viewControllers: [UIViewController]) {
        mJCLogger.log("Starting", Type: "info")
        guard viewControllers.count == pageViewController.items.count
        else { fatalError("The number of ViewControllers must equal to the number of TabItems.") }
        pageViewController.setPages(viewControllers)
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK: Collection View Delegates
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == menuCollectionView{
            if pageViewController.defaultCellHeight == nil {
                pageViewController.defaultCellHeight = self.menuCollectionView.frame.height
                pageViewController.itemCount = pageViewController.items.count
            }
            return pageViewController.items.count
        }else{
            return 0
        }
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        mJCLogger.log("Starting", Type: "info")
        let index = indexPath.row
        let cell = ScreenManager.getTabCell(collectionView: collectionView,indexPath:indexPath)
        guard let tabCell = cell as? TabCell else { return cell }
        tabCell.index = index
        tabCell.delegate = self
        tabCell.flocEquipModel = pageViewController.items[index]
        tabCell.indexPath = indexPath
        if DeviceType == iPhone{
            tabCell.titleLabel.font = .systemFont(ofSize: 14)
        }
        if selectedIndex == indexPath.row{
            tabCell.selectedView.backgroundColor = appColor
            tabCell.titleLabel.textColor = UIColor.lightText
            self.menuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }else {
            tabCell.selectedView.backgroundColor = UIColor.white
            tabCell.titleLabel.textColor = UIColor.white
        }
        return tabCell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){}
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        mJCLogger.log("Starting", Type: "info")
        mJCLogger.log("Ended", Type: "info")
        return UIEdgeInsets()
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == menuCollectionView {
            let width = pageViewController.itemsWidths[indexPath.row]
            return CGSize(width: width+100, height: 60)
        }else{
            return CGSize(width: 50, height: 50)
        }
    }
    public func moveTo(index: Int) {
        mJCLogger.log("Starting", Type: "info")
        selectedIndex = index
        pageViewController.moveTo(index: index)
        self.menuCollectionView.reloadData()
        mJCLogger.log("Ended", Type: "info")
    }
}
