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
import Alamofire
import SwiftyJSON

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
  
        switch result {
        case .valid:
            Alamofire.request("http://localhost:8080/rest/Feedback/isOpenforFeedback/\(meetingID.text!)", method: .get, parameters: [:], encoding: JSONEncoding.default).responseJSON { (response) in
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    print(JSON(json).boolValue)
                if(JSON(json).boolValue){
                    self.feedbackLabel.textColor = #colorLiteral(red: 0.09411764706, green: 0.6352941176, blue: 0.5098039216, alpha: 1)
                    self.feedbackLabel.text = "Rigtigt Møde ID"
                    self.goToFeedback()
                }else{
                    self.feedbackLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                    self.feedbackLabel.text = "Der fides ikke et møde klar til feedback med dette ID."
                }
                
            }
            }
        case .invalid(let failures):
            self.feedbackLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            feedbackLabel.text = "Møde ID her ikke det rigige format, prøv igen."
        }
    }
    
    func goToFeedback(){
        let vc: FeedbackViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "GiveFeedback") as! FeedbackViewController
        // TODO få spørgsmål for mødet og giv dem til vc.
        
        self.present(vc, animated: true, completion: nil)
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

