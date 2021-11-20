//
//  ChosenAccountTypeTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 20.11.2021.
//

import UIKit

class ChosenAccountTypeTableViewController: UITableViewController {

    var accountEnumType: [AccountTypes]!
    var delegete: IndexDidSelectedRowViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return accountEnumType.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var content = cell.defaultContentConfiguration()

        content.text = accountEnumType[indexPath.row].rawValue
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegete.updateType(with: accountEnumType[indexPath.row])
        dismiss(animated: true, completion: .none)
    }
}
