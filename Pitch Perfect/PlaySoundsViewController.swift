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

    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
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
            
            playAudio(audioPlayer, audioRate: 0.5)

            
            enableDisableButtons(stopButton, enableState: true)
            enableDisableButtons(slowButton, enableState: false)

        }else{
            print("audio player not found")
        }
    }
    
    @IBAction func playSoundFast(sender: UIButton) {
        
        if let audioPlayer = self.setupAudioPlayerWithFile("AllWithin", type:"mp3") {
            self.audioPlayer = audioPlayer
           
            playAudio(audioPlayer, audioRate: 1.5)
            
            enableDisableButtons(stopButton, enableState: true)
            enableDisableButtons(fastButton, enableState: false)
            
        }else{
            print("Audio Player not found")
        }
    }
    
    
    @IBAction func stopAudioPlayer(sender: UIButton) {
        audioPlayer.stop()
        print("Stopping Audio Player")
        enableDisableButtons(stopButton, enableState: false)
        enableDisableButtons(slowButton, enableState: true)
        enableDisableButtons(fastButton, enableState: true)
    }
    
    
    /**
     This method will return an AVAudioPlayer object
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
    
    func enableDisableButtons(actionButton: UIButton, enableState : Bool){
        actionButton.enabled = enableState
    }
    
    func playAudio(audioPlayer :AVAudioPlayer, audioRate : Float){
        print("Playing Audio File")
        audioPlayer.enableRate = true
        audioPlayer.currentTime = 0.0 //Start the audio from the begining
        audioPlayer.rate = audioRate
        audioPlayer.play()
    }
}
