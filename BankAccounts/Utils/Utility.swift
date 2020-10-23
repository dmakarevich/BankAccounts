//
//  Utility.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 17.10.2020.
//

import Foundation

struct Utility {
    static func dateTimeInMiliseconds(date: Date = Date()) -> Int {
        let since1970 = date.timeIntervalSince1970

        return Int(since1970 * 1000)
    }

    static func milisecondsToDateString(from dateInt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"

        return formatter.string(from: date)
    }
}
