//
//  UserManager.swift
//  EventMaster
//
//  Created by Max Siebengartner on 16/3/2024.
//

import Foundation
import FirebaseFirestore

class UserManager {
    
    private static let users = Firestore.firestore().collection("users")
    
    static func removeUser(id: String) {
        users.document(id).delete()
    }
    static func addUser(user: User) {
        let userData : [String : Any] = [
            "name" : user.name,
            "surname" : user.surname,
            "username" : user.username,
            "password" : SecurityManager().hash(user.password),
            "email" : user.email,
        ]
        users.addDocument(data: userData)
    }
    static func fetchUser(id: String) async -> User? {
        return try? await users.document(id).getDocument().data(as: User.self)
    }
    static func fetchUser(username: String) async -> User? {
        let query = users.whereField("username", isEqualTo: username)
        
        return try? await query.getDocuments().documents.first?.data(as: User.self)
    }
}
