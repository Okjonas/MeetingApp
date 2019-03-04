//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import FoldingCell
import UIKit

class DemoCell: FoldingCell {

    @IBOutlet var closeNumberLabel: UILabel!
    @IBOutlet var openNumberLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeWeekDay: UILabel!
    @IBOutlet weak var DateClosed: UILabel!
    
    
    var number: Int = 0 {
        didSet {
            closeNumberLabel.text = String(number)
            openNumberLabel.text = String(number)
        }
    }
    
    var data: String = ""{
        didSet{
           // closeLabel.text = data
            //openLabel.text = data
        }
    }

    override func awakeFromNib() {
       foregroundView.layer.cornerRadius = 10
       foregroundView.layer.masksToBounds = true
        foregroundView.layer.shadowColor = UIColor.black.cgColor
        
        foregroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        foregroundView.layer.shadowRadius = 3
        foregroundView.layer.shadowOpacity = 0.3
        //foregroundView.backgroundColor = UIColor.gray
       
        super.awakeFromNib()
    }

    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}

// MARK: - Actions ⚡️

extension DemoCell {

    @IBAction func buttonHandler(_: AnyObject) {
        print("tap")
    }
}

