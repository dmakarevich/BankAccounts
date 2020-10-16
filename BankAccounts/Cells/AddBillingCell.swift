//
//  AddBillingCell.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 16.10.2020.
//

import UIKit

@IBDesignable
class AddBillingCell: UICollectionViewCell {
    static let reuseIdentifier: String = "AddBillingCell"
    
    @IBInspectable
    private var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
