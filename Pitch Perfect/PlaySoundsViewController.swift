//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Paul Thaden on 5/20/15.
//  Copyright (c) 2015 Paul Thaden. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var timer = NSTimer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func playPlayer() {
        //play the audio
        audioPlayer.stop()
        //fix bug where effects overlap
        audioEngine.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    @IBAction func stopPlayer(sender: UIButton) {
        audioPlayer.stop()
        
    }
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
    
    @IBAction func ffwPressed(sender: UIButton) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target:self, selector: Selector("jumpForward"), userInfo: nil, repeats: true)
        
    }
    @IBAction func ffwReleased(sender: UIButton) {
        timer.invalidate()
    }
    
    func jumpForward() {
        if (audioPlayer.currentTime > 0.0 && audioPlayer.currentTime < audioPlayer.duration) {
            audioPlayer.currentTime = audioPlayer.currentTime + 0.2
        }
    }
    
    @IBAction func rewPressed(sender: UIButton) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target:self, selector: Selector("jumpBackward"), userInfo: nil, repeats: true)
        
    }
    @IBAction func rewReleased(sender: UIButton) {
        timer.invalidate()
    }
    
    func jumpBackward() {
        if (audioPlayer.currentTime > 0.0 && audioPlayer.currentTime < audioPlayer.duration) {
            audioPlayer.currentTime = audioPlayer.currentTime - 0.2
        }
    }
    
    
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.rate = 1.5
        //play the audio
        playPlayer()
        
    }
    @IBAction func playSlow(sender: UIButton) {
        
        audioPlayer.rate = 0.5
        playPlayer()
        
        
        
    }
}
