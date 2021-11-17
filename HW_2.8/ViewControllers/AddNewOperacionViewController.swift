//
//  AddNewOperacionViewController.swift
//  HW_2.8
//
//  Created by Anton Anan'eV on 17.11.2021.
//

import UIKit

class AddNewOperacionViewController: UIViewController {
    
    @IBOutlet var sumTextFieldOutlet: UITextField!
    @IBOutlet var dateTextFieldOutlet: UITextField!
    @IBOutlet var saveButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createToolBar(textField: sumTextFieldOutlet)
        createDatePicker(textField: dateTextFieldOutlet)
    }
    // MARK: - UIDatePicker
    func createDatePicker(textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.locale = Locale.current
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.preferredDatePickerStyle = .wheels
        textField.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(done))
        toolBar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    @objc func done() {
        let datePicker = UIDatePicker()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        dateTextFieldOutlet.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }

}
// MARK: - EXTENSION
extension AddNewOperacionViewController: UITextFieldDelegate {
   func textFieldDidChangeSelection(_ textField: UITextField) {
       if sumTextFieldOutlet.text == "" && dateTextFieldOutlet.text == "" {
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
    private func createToolBar(textField: UITextField) {
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
       sumTextFieldOutlet.endEditing(true)
       dateTextFieldOutlet.endEditing(true)
   }
    
   
    
    
}
