///Users/troels/Documents/MeetingApp3/MeetingApp/viewControllers/Cells/StringExampleTableViewCell.swift
//  CreateMeetingViewController.swift
//  MeetingApp
//
//  Created by Troels on 24/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Validator
import PopupDialog
import Alamofire
import SwiftyJSON

class CreateMeetingViewController: UITableViewController, CalDelegate, UITextFieldDelegate {
    
    var meetingName: UITextField?
    var meetingTopic: UITextField?
    var meetingPlace: UITextField?
    var durationOfMeeting: UIDatePicker?
    var dateMeeting: UIDatePicker?
    
    var name: String?
    var topic: String?
    var place: String?

    @IBAction func CreateMeetingBtn(_ sender: UIBarButtonItem) {
        let dto = MeetingDTO()
        dto.name = meetingName?.text
        dto.topic = meetingTopic?.text
        dto.place = meetingPlace?.text
        
        let calendar = Calendar.current
        let time = calendar.dateComponents([.hour,.minute,.second], from: durationOfMeeting!.date)
        dto.expectedDuration = "\(time.hour!):\(time.minute!):\(time.second!)"
        
        let date = calendar.dateComponents([.day,.month,.year, .hour, .minute], from: dateMeeting!.date)
        dto.day = date.day
        dto.month = date.month
        dto.year = date.year
        
        dto.state = 0
        
        let parameters = [
            "name": meetingName?.text,
            "topic": meetingTopic?.text,
            "place": meetingPlace?.text,
            "expectedDuration": "\(time.hour!):\(time.minute!):\(time.second!)",
            "day": date.day,
            "month": date.month,
            "year": date.year,
            "state": 0
            ] as [String : Any]
        
        let jsonData = try! JSONEncoder().encode(dto)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        Alamofire.request("http://localhost:8080/rest/Meeting/Opret", method: .post, parameters: parameters, encoding: JSONEncoding.default).response { (DefaultDataResponse) in
            print(DefaultDataResponse.data)
        }
    }
    
    func openCal() {
        print("open")
        showCustomDialog()
    }
   //  @IBOutlet weak var labelpopup: UILabel!

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
        case 1: return "Tidspunkt"
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3 // tal for hver section
        case 1: return 2
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
                stringCell.titleLabel.text = "mødenavn"
                stringCell.summaryLabel.text = ""
                stringCell.textField.delegate = self
                meetingName = stringCell.textField
                let minLengthRule = ValidationRuleLength(min: 5, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: minLengthRule)
                
            case 1:
                stringCell.titleLabel.text = "Formål"
                stringCell.summaryLabel.text = ""
                stringCell.textField.delegate = self
                meetingTopic = stringCell.textField
                let maxLengthRule = ValidationRuleLength(max: 5, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: maxLengthRule)
                
            case 2:
                stringCell.titleLabel.text = "Sted"
                stringCell.summaryLabel.text = ""
                stringCell.textField.delegate = self
                meetingPlace = stringCell.textField
                let rangeLengthRule = ValidationRuleLength(min: 5, max: 20, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: rangeLengthRule)
            default:
                break
            }
            
        case 1:
            
            let Datepicker = tableView.dequeueReusableCell(withIdentifier: "DatePicker", for: indexPath) as! DatepickerTableViewCell
            
            // numericCell.validationRuleSet = ValidationRuleSet<Float>()
            cell = Datepicker
            
            switch indexPath.row {
                
            case 0:
                
                Datepicker.delegate = self
                
                dateMeeting = Datepicker.datepicker
                // place = stringCell.textField
                Datepicker.titleLabel.text = "Start tidspunkt for mødet"
                
                
            case 1:
                
                Datepicker.delegate = self
                
                durationOfMeeting = Datepicker.datepicker
                // place = stringCell.textField
                Datepicker.titleLabel.text = "Længden af mødet"
                Datepicker.hidebtn()
                
                Datepicker.datepicker.datePickerMode = .countDownTimer
                Datepicker.datepicker.minuteInterval = 5
                
                
            default:
                break
            }
        default:
            break
        }
        
        return cell!
        
    }
    
}
extension CreateMeetingViewController{
    /*!
     Displays a custom view controller instead of the default view.
     Buttons can be still added, if needed
     */
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "Luk", height: 60) {
//            self.labelpopup.text = "You canceled the rating dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "Færdig", height: 60) {
            //self.labelpopup.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
    }
}
