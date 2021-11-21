//
//  ViewController.swift
//  HW_2.8
//
//  Created by Anton Anan'eV on 12.11.2021.
//

import UIKit

class LoginViewController: UIViewController {
     // MARK: - @IBOutlets
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton! {
        didSet {
            logInButton.layer.cornerRadius = logInButton.frame.height / 4
        }
    }
     // MARK: - Private properties
    private var person = Person.getPerson()
    
    
     // MARK: - @IBActions
    @IBAction func logInButtonAction() {
        if loginTextField.text != person.login || passwordTextField.text != person.password {
            showAlert(message: "Enter your username and password")
        }
    }
    
    @IBAction func forgotAction(_ sender: UIButton) {
        sender.tag == 0
        ? showAlert(message: "Your username is \(person.login)")
        : showAlert(message: "Your password is \(person.password)")
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
     // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let tabBarVC = navigationVC.topViewController as? StartTabBarController else { return }
        
        guard let viewControllers = tabBarVC.viewControllers else { return }
        
        for viewController in viewControllers {
            if let oneVC = viewController as? AccountExistingTableViewController {
                oneVC.persons = person
            } else if let twoVC = viewController as? AllAccountTransactionTableViewController {
                twoVC.persons = person
            } else  if let threeVC = viewController as? AllAccountTransactionTableViewController {
                threeVC.persons = person
            }
        }
    }
}

 // MARK: - UIAlertController
extension LoginViewController {
    private func showAlert(message: String, title: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
 // MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.view.endEditing(true)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            logInButtonAction()
            performSegue(withIdentifier: "goToNext", sender: nil)
        }
        return true
    }
}
