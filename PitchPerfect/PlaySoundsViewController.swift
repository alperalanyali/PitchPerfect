//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by alper alanyali on 22.03.2018.
//  Copyright © 2018 alper alanyali. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
   
    // MARK: Buttons Outlet
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    // MARK: declaration of audio
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    enum ButtonType: Int { case slow = 0,fast, chipmunk, vader, echo, reverb }
    
    // MARK: Play Sound Action
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow :
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
    
            playSound(pitch: 1000)
        case .vader:
             playSound(pitch: -1000)
        case .echo:
            playSound(echo:true)
        case .reverb:
            playSound(reverb:true)
        
        }
        configureUI(.playing)
    }
    // MARK: Stop Button Action
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        stopAudio()
    }
    

   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAudio()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
  
    

 

}
