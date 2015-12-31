//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Kioko on 31/12/2015.
//  Copyright © 2015 Thomas Kioko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //Change the visibility of the recording lable field
        recordingInProgress.hidden = false
        //TODO: Record the users voice
        print("Recording in progress ...")
    }

    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden = true
        print("Recording stopped ...")
    }

}

