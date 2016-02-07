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
    var timer = NSTimer()
    var startingTime = NSTimeInterval()
    @IBOutlet weak var timeDisplayLabel: UITextField!
    
    @IBAction func playDosEquisThemeSong(sender: AnyObject) {
        dosEquisThemeSong?.numberOfLoops = -1
        dosEquisThemeSong?.volume = 1
        dosEquisThemeSong?.play()
    }
    
    @IBAction func stopDosEquisThemeSong(sender: AnyObject) {
        let composer = TWTRComposer()
        
        composer.setText("just setting up my Fabric")
        composer.setImage(UIImage(named: "fabric"))
        
        // Called from a UIViewController
        composer.showFromViewController(self) { result in
            if (result == TWTRComposerResult.Cancelled) {
                print("Tweet composition cancelled")
            }
            else {
                print("Sending tweet!")
                self.dosEquisThemeSong?.stop()
                self.dosEquisThemeSong?.currentTime = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dosEquisThemeSong = self.setupAudioPlayerWithFile("DosEquisThemeSong", type:"mp3") {
            self.dosEquisThemeSong = dosEquisThemeSong
        }
        
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startingTime = NSDate.timeIntervalSinceReferenceDate()
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
    
    func updateTime () {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Second, .Minute, .Hour, .Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
//        print(year)
//        print(month)
//        print(day)
        
//        let currentTime = NSDate.timeIntervalSinceReferenceDate()
//        
//        // calculate elapsed time
//        var elapsedTime = currentTime
//        
//        // calculate elapsed hours
//        let hours = UInt8(elapsedTime / 3600.0)
//        elapsedTime -= NSTimeInterval(hours) * 3600.0
//        
//        // calculate elapsed minutes
//        let minutes = UInt8(elapsedTime / 60.0)
//        elapsedTime -= NSTimeInterval(minutes) * 60.0
//        
//        // calculate elapsed seconds
//        let seconds = UInt8(elapsedTime)
//        elapsedTime -= NSTimeInterval(seconds)
//        
//        // calculate elasped milliseconds
////        let milliseconds = UInt8(elapsedTime * 100)
        
        // add the leading zero for minutes, seconds and milliseconds and store them as string constants
        let strHour = String(format: "%02d", hour)
        let strMinute = String(format: "%02d", minute)
        let strSecond = String(format: "%02d", second)
        
        // concatenate minutes, seconds and milliseconds and assign them to the UILabel
        timeDisplayLabel.text = "\(strHour):\(strMinute):\(strSecond)"
    }
}
