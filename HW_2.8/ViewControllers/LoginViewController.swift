//
//  ViewController.swift
//  HW_2.8
//
//  Created by Anton Anan'eV on 12.11.2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    private let user = "User"
    private let password = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = logInButton.frame.height / 4
    }
   
    
    @IBAction func logInButtonAction() {
        if loginTextField.text == "" && passwordTextField.text == "" {
            showAlert(message: "Enter your username and password", title: "")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.view.endEditing(true)
    }
    
}
 // MARK: - Extension
extension LoginViewController {
    private func showAlert(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
