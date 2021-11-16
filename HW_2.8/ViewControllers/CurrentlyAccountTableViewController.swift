//
//  CurrentlyAccountTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

import UIKit

class CurrentlyAccountTableViewController: UITableViewController {

    var person: Person!
    var personIndex: AccountList!
    var personTransactions: [Transaction]!
    var ammountArray: [Transaction] = []
    var ammountRows1: [String: [Transaction]] = [:]
    var datesArray: [String] = []
    var date: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date = apdateCountOfHowManyDate()
        print(date)
        ammountRows1 = apdateArray()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        
        print(indexPath.section)
        let transactions = ammountRows1[date[indexPath.section]]!
       // print(indexPath.row)
        let transaction = transactions[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = transaction.category
        let accountCount = String(transaction.amountTransaction) + " ₽"
        content.secondaryText = accountCount
        cell.contentConfiguration = content
        
//        let person = persons.accountList[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//
//        content.text = person.accountName
//        let accountCount = String(person.accountStartCount + ammountAllTransaction(for: person)) + " ₽"
//        content.secondaryText = accountCount
//        cell.contentConfiguration = content

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

extension CurrentlyAccountTableViewController {
    func apdateCountOfHowManyDate() -> [String] {
        var dates1: Set<String> = []
        
        for personTransaction in personTransactions {
            dates1.insert(personTransaction.dateTransaction)
        }
        let datesArray1 = Array(dates1)
        let sortedDays = datesArray1.sorted(by: >)
        return sortedDays
    }
    
    func apdateArray() -> [String: [Transaction]] {
        var ammountRows1: [String: [Transaction]] = [:]
        var dates: Set<String> = []
        
        for personTransaction in personTransactions {
            dates.insert(personTransaction.dateTransaction)
        }
        
        for date in dates {
            var array: [Transaction] = []
            for personTransaction in personTransactions {
                if personTransaction.dateTransaction == date {
                    array.append(personTransaction)
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
    
}
