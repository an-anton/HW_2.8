//
//  AccountExistingTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

import UIKit

// MARK: - Protocol
protocol RefreshAccountViewControllerDelegete {
    func addNewAccount(with newValue: AccountList)
}
 
class AccountExistingTableViewController: UITableViewController {
    
    @IBOutlet var amountAccountButton: UIBarButtonItem!
    
    var persons: Person!
    var accountTypes: [AccountTypes] = []
    var accountForTypes: [String: [AccountList]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountAccountButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountTypes = coutingNumberOfTypes()
        amountAccountButton.title = String(ammountAllAccount()) + " ₽"
        accountForTypes = chosenAccountForTypes()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        accountTypes.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        accountTypes[section].rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dictionaryOfAccountList = accountForTypes
        let typeSection = accountTypes[section].rawValue
        let countAccountInAccountList = dictionaryOfAccountList[typeSection]!.count
        return countAccountInAccountList
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let accountsFromCurrentType = accountForTypes[accountTypes[indexPath.section].rawValue]!
        let currentAccount = accountsFromCurrentType[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        let accountCount = String(currentAccount.accountStartCount + ammountAllTransaction(for: currentAccount)) + " ₽"
        content.text = currentAccount.accountName
        content.secondaryText = accountCount
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "add" {
            let viewController = segue.destination as? UINavigationController
            guard let navigationVC = viewController else { return }
            guard let addAccountTVC = navigationVC.topViewController
                    as? AddAccountTableViewController else { return }
            addAccountTVC.delegate = self
            addAccountTVC.person = persons
        } else {
            let viewController = segue.destination as? UINavigationController
            guard let navigationVC = viewController else { return }
            guard let currentlyTVC = navigationVC.topViewController
                    as? CurrentlyAccountTableViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let accountsFromCurrentType = accountForTypes[accountTypes[indexPath.section].rawValue]!
            let currentAccount = accountsFromCurrentType[indexPath.row]
            
            let personAccountFroms = choosenTransactionsFromCurrentAccount(with: currentAccount)
            
            currentlyTVC.person = persons
            currentlyTVC.personTransactions = personAccountFroms
//            let personFromIndex = persons.accountList[indexPath.row]
            currentlyTVC.personIndex = currentAccount
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
    
    func coutingNumberOfTypes() -> [AccountTypes] {
        let accountTypes: [AccountTypes] = [.cash, .card, .bankBill]
        return accountTypes
    }
    
    func choosenTransactionsFromCurrentAccount(with currentAccount: AccountList) -> [Transaction] {
        var personAccountFroms: [Transaction] = []
        for person in persons.transaction {
            if person.accountTransactionFrom == currentAccount.accountName {
                personAccountFroms.append(person)
            }
        }
        return personAccountFroms
    }

    func chosenAccountForTypes() -> [String: [AccountList]] {
        var accountsForTypes: [String: [AccountList]] = [:]
        for currentlyType in persons.accountTypes {
            var accounts: [AccountList] = []
            for account in persons.accountList {
                if account.accountType == currentlyType {
                    accounts.append(account)
                    if accountsForTypes[currentlyType.rawValue]?.count != 0 {
                        accountsForTypes.updateValue(accounts, forKey: currentlyType.rawValue)
                    } else {
                        accountsForTypes[currentlyType.rawValue] = accounts
                    }
                }
            }
        }
        return accountsForTypes
    }
}
    // MARK: - Delegate
extension AccountExistingTableViewController: RefreshAccountViewControllerDelegete {
    func addNewAccount(with newValue: AccountList) {
        persons.accountList.append(newValue)
        accountForTypes = chosenAccountForTypes()
        accountTypes = coutingNumberOfTypes()
        amountAccountButton.title = String(ammountAllAccount()) + " ₽"
        tableView.reloadData()
    }
}
