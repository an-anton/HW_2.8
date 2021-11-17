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
        print(persons)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountAccountButton.title = String(ammountAllAccount()) + " ₽"
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "add" {
            let viewController = segue.destination as? UINavigationController
            guard let navigationVC = viewController else { return }
            guard let addAccountTVC = navigationVC.topViewController
                    as? AddAccountTableViewController else { return }
            addAccountTVC.delegate = self
        } else {
            let viewController = segue.destination as? UINavigationController
            guard let navigationVC = viewController else { return }
            guard let currentlyTVC = navigationVC.topViewController
                    as? CurrentlyAccountTableViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let personAccountFroms = transactionsFromCurrentAccount(with: indexPath)
            
            currentlyTVC.person = persons
            currentlyTVC.personTransactions = personAccountFroms
            let personFromIndex = persons.accountList[indexPath.row]
            currentlyTVC.personIndex = personFromIndex
        }
    }
}
    // MARK: - Extension
extension AccountExistingTableViewController {
    func ammountAllAccount() -> Int {
        var ammount = 0
        for accountList in persons.accountList {
            ammount = ammount + accountList.accountStartCount
        }
        for transaction in persons.transaction {
            if transaction.typeTransaction == "Доход" {
                ammount = ammount + transaction.amountTransaction
            } else { ammount = ammount - transaction.amountTransaction }
        }
        return ammount
    }
    
    func ammountAllTransaction(for person: AccountList) -> Int {
        var summAllTransaction = 0
        for transaction in persons.transaction {
            if transaction.accountTransactionFrom == person.accountName {
                if transaction.typeTransaction == "Доход" {
                    summAllTransaction = summAllTransaction + transaction.amountTransaction
                } else {summAllTransaction = summAllTransaction - transaction.amountTransaction}
            }
        }
        return summAllTransaction
    }
}
    // MARK: - Delegate
extension AccountExistingTableViewController: RefreshAccountViewControllerDelegete {
    func addNewAccount(with newValue: AccountList) {
        persons.accountList.append(newValue)
        tableView.reloadData()
    }
}

extension AccountExistingTableViewController {
    func transactionsFromCurrentAccount(with indexPath: IndexPath) -> [Transaction] {
        var personAccountFroms: [Transaction] = []
        for person in persons.transaction {
            if person.accountTransactionFrom == persons.accountList[indexPath.row].accountName {
                personAccountFroms.append(person)
            }
        }
        return personAccountFroms
    }
}
