//
//  MoreTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 21.11.2021.
//

import UIKit

protocol CategoriesTableViewDalegete {
    func addNewCategory(with newValue: Categories)
}

class MoreTableViewController: UITableViewController {

    var persons: Person!
    var delegate: UpdateTabBatTest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let categoriesVC = segue.destination as? CategoriesTableViewController else { return }
        categoriesVC.categories = persons.accountСategories
    }
}

    // MARK: - Extension
extension MoreTableViewController: CategoriesTableViewDalegete {
    func addNewCategory(with newValue: Categories) {
        persons.accountСategories.append(newValue)
        delegate.updateTabBar(with: persons)
    }
}
