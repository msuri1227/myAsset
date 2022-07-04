
//  AppDelegate.swift
//  myJobCard
//  Created by Ondevice Solutions on 11/17/16.
//  Copyright © 2016 Ondevice Solutions. All rights reserved.
//

import UIKit
import UserNotifications
import ODSFoundation
import mJCLib


@UIApplicationMain
class AppDelegate: UIResponder,UNUserNotificationCenterDelegate, UIApplicationDelegate,UISplitViewControllerDelegate {
    
    var window: UIWindow?
    var notificationFireType = String()
    let center = UNUserNotificationCenter.current()
    var MasterBGTimer = Timer()
    var MasterBGTimerCount = Int()
    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerforpushnotification()
        registerforlocalnotifications()
        if((UserDefaults.standard.value(forKey:"DebugLogLevel")) == nil){
            UserDefaults.standard.setValue(true, forKey: "DebugLogLevel")
        }
        if((UserDefaults.standard.value(forKey:"ErrorLogLevel")) == nil){
            UserDefaults.standard.setValue(true, forKey: "ErrorLogLevel")
        }
        if #available(iOS 13.0, *) {
            let mode = UserDefaults.standard.value(forKey: "theme") as? String ?? ""
            if mode == ""{
                UserDefaults.standard.setValue("default", forKey: "theme")
                UIApplication.shared.windows.forEach { window in
                    if UITraitCollection.current.userInterfaceStyle == .dark {
                        window.overrideUserInterfaceStyle = .dark
                    }else{
                        window.overrideUserInterfaceStyle = .light
                    }
                }
            }else if mode == "dark"{
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
            }else if  mode == "default"{
                UIApplication.shared.windows.forEach { window in
                    if UITraitCollection.current.userInterfaceStyle == .dark {
                        window.overrideUserInterfaceStyle = .dark
                    }else {
                        window.overrideUserInterfaceStyle = .light
                    }
                }
            }else{
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        if UserDefaults.standard.value(forKey: "isHttps") != nil{
            isHttps = UserDefaults.standard.value(forKey: "isHttps") as! Bool
        }
        if let path = Bundle.main.path(forResource: "mJCConfig", ofType: "plist") {
            if let nsDictionary = NSDictionary(contentsOfFile: path){
                if let pingUrl =  nsDictionary["serverPingURL"]{
                    ODSReachability.sharedInstance().serverPingURL = pingUrl as? String
                }
            }
        }
        if((UserDefaults.standard.value(forKey:"Deletion")) != nil){
            let deletionStatus = UserDefaults.standard.value(forKey:"Deletion") as! Bool
            deletionValue = deletionStatus
        }else{
            deletionValue = true
            UserDefaults.standard.set(true, forKey: "Deletion")
        }
        if((UserDefaults.standard.value(forKey:"Logout")) != nil){
            let logoutStatus = UserDefaults.standard.value(forKey:"Logout") as! Bool
            logoutValue = logoutStatus
        }else{
            logoutValue = true
            UserDefaults.standard.set(true, forKey: "Logout")
        }
        if let documentsPath = myAsset.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
            print("Documents Directory: \(documentsPath)")
            mJCLogger.log("Documents Directory: \(documentsPath)", Type: "")
        }
        application.applicationIconBadgeNumber = 0
        GMSServices.provideAPIKey(GoogleAPIKey)
        // TODO: Move this to where you establish a user session
        IQKeyboardManager.shared.enable = true
        DropDown.startListeningToKeyboard()
        UIApplication.shared.statusBarStyle = .lightContent
        self.createStoreHomeDir()
        return true
    }
    func createStoreHomeDir(){
        let url = NSURL(fileURLWithPath: documentPath)
        let libraryURL = NSURL(fileURLWithPath: libraryPath)
        let DemoPath = url.appendingPathComponent("DemoStores")?.path
        if !myAsset.fileManager.fileExists(atPath: DemoPath!){
            do {
                try myAsset.fileManager.createDirectory(atPath: DemoPath!, withIntermediateDirectories: false, attributes: nil)
            }
            catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        let FilePath = url.appendingPathComponent("Stores")?.path
        if !myAsset.fileManager.fileExists(atPath: FilePath!){
            do {
                try myAsset.fileManager.createDirectory(atPath: FilePath!, withIntermediateDirectories: false, attributes: nil)
            }
            catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        let logpath = url.appendingPathComponent("Logs")?.path
        if !myAsset.fileManager.fileExists(atPath: logpath!){
            do{
                try myAsset.fileManager.createDirectory(atPath: logpath!, withIntermediateDirectories: false, attributes: nil)
            }catch let error as NSError{
                print("Error while creating Forms Folder \(error.localizedDescription)")
            }
        }
        let FilePath1 = url.appendingPathComponent("Download")?.path
        if !myAsset.fileManager.fileExists(atPath: FilePath1!){
            do {
                try myAsset.fileManager.createDirectory(atPath: FilePath1!, withIntermediateDirectories: false, attributes: nil)
            }
            catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        let FilePath2 = url.appendingPathComponent("Address")?.path
        if !myAsset.fileManager.fileExists(atPath: FilePath2!){
            do {
                try myAsset.fileManager.createDirectory(atPath: FilePath2!, withIntermediateDirectories: false, attributes: nil)
            }
            catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        let resourcePath = Bundle.main.resourcePath! + "/Address.plist"

        if let addressListPath = NSURL(fileURLWithPath: FilePath2!).appendingPathComponent("Address.plist"){
            addressPlistPath = addressListPath
        }
        if !myAsset.fileManager.fileExists(atPath: addressPlistPath!.path){
            do {
                try myAsset.fileManager.copyItem(atPath: resourcePath, toPath: addressPlistPath!.path)
            }catch let error as NSError{
                print(error.localizedDescription);
            }
        }else{
            print("Failed")
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.receivedPush(notification: notification)
        completionHandler([.sound])
    }
    func receivedPush(notification: UNNotification){
        let userInfo = notification.request.content.userInfo
        if let pushdata = userInfo[AnyHashable("data")]{
            if let dict = convertToDictionary(text: pushdata as! String){
                let pushdata = dict as NSDictionary
                var order = String()
                var oprCount = String()
                var type = String()
                if let orderid = pushdata.value(forKey: "orderid"){
                    order = orderid as! String
                    if order == ""{
                        mJCLogger.log("push orderid is empty", Type: "Debug")
                        return
                    }
                    type = "Work_Order".localized()
                }else if let noteficationid = pushdata.value(forKey: "notification"){
                    order = noteficationid as! String
                    if order == ""{
                        mJCLogger.log("push orderid is empty", Type: "Debug")
                        return
                    }
                    type = "Notification".localized()
                }
                if let operationcount = pushdata.value(forKey: "operationcount"){
                    oprCount = operationcount as! String
                }
                var priority = pushdata.value(forKey: "priority") as! String
                if priority == "1"{
                    priority = "Very_High".localized()
                }else if priority == "2"{
                    priority = "High".localized()
                }
                DispatchQueue.main.async {
                    var msg = "New".localized() + " " + "\(type)" + " " + "Received :".localized() + " " + "\(order)" + " " + "(\(priority))"
                    if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && type != "Notification".localized(){
                        msg = "New".localized() + " " + "\(type)" + " " + "Received :".localized() + " " + "\(order)" + " " + "(\(priority))" + " " + "and_operations:".localized() + " " + "\(oprCount)"
                    }
                    var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                    topWindow?.rootViewController = UIViewController()
                    topWindow?.windowLevel = UIWindow.Level.alert + 1
                    let alert = UIAlertController(title: alerttitle, message: msg, preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: okay, style: .default, handler: { (alertAction) in
                        topWindow?.isHidden = true
                        topWindow = nil
                    })
                    alert.addAction(action)
                    topWindow?.makeKeyAndVisible()
                    topWindow?.rootViewController?.present(alert, animated: true, completion:nil)
                }
            }
        }else if let pushdata = userInfo[AnyHashable("aps")] as? NSMutableDictionary{
            DispatchQueue.main.async {
                if let msg = pushdata.value(forKey: "alert") as? String{
                    var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                    topWindow?.rootViewController = UIViewController()
                    topWindow?.windowLevel = UIWindow.Level.alert + 1
                    let alert = UIAlertController(title: alerttitle, message: msg, preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: okay, style: .default, handler: { (alertAction) in
                        topWindow?.isHidden = true
                        topWindow = nil
                    })
                    alert.addAction(action)
                    topWindow?.makeKeyAndVisible()
                    topWindow?.rootViewController?.present(alert, animated: true, completion:nil)
                }
            }
        }else if let pushdata = userInfo[AnyHashable("aps")] as? NSDictionary{
            DispatchQueue.main.async {
                if let msg = pushdata.value(forKey: "alert") as? String{
                    var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                    topWindow?.rootViewController = UIViewController()
                    topWindow?.windowLevel = UIWindow.Level.alert + 1
                    let alert = UIAlertController(title: alerttitle, message: msg, preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: okay, style: .default, handler: { (alertAction) in
                        topWindow?.isHidden = true
                        topWindow = nil
                    })
                    alert.addAction(action)
                    topWindow?.makeKeyAndVisible()
                    topWindow?.rootViewController?.present(alert, animated: true, completion:nil)
                }
            }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let pushdata = userInfo[AnyHashable("data")]{
            if let dict = convertToDictionary(text: pushdata as! String){
                let pushdata = dict as NSDictionary
                var order = String()
                var oprCount = String()
                var type = String()
                if let orderid = pushdata.value(forKey: "orderid"){
                    order = orderid as! String
                    if order == ""{
                        mJCLogger.log("push orderid is empty", Type: "Debug")
                        return
                    }
                    type = "Work_Order".localized()
                }else if let noteficationid = pushdata.value(forKey: "notification"){
                    order = noteficationid as! String
                    if order == ""{
                        mJCLogger.log("push orderid is empty", Type: "Debug")
                        return
                    }
                    type = "Notification".localized()
                }
                if let operationcount = pushdata.value(forKey: "operationcount"){
                    oprCount = operationcount as! String
                }
                var priority = pushdata.value(forKey: "priority") as! String
                if priority == "1"{
                    priority = "Very_High".localized()
                }else if priority == "2"{
                    priority = "High".localized()
                }
                DispatchQueue.main.async {
                    var msg = "New".localized() + " " + "\(type)" + " " + "Received :".localized() + " " + "\(order)" + " " + "(\(priority))"
                    if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && type != "Notification".localized(){
                        msg = "New".localized() + " " + "\(type)" + " " + "Received :".localized() + " " + "\(order)" + " " + "(\(priority))" + " " + "and_operations:".localized() + " " + "\(oprCount)"
                    }
                    var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                    topWindow?.rootViewController = UIViewController()
                    topWindow?.windowLevel = UIWindow.Level.alert + 1
                    let alert = UIAlertController(title: alerttitle, message: msg, preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: okay, style: .default, handler: { (alertAction) in
                        topWindow?.isHidden = true
                        topWindow = nil
                    })
                    alert.addAction(action)
                    topWindow?.makeKeyAndVisible()
                    topWindow?.rootViewController?.present(alert, animated: true, completion:nil)
                }
            }
        }else if let pushdata = userInfo[AnyHashable("aps")] as? NSMutableDictionary{
            DispatchQueue.main.async {
                if let msg = pushdata.value(forKey: "alert") as? String{
                    var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                    topWindow?.rootViewController = UIViewController()
                    topWindow?.windowLevel = UIWindow.Level.alert + 1
                    let alert = UIAlertController(title: alerttitle, message: msg, preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: okay, style: .default, handler: { (alertAction) in
                        topWindow?.isHidden = true
                        topWindow = nil
                    })
                    alert.addAction(action)
                    topWindow?.makeKeyAndVisible()
                    topWindow?.rootViewController?.present(alert, animated: true, completion:nil)
                }
            }
        }
        completionHandler()
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        mJCLogger.log("enterBG --\(Date().localDate())", Type: "")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        mJCLogger.log("enterFG --\(Date().localDate())", Type: "")
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        mJCLoader.resumeAnimating()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //  SODataOfflineStore.globalFini()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ supportedInterfaceOrientationsForapplication: UIApplication,supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if DeviceType == iPad{
            if isSupportPortait {
                return .all
            }
            else {
                return .landscape
            }
        }else{
            return .portrait
        }
    }
    func shouldAutorotate() -> Bool {
        return false
    }
    
    var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    func splitViewController(_ svc: UISplitViewController, shouldHide vc: UIViewController, in orientation: UIInterfaceOrientation) -> Bool {
        return isMasterHidden
    }
    // MARK:- PUSH NOTIFICATIONS
    func registerforpushnotification(){
        DispatchQueue.main.async{
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    DispatchQueue.main.async{ UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
    }
    func registerforlocalnotifications(){
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }
                })
            case .authorized:
                print("local notification authorized")
                mJCLogger.log("local notification authorized".localized(), Type: "")
            // Schedule Local Notification
            case .denied:
                print("Application Not Allowed to Display Notifications")
                mJCLogger.log("Application Not Allowed to Display Notifications".localized(), Type: "")
            default : print("default")
            }
        }
    }
    
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                mJCLogger.log("Request Authorization Failed (\(error), \(error.localizedDescription))", Type: "Error")
            }
            completionHandler(success)
        }
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        let chars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var token = ""
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", arguments: [chars[i]])
        }
        UserDefaults.standard.setValue(token, forKey: "DeviceToken")
        print("Device Token = ", token)
        mJCLogger.log("Device Token = \(token)", Type: "Debug")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print("Error = ",error.localizedDescription)
        mJCLogger.log("Error = \(error.localizedDescription)", Type: "Error")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        mJCLogger.log("push Notification \(userInfo)", Type: "Debug")
        if let pushdata = userInfo[AnyHashable("data")]{
            if let dict = convertToDictionary(text: pushdata as! String){
                let pushdata = dict as NSDictionary
                var order = String()
                var oprCount = String()
                var type = String()
                if let orderid = pushdata.value(forKey: "orderid"){
                    order = orderid as! String
                    if order == ""{
                        print("push orderid is empty")
                        return
                    }
                    type = "Work_Order".localized()
                }else if let noteficationid = pushdata.value(forKey: "notification"){
                    order = noteficationid as! String
                    if order == ""{
                        print("push orderid is empty")
                        return
                    }
                    type = "Notification".localized()
                }
                if let operationcount = pushdata.value(forKey: "operationcount"){
                    oprCount = operationcount as! String
                }
                var priority = pushdata.value(forKey: "priority") as! String
                if priority == "1"{
                    priority = "Very_High".localized()
                }else if priority == "2"{
                    priority = "High".localized()
                }
                DispatchQueue.main.async {
                    var msg = "New".localized() + " " + "\(type)" + " " + "Received :".localized() + " " + "\(order)" + " " + "(\(priority))"
                    if (WORKORDER_ASSIGNMENT_TYPE == "2" || WORKORDER_ASSIGNMENT_TYPE == "4" || WORKORDER_ASSIGNMENT_TYPE == "5") && type != "Notification"{
                        msg = "New".localized() + " " + "\(type)" + " " + "Received :".localized() + " " + "\(order)" + " " + "(\(priority))" + " " + "and_operations:".localized() + " " + "\(oprCount)"
                    }
                    var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                    topWindow?.rootViewController = UIViewController()
                    topWindow?.windowLevel = UIWindow.Level.alert + 1
                    let alert = UIAlertController(title: alerttitle, message: msg, preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: okay, style: .default, handler: { (alertAction) in
                        topWindow?.isHidden = true
                        topWindow = nil
                    })
                    alert.addAction(action)
                    topWindow?.makeKeyAndVisible()
                    topWindow?.rootViewController?.present(alert, animated: true, completion:nil)
                }
            }
        }else if let pushdata = userInfo[AnyHashable("aps")] as? NSMutableDictionary{
            DispatchQueue.main.async {
                if let msf = pushdata.value(forKey: "alert") as? String{
                    var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                    topWindow?.rootViewController = UIViewController()
                    topWindow?.windowLevel = UIWindow.Level.alert + 1
                    let alert = UIAlertController(title: alerttitle, message: msf, preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: okay, style: .default, handler: { (alertAction) in
                        topWindow?.isHidden = true
                        topWindow = nil
                    })
                    alert.addAction(action)
                    topWindow?.makeKeyAndVisible()
                    topWindow?.rootViewController?.present(alert, animated: true, completion:nil)
                }
            }
        }
    }
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        var orientation: UIInterfaceOrientationMask!
        orientation = [UIInterfaceOrientationMask.landscape]
        return orientation
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    // MARK:- Url Schema
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        // handler code here
        return true
    }
}





