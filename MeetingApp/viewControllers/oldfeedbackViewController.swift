//
//  feedbackViewController.swift
//  MeetingApp
//
//  Created by Troels on 27/02/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class feedbackViewController: UIViewController {
    
    var vote: Int = -1
    
    var qustions: [String] = ["spørgsmål 1", "spørgsmål 2", "spørgsmål 3"]
    var index = 0
    var answer: [FeedbackDTO] = []
    
    @IBOutlet weak var numberOfQustions: UILabel!
    @IBOutlet weak var TheQustion: UILabel!
    @IBOutlet weak var textFeedback: UITextField!
    @IBOutlet weak var progressline: UIView!
    @IBOutlet weak var progressbar: UIView!
    
    @IBOutlet var btn: [UIButton]!
    
    @IBAction func skale(_ sender: UIButton) {
        for item in btn {
            item.alpha = 0.6
        }
        sender.alpha = 1
        vote = Int(sender.restorationIdentifier!)!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfQustions.text = "\(index+1) af \(qustions.count)"
        TheQustion.text = qustions[index]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backbtn(_ sender: UIButton) {
        if(index > 0){
        index -= 1
        numberOfQustions.text = "\(index+1) af \(qustions.count)"
        TheQustion.text = qustions[index]
         //   progressline.frame.size.width = CGFloat(index/Qustions.count * Int(progressbar.frame.size.width))
            // TODO unpack.
        }
        unpackfeedback()
    }
    @IBAction func nextbtn(_ sender: UIButton) {
        if(index+1 < qustions.count){
        index += 1
        numberOfQustions.text = "\(index+1) af \(qustions.count)"
        TheQustion.text = qustions[index]
        //progressline.frame.size.width = CGFloat(index/Qustions.count * Int(progressbar.frame.size.width))
        packfeedback()
        }
    }
    
    func packfeedback(){
        let dto: FeedbackDTO = FeedbackDTO()
        dto.comment = textFeedback.text
        dto.feedback = vote
        answer.append(dto)
        
        for item in btn {
            item.alpha = 0.6
        }
        print(answer)
    }
    
    func unpackfeedback(){
        if let dto: FeedbackDTO = answer.popLast() {
            textFeedback.text = dto.comment
            vote = dto.feedback!
            
            for item in btn {
                item.alpha = 0.6
            }
            btn[dto.feedback!].alpha = 1
            print(answer)
        }
    }

}
