//
//  MinpickerTableViewCell.swift
//  MeetingApp
//
//  Created by Troels on 26/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

final class MinpickerTableViewCell: ExampleTableViewCell {

    @IBOutlet weak var minPicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // textView.validateOnInputChange(enabled: true)
        // textView.validationHandler = { result in self.updateValidationState(result: result) }
    }
    
    override func prepareForReuse() {
        //  textView.text = ""
    }
    

}
