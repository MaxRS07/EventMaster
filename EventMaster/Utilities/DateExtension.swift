//
//  DateExtension.swift
//  EventMaster
//
//  Created by Max Siebengartner on 18/3/2024.
//

import Foundation


extension Date {
    public func formatDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
