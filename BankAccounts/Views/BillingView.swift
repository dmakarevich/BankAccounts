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
    var id: Int?
    var completionHandler: (() -> ())?
    @IBInspectable
    @IBOutlet weak var balanceLabel: UILabel!
    @IBInspectable
    @IBOutlet weak var ownerLabel: UILabel!
    @IBInspectable
    @IBOutlet weak var dateLabel: UILabel!
    
    func set(by billing: Billing) {
        self.balanceLabel.text = "Balance: \(billing.balance)"
        self.ownerLabel.text = "Owner: \(billing.owner)"
        self.dateLabel.text = Utility.milisecondsToDateString(from: billing.date)
        self.id = billing.id
    }
    
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

    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let id = self.id else {
            return
        }
        self.deleteBiling(by: id)
    }
    
    func deleteBiling(by id: Int) {
        let success = { [unowned self] (data: Data?) in
            guard let handler = self.completionHandler else {
                print("Failed success closure")
                return
            }
            handler()
        }

        NetworkManager.delete(path: .deleteBiling,
                              id: id,
                              withCompletion: success)
    }
}
