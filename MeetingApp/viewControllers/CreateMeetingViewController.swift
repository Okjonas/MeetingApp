//
//  CreateMeetingViewController.swift
//  MeetingApp
//
//  Created by Troels on 24/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Validator
import PopupDialog

class CreateMeetingViewController: UITableViewController, CalDelegate {
    
   
    
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
                stringCell.titleLabel.text = "mødenavn"
                stringCell.summaryLabel.text = ""
                let minLengthRule = ValidationRuleLength(min: 5, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: minLengthRule)
                
            case 1:
                stringCell.titleLabel.text = "Formål"
                stringCell.summaryLabel.text = ""
                let maxLengthRule = ValidationRuleLength(max: 5, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: maxLengthRule)
                
            case 2:
                stringCell.titleLabel.text = "Sted"
                stringCell.summaryLabel.text = ""
                let rangeLengthRule = ValidationRuleLength(min: 5, max: 20, error: ValidationError(message: "😫"))
                stringCell.validationRuleSet?.add(rule: rangeLengthRule)
            default:
                break
            }
            
        case 1:
            
            let Datepicker = tableView.dequeueReusableCell(withIdentifier: "DatePicker", for: indexPath) as! DatepickerTableViewCell
            // numericCell.validationRuleSet = ValidationRuleSet<Float>()
            Datepicker.delegate = self
            cell = Datepicker
            
            switch indexPath.row {
                
            case 0:
                Datepicker.titleLabel.text = "Tidspunkt for mødet"
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
extension CreateMeetingViewController{
    
    // MARK: Outlets
    
   
    
    // MARK: Actions
    
    @IBAction func showImageDialogTapped(_ sender: UIButton) {
        showImageDialog()
    }
    
    @IBAction func showStandardDialogTapped(_ sender: UIButton) {
        showStandardDialog()
    }
    
    @IBAction func showCustomDialogTapped(_ sender: UIButton) {
        showCustomDialog()
    }
    
    // MARK: Popup Dialog examples
    
    /*!
     Displays the default dialog with an image on top
     */
    func showImageDialog(animated: Bool = true) {
        
        // Prepare the popup assets
        let title = "THIS IS THE DIALOG TITLE"
        let message = "This is the message section of the PopupDialog default view"
        let image = UIImage(named: "colorful")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image, preferredWidth: 580)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL") { [weak self] in
//            self!.labelpopup.text = "You canceled the image dialog"
        }
        
        // Create fourth (shake) button
        let buttonTwo = DefaultButton(title: "SHAKE", dismissOnTap: false) { [weak popup] in
            popup?.shake()
        }
        
        // Create second button
        let buttonThree = DefaultButton(title: "OK") { [weak self] in
  //            self!.labelpopup.text = "You ok'd the image dialog"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    /*!
     Displays the default dialog without image, just as the system dialog
     */
    func showStandardDialog(animated: Bool = true) {
        
        // Prepare the popup
        let title = "THIS IS A DIALOG WITHOUT IMAGE"
        let message = "If you don't pass an image to the default dialog, it will display just as a regular dialog. Moreover, this features the zoom transition"
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true,
                                hideStatusBar: true) {
                                    print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL") {
      //      self.labelpopup.text = "You canceled the default dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "OK") {
       //     self.labelpopup.text = "You ok'd the default dialog"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
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
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
//            self.labelpopup.text = "You canceled the rating dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "RATE", height: 60) {
            //self.labelpopup.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
    }
}
