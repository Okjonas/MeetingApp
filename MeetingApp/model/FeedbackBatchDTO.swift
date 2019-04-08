//
//  FeedbackBatchDTO.swift
//  MeetingApp
//
//  Created by Troels on 08/04/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import Foundation


class FeedbackBatchDTO: Codable {
    
    var meetingID: String?
    var feedback : [FeedbackDTO]?

}
/*
extension FeedbackBatchDTO {
    func toJSON() -> Dictionary<String, AnyObject> {
        return [
            "meetingID": self.meetingID as AnyObject,
            "feedback": self.feedback as AnyObject
        ]
    }
}
*/
