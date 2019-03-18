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
    @IBOutlet var evalAnimations: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up Animationer.
        let animationViewBrugernavn = AnimationView(name: "Check Mark")
        animationViewBrugernavn.frame = CGRect(x: -10, y: -13, width: 25, height: 25)
        animationViewBrugernavn.contentMode = .scaleAspectFill
        self.brugernavnValLabel.addSubview(animationViewBrugernavn)
        
        let animationViewWrongBrugernavn = AnimationView(name: "wrong")
        animationViewWrongBrugernavn.frame = CGRect(x: -10, y: -13, width: 25, height: 25)
        animationViewWrongBrugernavn.contentMode = .scaleAspectFill
        self.brugernavnValLabel.addSubview(animationViewWrongBrugernavn)
        
        
        // set up Animationer.
        let animationViewEmail = AnimationView(name: "Check Mark")
        animationViewEmail.frame = CGRect(x: -10, y: -13, width: 25, height: 25)
        animationViewEmail.contentMode = .scaleAspectFill
        self.emailValLabel.addSubview(animationViewEmail)
        
        let animationViewWrongEmail = AnimationView(name: "wrong")
        animationViewWrongEmail.frame = CGRect(x: -10, y: -13, width: 25, height: 25)
        animationViewWrongEmail.contentMode = .scaleAspectFill
        self.emailValLabel.addSubview(animationViewWrongEmail)
        
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
                animationViewBrugernavn.isHidden = false
                animationViewWrongBrugernavn.isHidden = true
                animationViewBrugernavn.play()
                print("YES!")
            case .invalid(let failureErrors):
                print("nope....")
                animationViewBrugernavn.isHidden = true
                animationViewWrongBrugernavn.isHidden = false
                animationViewWrongBrugernavn.play()
            }
        }
        
        emailInput.validationHandler = { result in
            switch result {
            case .valid:
                animationViewEmail.isHidden = false
                animationViewWrongEmail.isHidden = true
                animationViewEmail.play()
                print("YES!")
            case .invalid(let failureErrors):
                print("nope....")
                animationViewEmail.isHidden = true
                animationViewWrongEmail.isHidden = false
                animationViewWrongEmail.play()
            }
        }
        
        brugernavnInput.validateOnInputChange(enabled: true)
        emailInput.validateOnInputChange(enabled: true)
    }
    
}
