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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddBankCardCell.reuseIdentifier,
                                                          for: indexPath) as? AddBankCardCell ?? AddBankCardCell()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BankCardCell.reuseIdentifier,
                                                          for: indexPath) as? BankCardCell ?? BankCardCell()
            let billing = self.billings[indexPath.row]
            cell.set(balance: billing.balance, owner: billing.owner)

            return cell
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
