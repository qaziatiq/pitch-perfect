//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Qazi on 03/06/2015.
//  Copyright (c) 2015 Qazi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer :AVAudioPlayer!
    var receivedSound : RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile : AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedSound.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedSound.filePathUrl, error: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func stopAudio()
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudio(rate: Float)
    {
        stopAudio()
        
        audioPlayer.rate = rate
        
        audioPlayer.currentTime = 0.0
        
        audioPlayer.play()
        
    }
    @IBAction func playFast(sender: AnyObject) {
       
        self.playAudio(2.0)
    }
    
    @IBAction func playSlow(sender: AnyObject) {
        
        self.playAudio(0.5)
    }
    
    func playAudioWithVariablePitch(pitch : Float)
    {
        stopAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    @IBAction func playChipmunkSound(sender: AnyObject) {
        
        playAudioWithVariablePitch(1000)
    
    }
    
    @IBAction func playDarthVaderSound(sender: AnyObject) {
        
                playAudioWithVariablePitch(-1000)
    }
    
    
    @IBAction func stopSound(sender: AnyObject) {
        
        stopAudio()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
