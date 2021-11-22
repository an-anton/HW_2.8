//
//  AddNewOperacionViewController.swift
//  HW_2.8
//
//  Created by Anton Anan'eV on 17.11.2021.
//

import UIKit

protocol UpdateCategoryTableViewDelegate {
    func updateCategory(with newValue: Categories)
}

protocol UpdateAccountFromTableViewDelegate {
    func updateAccountFrom(with accountName: String, andAccountBalance: String)
}

class AddNewOperacionTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet var segmentedControlOutlet: UISegmentedControl!
    
    @IBOutlet var currentAccountTransactionLable: UILabel!
    @IBOutlet var currentCategoryTransactionLable: UILabel!
    @IBOutlet var currentDateTransactionLable: UILabel!
    @IBOutlet var currentAccountBalanceLable: UILabel!
    
    @IBOutlet var ammountCurrentTransactionTextField: UITextField!
    
    // MARK: - Public preference
    var persons: Person!
    var delegate: UpdateTransactionsTableViewDelegate!

    // MARK: - Private preverence
    private let datePicker = UIDatePicker()
    private var typeCurrentTransaction = "Расход"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func segmentedControlAction() {
        switch segmentedControlOutlet.selectedSegmentIndex {
        case 0: typeCurrentTransaction = "Расход"
        default: typeCurrentTransaction = "Доход"
        }
        print(typeCurrentTransaction)
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        let ammountTransaction = Int(ammountCurrentTransactionTextField.text!) ?? 0
        //let dateTransaction = currentDateTransactionLable.text ?? ""
        let categoryTransaction = currentCategoryTransactionLable.text ?? ""
        let currentAccountBalance = currentAccountBalanceLable.text ?? ""
        var accountBalance = 0
        if typeCurrentTransaction == "Доход" {
            accountBalance =  Int(currentAccountBalance)! + ammountTransaction
        } else { accountBalance =  Int(currentAccountBalance)! - ammountTransaction }
        let currentAccountTransactionName = currentAccountTransactionLable.text ?? ""
        
        delegate.updateTransaction(with: Transaction(
            dateTransaction: "22.11.2021",
            amountTransaction: ammountTransaction,
            category: categoryTransaction,
            typeTransaction: typeCurrentTransaction,
            accountTransactionFrom: currentAccountTransactionName,
            accountBalance: accountBalance))
        
        dismiss(animated: true, completion: .none)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: .none)
    }
    
    @IBAction func unwindFromChosenCategory(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
    }
    
    @IBAction func unwindFromChosenAccountFrom(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.preferredDatePickerStyle = .compact
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let choosenAccountTypeFrom = segue.destination as? ChosenAccountTypeFromAddTableViewController {
            choosenAccountTypeFrom.categories = persons.accountСategories
            choosenAccountTypeFrom.delegate = self
        } else if let chosenAccountFrom = segue.destination as? ChosenAccountFromTableViewController {
            chosenAccountFrom.person = persons
            chosenAccountFrom.delegate = self
        }
    }
    
    

    // MARK: - UIDatePicker
    private func createDatePicker(textfields: UITextField...) {
    }
}

    // MARK: - EXTENSION
extension AddNewOperacionTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.view.endEditing(true)
    }
}

extension AddNewOperacionTableViewController: UpdateCategoryTableViewDelegate {
    func updateCategory(with newValue: Categories) {
        currentCategoryTransactionLable.text = newValue.categoriesName
    }
}

extension AddNewOperacionTableViewController: UpdateAccountFromTableViewDelegate {
    func updateAccountFrom(with accountName: String, andAccountBalance: String) {
        currentAccountTransactionLable.text = accountName
        currentAccountBalanceLable.text = andAccountBalance
    }
}
