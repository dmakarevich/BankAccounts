//
//  Ex+View.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 19.10.2020.
//

import UIKit

@IBDesignable
extension UIView {
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
