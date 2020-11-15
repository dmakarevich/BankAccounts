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

    func toStringParameters() -> String {
        let valideDate = (self.date - date%1000)/1000
        return CodingKeys.date.rawValue + "=\(valideDate)&" +
               CodingKeys.balance.rawValue + "=\(self.balance)&" +
               CodingKeys.ownerId.rawValue + "=\(self.ownerId)"
    }
    
    func toParameters() -> [String: String] {
        let valideDate = (self.date - date%1000)/1000
        return [CodingKeys.date.rawValue: "\(valideDate)",
                CodingKeys.balance.rawValue: "\(self.balance)",
                CodingKeys.ownerId.rawValue: "\(self.ownerId)"]
    }
}
