//
//  CurrentlyAccountTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

import UIKit

protocol UpdateTransactionsTableViewDelegate {
    func updateTransaction(with currentTransaction: Transaction)
}

class AllAccountTransactionTableViewController: UITableViewController {
   
    //MARK: - @IBOutlet
    @IBOutlet var ammoutAccountButton: UIBarButtonItem!
    
    
    //MARK: - Properties
    var persons: Person!
    var delegate: UpdateTabBatTest!
    
    //MARK: - Private properties
    private var allTransForDates: [String: [Transaction]] = [:]
    private var date: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ammoutAccountButton.isEnabled = false
        allTransForDates = chosenAllTransactionForDates()
        date = apdateCountOfHowManyDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ammoutAccountButton.title = String(ammountAllAccount()) + " ₽"
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return date.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return date[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrayOfTransaction = allTransForDates
        let date = apdateCountOfHowManyDate()
        let dataSection = date[section]
        let transactionsArray = arrayOfTransaction[dataSection]!.count
        return transactionsArray
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionsTableViewCell
        let arrayOfTransaction = allTransForDates
        let transactions = arrayOfTransaction[date[indexPath.section]]!
        let transaction = transactions[indexPath.row]
        
        cell.categoryTransactionLable.text = transaction.category
        for transactionList in persons.accountList {
            if transactionList.accountName == transaction.accountTransactionFrom {
                cell.balanceTransactionLable.text = String(transaction.accountBalance) + " ₽"
            }
        }
        cell.accountFromTransactionLable.text = transaction.accountTransactionFrom
        let accountCount: String
        if transaction.typeTransaction == "Доход" {
            accountCount = "+ \(transaction.amountTransaction) ₽"
        } else { accountCount = "- \(transaction.amountTransaction) ₽" }
        cell.ammountOperationTransactionLable.text = accountCount

        if let image = UIImage(named: transaction.category) {
            cell.imageCategotyTransactionLable.image = image
        }
        
        return cell
    }

     //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let addNewOperacionVC = navigationVC.topViewController as? AddNewOperacionTableViewController else { return }
        addNewOperacionVC.persons = persons
        addNewOperacionVC.delegate = self
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
    }

}

//MARK: - Extension
extension AllAccountTransactionTableViewController {
    func apdateCountOfHowManyDate() -> [String] {
        var dates1: Set<String> = []
        
        for transaction in persons.transaction {
            dates1.insert(transaction.dateTransaction)
        }
        let datesArray1 = Array(dates1)
        let sortedDays = datesArray1.sorted(by: >)
        return sortedDays
    }
    
    func chosenAllTransactionForDates() -> [String: [Transaction]] {
        var ammountRows1: [String: [Transaction]] = [:]
        let dates = apdateCountOfHowManyDate()

        for date in dates {
            var arrayTransactions: [Transaction] = []
            for transaction in persons.transaction {
                if transaction.dateTransaction == date {
                    arrayTransactions.append(transaction)
                    if ammountRows1[date]?.count != 0 {
                        ammountRows1.updateValue(arrayTransactions, forKey: date)
                    } else {
                        ammountRows1[date] = arrayTransactions
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

//MARK: - Protocol
extension AllAccountTransactionTableViewController: UpdateTransactionsTableViewDelegate {
    func updateTransaction(with currentTransaction: Transaction) {
        persons.transaction.insert(currentTransaction, at: 0)
        date = apdateCountOfHowManyDate()
        allTransForDates = chosenAllTransactionForDates()
        delegate.updateTabBar(with: persons)
        tableView.reloadData()
    }
}
