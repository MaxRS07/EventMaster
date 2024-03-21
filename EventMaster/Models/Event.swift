//
//  Event.swift
//  EventMaster
//
//  Created by Max Siebengartner on 15/3/2024.
//

import Foundation
import FirebaseFirestore

public struct Event : Codable, Identifiable {
    @DocumentID public var id: String?
    
    var image: Data
    var name: String
    var desc: String
    var date: String
    var tags: [String]
    var location: String
    var hosts: [String]
    
    init(id: String? = nil, image: Data, name: String, desc: String, date: String, location: String, tags: [EventTags]? = nil, hosts: [String]) {
        self.id = id
        self.image = image
        self.name = name
        self.desc = desc
        self.date = date
        self.location = location
        self.hosts = hosts
        if let tags {
            self.tags = tags.map({$0.rawValue})
        } else {
            self.tags = []
        }
    }
}
