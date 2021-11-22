//
//  ChosenAccountTypeFromAddTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 21.11.2021.
//

import UIKit

class ChosenAccountTypeFromAddTableViewController: UITableViewController {

    var categories: [Categories]!
    var delegate: UpdateCategoryTableViewDelegate!
    
    private var sortedCategories: [Categories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortedCategories = categories.sorted(by: { $0.categoriesName < $1.categoriesName })
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedCategories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = sortedCategories[indexPath.row].categoriesName
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.updateCategory(with: sortedCategories[indexPath.row])
    }
}
