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
    @IBOutlet var dateTextField: UITextField!
    
    @IBOutlet var currentAccountBalanceLable: UILabel!
    
    @IBOutlet var ammountCurrentTransactionTextField: UITextField!
    @IBOutlet var saveButtonOutlet: UIBarButtonItem!
    
    // MARK: - Public preference
    var persons: Person!
    var delegate: UpdateTransactionsTableViewDelegate!

    // MARK: - Private preverence
    let datePicker = UIDatePicker()
    private var typeCurrentTransaction = "Расход"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ammountCurrentTransactionTextField.becomeFirstResponder()
        createToolBar(for: ammountCurrentTransactionTextField)
        dateTextField.text = "23.11.21"
        createDataPicker(for: dateTextField)
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
        let categoryTransaction = currentCategoryTransactionLable.text ?? ""
        let currentAccountBalance = currentAccountBalanceLable.text ?? ""
        var accountBalance = 0
        if typeCurrentTransaction == "Доход" {
            accountBalance =  Int(currentAccountBalance)! + ammountTransaction
        } else { accountBalance =  Int(currentAccountBalance)! - ammountTransaction }
        let currentAccountTransactionName = currentAccountTransactionLable.text ?? ""
        
        delegate.updateTransaction(with: Transaction(
            dateTransaction: dateTextField.text ?? "ERROR",
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
}

    // MARK: - EXTENSION
extension AddNewOperacionTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.view.endEditing(true)
    }
    private func createToolBar(for textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneClicked))
        toolBar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
        }
    
    private func createDataPicker(for textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        textField.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneDatePicker))
        toolBar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }

    @objc func doneDatePicker() {
            let formater = DateFormatter()
            formater.dateFormat = "dd.MM.yy"
        dateTextField.text = formater.string(from: datePicker.date)
   
            view.endEditing(true)
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
