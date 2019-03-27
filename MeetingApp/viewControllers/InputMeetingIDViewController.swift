//
//  LoginViewController.swift
//  MeetingApp
//
//  Created by Troels on 25/02/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Validator
import EasyPeasy

class InputMeetingIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        meetingID.easy.layout(
            CenterX().to(mainView),
            Top(40).to(mainView)
                              )
 */
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var titel: UILabel!
    @IBOutlet weak var mainView: UIImageView!
    @IBOutlet weak var meetingID: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBAction func feedbackBtn(_ sender: UIButton) {
        validate()
    }
    
    func validate() {
        let rule = ValidationRuleLength(min: 4, max: 4, error: ValidationError.init(message: "fejl"))
        
        let result = meetingID.text!.validate(rule: rule)
        // Note: the above is equivalent to Validator.validate(input: "invalid@email,com", rule: rule)
        
        switch result {
        case .valid: feedbackLabel.text = ""
        case .invalid(let failures): feedbackLabel.text = "Møde ID her ikke det rigige format, prøv igen."
        }
    }
    
    
    

}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
}

