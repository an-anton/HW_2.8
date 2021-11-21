//
//  AddNewOperacionViewController.swift
//  HW_2.8
//
//  Created by Anton Anan'eV on 17.11.2021.
//

import UIKit
class AddNewOperacionViewController: UIViewController {
     // MARK: - Outlets
    @IBOutlet var segmentedControlOutlet: UISegmentedControl!
    
    @IBOutlet var sumTextFieldOutlet: UITextField!
    @IBOutlet var dateTextFieldOutlet: UITextField!
    @IBOutlet var saveButtonOutlet: UIBarButtonItem!
    @IBOutlet var categoryTextFiledOutlet: UITextField!
    
    @IBOutlet var accoutTextFieldOutlet: UITextField!
    
    @IBOutlet var incomeStackOutlet: UIStackView!
    @IBOutlet var incomeSumTF: UITextField!
    @IBOutlet var incomeDateTF: UITextField!
    @IBOutlet var incomeCategoryTF: UITextField!
    @IBOutlet var incomeAcountTF: UITextField!
    
    @IBOutlet var spendStackLabels: UIStackView!
    @IBOutlet var spendStackTF: UIStackView!
 
     // MARK: - Public preference
    var person: Person!
    
     // MARK: - Private preverence
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sumTextFieldOutlet.becomeFirstResponder()
        incomeStackOutlet.isHidden = true
        createToolBar(textFields: sumTextFieldOutlet, incomeSumTF)
        createDatePicker(textfields: dateTextFieldOutlet, incomeDateTF)
    }
     // MARK: - Actions
    @IBAction func segmentedControlAction() {
        switch segmentedControlOutlet.selectedSegmentIndex {
        case 0:
            spendStackLabels.isHidden = false
            spendStackTF.isHidden = false
            incomeStackOutlet.isHidden = true
            sumTextFieldOutlet.becomeFirstResponder()
        default:
            spendStackLabels.isHidden = true
            spendStackTF.isHidden = true
            incomeStackOutlet.isHidden = false
            incomeSumTF.becomeFirstResponder()
        }
    }
    
    // MARK: - UIDatePicker
    private func createDatePicker(textfields: UITextField...) {
        
    datePicker.locale = Locale(identifier: "ru_RU")
    datePicker.datePickerMode = UIDatePicker.Mode.date
    datePicker.preferredDatePickerStyle = .wheels
            
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(done))
    toolBar.setItems([doneButton], animated: true)
       
        for textfield in textfields {
            textfield.inputView = datePicker
            textfield.inputAccessoryView = toolBar
        }
    }
    @objc func done() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        
        dateTextFieldOutlet.text = formatter.string(from: datePicker.date)
        incomeDateTF.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
}
    // MARK: - EXTENSION
extension AddNewOperacionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
   func textFieldDidChangeSelection(_ textField: UITextField) {
       if sumTextFieldOutlet.text == "" && dateTextFieldOutlet.text == "" {
           saveButtonOutlet.isEnabled = false
       } else {
           saveButtonOutlet.isEnabled = true
       }
       
       if incomeSumTF.text == "" && incomeDateTF.text == "" && incomeAcountTF.text == "" && incomeCategoryTF.text == ""{
           saveButtonOutlet.isEnabled = false
       } else {
           saveButtonOutlet.isEnabled = true
       }
   }
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.endEditing(true)
       return true
   }
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       super.view.endEditing(true)
   }
    private func createToolBar(textFields: UITextField...) {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "done",
                                        style: .done,
                                        target: self,
                                        action: #selector(doneClicked))
       toolBar.setItems([doneButton], animated: true)
        for textField in textFields {
            textField.inputAccessoryView = toolBar
        }
   }
   @objc func doneClicked() {
       view.endEditing(true)
       sumTextFieldOutlet.endEditing(true)
       dateTextFieldOutlet.endEditing(true)
   }
}
