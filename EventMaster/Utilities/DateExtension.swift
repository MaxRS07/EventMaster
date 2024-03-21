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
    public func formatDate(format: DateFormatOptions) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    public enum DateFormatOptions : String {
        case day = "dd"
        case fullMonth = "MMMM"
        case numMonth = "MM"
        case fullYear = "YYYY"
        case shortYear = "YY"
        case normal = "MMMM dd"
        case normalYYYY = "MMMM dd, YYYY"
        case short = "MMM dd"
        case mini = "dd/MM"
        case monthyear = "MMMM, YYYY"
    }
    public var month : Int {
        get {return Int(self.formatDate(format: .fullMonth))!}
    }
    public var day : Int {
        get {return Int(self.formatDate(format: .day))! }
    }
    public var year : Int {
        get {return Int(self.formatDate(format: .fullYear))!}
    }
    public var hour : Int {
        get {return Int(self.formatDate(format: "hh"))!}
    }
    public var minute : Int {
        get {return Int(self.formatDate(format: "mm"))!}
    }
    public func sameday(other: Self) -> Bool {
        return self.formatDate(format: "MMddYYYY") == other.formatDate(format: "MMddYYYY")
    }
    public func addTime(_ period: DateComponents,_ num: Int = 1) -> Self {
        return Calendar.current.date(byAdding: period, to: self)!
    }
    func numberOfDaysInMonth() -> Int {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month], from: self)
        
        guard let startDate = calendar.date(from: dateComponents),
              let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) else {
            return 0
        }
        
        let numberOfDays = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        
        return numberOfDays + 1
    }
    func firstDayOfMonth() -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month], from: self)
        let firstDayOfMonth = calendar.date(from: dateComponents)!
        
        return firstDayOfMonth
    }
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    static func decode(date: String) -> Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        
        let monthIndex = date.index(date.startIndex, offsetBy: 5)
        let monthIndexEnd = date.index(date.startIndex, offsetBy: 7)

        let dayIndex = date.index(date.startIndex, offsetBy: 8)
        let dayIndexEnd = date.index(date.startIndex, offsetBy: 10)

        let hourIndex = date.index(date.startIndex, offsetBy: 11)
        let hourIndexEnd = date.index(date.startIndex, offsetBy: 13)
        
        dateComponents.year = Int(date.prefix(4))!
        dateComponents.month = Int(date[monthIndex..<monthIndexEnd])!
        dateComponents.day = Int(date[dayIndex..<dayIndexEnd])!
        dateComponents.hour = Int(date[hourIndex..<hourIndexEnd])!
        dateComponents.minute = Int(date.suffix(2))!
        return calendar.date(from: dateComponents)
    }
}
