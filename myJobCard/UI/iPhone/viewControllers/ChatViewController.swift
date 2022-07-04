//
//  ChatViewController.swift
//  YanaSDKDemo
//
//  Created by 1 on 16/04/19.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import Speech
import AVFoundation


 public class ChatViewController: UIViewController,SFSpeechRecognizerDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
   
    
    
    public var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    @IBOutlet weak var bottomView: UIView!
    let synth = AVSpeechSynthesizer()
    var myUtternce:AVSpeechUtterance = AVSpeechUtterance(string: "")
    public var recognitionRequest : SFSpeechAudioBufferRecognitionRequest?
    public var speechRecognitionTask : SFSpeechRecognitionTask?
    public let audioEngine = AVAudioEngine()
    var chat = [String]()
    let dateFormatter:DateFormatter! = nil

    var stopTimer:Timer! = nil
    var speechText:String = ""
    let isShownSignOutMenu:Bool! = nil
    var responseAdded = false


    
    
    @IBOutlet var recordImageView: UIImageView!
    @IBOutlet  var dimView: UIView!
    
    @IBOutlet var chatView: UIView! = UIView()
    
    var messegesArray = [String]()
    var responseArray = [String]()
    
    var indexPath = IndexPath(item: 0, section: 0)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        

        chatTableView.delegate=self
        chatTableView.dataSource=self
        chatTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "messagecell_id")
        self.chatTableView.estimatedRowHeight = 400.0
        self.chatTableView.rowHeight =  UITableView.automaticDimension

        chatTextView.delegate=self
        speechRecognizer!.delegate = self  //3
        


        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()

    }
    
    @IBAction func sendButtonAction(_ sender: Any) {

        messegesArray.append(chatTextView.text)
        responseAdded = false
        chatTableView.reloadData()
        myUtternce = AVSpeechUtterance(string:chatTextView.text)
        chatTextView.text=""
        myUtternce.voice=AVSpeechSynthesisVoice(language: "en-US")
        myUtternce.rate = 0.5
        synth.speak(myUtternce)
        print(messegesArray)
        askQuestion()

    

    }
 
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if chatTextView.text.count == 0{
//            mikeButton.isHidden=false
            sendButton.isHidden=true
        }else{
//            mikeButton.isHidden=true
            sendButton.isHidden=false
        }
        return true
    }
    
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if text == "\n" {
            textView.resignFirstResponder()

            return false
        }
        if chatTextView.text.count == 0{
//            mikeButton.isHidden=false
            sendButton.isHidden=true
        }else{
//            mikeButton.isHidden=true
            sendButton.isHidden=false
        }
        return true
    }
    
    public func showPopup() {
        recordImageView.center = self.chatView.center
        //      dimView.frame = UIView(frame:view.)
        //  dimView = [[UIView alloc]initWithFrame:self.view.frame];
        dimView = UIView(frame: view.frame)
//        dimView.backgroundColor = UIColor.black
        dimView.alpha = 0;
        chatView.addSubview(dimView)
        chatView.bringSubviewToFront(dimView)
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha=0.3
        }
        chatView.addSubview(recordImageView)
        recordImageView.image=#imageLiteral(resourceName: "microphonegreay")
        dimView.center = chatView.center
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messegesArray.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagecell_id", for: indexPath) as! MessageTableViewCell
        cell.messageTextView.layer.cornerRadius = 15
        cell.messageTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if #available(iOS 11.0, *) {
            cell.messageTextView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMinXMinYCorner]
        }
        
        cell.messageTextView.text = messegesArray[indexPath.row] as? String
        
        if responseArray.count > 0 {
            if responseAdded == true{
                cell.responseTextView.isHidden = false
                cell.responseTextView.text = responseArray[indexPath.row] as? String
           
        }
            if cell.responseTextView.text == ""{
                cell.responseTextView.isHidden = true

            }else{
                cell.responseTextView.isHidden = false

            }
            
        }else{
            cell.responseTextView.isHidden = true
        }
//    
        return cell
        
        
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return UITableView.automaticDimension
    }
    
   func askQuestion(){
//    Alamofire.request("https://api.cai.tools.sap/train/v2/request/ask", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
//
//        switch response.result {
//
//        case .success(_):
//            if let json = response.value
//            {
//                let successHandler = json as! [String:AnyObject]
//                let dic:NSArray = successHandler["results"]?["faq"] as! NSArray
//                let answer:NSDictionary = dic[0] as! NSDictionary
//                self.responseArray.append("\(answer["answer"]!)")
//                self.indexPath = IndexPath(item: self.responseArray.lastIndex(of: "\(answer["answer"]!)") ?? 0, section: 0)
//                self.responseAdded = true
//                self.chatTableView.reloadData()
//            }
//            break
//        case .failure(let error):
//             let failureHandler = error as Error
//             print(failureHandler)
//
//            break
//        }
//
//
//    })
//
    }
       
    
}


        
