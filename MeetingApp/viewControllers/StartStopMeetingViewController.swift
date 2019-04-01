//
//  StartStopMeetingViewController.swift
//  MeetingApp
//
//  Created by Troels on 01/04/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class StartStopMeetingViewController: UIViewController {
    
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var deltaTime = 0
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var meetingStarted = false
    
    var meetingDTO: MeetingDTO?
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var meetingName: UILabel!
    @IBOutlet weak var meetingTopic: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBAction func StartBtn(_ sender: UIButton) {
        if(!meetingStarted){
        runTimer()
        sender.titleLabel?.text = "Stop Mødet"
        meetingStarted = true
        }else{
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        meetingName.text = meetingDTO?.name
        meetingTopic.text = meetingDTO?.topic
        startTime.text = meetingDTO?.startTime
        endTime.text = meetingDTO?.endTime
    }

    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(seconds), target: self,   selector: (#selector(self.setTimerLabel)), userInfo: nil, repeats: true)
    }
    
    @objc func setTimerLabel() {
        deltaTime+=1
        minLabel.text = "\(deltaTime) Min"
    }

}
