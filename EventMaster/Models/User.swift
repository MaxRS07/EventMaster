//
//  User.swift
//  EventMaster
//
//  Created by Max Siebengartner on 15/3/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

public struct User : Codable, Identifiable {
    @DocumentID public var id: String?
    
    var name: String
    var surname: String
    var username: String
    var password: String
    var email: String
    
    var registedEvents: [String]?
}

extension User {
    func enrolledEvents(on date: Date) async -> [Event] {
        let events = await EventManager.fetchEvents()
        
        return events.filter({
            $0.date.prefix(11) == date.formatDate(format: "YYYY MMM dd")
        })
    }
}
