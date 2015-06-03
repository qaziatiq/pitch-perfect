//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Qazi on 20/05/2015.
//  Copyright (c) 2015 Qazi. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func viewWillAppear(animated: Bool) {
        self.stopRecordingButton.hidden = true;
        self.recordButton.enabled = true;
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
       
        if(flag)
        {
            recordedAudio = RecordedAudio(filePath: recorder.url, title: recorder.url.lastPathComponent!)

            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "stopRecording")
        {
            let playSoundVC : PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundVC.receivedSound = data
            
        }
        
    }
    @IBAction func recordAudio(sender: AnyObject) {
        
        self.recordButton.enabled = false;
        self.recordingLabel.text = "Recording";
        self.stopRecordingButton.hidden = false;
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self

        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(sender: AnyObject) {
        
        self.recordButton.enabled = true;
        self.recordingLabel.text = "Tap to Record";
        self.stopRecordingButton.hidden = true;
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

