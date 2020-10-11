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
    }


}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 //self.billings?.count ?? 10
    }
}
