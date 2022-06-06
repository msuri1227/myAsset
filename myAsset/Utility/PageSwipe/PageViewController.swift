//
//  PageViewController.swift
//  PolioPager
//
//  Created by Yuiga Wada on 2019/08/22.
//  Copyright © 2019 Yuiga Wada. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

public protocol PageViewParent {
    var menuCollectionView: UICollectionView! { get set }
    var pageViewController: PageViewController { get set }
}
public class PageViewController: UIPageViewController, UIScrollViewDelegate {

    public var initialIndex: Int?
    public var barAnimators: [UIViewPropertyAnimator] = []
    public var tabActions: [() -> Void] = []
    public var initialAction: (() -> Void)?
    public var parentVC: PageViewParent? {
        didSet {
        }
    }
    
    private var pages: [UIViewController] = []
    public var scrollPageView: UIScrollView?
    private var initialized: Bool = false
    private var needSearchTab: Bool = true
    public var holderFrame = CGRect()
    public var itemCount = Int()
    public var isPageFrom = String()
    public var barAnimationDuration: Double = 0.1
    public var tabBackgroundColor: UIColor = UIColor(named: "mjcViewBgColor") ?? .white
    public var eachLineSpacing: CGFloat = 5
    public var items: [TabItem] = []
    public var defaultCellHeight: CGFloat?
    public var itemsFrame: [CGRect] = []
    public var itemsWidths: [CGFloat] = []
    public var sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
    public var selectedBarHeight: CGFloat = 5
    public var selectedBarMargins: (upper: CGFloat, lower: CGFloat) = (1, 2)
    public var pageViewMargin: CGFloat = 1
    public var selectedBar: UIView!
    public var borderView: UIView!
    public var pageView: UIView!
    public var needBorder: Bool = false {
        didSet {
            borderView.isHidden = !needBorder
        }
    }
    public var boderHeight: CGFloat = 1
    public var borderColor: UIColor = .black {
        didSet {
            borderView.backgroundColor = borderColor
        }
    }
    
    private var nowIndex: Int = 0 {
        willSet(index) { // Set now page's scrollsToTop to true and other's one to false. (#3)
            guard !initialized, pages.count > 0, index >= 0, index < pages.count else { return }
        }
    }
    private var autoScrolled: Bool = false {
        didSet {
            guard let parentVC = self.parentVC else { return }
            parentVC.menuCollectionView.isUserInteractionEnabled = !autoScrolled
            guard let scrollPageView = self.scrollPageView else { return }
            scrollPageView.isUserInteractionEnabled = !autoScrolled
        }
    }
    // MARK: LifeCycle
    public override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !initialized{
            scrollPageView?.scrollsToTop = false
            dataSource = self
            delegate = self
            let scrollView = view.subviews.filter { $0 is UIScrollView }.first as! UIScrollView
            scrollView.delegate = self
            guard let parentVC = self.parentVC else { return }
            parentVC.pageViewController.view.subviews.forEach { subView in
                guard let scrollView = subView as? UIScrollView else { return }
                self.scrollPageView = scrollView
                if isPageFrom == "suspend"{
                    self.scrollPageView?.isScrollEnabled = false
                }
            }
            holderFrame = CGRect(x: 0, y: 0, width: parentVC.pageViewController.view.frame.size.width, height: parentVC.pageViewController.view.frame.size.height)

            parentVC.pageViewController.view.frame = holderFrame
            initialized = true
        }else{
            parentVC?.pageViewController.view.frame = holderFrame
            return
        }
    }
    public func setupAnimator() {
        mJCLogger.log("Starting", Type: "info")
        guard self.barAnimators.count == 0 else { return }
        var animators: [UIViewPropertyAnimator] = []
        var actions: [() -> Void] = []
        itemsFrame.removeAll()
        for i in 0 ... self.items.count{
            let frame = CGRect(x: i * 130 , y: 0, width: 130, height: 60)
            itemsFrame.append(frame)
        }
        let maxIndex = itemsFrame.count - 2
        for index in 0 ... maxIndex {
            let nextFrame = itemsFrame[index + 1]
            let action = {
                let barFrame = self.selectedBar.frame
                self.selectedBar.frame = CGRect(x: nextFrame.origin.x,
                                                y: barFrame.origin.y,
                                                width: nextFrame.width,
                                                height: barFrame.height)
            }
            let barAnimator = UIViewPropertyAnimator(duration: self.barAnimationDuration, curve: .easeInOut, animations: action)
            barAnimator.pausesOnCompletion = true
            animators.append(barAnimator)
            actions.append(action)
        }
        var initialAction: (() -> Void)?
        let firstCellFrame = itemsFrame[0]
        initialAction = {
            let barFrame = self.selectedBar.frame
            self.selectedBar.frame = CGRect(x: firstCellFrame.origin.x,
                                            y: barFrame.origin.y,
                                            width: firstCellFrame.width,
                                            height: barFrame.height)
        }
        self.setAnimators(needSearchTab: false,
                                        animators: animators,
                                        originalActions: actions,
                                        initialAction: initialAction)
        mJCLogger.log("Ended", Type: "info")
    }
    public func setupAutoLayout() {
//        mJCLogger.log("Starting", Type: "info")
//        if let pageView = self.pageView {
//            pageView.translatesAutoresizingMaskIntoConstraints = false
//            view.addConstraints([
//                NSLayoutConstraint(item: pageView,
//                                   attribute: .bottom,
//                                   relatedBy: .equal,
//                                   toItem: view,
//                                   attribute: .bottom,
//                                   multiplier: 1.0,
//                                   constant: 0),
//                NSLayoutConstraint(item: pageView,
//                                   attribute: .left,
//                                   relatedBy: .equal,
//                                   toItem: view.safeAreaLayoutGuide,
//                                   attribute: .left,
//                                   multiplier: 1.0,
//                                   constant: 0),
//                NSLayoutConstraint(item: pageView,
//                                   attribute: .right,
//                                   relatedBy: .equal,
//                                   toItem: view.safeAreaLayoutGuide,
//                                   attribute: .right,
//                                   multiplier: 1.0,
//                                   constant: 0),
//                NSLayoutConstraint(item: pageView,
//                                   attribute: .top,
//                                   relatedBy: .equal,
//                                   toItem: self.parentVC!.menuCollectionView,
//                                   attribute: .bottom,
//                                   multiplier: 1.0,
//                                   constant: self.selectedBarMargins.upper + self.selectedBarMargins.lower + self.pageViewMargin + selectedBar.frame.height + (self.needBorder ? self.boderHeight : 0))
//            ])
//        }
//        if let view = self.view {
//            pageView.addConstraints([
//                NSLayoutConstraint(item: view,
//                                   attribute: .centerX,
//                                   relatedBy: .equal,
//                                   toItem: pageView,
//                                   attribute: .centerX,
//                                   multiplier: 1.0,
//                                   constant: 0),
//                NSLayoutConstraint(item: view,
//                                   attribute: .centerY,
//                                   relatedBy: .equal,
//                                   toItem: pageView,
//                                   attribute: .centerY,
//                                   multiplier: 1.0,
//                                   constant: 0),
//                NSLayoutConstraint(item: view,
//                                   attribute: .width,
//                                   relatedBy: .equal,
//                                   toItem: pageView,
//                                   attribute: .width,
//                                   multiplier: 1.0,
//                                   constant: 0),
//                NSLayoutConstraint(item: view,
//                                   attribute: .height,
//                                   relatedBy: .equal,
//                                   toItem: pageView,
//                                   attribute: .height,
//                                   multiplier: 1.0,
//                                   constant: 0)
//            ])
//        }
//        mJCLogger.log("Ended", Type: "info")
    }
    public func setTabItem(_ items: [TabItem]) {
        mJCLogger.log("Starting", Type: "info")
        self.items.removeAll()
        self.items = items
        if items.count>0{
            for i in 0 ... self.items.count - 1 {
                let item = self.items[i]
                var width: CGFloat
                let fontSize = (1 / 1366 * view.frame.width) * self.items[i].font.pointSize
                self.items[i].font = item.font.withSize(fontSize)
                width = item.cellWidth == nil ? defaultCellHeight! : item.cellWidth!
                itemsWidths.append(width)
            }
            itemsWidths = recalculateWidths()
        }
        mJCLogger.log("Ended", Type: "info")
    }
    public func recalculateWidths() -> [CGFloat]  {
        mJCLogger.log("Starting", Type: "info")
        var itemsWidths: [CGFloat] = []
        let cellMarginSum = CGFloat(items.count - 1) * eachLineSpacing
        let maxWidth = CGFloat(items.count) * 130.0
        var cellSizeSum: CGFloat = 0
        self.itemsWidths.forEach {
            cellSizeSum += $0
        }
        let extraMargin = maxWidth - (sectionInset.right + sectionInset.left + cellMarginSum + cellSizeSum)
        let distributee = items.count
        guard extraMargin > 0 else {
            self.itemsWidths.removeAll()
            for i in 0 ... items.count - 1 {
                let item = items[i]
                var width: CGFloat = 0
                let fontSize = items[i].font.pointSize * 0.9 // * 0.9, 0.8, 0.7, 0.65, 0.6, 0.5 ...
                items[i].font = item.font.withSize(fontSize)
                width = labelWidth(text: item.title!, font: item.font)
                self.itemsWidths.append(width)
            }
            return recalculateWidths() // recursion
        }
        self.itemsWidths.forEach {
            itemsWidths.append($0 + extraMargin / CGFloat(distributee))
        }
        mJCLogger.log("Ended", Type: "info")
        return itemsWidths
    }
    public func labelWidth(text: String, font: UIFont) -> CGFloat {
        mJCLogger.log("Starting", Type: "info")
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text + "AAAAA"
        label.sizeToFit()
        mJCLogger.log("Ended", Type: "info")
        return label.frame.width
    }
    // MARK: SetMethod
    public func setAnimators(needSearchTab: Bool, animators: [UIViewPropertyAnimator], originalActions: [() -> Void], initialAction: (() -> Void)?) {
        for i in 0 ... (animators.count - 1) {
            animators[i].fractionComplete = (i >= initialIndex! ? 0 : 1)
        }
        barAnimators = animators
        tabActions = originalActions
        self.initialAction = initialAction
    }
    public func setPages(_ vcs: [UIViewController]) {
        guard let index = initialIndex else { return }
        pages = vcs
        if pages.indices.contains(index){
            setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
            nowIndex = index
            
        }else{
            setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
            nowIndex = 0
        }
    }
    public func moveTo(index: Int) {
        guard index >= 0, index < pages.count else { return }
        guard index != nowIndex, !autoScrolled else { return }
        // pageView, selectedBar
        var isCompleted: Bool = false
        let finalCompletion: (Bool, Bool) -> Void = { needChangeUserInteraction, searchTab in
            if isCompleted {
                //self.resetSelection()
                self.autoScrolled = false
            } else
            { isCompleted = true }
        }
        // After we call startAnimation() method to start the animations, each animators become unusable.
        // So, we have to recreate animators.
        // Additionaly, We should pay special attention to the fact that each animations depend on the current position of selectedBar.
        // We have to move selectedBar to index=0 once. → (1)
        var animators: [UIViewPropertyAnimator] = []
        var ascending: Bool = true
        var needChangeUserInteraction: Bool = false
        var toLeft: Bool = false
        if index < nowIndex // to left
        {
            toLeft = true
            ascending = false
            needChangeUserInteraction = (index == 0 && needSearchTab) // Bool
            if index == 0 {
                animators.append(UIViewPropertyAnimator(duration: needSearchTab ? 0.4 : barAnimationDuration,
                                                        curve: .easeInOut,
                                                        animations: initialAction))
                if !needSearchTab, nowIndex > 1 {
                    for i in 0 ... nowIndex - 2 { animators.append(createAnimator(i)) }
                }
            } else {
                for i in index - 1 ... nowIndex - 2 { animators.append(createAnimator(i)) }
            }
            animators = createChainAnimator(animators: animators, ascending: ascending)
        }else{
            toLeft = false
            ascending = true
            needChangeUserInteraction = (nowIndex == 0 && needSearchTab) // Bool
            for i in nowIndex ... (index - 1) { animators.append(createAnimator(i)) }
            animators = createChainAnimator(animators: animators, ascending: ascending)
        }
        let n = animators.count - 1
        let startIndex = ascending ? n : 0
        let endIndex = ascending ? 0 : n
        let direction: UIPageViewController.NavigationDirection = toLeft ? .reverse : .forward
        
        autoScrolled = true
        barAnimators.forEach { $0.stopAnimation(true) }
        
        animators[startIndex].addCompletion { _ in
            self.nowIndex = index
            if self.initialAction != nil { self.initialAction!() } // memo: (1)
            self.barAnimators.removeAll()
            self.tabActions.forEach {
                self.barAnimators.append(UIViewPropertyAnimator(duration: self.barAnimationDuration, curve: .easeInOut, animations: $0))
            }
            for i in 0 ... self.barAnimators.count - 1 {
                self.barAnimators[i].fractionComplete = (i < index ? 1 : 0) // memo: (1)→Undo
                self.barAnimators[i].pausesOnCompletion = true // preventing animator from stopping when you leave your app.
            }
            animators.filter { $0.state == .active }.forEach { $0.stopAnimation(true) }
            animators.removeAll()
            finalCompletion(needChangeUserInteraction, toLeft)
        }
        animators[endIndex].startAnimation()
        setViewControllers([pages[index]], direction: direction, animated: true, completion: { _ in
            finalCompletion(needChangeUserInteraction, toLeft)
        }) // moves Page.
    }
    // MARK: Animator Utility
    private func createAnimator(_ index: Int) -> UIViewPropertyAnimator {
        if tabActions.count > 0{
            return UIViewPropertyAnimator(duration: barAnimationDuration, curve: .easeIn, animations: tabActions[index])
        }else{
            return UIViewPropertyAnimator()
        }
    }
    private func createChainAnimator(animators: [UIViewPropertyAnimator], ascending: Bool) -> [UIViewPropertyAnimator] {
        let n = animators.count - 1
        for i in 0 ... n {
            if !ascending, n - i - 1 >= 0 {
                animators[n - i].addCompletion { _ in
                    animators[n - i - 1].startAnimation()
                }
            }
            if ascending, i < n {
                animators[i].addCompletion { _ in
                    animators[i + 1].startAnimation()
                }
            }
        }
        return animators
    }
    // MARK: DelegateMethod
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !autoScrolled else { return }
        let maxWidth = CGFloat(itemCount) * 130.0
        var animator: UIViewPropertyAnimator?
        var complete: CGFloat?
        if scrollView.contentOffset.x < maxWidth, nowIndex > 0 {
            animator = barAnimators[nowIndex - 1]
            complete = scrollView.contentOffset.x / maxWidth // 1 → 0
        } else if scrollView.contentOffset.x >= maxWidth, nowIndex < pages.count - 1{
            animator = barAnimators[nowIndex]
            complete = (scrollView.contentOffset.x - maxWidth) / maxWidth // 0 → 1
        }
        guard complete != nil else { return }
        animator!.fractionComplete = complete!
    }
    // MARK: 4Debug
    private func state2String(_ state: UIViewAnimatingState) -> String {
        switch state {
        case .active:
            return "active"
        case .inactive:
            return "inactive"
        case .stopped:
            return "stopped"
        @unknown default:
            fatalError("Unknown error.")
        }
    }
    private func printAnimatorStates() {
        print("--------")
        for i in 0 ... barAnimators.count - 1 {
            print("right" + i.description + ": " + barAnimators[i].fractionComplete.description + " state: " + state2String(barAnimators[i].state))
        }
        print("nowIndex: " + nowIndex.description)
    }
}

extension PageViewController: UIPageViewControllerDataSource{
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //self.resetSelection()
        guard let index = pages.firstIndex(of: viewController) else {
            return nil
        }
        guard (index - 1) >= 0, pages.count > (index - 1) else {
            return nil
        }
        return pages[index - 1]
    }
    func resetSelection() {
        selectedOperationNumber = ""
        selectedComponentNumber = ""
        selectedItem = ""
        selectedTask = ""
        selectedAcitivity = ""
        selectedItemActivity = ""
        selectedItemTask = ""
        selectedItemCause = ""
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController)
        else {
            return nil
        }
        guard index + 1 != pages.count, pages.count > (index + 1) else {
            return nil
        }
        return pages[index + 1]
    }
}
extension PageViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            let current = pageViewController.viewControllers![0]
            if let index = pages.firstIndex(of: current) {
                nowIndex = index
                selectedIndex = index
                scrollingIndex = index
                NotificationCenter.default.post(name: NSNotification.Name("Reload"), object: nil)
            }
        }
    }
}
