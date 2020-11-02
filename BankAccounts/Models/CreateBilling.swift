//
//  CreateBilling.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 17.10.2020.
//

import Foundation

struct CreateBilling: Codable {
    let balance: String
    let date: Int
    let ownerId: Int

    init(balance: String) {
        self.balance = balance
        self.date = Utility.dateTimeInMiliseconds()
        self.ownerId = 1
    }

    enum CodingKeys: String, CodingKey {
        case balance
        case date
        case ownerId = "ownerID"
    }

    func toParameters() -> String {
        return CodingKeys.date.rawValue + "=\(self.date)&" +
            CodingKeys.balance.rawValue + "=\(self.balance)&" +
            CodingKeys.ownerId.rawValue + "=\(self.ownerId)"
    }
}
