//
//  AddAccountTableViewController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 14.11.2021.
//

import UIKit

protocol IndexDidSelectedRowViewControllerDelegate {
    func updateType(with newValue: AccountTypes)
}

class AddAccountTableViewController: UITableViewController {

    @IBOutlet var nameNewCard: UITextField!
    @IBOutlet var startAmmountNewCard: UITextField!
    @IBOutlet var saveButtonOutlet: UIBarButtonItem!
    @IBOutlet var typeLable: UILabel!
    
    var person: Person!
    var delegate: RefreshAccountViewControllerDelegete!
    var accountType: AccountTypes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        saveButtonOutlet.isEnabled = false
//        createToolBar()
        accountType = .card
        typeLable.text = accountType.rawValue
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
            accountType: accountType,
            accountStartCount: newAccountStartCount
        )
        delegate.addNewAccount(with: newAccount)
        dismiss(animated: true, completion: .none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as? UINavigationController
        guard let chosenAccountType = viewController?.topViewController
                as? ChosenAccountTypeTableViewController else { return }
        chosenAccountType.accountEnumType = person.accountTypes
        chosenAccountType.delegete = self
    }
}
 // MARK: - EXTENSION
extension AddAccountTableViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        //saveButtonOutlet.isEnabled = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.view.endEditing(true)
    }
//    private func createToolBar() {
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        let doneButton = UIBarButtonItem(
//            title: "done",
//            style: .done,
//            target: self,
//            action: #selector(doneClicked)
//        )
//        toolBar.setItems([doneButton], animated: true)
//        startAmmountNewCard.inputAccessoryView = toolBar
//    }
//    @objc func doneClicked() {
//        view.endEditing(true)
//        startAmmountNewCard.endEditing(true)
//    }
}

extension AddAccountTableViewController: IndexDidSelectedRowViewControllerDelegate {
    func updateType(with newValue: AccountTypes) {
        typeLable.text = newValue.rawValue
        accountType = newValue
    }
}
