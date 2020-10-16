//
//  Billing.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 14.10.2020.
//

import Foundation

struct Billing: Codable {
    let balance: String
    let date: Int
    let id: Int
    let owner: String
    let ownerId: Int

    enum CodingKeys: String, CodingKey {
        case balance
        case date
        case id
        case owner
        case ownerId = "ownerID"
    }
}
