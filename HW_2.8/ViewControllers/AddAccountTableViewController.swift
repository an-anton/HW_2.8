//
//  AddAccountTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

import UIKit

class AddAccountTableViewController: UITableViewController {

    @IBOutlet var nameNewCard: UITextField!
    @IBOutlet var startAmmountNewCard: UITextField!
    
    var person: Person!
    var delegate: RefreshAccountViewControllerDelegete!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    @IBAction func canceButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: .none)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
//        person.accountList.append(AccountList(accountName: nameNewCard.text ?? "", accountStartCount: Int(startAmmountNewCard.text!) ?? 0))
        delegate.addNewAccount(with: AccountList(accountName: nameNewCard.text ?? "", accountStartCount: Int(startAmmountNewCard.text!) ?? 0))
        dismiss(animated: true, completion: .none)
    }
    
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
