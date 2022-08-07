//
//  AuthViewController.swift
//  CoockUerSongs
//
//  Created by BigSynt on 02.08.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {

    var singUp: Bool = true {
        willSet{
            if newValue{
                titleLabel.text = "Регистрация"
                emailField.isHidden = false
                enterButton.setTitle("Войти", for: .normal)
            } else {
                titleLabel.text = "Вход"
                emailField.isHidden = true
                enterButton.setTitle("Регистрация", for: .normal)
            }
        }
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var loginField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }

    @IBAction func switchButton(_ sender: UIButton) {
        //singUp = !singUp
        if checkFieldsAndCreateUser() {
            navigationView()
        }
    }
    
    func showAlert(massage: String) {
        let alert = UIAlertController(title: "Ошибка", message: massage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func createUserAccount(login: String, email: String, password: String) -> Bool {
        
        var resultBool = false
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                if let result = result {
                    print("token: \(result.user.uid)")
                    resultBool = true
                }
            } else {
                self.showAlert(massage: error?.localizedDescription ?? "localizedDescription = nil")
                resultBool = false
            }
        }
        return resultBool
    }
    
    func checkFieldsAndCreateUser() -> Bool {
        
        let login = loginField.text!
        let email = emailField.text!
        let password = passwordField.text!
        
        var userBool = false
        
        if (singUp) {
            
            if (!login.isEmpty && !email.isEmpty && !password.isEmpty) {
                if createUserAccount(login: login, email: email, password: password) {
                    userBool = true
                }
                
            } else {
                showAlert(massage: "заполните все поля")
                userBool = false
            }
        } else {
            if (!email.isEmpty && !password.isEmpty) {
                
                userBool = true
            } else {
                showAlert(massage: "заполните все поля")
                userBool = false
            }
        }
        return userBool
    }
    func navigationView() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "TabView") as! TabViewController
        
        let NavController = UINavigationController(rootViewController: view)
        NavController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if checkFieldsAndCreateUser() {
            navigationView()
        }
        
        return true
    }
}
