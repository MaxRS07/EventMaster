//
//  SecurityManager.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import CryptoKit
import BCrypt

class SecurityManager {
    func hash(_ input: String) -> String? {
        do {
            let salt = try BCrypt.Salt()
            let hashedString = try BCrypt.Hash.make(message: input, with: salt)
            return hashedString.makeString()
        } catch {
            print("Error hashing string: \(error)")
            return nil
        }
    }
    func verify(_ password: String, hashedPassword: String) -> Bool {
        do {
            return try BCrypt.Hash.verify(message: password, matches: hashedPassword)
        } catch {
            print("Error verifying password: \(error)")
            return false
        }
    }
}
