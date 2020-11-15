//
//  MainViewController.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 09.10.2020.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Variables
    private var billings: [Billing] = []

    private enum BillingSections: Int {
        case billing
        case addBilling
        case count

        private static let addBillingItemsCount = 1

        static func getAddBillingItemsCount() -> Int {
            return 1
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.fetchBilings()
    }

    func updateCollectionView(billings: [Billing]) {
        self.billings = billings
        self.collectionView.reloadData()
    }
}

//MARK: - Network methods for billings
extension MainViewController  {
    func fetchBilings() {
        let success = { [unowned self] (data: Data?) in
            guard let data = data,
                  let billings = try? JSONDecoder().decode([Billing].self, from: data) else {
                return
            }
            self.updateCollectionView(billings: billings)
        }

        NetworkManager.load(path: .allBilling,
                            withCompletion: success)

//        AFNetworkManager.load(path: .allBilling,
//                              successHandler: success)
    }
    
    func insertBiling(billing: CreateBilling) {
        let success = { [unowned self] in
            self.fetchBilings()
        }

        NetworkManager.insert(path: .newBilling,
                              parameters: billing.toStringParameters(),
                              withCompletion: success)
//
//        AFNetworkManager.insert(path: .newBilling,
//                                parameters: billing.toParameters(),
//                                withCompletion: success)
    }

    func openCreateBillingAlert() {
        let alert = UIAlertController(title: "New Billing",
                                      message: "Enter a balance of billing",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Add Billing",
                                       style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first,
                let balance = textField.text else {
                return
            }

            self.insertBiling(billing: CreateBilling(balance: balance))
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField(configurationHandler: { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = "100"
        })
        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true)
    }

    func openBillingModal(by billing: Billing) {
        guard let vc = self
                .storyboard?
                .instantiateViewController(withIdentifier: Constants.billingModalVCIdentifier) as? BillingModalViewController else {
            return
        }

        vc.modalPresentationStyle = .overCurrentContext
        vc.billing = billing
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: BillingModalViewControllerDelegate {
    func billingModalViewControllerDidFinish(_ bilingModalViewController: BillingModalViewController) {
        bilingModalViewController.dismiss(animated: true, completion: nil)
        self.fetchBilings()
    }
}

// MARK: - Collection View DataSource and Delrgate Methods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return BillingSections.count.rawValue
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == BillingSections.billing.rawValue {
            return billings.count
        } else {
            return BillingSections.getAddBillingItemsCount()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == BillingSections.addBilling.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddBillingCell.reuseIdentifier,
                                                          for: indexPath) as? AddBillingCell ?? AddBillingCell()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillingCell.reuseIdentifier,
                                                          for: indexPath) as? BillingCell ?? BillingCell()
            let billing = self.billings[indexPath.row]
            cell.set(balance: billing.balance, owner: billing.owner)

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case BillingSections.addBilling.rawValue:
            self.openCreateBillingAlert()
        case BillingSections.billing.rawValue:
            let billing = self.billings[indexPath.row]
            self.openBillingModal(by: billing)
        default:
            print("Unknowen BillingCell Tapped!!")
        }
    }
}

// MARK: - CollectionViewDelegateFlowLayout Methods
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 115)
    }
}
