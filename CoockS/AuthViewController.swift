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
                enterButton.setTitle("Зарегистрироваться", for: .normal)
                singButton.setTitle("войти", for: .normal)
                
            } else {
                titleLabel.text = "Вход"
                emailField.isHidden = true
                enterButton.setTitle("Войти", for: .normal)
                singButton.setTitle("Зарегистрироваться", for: .normal)
            }
        }
    }
    
    let loadingView = UIActivityIndicatorView(style: .large)
    
    var blurEffectView = UIVisualEffectView()
    

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var loginField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var enterButton: UIButton!
    @IBOutlet var singButton: UIButton!
    
    @IBAction func switchButton(_ sender: UIButton) {
        switchButtonAction()
        enterButton.isEnabled = true
    }
    
    @IBAction func switchSingUpIn(_ sender: UIButton) {
        singUp = !singUp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        singUp = false
        
        configureBlurView()
        configureLoadingView()
        hideLoadingView()
    }
    
    
    
    // MARK: LOGIC

    func loginUser(email: String, password: String) {

        showLoadingView()
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in

            self.hideLoadingView()
            
            guard let user = result?.user, error == nil else {
                print("error: \(error?.localizedDescription ?? "error")")
                self.showAlert(massage: error?.localizedDescription ?? "localizedDescription = nil")
                return
            }
            
            print("token: \(user.uid)")
            self.openRootView()
        }
    }
    
    func createUserAccount(login: String, email: String, password: String) {
        
        showLoadingView()
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            self.hideLoadingView()
            
            guard let user = result?.user, error == nil else {
                print("error: \(error?.localizedDescription ?? "error")")
                self.showAlert(massage: error?.localizedDescription ?? "localizedDescription = nil")
                return
            }
            
            print("token: \(user.uid)")
            self.openRootView()
        }
    }
    
    func checkFieldsAndMakeLoginLogic() {
        
        guard let login = loginField.text, !login.isEmpty  else {
            showAlert(massage: "заполните логин")
            return
        }
        guard let email = emailField.text, !email.isEmpty else {
            showAlert(massage: "заполните email")
            return
        }
        guard let password = passwordField.text, !password.isEmpty else {
            showAlert(massage: "заполните passwodr")
            return
        }
        
        if singUp {
            createUserAccount(login: login, email: email, password: password)
        } else {
            loginUser(email: email, password: password)
        }
    }
    
    // MARK: UI
    
    func configureLoadingView() {
        loadingView.color = .black
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.contentView.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: blurEffectView.contentView.centerYAnchor).isActive = true
    }
    
    func configureBlurView() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    func showLoadingView() {
        loadingView.isHidden = false
        loadingView.startAnimating()
        
        enterButton.isEnabled = false
        singButton.isEnabled = false
        
        blurEffectView.isHidden = false
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
        loadingView.stopAnimating()
        
        enterButton.isEnabled = true
        singButton.isEnabled = true
        
        blurEffectView.isHidden = true
    }
    
    func showAlert(massage: String) {
        let alert = UIAlertController(title: "Ошибка", message: massage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func openRootView() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "TabView") as! TabViewController
        
        let NavController = UINavigationController(rootViewController: view)
        NavController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    // MARK: Actions
    
    func switchButtonAction() {
        checkFieldsAndMakeLoginLogic()
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        checkFieldsAndMakeLoginLogic()
        
        return true
    }
}
