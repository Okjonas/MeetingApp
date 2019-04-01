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
        animationView.animationSpeed = 0.6
        lottiView.addSubview(animationView)
        let vc: InputMeetingIDViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "startFeedback") as! InputMeetingIDViewController
        let segue = FadeSegue(identifier: "startFeedback", source: self, destination: vc)
        
        animationView.play(completion: { (completed) in
          /*  let vc: InputMeetingIDViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "startFeedback") as! InputMeetingIDViewController
            self.present(vc, animated: true, completion: nil) */
            segue.perform()
        })
        
       // animationView.play()
    }
    
}

