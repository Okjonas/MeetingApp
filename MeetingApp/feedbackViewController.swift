//
//  feedbackViewController.swift
//  MeetingApp
//
//  Created by Troels on 27/02/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class feedbackViewController: UIViewController {
    
    var vote: Int = 0
    
    var Qustions: [String] = ["spørgsmål 1", "spørgsmål 2", "spørgsmål 3"]
    var index = 0
    
    @IBOutlet weak var numberOfQustions: UILabel!
    @IBOutlet weak var TheQustion: UILabel!
    @IBOutlet weak var textFeedback: UITextField!
    @IBOutlet weak var progressline: UIView!
    
    @IBOutlet var btn: [UIButton]!
    
    @IBAction func skale(_ sender: UIButton) {
        for item in btn {
            item.alpha = 0.6
        }
        sender.alpha = 1
        vote = Int(sender.restorationIdentifier!)!
        print(vote)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfQustions.text = "\(index+1) af \(Qustions.count)"
        TheQustion.text = Qustions[index]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backbtn(_ sender: UIButton) {
        if(index > 0){
        index -= 1
        numberOfQustions.text = "\(index+1) af \(Qustions.count)"
        TheQustion.text = Qustions[index]
        }
    }
    @IBAction func nextbtn(_ sender: UIButton) {
        if(index+1 < Qustions.count){
        index += 1
        numberOfQustions.text = "\(index+1) af \(Qustions.count)"
        TheQustion.text = Qustions[index]
        }
    }

}
