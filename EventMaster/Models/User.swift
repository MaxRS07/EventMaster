//
//  User.swift
//  EventMaster
//
//  Created by Max Siebengartner on 15/3/2024.
//

import Foundation
import FirebaseFirestore

struct User : Codable, Identifiable {
    @DocumentID var id: String?
    
    var name: String
    var surname: String
    var username: String
    var password: String
    var email: String
}
