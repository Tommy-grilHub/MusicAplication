//
//  AuthViewController.swift
//  CoockUerSongs
//
//  Created by BigSynt on 02.08.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

class AuthViewController: UIViewController {
    
    //var tabBarView: TabBarViewController?
    var titleLabel = UILabel()
    var loginField = UITextField()
    var emailField = UITextField()
    var passwordField = UITextField()
    var enterButton = UIButton()
    var singButton = UIButton()
    
    var UID = String()
    
    var singUp: Bool = true {
        willSet{
            if newValue{
                titleLabel.text = "Регистрация"
                loginField.isHidden = false
                enterButton.setTitle("Зарегистрироваться", for: .normal)
                singButton.setTitle("войти", for: .normal)
                
            } else {
                titleLabel.text = "Вход"
                loginField.isHidden = true
                enterButton.setTitle("Войти", for: .normal)
                singButton.setTitle("Зарегистрироваться", for: .normal)
            }
        }
    }
    
    let loadingView = UIActivityIndicatorView(style: .large)
    
    var blurEffectView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        test()
        
        singUp = false
        initInterface()
        configureBlurView()
        configureLoadingView()
        hideLoadingView()
    }
    
    // MARK: func for Test 
    
    func test() {
        emailField.text = "dima@m.ru"
        passwordField.text = "123456"
    }
    
    private func initInterface() {
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)

        view.addSubview(titleLabel)
        titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(150)
        }

        view.addSubview(loginField)
        loginField.layer.cornerRadius = 3
        loginField.font = UIFont.systemFont(ofSize: 19)
        loginField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loginField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        loginField.placeholder = "введите имя"
        loginField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        loginField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.left.right.equalToSuperview().inset(50)
            maker.top.equalTo(titleLabel).inset(70)
        }

        view.addSubview(emailField)
        emailField.layer.cornerRadius = 3
        emailField.font = UIFont.systemFont(ofSize: 19)
        emailField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        emailField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailField.placeholder = "введите email"
        emailField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.left.right.equalToSuperview().inset(50)
            maker.top.equalTo(loginField).inset(35)
        }
        
        view.addSubview(passwordField)
        passwordField.layer.cornerRadius = 3
        passwordField.font = UIFont.systemFont(ofSize: 19)
        passwordField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        passwordField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordField.placeholder = "введите пароль"
        passwordField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordField.isSecureTextEntry = true
        passwordField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.left.right.equalToSuperview().inset(50)
            maker.top.equalTo(emailField).inset(35)
        }
        
        view.addSubview(enterButton)
        enterButton.layer.cornerRadius = 10
        enterButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        enterButton.backgroundColor = #colorLiteral(red: 0.5711960793, green: 0.8409035802, blue: 0.4088996053, alpha: 1)
        enterButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.left.right.equalToSuperview().inset(50)
            maker.top.equalTo(passwordField).inset(70)
            maker.bottom.equalToSuperview().inset(410)
        }
        enterButton.addTarget(self, action: #selector(onClickEnterButton), for: .touchUpInside)
        
        view.addSubview(singButton)
        singButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        singButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.left.right.equalToSuperview().inset(50)
            maker.bottom.equalToSuperview().inset(80)
        }
        singButton.addTarget(self, action: #selector(onClickSingButton), for: .touchUpInside)
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
            
            // open uid in xano
            self.UID = user.uid
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
            
            // add uid in xano
            self.UID = user.uid
            self.openRootView()
        }
    }
    
    func checkFieldsAndMakeLoginLogic() {
        
        guard let login = loginField.text, !login.isEmpty || loginField.isHidden == true  else {
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
        //let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //let view = storyBoard.instantiateViewController(withIdentifier: "TabView") as! TabBarViewController
        //view.UID = UID
        
        let tabBarView = TabBarViewController()
        //let navController = UINavigationController(rootViewController: tabBarView)
        //navController.modalPresentationStyle = .fullScreen
        tabBarView.getData(data: UID)
        self.navigationController?.pushViewController(tabBarView, animated: true)
    }
    
    // MARK: Actions
    
    func switchButtonAction() {
        checkFieldsAndMakeLoginLogic()
    }
    
    @objc func onClickEnterButton() {
        switchButtonAction()
        enterButton.isEnabled = true
    }
    
    @objc func onClickSingButton() {
        singUp = !singUp
    }
    
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        checkFieldsAndMakeLoginLogic()
        
        return true
    }
}
