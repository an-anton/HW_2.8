//
//  CurrentlyAccountTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

import UIKit

class AllAccountTransactionTableViewController: UITableViewController {
    @IBOutlet var ammoutAccountButton: UIBarButtonItem!
    
     // MARK: - Public properties
    var persons: Person!
//    var personTransactions: [Transaction]!
    
    private var ammountArray: [Transaction] = []
    private var ammountRows1: [String: [Transaction]] = [:]
    private var datesArray: [String] = []
    private var date: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date = apdateCountOfHowManyDate()
        ammountRows1 = chosenAllTransactionForDates()
        ammoutAccountButton.isEnabled = false
    }
    @IBAction func addButton(_ sender: UIBarButtonItem) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ammoutAccountButton.title = String(ammountAllAccount()) + " ₽"
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return date.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return date[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrayOfTransaction = ammountRows1
        let date = apdateCountOfHowManyDate()
        let dataSection = date[section]
        let transactionsArray = arrayOfTransaction[dataSection]!.count
        return transactionsArray
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let transactions = ammountRows1[date[indexPath.section]]!
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


    
     //MARK: - Navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let addNewOperacionVC = navigationVC.topViewController as? AddNewOperacionViewController else { return }
        addNewOperacionVC.person = persons
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let addNewOperacionVC = segue.source as? AddNewOperacionViewController else { return }
        
        let newOperacion = Transaction(dateTransaction: addNewOperacionVC.dateTextFieldOutlet.text ?? "ERROR",
                                       amountTransaction: Int(addNewOperacionVC.sumTextFieldOutlet.text ?? "ERROR") ?? 0,
                                       category: addNewOperacionVC.categoryTextFiledOutlet.text ?? "ERROR",
                                       typeTransaction: "????",
                                       accountTransactionFrom: "????",
                                       accountTransactionTo: "????")
        persons.transaction.insert(newOperacion, at: 0)
        
//        let newIndexPath = IndexPath(row: persons.transaction.count, section: 0)
//        tableView.insertRows(at: [newIndexPath], with: .fade)
//        tableView.reloadData()
    }

}
 // MARK: - EXTENSION
extension AllAccountTransactionTableViewController {
    func apdateCountOfHowManyDate() -> [String] {
        let array = persons.transaction
        var dates1: Set<String> = []
        
        for transaction in array {
            dates1.insert(transaction.dateTransaction)
        }
        let datesArray1 = Array(dates1)
        let sortedDays = datesArray1.sorted(by: >)
        return sortedDays
    }
    
    func chosenAllTransactionForDates() -> [String: [Transaction]] {
        var ammountRows1: [String: [Transaction]] = [:]
        var dates: Set<String> = []
        
        for transaction in persons.transaction {
            dates.insert(transaction.dateTransaction)
        }
        
        for date in dates {
            var array: [Transaction] = []
            for transaction in persons.transaction {
                if transaction.dateTransaction == date {
                    array.append(transaction)
                    if ammountRows1[date]?.count != 0 {
                        ammountRows1.updateValue(array, forKey: date)
                    } else {
                        ammountRows1[date] = array
                    }
                }
            }
        }
        return ammountRows1
    }
    
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
