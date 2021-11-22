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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

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
