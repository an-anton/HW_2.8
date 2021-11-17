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
    var ammountArray: [Transaction] = []
    var ammountRows1: [String: [Transaction]] = [:]
    var datesArray: [String] = []
    var dates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dates = datesFromCurrentlyAccount()
        print(dates)
        ammountRows1 = transactionsFromCurrentAccountForDates()
        accountCountButton.title = String(ammountTransactionsForCurrentAccount()) + " ₽"
        accountCountButton.isEnabled = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return dates.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dates[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrayOfTransaction = ammountRows1
        let dataSection = dates[section]
        let transactionsArray = arrayOfTransaction[dataSection]!.count
        return transactionsArray
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)

        let transactions = ammountRows1[dates[indexPath.section]]!
        let transaction = transactions[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = transaction.category
        let accountCount: String
        if transaction.typeTransaction == "Доход" {
            accountCount = "+ \(transaction.amountTransaction) ₽"
        } else { accountCount = "- \(transaction.amountTransaction) ₽" }
        content.secondaryText = accountCount
        cell.contentConfiguration = content

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}

// MARK: - Extension

extension CurrentlyAccountTableViewController {
    func datesFromCurrentlyAccount() -> [String] {
        var dates1: Set<String> = []
        
        for personTransaction in personTransactions {
            dates1.insert(personTransaction.dateTransaction)
        }
        let datesArray1 = Array(dates1)
        let sortedDays = datesArray1.sorted(by: >)
        return sortedDays
    }

    func transactionsFromCurrentAccountForDates() -> [String: [Transaction]] {
        var transactionsDictionary: [String: [Transaction]] = [:]

        for date in dates {
            var transactions: [Transaction] = []
            for personTransaction in personTransactions {
                if personTransaction.dateTransaction == date {
                    transactions.append(personTransaction)
                    if transactionsDictionary[date]?.count != 0 {
                        transactionsDictionary.updateValue(transactions, forKey: date)
                    } else {
                        transactionsDictionary[date] = transactions
                    }
                }
            }
        }
        return transactionsDictionary
    }
    
    func ammountTransactionsForCurrentAccount() -> Int {
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
