//
//  MainViewController.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 09.10.2020.
//

import UIKit

class MainViewController: UIViewController {
    private var billings : [String]?
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }


}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    internal func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BankCardCell.reuseIdentifier,
                                                      for: indexPath)

        return cell
    }
}
