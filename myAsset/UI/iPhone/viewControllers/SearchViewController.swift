//
//  SearchViewController.swift
//  MyJobCard
//
//  Created by Navdeep Singla on 13/08/19.
//  Copyright © 2019 Pratik Patel. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SODataOnlineStoreDelegate,UsernamePasswordProviderProtocol {

    func provideUsernamePassword(forAuthChallenge authChallenge: URLAuthenticationChallenge!, completionBlock: username_password_provider_completion_t!) {
        
        if((UserDefaults.standard.value(forKey:"login_Details")) != nil) {
            
            if let dict =  UserDefaults.standard.value(forKey:"login_Details") as? NSMutableDictionary {
              
                let username = dict.value(forKey :"userName") as? String
                let password = dict.value(forKey :"password") as? String
                let credential = URLCredential(user: username!, password: password!, persistence: .forSession)
                completionBlock(credential, nil)
              }
            
        }
        
    }
    
    var transOnlineStore : (SODataStore & SODataStoreAsync)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.openonlineStore()
        
    }
    
    func openonlineStore() {
        
        var serverIP = String()
        var portNumber = String()
        var storeurl = String()
        var storename  = String()
        if((UserDefaults.standard.value(forKey:"serverDetails")) != nil) {
            
            let serverDetails = UserDefaults.standard.value(forKey:"serverDetails") as! NSMutableDictionary
            serverIP = (serverDetails.value(forKey :"serverIP") as? String)!
            portNumber = (serverDetails.value(forKey :"portNumber") as? String)!
        }
        if((UserDefaults.standard.value(forKey:"StoreDetails")) != nil){
            let StoreDetails = UserDefaults.standard.object(forKey: "StoreDetails") as! NSMutableDictionary
            storename = StoreDetails.value(forKey: txStoreName) as! String
        }
        if ishcp == true{
            storeurl = "https://\(serverIP):\(portNumber)/\(storename)"
        }else{
            storeurl = "http://\(serverIP):\(portNumber)/\(storename)"
        }
        let options = SODataOnlineStoreOptions.init()
        options.requestFormat = SODataDataFormatJSON
        let httpConvMan = HttpConversationManager.init()
        let commonfig = CommonAuthenticationConfigurator.init()
        //commonfig.addSAML2ConfigProvider(self)
        commonfig.addUsernamePasswordProvider(self)
        commonfig.configureManager(httpConvMan)
        
        let onlineStore = SODataOnlineStore.init(url: URL(string:storeurl), httpConversationManager: httpConvMan)
        onlineStore?.onlineStoreDelegate = self
        transOnlineStore = onlineStore
        
        do {
            try  (transOnlineStore as! SODataOnlineStore).open()
            
        }
        catch {
            
            print("Error")
        }
        
    }
 
    //MARK:- Online Delegate methods
    
    func onlineStoreOpenFinished(_ store: SODataOnlineStore!) {
        
        print("Onlines store open Finished")
        
        self.getDynamicFilterList()
        
    }
    
    func onlineStoreOpenFailed(_ store: SODataOnlineStore!, error: Error!) {
        
        print("Failure")
        
    }
    
    func getDynamicFilterList() {
        
        let defineReq = DefineRequestModelClass.uniqueInstance.getWorkorderDefineRequest(type: "List", OrderNum: "") as String
        
      //  let def = "DynamicFilterSet(UserId='\(strUser)',UniqueId='')"
        
        Log.debug("getmainWorkCentersList defineReq:- \(defineReq)")
        
        let requestParam = SODataRequestParamSingleDefault(mode: SODataRequestModeRead, resourcePath: defineReq)
        
//        _ = myJobCardDataManager.uniqueInstance.transOnlineStore?.scheduleRequest?(requestParam, completion: {{ (<#SODataRequestExecution?#>, <#Error?#>) in
//            <#code#>
//            }})
        
        _ = myJobCardDataManager.uniqueInstance.transOnlineStore?.scheduleReadEntity?(withResourcePath: defineReq , options: nil, completion: { (SODataRequest, error) in
            
            if(error == nil) {
                
                let dict = NSMutableDictionary()
                dict.setValue(SODataRequest, forKey: "data")
                let dict1 = myJobCardDataManager.uniqueInstance.SODataRequestToDictionary(SODataRequest: dict.object(forKey:"data") as! SODataRequestExecution)
                
                Log.debug("getmainWorkCentersList Response Dic:- \(dict)")
//                self.dynamicDict = dict1
//
//                if dict1.count > 0 {
//
//                    let arr = self.dynamicDict["data"] as! NSMutableArray
//
//                    let dic = arr[0] as! NSMutableDictionary
//
//                    if dic.value(forKey: "Param1") as! String != ""{
//                        updatedLine1 = dic.value(forKey: "Param1") as! String
//
//                        if (UserDefaults.standard.value(forKey:"fromNewUser") != nil){
//                            let newuser = UserDefaults.standard.value(forKey: "fromNewUser") as! String
//                            if newuser == "YES"{
//                                UserDefaults.standard.removeObject(forKey: "fromNewUser")
//                                self.openAllOfflineStore()
//                            }
//                        }else{
//                            self.openOfflineStore(count: 1)
//                        }
//                    }else{
//                        self.postDynamicLine()
//                    }
//
//
//
//                }else{
//                    self.postDynamicLine()
//                }
                
            }
            else {
                Log.error("\(error?.localizedDescription)")
            }
        })
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
