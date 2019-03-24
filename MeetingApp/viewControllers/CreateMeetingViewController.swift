//
//  CreateMeetingViewController.swift
//  MeetingApp
//
//  Created by Troels on 23/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Validator

class CreateMeetingViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
    }
    
}

extension CreateMeetingViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Oplysninger om dig"
        case 1: return "Numeric (with UISlider)"
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 7 // tal for hver section
        case 1: return 1
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        switch indexPath.section {
            
        case 0:
            
            let stringCell = tableView.dequeueReusableCell(withIdentifier: "StringExample", for: indexPath) as! StringExampleTableViewCell
            stringCell.validationRuleSet = ValidationRuleSet<String>()
            cell = stringCell
            
            switch indexPath.row {
                
            case 0:
                stringCell.titleLabel.text = "Fornavn"
                stringCell.summaryLabel.text = ""
                let minLengthRule = ValidationRuleLength(min: 5, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: minLengthRule)
                
            case 1:
                stringCell.titleLabel.text = "Efternavn"
                stringCell.summaryLabel.text = ""
                let maxLengthRule = ValidationRuleLength(max: 5, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: maxLengthRule)
                
            case 2:
                stringCell.titleLabel.text = "Telefon"
                stringCell.summaryLabel.text = ""
                let rangeLengthRule = ValidationRuleLength(min: 5, max: 20, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: rangeLengthRule)
                
            case 3:
                stringCell.titleLabel.text = "Email Address"
                stringCell.summaryLabel.text = ""
                let emailPattern = EmailValidationPattern.simple
                let emailRule = ValidationRulePattern(pattern: emailPattern, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: emailRule)
                
            case 4:
                stringCell.titleLabel.text = "Virksomheds ID"
                stringCell.summaryLabel.text = "Hvis din virksomhed anvender Spinoff har de et ID fx. V123"
                let containsRule = ValidationRuleContains<String, Array<String>>(sequence: ["hello", "hey", "hi"], error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: containsRule)
                
            case 5:
                stringCell.titleLabel.text = "Password"
                stringCell.summaryLabel.text = ""
                let rangeLengthRule = ValidationRuleLength(min: 5, max: 30, error: ValidationError(message: "😫"))
                let digitPattern = ContainsNumberValidationPattern()
                let digitRule = ValidationRulePattern(pattern: digitPattern, error: ValidationError(message: "😥"))
                let casePattern = CaseValidationPattern.uppercase
                let capitalRule = ValidationRulePattern(pattern: casePattern, error: ValidationError(message: "😞"))
                stringCell.validationRuleSet?.add(rule: rangeLengthRule)
                stringCell.validationRuleSet?.add(rule: digitRule)
                stringCell.validationRuleSet?.add(rule: capitalRule)
                
            case 6:
                stringCell.titleLabel.text = "Password igen"
                stringCell.summaryLabel.text = ""
                let rangeLengthRule = ValidationRuleLength(min: 5, max: 30, error: ValidationError(message: "😫"))
                let digitPattern = ContainsNumberValidationPattern()
                let digitRule = ValidationRulePattern(pattern: digitPattern, error: ValidationError(message: "😥"))
                let casePattern = CaseValidationPattern.uppercase
                let capitalRule = ValidationRulePattern(pattern: casePattern, error: ValidationError(message: "😞"))
                stringCell.validationRuleSet?.add(rule: rangeLengthRule)
                stringCell.validationRuleSet?.add(rule: digitRule)
                stringCell.validationRuleSet?.add(rule: capitalRule)
            default:
                break
            }
            
        case 1:
            
            let numericCell = tableView.dequeueReusableCell(withIdentifier: "DatePicker", for: indexPath) as! DatepickerTableViewCell
           // numericCell.validationRuleSet = ValidationRuleSet<Float>()
            cell = numericCell
            
            switch indexPath.row {
                
            case 0:
                numericCell.titleLabel.text = "Comparison"
                //numericCell.summaryLabel.text = "Ensures the input is between 2 and 7 using ValidationRuleComparison"
               // let comparisonRule = ValidationRuleComparison<Float>(min: 5, max: 7, error: ValidationError(message: "😫"))
               // numericCell.validationRuleSet?.add(rule: comparisonRule)
                
            default:
                break
            }
        default:
            break
        }
        
        return cell!
        
    }
    
}
