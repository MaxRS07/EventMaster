//
//  UserAuth.swift
//  EventMaster
//
//  Created by Max Siebengartner on 19/3/2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import AuthenticationServices

enum AuthState {
    case loggedIn
    case loggedOut
    case authenticated
}
@MainActor
class UserAuth : ObservableObject {
    @Published var currentUser: User?
    @Published var authState: AuthState = .loggedOut

    //TODO: support firebase/google login
    func login(username: String, password: String) async -> Bool {
        let securityManager = SecurityManager()
        guard let user = await UserManager.fetchUser(username: username) else {
            return false
        }
        if securityManager.verify(password, hashedPassword: user.password) {
            currentUser = user
            authState = .loggedIn
            return true
        } else {
            return false
        }
        
    }
    func logout() {
        authState = .loggedOut
        currentUser = nil
    }
}
