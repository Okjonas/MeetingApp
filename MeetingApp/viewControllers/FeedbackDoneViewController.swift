//
//  FeedbackDoneViewController.swift
//  MeetingApp
//
//  Created by Troels on 21/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Lottie

class FeedbackDoneViewController: UIViewController {

    @IBOutlet weak var lottiView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up Animationer.
        let animationView = AnimationView(name: "feedbackDone")
        //animationView.frame = CGRect(x: -200, y: -200, width: lottiView.frame.size.width, height: lottiView.frame.size.height)
        animationView.center = lottiView.center
        animationView.contentMode = .scaleAspectFill
        lottiView.addSubview(animationView)
        
        animationView.play(completion: { (completed) in
            let vc: InputMeetingIDViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "startFeedback") as! InputMeetingIDViewController
            self.present(vc, animated: true, completion: nil)
        })
        
       // animationView.play()
    }
    
}
