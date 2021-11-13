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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = logInButton.frame.height / 4
        logInButton.isEnabled = false
        logInButton.backgroundColor = .clear
    }
   
    
    @IBAction func logInButtonAction() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.view.endEditing(true)
    }
    
}

