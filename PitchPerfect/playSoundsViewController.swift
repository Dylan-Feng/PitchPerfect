//
//  playSoundsViewController.swift
//  PitchPerfect
//
//  Created by 冯士琳 on 2017/7/22.
//  Copyright © 2017年 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundsViewController: UIViewController {
   @IBOutlet weak var HighPitchButton: UIButton!
   @IBOutlet weak var LowPitchButton: UIButton!
   @IBOutlet weak var fastButton: UIButton!
   @IBOutlet weak var slowButton: UIButton!
   @IBOutlet weak var echoButton: UIButton!
   @IBOutlet weak var reverbButton: UIButton!
   @IBOutlet weak var stopButton: UIButton!

    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    enum ButtonType: Int { case HighPitch = 0, lowPitch, fast, slow, echo, reverb
    }
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .HighPitch:
            playSound(pitch: 1000)
        case .lowPitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        print("Play Sound Button Pressed")
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
