//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ibrahim.Moustafa on 1/9/16.
//  Copyright (c) 2016 Ibrahim.Moustafa. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var recAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSound()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initSound(){
        audioEngine = AVAudioEngine()
        try! audioFile = AVAudioFile(forReading: recAudio.filePathUrl)
        try! audioPlayer = AVAudioPlayer(contentsOfURL: recAudio.filePathUrl)
        audioPlayer.enableRate = true
    }
    
    @IBAction func btnPlaySlow(sender: UIButton) {
        playWithVariableTempo(0.5)
    }

    @IBAction func btnPlayFast(sender: UIButton) {
        playWithVariableTempo(1.5)
    }
    
    func playWithVariableTempo(speed:Float){
        stopAll()
        audioPlayer.currentTime = 0
        audioPlayer.rate = speed
        audioPlayer.play()
    }
    
    @IBAction func btnPlayDarthvader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func btnPlayChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func btnStopAllPlays(sender: UIButton) {
        stopAll()
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAll()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        
        audioPlayerNode.play()
    }
    
    @IBAction func btnPlayReverbClick(sender: UIButton) {
        playAudioWithReverb()
    }
    
    func playAudioWithReverb(){
        stopAll()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.wetDryMix = 50
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.LargeChamber)
        audioEngine.attachNode(reverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func stopAll(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
