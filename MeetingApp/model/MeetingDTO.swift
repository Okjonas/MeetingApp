//
//  MeetingDTO.swift
//  MeetingApp
//
//  Created by Troels on 24/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import Foundation

class MeetingDTO: Codable {
    var name: String?
    var topic: String?
    var place: String?
    var state: Int?// 0 ikke starte, 1 igang, 2 slut.
    var day: Int?
    var month: Int?
    var year: Int?
    var realStartTime: String?
    var realendTime: String?
    var meetingID: String?
    var userMeetingID: String?
    var startTime: String?
    var endTime: String?
    var expectedDuration: String?
    var createdById: Int?
}
