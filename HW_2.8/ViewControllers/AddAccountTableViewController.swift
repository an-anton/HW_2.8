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
    
    // MARK: - IBActions
    @IBAction func canceButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: .none)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let newAccountName = nameNewCard.text ?? ""
        let newAccountStartCount = Int(startAmmountNewCard.text!) ?? 0
        let newAccount = AccountList(
            accountName: newAccountName,
            accountStartCount: newAccountStartCount
        )
        delegate.addNewAccount(with: newAccount)
        dismiss(animated: true, completion: .none)
    }
}
