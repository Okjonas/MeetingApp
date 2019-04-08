//
//  FeedbackDTO.swift
//  MeetingApp
//
//  Created by Troels on 28/02/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import Foundation

class FeedbackDTO: Codable {

    var comment: String?
    var vote : Int?
    
}
/*
extension FeedbackDTO{
    func toJSON() -> Dictionary<String, AnyObject> {
        return [
            "comment": self.comment as AnyObject,
            "vote": self.vote as AnyObject
        ]
    }
}
*/
