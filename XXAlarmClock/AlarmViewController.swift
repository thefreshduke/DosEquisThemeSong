//
//  AlarmViewController.swift
//  XXAlarmClock
//
//  Created by Scotty Shaw on 2/5/16.
//  Copyright © 2016 ___sks6___. All rights reserved.
//

import UIKit
import AVFoundation
import TwitterKit

class AlarmViewController: UIViewController {
    
    var dosEquisThemeSong: AVAudioPlayer?
    
    @IBAction func playDosEquisThemeSong(sender: AnyObject) {
        dosEquisThemeSong?.numberOfLoops = -1
        dosEquisThemeSong?.volume = 1
        dosEquisThemeSong?.play()
    }
    
    @IBAction func stopDosEquisThemeSong(sender: AnyObject) {
        dosEquisThemeSong?.stop()
        dosEquisThemeSong?.currentTime = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dosEquisThemeSong = self.setupAudioPlayerWithFile("DosEquisThemeSong", type:"mp3") {
            self.dosEquisThemeSong = dosEquisThemeSong
        }
    }
    
    func setupAudioPlayerWithFile(file: NSString, type: NSString) -> AVAudioPlayer?  {
        
        // 1
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
//        let url = NSURL.fileURLWithPath("DosEquisThemeSong.mp3")
        
        // 2
        var audioPlayer: AVAudioPlayer?
        
        // 3
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
//            try audioPlayer = AVAudioPlayer(contentsOfURL: NSURL.fileURLWithPath("DosEquisThemeSong.mp3"))
        }
        catch {
            print("Player not available")
        }
        
        // 4
        return audioPlayer
    }
    
}
