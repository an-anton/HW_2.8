//
//  AccountExistingTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

import UIKit

protocol RefreshAccountViewControllerDelegete {
    func addNewAccount(with newValue: AccountList)
}

class AccountExistingTableViewController: UITableViewController {
    
    @IBOutlet var amountAccountButton: UIBarButtonItem!
    
    var persons = Person.getPerson()

    override func viewDidLoad() {
        super.viewDidLoad()
        amountAccountButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountAccountButton.title = String(ammountAllAccount()) + " ₽"
        tableView.reloadData()
        
        print("nfd")
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       persons.accountList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = persons.accountList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = person.accountName
        let accountCount = String(person.accountStartCount + ammountAllTransaction(for: person)) + " ₽"
        content.secondaryText = accountCount
        cell.contentConfiguration = content

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "add" {
            let viewController = segue.destination as? UINavigationController
            guard let navigationVC = viewController else { return }
            guard let addAccountTVC = navigationVC.topViewController as? AddAccountTableViewController else { return }
            addAccountTVC.delegate = self
        } else {
            let viewController = segue.destination as? UINavigationController
            guard let navigationVC = viewController else { return }
            guard let currentlyTVC = navigationVC.topViewController as? CurrentlyAccountTableViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            var personAccountFroms: [Transaction] = []
            for person in persons.transaction {
                if person.accountTransactionFrom == persons.accountList[indexPath.row].accountName {
                    personAccountFroms.append(person)
                }
            }
            currentlyTVC.person = persons
            currentlyTVC.personTransactions = personAccountFroms
            let personFromIndex = persons.accountList[indexPath.row]
            currentlyTVC.personIndex = personFromIndex
        }
    }
}

extension AccountExistingTableViewController {
    func ammountAllAccount() -> Int {
        var ammount = 0
        for accountList in persons.accountList {
            ammount = ammount + accountList.accountStartCount
        }
        for transaction in persons.transaction {
            ammount = ammount + transaction.amountTransaction
        }
        return ammount
    }
    
    func ammountAllTransaction(for person: AccountList) -> Int {
        var summAllTransaction = 0
        for transaction in persons.transaction {
            if transaction.accountTransactionFrom == person.accountName {
                summAllTransaction = summAllTransaction + transaction.amountTransaction
            }
        }
        return summAllTransaction
    }
}

extension AccountExistingTableViewController: RefreshAccountViewControllerDelegete {
    func addNewAccount(with newValue: AccountList) {
        persons.accountList.append(newValue)
    }
}
