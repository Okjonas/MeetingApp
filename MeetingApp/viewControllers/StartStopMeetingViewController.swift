//
//  StartStopMeetingViewController.swift
//  MeetingApp
//
//  Created by Troels on 01/04/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
    @IBOutlet weak var realStartTime: UILabel!
    @IBOutlet weak var realEndTime: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBAction func StartBtn(_ sender: UIButton) {
        if(!meetingStarted){
            startMeeting()
        }else{
            stopMeeting()
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
    
    func startMeeting(){
        Alamofire.request("http://localhost:8080/rest/Meeting/Start/\(String(describing: meetingDTO!.meetingID!))", method: .post).responseJSON { response in
            switch response.result {
            case .success:
                let date: String = JSON(response.data).string!
                self.startBtn.setTitle("Stop Møde", for: .normal)
                self.meetingStarted = true
                self.runTimer()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func stopMeeting(){
        Alamofire.request("http://localhost:8080/rest/Meeting/End/\(String(describing: meetingDTO!.meetingID!))", method: .post).responseJSON { response in
            switch response.result {
            case .success:
                self.startBtn.setTitle("Mødet er nu afsluttet", for: .normal)
                self.startBtn.isHidden = true;
            case .failure(let error):
                print(error)
            }
        }
    }

}
