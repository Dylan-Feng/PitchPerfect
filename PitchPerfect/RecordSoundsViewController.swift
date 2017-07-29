//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by 冯士琳 on 2017/7/15.
//  Copyright © 2017年 Udacity. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var recodingLabel: UILabel!
    @IBOutlet weak var recordbutton: UIButton!
    @IBOutlet weak var stoprecording: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        stoprecording.isEnabled = false
    }
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }


    override var prefersStatusBarHidden: Bool {
        return true
    }
      @IBAction func RecordAudio(_ sender: Any) {
        recodingLabel.text = "recoding in progress"
        recordbutton.isEnabled = false
        stoprecording.isEnabled = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        stoprecording.isEnabled = false
        recordbutton.isEnabled = true
        recodingLabel.text = "Tap to record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("recording is failed")
        
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
        let playSoundsVC = segue.destination as! playSoundsViewController
        let recordedAudioURL = sender as! URL
        playSoundsVC.recordedAudioURL = recordedAudioURL
            print("succed")
        }
        
    }
}
