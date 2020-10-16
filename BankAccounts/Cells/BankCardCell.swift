//
//  BankCardCell.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 12.10.2020.
//

import UIKit

@IBDesignable
class BankCardCell: UICollectionViewCell {
    static let reuseIdentifier: String = "BankCardCell"

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!

    @IBInspectable
    private var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

    func set(balance: String, owner: String) {
        self.balanceLabel.text = balance
        self.ownerLabel.text = owner
    }
}
