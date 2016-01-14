//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ibrahim.Moustafa on 1/8/16.
//  Copyright (c) 2016 Ibrahim.Moustafa. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{
    
    
    @IBOutlet weak var btnRecordSound: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblRecording: UILabel!
    
    @IBOutlet weak var prgVolume: UIProgressView!
    @IBOutlet weak var lblTimer: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordSettings:[NSObject : AnyObject]!
    var recTimer:NSTimer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordSettings = [
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
    }
    
    
    func SetRecordingState(isRecording: Bool)
    {
        btnStop.hidden = !isRecording
        btnRecordSound.enabled = !isRecording
        prgVolume.hidden = !isRecording
        lblTimer.hidden = !isRecording
        if(isRecording)
        {
            lblRecording.text = "Recording...."
            
        }
        else
        {
            lblRecording.text = "Tab to record"
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        SetRecordingState(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segStopRecording"){
            let vcPlaySounds: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data:RecordedAudio = sender as! RecordedAudio
            vcPlaySounds.recAudio = data
        }
    }
    
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            let recAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            performSegueWithIdentifier("segStopRecording", sender: recAudio)
        }
        else
        {
            print("error saving record")
            SetRecordingState(false)
        }
        
    }
    
    
    
    @IBAction func recordAudio(sender: UIButton) {
        
        SetRecordingState(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)!
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        audioRecorder = try! AVAudioRecorder(URL: filePath, settings: recordSettings as! [String : AnyObject])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        recTimer = NSTimer.scheduledTimerWithTimeInterval(0.1,
            target:self,
            selector:"updateAudioMeter:",
            userInfo:nil,
            repeats:true)
    }
    
    func updateAudioMeter(timer:NSTimer) {
        if audioRecorder.recording {
            let dFormat = "%02d"
            let min:Int = Int(audioRecorder.currentTime / 60)
            let sec:Int = Int(audioRecorder.currentTime % 60)
            lblTimer.text = "\(String(format: dFormat, min)):\(String(format: dFormat, sec))"
           
            audioRecorder.updateMeters()
             var peak0 = audioRecorder.peakPowerForChannel(0)
            peak0 += 100
            peak0 = peak0 / 100
            prgVolume.progress = Float( peak0)
        }
    }
    
    @IBAction func btnStopClick(sender: UIButton) {
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        
    }
}

