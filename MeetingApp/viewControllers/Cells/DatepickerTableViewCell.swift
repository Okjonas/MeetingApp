//
//  DatepickerTableViewCell.swift
//  MeetingApp
//
//  Created by Troels on 24/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import Foundation
import Validator

protocol CalDelegate: class {
    func openCal()
}
final class DatepickerTableViewCell: ExampleTableViewCell  {
    var delegate: CalDelegate?
    @IBAction func OpenCalBtn(_ sender: Any) {
        delegate?.openCal()
    }
    
    @IBOutlet weak var date: UIDatePicker!
    /*
    var validationRuleSet: ValidationRuleSet<String>? {
        didSet { textView.validationRules = validationRuleSet }
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
       // textView.validateOnInputChange(enabled: true)
       // textView.validationHandler = { result in self.updateValidationState(result: result) }
    }
    
    override func prepareForReuse() {
      //  textView.text = ""
    }
    
}

