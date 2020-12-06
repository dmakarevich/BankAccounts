//
//  BillingCell.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 12.10.2020.
//

import UIKit

class BillingCell: UICollectionViewCell {
    static let reuseIdentifier: String = "BillingCell"

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!

    func set(balance: String, owner: String) {
        self.balanceLabel.text = balance
        self.ownerLabel.text = owner
    }
}
