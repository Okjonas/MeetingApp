//
//  FadeSegue.swift
//  MeetingApp
//
//  Created by Troels on 22/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class FadeSegue: UIStoryboardSegue {
    
    override func perform() {
        let toVc = self.destination
        let fromVc = self.source
        
        fromVc.view.superview?.insertSubview(toVc.view, at: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
            fromVc.view.alpha = 0
        }, completion:{ success in
            let vc: InputMeetingIDViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "startFeedback") as! InputMeetingIDViewController
            fromVc.present(vc, animated: false, completion: nil)
        })
    }

}
