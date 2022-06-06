//
//  ReadAndWriteModelclass.swift
//  myJobCard
//
//  Created by Rover Software on 24/07/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import AVFoundation
import Speech
import ODSFoundation
import mJCLib

@available(iOS 10.0, *)
class ReadAndWriteModelclass: NSObject,SFSpeechRecognizerDelegate,AVSpeechSynthesizerDelegate {
    class var uniqueInstance : ReadAndWriteModelclass {
        struct Static {
            static let instance : ReadAndWriteModelclass = ReadAndWriteModelclass()
        }
        return Static.instance
    }
    override init() {
        super.init()
    }
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? = nil
    var recognitionTask: SFSpeechRecognitionTask? = nil
    let audioEngine = AVAudioEngine()
    var Synthesizer = AVSpeechSynthesizer()
    func ReadText(text : String){
        if Synthesizer.isSpeaking == false{
            let speachutteerance = AVSpeechUtterance(string :text)
            speachutteerance.rate = 0.4
            speachutteerance.voice = AVSpeechSynthesisVoice.init(language: "en-US")
            Synthesizer.delegate = self
            Synthesizer.speak(speachutteerance)
            
        }else{
            Synthesizer.stopSpeaking(at: .immediate)
        }
    }
    func stopspeaking() {
        Synthesizer.stopSpeaking(at: .immediate)
    }
    // avspeechsynthesizer delegates
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance){
        print("speak started")
        mJCLogger.log("speak started".localized(), Type: "")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance){
        print("speak finished")
        mJCLogger.log("speak finished".localized(), Type: "")
        NotificationCenter.default.post(name: Notification.Name(rawValue:"textToSpeechEnded"), object: "")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance){
        print("speak pause")
        mJCLogger.log("speak pause".localized(), Type: "")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance){
        print("speak continue")
        mJCLogger.log("speak continue".localized(), Type: "")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance){
        print("speak caneled")
        mJCLogger.log("speak caneled".localized(), Type: "")
        self.speechSynthesizer(synthesizer, didFinish: utterance)
    }
    func getsiripermission(){
        mJCLogger.log("getsiripermission".localized(), Type: "")
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            switch authStatus {
            case .authorized:
                print("User  accepted to speech recognition")
                mJCLogger.log("User  accepted to speech recognition".localized(), Type: "Debug")
            case .denied:
                print("User denied access to speech recognition")
                mJCLogger.log("User denied access to speech recognition".localized(), Type: "Debug")
            case .restricted:
                print("Speech recognition restricted on this device")
                mJCLogger.log("Speech recognition restricted on this device".localized(), Type: "Debug")
            case .notDetermined:
                print("Speech recognition not yet authorized")
                mJCLogger.log("Speech recognition not yet authorized".localized(), Type: "Debug")
            }
        }
    }
}
