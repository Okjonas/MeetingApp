//
//  FadeSegue.swift
//  MeetingApp
//
//  Created by Troels on 22/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class FadeSegue: UIStoryboardSegue {
    /*
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
 */
    
    override func perform() {
        // Get the view of the source
        let sourceViewControllerView = self.source
        // Get the view of the destination
        let destinationViewControllerView = self.destination
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // Make the destination view the size of the screen
        destinationViewControllerView.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        // Insert destination below the source
        // Without this line the animation works but the transition is not smooth as it jumps from white to the new view controller
        destinationViewControllerView.view.alpha = 0;
        sourceViewControllerView.view.addSubview(destinationViewControllerView.view);
        // Animate the fade, remove the destination view on completion and present the full view controller
        UIView.animate(withDuration: 0.5, animations: {
            destinationViewControllerView.view.alpha = 1;
        }, completion: { (finished) in
            destinationViewControllerView.view.removeFromSuperview()
            sourceViewControllerView.present(self.destination, animated: false, completion: nil)
        })
    }
}
