//
//  BillingModalViewController.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 18.10.2020.
//

import UIKit

protocol BillingModalViewControllerDelegate: class {    
    func billingModalViewControllerDidFinish(_ bilingModalViewController: BillingModalViewController)
}

class BillingModalViewController: UIViewController {
    private var deleteHandler: (() -> ())?
    var billing: Billing?
    @IBOutlet weak var billingView: BillingView!
    
    // MARK: - Delegate
    weak var delegate: BillingModalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let billing = self.billing else {
            return
        }
        
        self.billingView.set(by: billing)
        deleteHandler = { [weak self] in
            guard let self = self else {
                print("Failed in delete handler!")
                return
            }
            self.openConfirmDeleteBillingAlert()
        }

        self.billingView.completionHandler = deleteHandler
        self.createBlurredBackgroundView()
    }

    @objc func closeViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func createBlurredBackgroundView() {
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurredView.frame = self.view.bounds
        self.view.insertSubview(blurredView, at: 0)
        
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(closeViewController))
        recognizer.numberOfTapsRequired = 1
        blurredView.addGestureRecognizer(recognizer)
        
    }

    func openConfirmDeleteBillingAlert() {
        let success = { [weak self] in
            guard let self = self else {
                print("Failed in delete handler!")
                return
            }
            self.delegate?.billingModalViewControllerDidFinish(self)
        }

        let alert = UIAlertController(title: "Delete",
                                      message: "You sure want delete the billing?",
                                      preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete",
                                       style: .destructive) { [unowned self] action in
            guard let id = self.billing?.id else {
                return
            }

            AFNetworkManager.delete(path: .deleteBiling, id: id, successHandler: success)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true)
    }
}
