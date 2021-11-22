//
//  CurrentlyAccountTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

import UIKit

class CurrentlyAccountTableViewController: UITableViewController {

    @IBOutlet var accountCountButton: UIBarButtonItem!
    
    var person: Person!
    var personIndex: AccountList!
    var personTransactions: [Transaction]!
    var datesWithCurrentlyAccountTransaction: [String: [Transaction]] = [:]
    var datesTransaction: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datesTransaction = ChosenDatesTransactionFromCurrentlyAccount()
        datesWithCurrentlyAccountTransaction = chosenTransactionsFromCurrentlyAccountForDates()
        accountCountButton.title = String(ammountTransactionsForCurrentAccount()) + " ₽"
        accountCountButton.isEnabled = false
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return datesTransaction.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return datesTransaction[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrayOfTransaction = datesWithCurrentlyAccountTransaction
        let dateSection = datesTransaction[section]
        let transactionsArray = arrayOfTransaction[dateSection]!.count
        return transactionsArray
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TransactionsTableViewCell

        let transactions = datesWithCurrentlyAccountTransaction[datesTransaction[indexPath.section]]!
        let transaction = transactions[indexPath.row]

        let accountCount: String
        var cellColor: UIColor = .black
        if transaction.typeTransaction == "Доход" {
            accountCount = "+ \(transaction.amountTransaction) ₽"
            cellColor = .green
        } else {
            accountCount = "- \(transaction.amountTransaction) ₽"
        }
        
        cell.categoryTransactionLable.text = transaction.category
        cell.ammountOperationTransactionLable.text = accountCount
        cell.ammountOperationTransactionLable.textColor = cellColor
        cell.accountFromTransactionLable.text = transaction.accountTransactionFrom
        cell.balanceTransactionLable.text = String(transaction.accountBalance) + " ₽"
        if let image = UIImage(named: transaction.category) {
            cell.imageCategotyTransactionLable.image = image
        }
        
        return cell
    }

    
    // MARK: - Navigation
}

// MARK: - Extension

extension CurrentlyAccountTableViewController {
    private func ChosenDatesTransactionFromCurrentlyAccount() -> [String] {
        var datesTransaction: Set<String> = []
        
        for personTransaction in personTransactions {
            datesTransaction.insert(personTransaction.dateTransaction)
        }
        let datesTransactionArray = Array(datesTransaction)
        let sortedDaysTransaction = datesTransactionArray.sorted(by: >)
        return sortedDaysTransaction
    }

    private func chosenTransactionsFromCurrentlyAccountForDates() -> [String: [Transaction]] {
        var transactionsForDates: [String: [Transaction]] = [:]

        for currentlyDate in datesTransaction {
            var transactions: [Transaction] = []
            for personTransaction in personTransactions {
                if personTransaction.dateTransaction == currentlyDate {
                    transactions.append(personTransaction)
                    if transactionsForDates[currentlyDate]?.count != 0 {
                        transactionsForDates.updateValue(transactions, forKey: currentlyDate)
                    } else {
                        transactionsForDates[currentlyDate] = transactions
                    }
                }
            }
        }
        return transactionsForDates
    }
    
    private func ammountTransactionsForCurrentAccount() -> Int {
        var ammount = 0
        
        for personAccountList in person.accountList {
            if personAccountList.accountName == personIndex.accountName {
                ammount += personAccountList.accountStartCount
            }
        }
        
        for personTransaction in personTransactions {
            if personTransaction.typeTransaction == "Доход" {
                ammount += personTransaction.amountTransaction
            } else { ammount -= personTransaction.amountTransaction }
        }
        return ammount
    }
}
