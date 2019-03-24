//
//  RatingViewController.swift
//  PopupDialog
//
//  Created by Martin Wildfeuer on 11.07.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import TinyCalendar

class RatingViewController: UIViewController {
    
    //@IBOutlet weak var cosmosStarRating: CosmosView!
  //  @IBOutlet weak var calendarView: CalendarView!
    
    @IBOutlet weak var commentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let calendarView = CalendarView(frame: CGRect(x: 0, y: 40, width: 375, height: 375))
      //  calendarView.configure()
        
        
        let calendarView = CalendarView(frame: CGRect(x: 0, y: 0, width: 300, height: 240))
        calendarView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        calendarView.configure()
        
        self.view.addSubview(calendarView)

     //   commentTextField.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
        //: ### Select a day
        let today = CalendarDate.today()!
        calendarView.select(at: today, animated: true)
        
        //: ### Change year or month
        let calendar = Calendar(identifier: .gregorian)
        let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: Date())!
        let nextMonth = CalendarDate(with: nextMonthDate)!
        calendarView.update(year: nextMonth.year, month: nextMonth.month)

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func endEditing() {
        view.endEditing(true)
    }
}

extension RatingViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
}
