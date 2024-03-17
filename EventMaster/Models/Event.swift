//
//  Event.swift
//  EventMaster
//
//  Created by Max Siebengartner on 15/3/2024.
//

import Foundation
import FirebaseFirestore

struct Event : Codable, Identifiable {
    @DocumentID var id: String?
    
    var image: Data
    var name: String
    var desc: String
    var date: String
    
    init(id: String? = nil, image: Data, name: String, desc: String, date: String) {
        self.id = id
        self.image = image
        self.name = name
        self.desc = desc
        self.date = date
    }
}
