//
//  File.swift
//  MeetingApp
//
//  Created by Troels on 05/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import Foundation

struct ValidationError: Error {
    
    public let message: String
    
    public init(message m: String) {
        message = m
    }
}
    
