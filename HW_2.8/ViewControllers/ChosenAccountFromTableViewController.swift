//
//  ChosenAccountFromTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 22.11.2021.
//

import UIKit

class ChosenAccountFromTableViewController: UITableViewController {

    var person: Person!
    var delegate: UpdateAccountFromTableViewDelegate!
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.accountList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let accountName = person.accountList[indexPath.row].accountName
        let accountBalance = ammountTransactions(for: person, with: accountName)
        delegate.updateAccountFrom(with: accountName, andAccountBalance: String(accountBalance))
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = person.accountList[indexPath.row].accountName
        let accountBalance = ammountTransactions(for: person, with: content.text!)
        content.secondaryText = String(accountBalance) + " ₽"
        cell.contentConfiguration = content

        return cell
    }
}

    // MARK: - Extension
extension ChosenAccountFromTableViewController {
    private func ammountTransactions(for currentAccount: Person, with accountName: String) -> Int {
        var ammount = 0
        
        for personAccountList in person.accountList {
            if personAccountList.accountName == accountName {
                ammount += personAccountList.accountStartCount
            }
        }
        
        for personTransaction in person.transaction {
            if personTransaction.accountTransactionFrom == accountName {
                if personTransaction.typeTransaction == "Доход" {
                    ammount += personTransaction.amountTransaction
                } else { ammount -= personTransaction.amountTransaction }
            }
        }
        return ammount
    }
}
