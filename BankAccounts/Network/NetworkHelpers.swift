//
//  NetworkHelpers.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 16.10.2020.
//

import Foundation

enum Urls: String {
    case baseURL = "https://bankaccounts-andersen.herokuapp.com/"
    case allBilling
    case newBilling
    case deleteBiling = "billing"
    case allTransaction
    case newTransaction
    case deleteTransaction = "transaction"
}

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
