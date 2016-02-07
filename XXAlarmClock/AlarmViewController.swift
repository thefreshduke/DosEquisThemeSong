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
    
    @IBOutlet weak var alarmTimeLabel: UITextField!
    
    var alarmHour: Int = 20
    var alarmMinute: Int = 04
    var alarmSecond: Int = 00
    
    @IBOutlet weak var timeDisplayLabel: UITextField!
    
    
    @IBAction func setAlarmTime(sender: AnyObject) {
//        let alert = UIAlertController(title: "Set alarm time", message: "", preferredStyle: UIAlertControllerStyle.Alert)
//        
//        var alarmTimeString: UITextField
//        
//        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
//            alarmTimeString = alert.textFields![0] as UITextField
//            print("Text field: \(alarmTimeString.text)")
//        }))

//        alarmHour = Range<String.Index>(start: alarmTime.0, end: alarmTime.2)
//        alarmMinute = Range(start: alarmTime.3, end: alarmTime.5)
//        alarmSecond = Range(start: alarmTime.6, end: alarmTime.8)
        
//        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
//            textField.placeholder = "Enter text:"
//        })
//        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func playDosEquisThemeSong(sender: AnyObject) {
        dosEquisThemeSong?.numberOfLoops = -1
        dosEquisThemeSong?.volume = 1
        dosEquisThemeSong?.play()
    }
    
    @IBAction func stopDosEquisThemeSong(sender: AnyObject) {
        let composer = TWTRComposer()
        
        composer.setText("I don't always ... But when I do, I...")
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
        
        let strAlarmHour = String(format: "%02d", alarmHour)
        let strAlarmMinute = String(format: "%02d", alarmMinute)
        let strAlarmSecond = String(format: "%02d", alarmSecond)
        
        alarmTimeLabel.text = "\(strAlarmHour):\(strAlarmMinute):\(strAlarmSecond)"
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
        let components = calendar.components([.Second, .Minute, .Hour], fromDate: date)
        
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        // add the leading zero for minutes, seconds and milliseconds and store them as string constants
        let strHour = String(format: "%02d", hour)
        let strMinute = String(format: "%02d", minute)
        let strSecond = String(format: "%02d", second)
        
        // concatenate minutes, seconds and milliseconds and assign them to the UILabel
        timeDisplayLabel.text = "\(strHour):\(strMinute):\(strSecond)"
        
        if (alarmHour == hour && alarmMinute == minute && alarmSecond == second) {
            dosEquisThemeSong?.numberOfLoops = -1
            dosEquisThemeSong?.volume = 1
            dosEquisThemeSong?.play()
        }
    }
}
