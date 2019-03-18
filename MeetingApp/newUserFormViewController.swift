//
//  newUserFormViewController.swift
//  MeetingApp
//
//  Created by Troels on 11/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Lottie
import Validator
import EasyPeasy

class newUserFormViewController: UIViewController {
    @IBOutlet weak var brugernavnInput: UITextField!
    @IBOutlet weak var brugernavnValLabel: UIView!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var emailValLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up Animationer.
        let animationView = LOTAnimationView(name: "Check Mark")
        animationView.frame = CGRect(x: -10, y: -13, width: 25, height: 25)
        animationView.contentMode = .scaleAspectFill
        self.brugernavnValLabel.addSubview(animationView)
        self.emailValLabel.addSubview(animationView)
        
        let animationViewWrong = LOTAnimationView(name: "wrong")
        animationViewWrong.frame = CGRect(x: -10, y: -13, width: 25, height: 25)
        animationViewWrong.contentMode = .scaleAspectFill
        self.brugernavnValLabel.addSubview(animationViewWrong)
        self.emailValLabel.addSubview(animationViewWrong)
        
        // set up valiadtion of textfiled.
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 4, max: 4, error: ValidationError.init(message: "fejl")))
        brugernavnInput.validationRules = rules
        
        var emailrules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError.init(message: "email val fejl")))
        self.emailInput.validationRules = emailrules
        
        brugernavnInput.validationHandler = { result in
            switch result {
            case .valid:
                animationView.isHidden = false
                animationViewWrong.isHidden = true
                animationView.play()
                print("YES!")
            case .invalid(let failureErrors):
                print("nope....")
                animationView.isHidden = true
                animationViewWrong.isHidden = false
                animationViewWrong.play()
            }
        }
        
        emailInput.validationHandler = { result in
            switch result {
            case .valid:
                animationView.isHidden = false
                animationViewWrong.isHidden = true
                animationView.play()
                print("YES!")
            case .invalid(let failureErrors):
                print("nope....")
                animationView.isHidden = true
                animationViewWrong.isHidden = false
                animationViewWrong.play()
            }
        }
        
        brugernavnInput.validateOnInputChange(enabled: true)
        emailInput.validateOnInputChange(enabled: true)
    }
    
}
