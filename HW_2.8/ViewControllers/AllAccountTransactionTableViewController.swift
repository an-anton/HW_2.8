//
//  CurrentlyAccountTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

import UIKit

class AllAccountTransactionTableViewController: UITableViewController {
    @IBOutlet var ammoutAccountButton: UIBarButtonItem!
    
    var persons = Person.getPerson()
    var personTransactions: [Transaction]!
    var ammountArray: [Transaction] = []
    var ammountRows1: [String: [Transaction]] = [:]
    var datesArray: [String] = []
    var date: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date = apdateCountOfHowManyDate()
        ammountRows1 = apdateArray()
        ammoutAccountButton.isEnabled = false
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    
    func apdateArray() -> [String: [Transaction]] {
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
