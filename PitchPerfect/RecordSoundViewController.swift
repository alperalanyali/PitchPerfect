//
// RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by alper alanyali on 21.03.2018.
//  Copyright © 2018 alper alanyali. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder?
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
  @IBAction func record(_ sender: UIButton)
    {
        
        print("Record Button is presssed")
        recordingLabel.text = "Recoding in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = URL(string: pathArray.joined(separator: "/"))
            audioRecorder?.delegate = self
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
            
            try! audioRecorder = AVAudioRecorder(url:filePath!, settings: [:])
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
     
    }
    @IBAction func stopRecording(_ sender: UIButton) {
        
        recordingLabel.text = " Tap to Record"
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        if audioRecorder != nil {
            audioRecorder?.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
            audioRecorderDidFinishRecording(audioRecorder!, successfully: true)
        }
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder?.url)
            
        } else {
            print("Recording was not successful")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "stopRecording"{
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as? URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
}

