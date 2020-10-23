//
//  BillingView.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 19.10.2020.
//

import UIKit

@IBDesignable
class BillingView: UIView {
    private let selfName = "BillingView"
    @IBInspectable
    @IBOutlet weak var balanceLabel: UILabel!
    @IBInspectable
    @IBOutlet weak var ownerLabel: UILabel!
    @IBInspectable
    @IBOutlet weak var dateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: BillingView.self)
        if let viewsToAdd = bundle.loadNibNamed(self.selfName, owner: self, options: nil),
            let contentView = viewsToAdd.first as? UIView {
            self.addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }
}
