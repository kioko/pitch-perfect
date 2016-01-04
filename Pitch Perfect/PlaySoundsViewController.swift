//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Kioko on 31/12/2015.
//  Copyright © 2015 Thomas Kioko. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var reveivedAudio:RecordedAudio!
    var audioPlayerNode:AVAudioPlayerNode!
    
    
    //The default value is 1.0. The range of supported values is 1/32 to 32.0.
    var slowAudioRate : Float = 0.5
    var fastAudioRate : Float = 1.5
    
    //The default value is 1.0. The range of values is -2400 to 2400
    var chimpMunkPicth : Float = 1000
    var darthVaderPitch : Float = -1000
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var chimpMunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        if let audioPlayer = self.setupAudioPlayerWithFile("AllWithin", type:"mp3") {
            self.audioPlayer = audioPlayer
            
            
            playAudio(audioPlayer, audioFile: nil, audioPitch: nil, audioRate: slowAudioRate)
            
            
            enableDisableButtons(stopButton, enableState: true)
            enableDisableButtons(slowButton, enableState: false)
            enableDisableButtons(fastButton, enableState: true)
            enableDisableButtons(chimpMunkButton, enableState: true)
            enableDisableButtons(darthVaderButton, enableState: true)
            
        }else{
            print("audio player not found")
        }
    }
    
    @IBAction func playSoundFast(sender: UIButton) {
        
        if let audioPlayer = self.setupAudioPlayerFromRecordedFile() {
            self.audioPlayer = audioPlayer
            
            playAudio(audioPlayer, audioFile: nil, audioPitch: nil, audioRate: fastAudioRate)
            
            enableDisableButtons(stopButton, enableState: true)
            enableDisableButtons(slowButton, enableState: true)
            enableDisableButtons(fastButton, enableState: false)
            enableDisableButtons(chimpMunkButton, enableState: true)
            enableDisableButtons(darthVaderButton, enableState: true)
            
        }else{
            print("Audio Player not found")
        }
    }
    
    
    @IBAction func playChimpMunkAudio(sender: UIButton) {
        
        if let audioPlayer = self.setupAudioPlayerFromRecordedFile() {
            self.audioPlayer = audioPlayer
            var audioFile:AVAudioFile!
            
            do{
                try audioFile = AVAudioFile(forReading: reveivedAudio.filePathUrl)
            }catch{
                print("Error converting to Audio File")
            }
            
            playAudio(audioPlayer, audioFile: audioFile, audioPitch: chimpMunkPicth, audioRate:nil)
            
            enableDisableButtons(stopButton, enableState: true)
            enableDisableButtons(slowButton, enableState: true)
            enableDisableButtons(fastButton, enableState: true)
            enableDisableButtons(chimpMunkButton, enableState: false)
            enableDisableButtons(darthVaderButton, enableState: true)
            
        }else{
            print("Audio Player not found")
        }
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        
        if let audioPlayer = self.setupAudioPlayerFromRecordedFile() {
            self.audioPlayer = audioPlayer
            var audioFile:AVAudioFile!
            
            do{
                try audioFile = AVAudioFile(forReading: reveivedAudio.filePathUrl)
            }catch{
                print("Error converting to Audio File")
            }
            
            playAudio(audioPlayer, audioFile: audioFile, audioPitch: darthVaderPitch, audioRate:nil)
            
            enableDisableButtons(stopButton, enableState: true)
            enableDisableButtons(slowButton, enableState: true)
            enableDisableButtons(fastButton, enableState: true)
            enableDisableButtons(chimpMunkButton, enableState: true)
            enableDisableButtons(darthVaderButton, enableState: false)
            
        }else{
            print("Audio Player not found")
        }
        
    }
    
    @IBAction func stopAudioPlayer(sender: UIButton) {
        audioPlayer.stop()
        audioPlayerNode.play()
        print("Stopping Audio Player")
        enableDisableButtons(stopButton, enableState: false)
        enableDisableButtons(slowButton, enableState: true)
        enableDisableButtons(fastButton, enableState: true)
        enableDisableButtons(darthVaderButton, enableState: true)
    }
    
    
    /**
     This method will return an AVAudioPlayer object. It loads an audio file
     from the app.
     @param file File Name
     @param type File type eg Mp3
     @return AudioPlayer Audio Player Object
     */
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        //Get the Full path of the Audio file
        let audioFilePath = NSBundle.mainBundle()
            .pathForResource(file as String, ofType: type as String)
        
        if audioFilePath != nil{
            
            let url = NSURL.fileURLWithPath(audioFilePath!)
            
            /// Try and create an Audio Player object. We surround it with
            /// try and catch in case the object is not created
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: url)
            } catch {
                print("Player not available")
            }
            return audioPlayer
        } else {
            print("audio file is not found")
            return nil
        }
    }
    
    /**
     This method will return an AVAudioPlayer object. It loads an audio file
     that has been recorded from RecordSoundsViewController.
     
     @return AudioPlayer Audio Player Object
     */
    func setupAudioPlayerFromRecordedFile() -> AVAudioPlayer?  {
        //Get the Full path of the Audio file
        let audioFilePath = reveivedAudio.filePathUrl
        
        if audioFilePath != nil{
            
            /// Try and create an Audio Player object. We surround it with
            /// try and catch in case the object is not created
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioFilePath)
            } catch {
                print("Player not available")
            }
            return audioPlayer
        } else {
            print("audio file is not found")
            return nil
        }
    }
    
    
    func enableDisableButtons(actionButton: UIButton, enableState : Bool){
        actionButton.enabled = enableState
    }
    
    func playAudio(audioPlayer :AVAudioPlayer, audioFile: AVAudioFile?,
        audioPitch : Float?, audioRate : Float?){
            
            print("Playing Normal Audio File")
            
            if let audioRate = audioRate{
                audioPlayer.rate = audioRate
            }
            
            audioPlayer.enableRate = true
            audioPlayer.currentTime = 0.0 //Start the audio from the begining
            
            if let audioTimePitch = audioPitch{
                print("Playing Normal Audio File")
                audioEngine = AVAudioEngine()
                audioEngine.stop()
                audioEngine.reset()
                
                let audioPlayerNode = AVAudioPlayerNode()
                audioEngine.attachNode(audioPlayerNode)
                
                let changePithcEffect = AVAudioUnitTimePitch()
                changePithcEffect.pitch = audioTimePitch
                audioEngine.attachNode(changePithcEffect)
                
                audioEngine.connect(audioPlayerNode, to: changePithcEffect, format: nil)
                audioEngine.connect(changePithcEffect, to: audioEngine.outputNode, format: nil)
                
                if let audioFile = audioFile{
                    audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
                }
                
                try! audioEngine.start()
                audioPlayerNode.play()
            }else{
                audioPlayer.play()
            }
            
    }
    
}
