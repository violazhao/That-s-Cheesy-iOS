//
//  LogInViewController.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/14/23.
//

import UIKit

var isLoggedIn = false
class LogInViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // header image cheese emoji
    private let cheeseImage: UIImageView = {
        let cheese = UIImage(named: "cheeseEmoji")
        let cheeseView = UIImageView(image: cheese)
        cheeseView.translatesAutoresizingMaskIntoConstraints = false
        return cheeseView
    }()
    
    private let userField: UITextField = {
        let username = UITextField()
        username.translatesAutoresizingMaskIntoConstraints = false
        username.placeholder = "Username"
        username.borderStyle = UITextField.BorderStyle.roundedRect
        return username
    }()
    
    private let passField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.placeholder = "Password"
        password.borderStyle = UITextField.BorderStyle.roundedRect
        return password
    }()
    
    lazy var loginBtn: UIButton = {
        let login = UIButton()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.setTitle("Log In", for: .normal)
        login.setTitleColor(.label, for: .normal)
        login.backgroundColor = UIColor(rgb: 0xffa700)
        login.layer.cornerRadius = 8
        login.titleLabel?.font = .systemFont(ofSize: 15)
        login.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return login
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        if userField.text == UserManager.shared.user.username && passField.text == UserManager.shared.user.password {
            isLoggedIn = true
            navigationController?.setViewControllers([ProfileViewController()], animated: false)
        } else {
            isLoggedIn = false
        }
        userField.text = nil
        passField.text = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        titleLabel.text = "Log In"
        view.addSubview(titleLabel)
        view.addSubview(cheeseImage)
        view.addSubview(userField)
        view.addSubview(passField)
        view.addSubview(loginBtn)
        
        applyConstraints()
    }

    private func applyConstraints() {
        let cheeseConstraints = [
            cheeseImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            cheeseImage.widthAnchor.constraint(equalToConstant: 40),
            cheeseImage.heightAnchor.constraint(equalToConstant: 42),
            cheeseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cheeseImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10)
        ]
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: userField.topAnchor, constant: -20)
        ]

        let userConstraints = [
            userField.widthAnchor.constraint(equalToConstant: 300),
            userField.heightAnchor.constraint(equalToConstant: 30),
            userField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userField.bottomAnchor.constraint(equalTo: passField.topAnchor, constant: -15)
        ]

        let passConstraints = [
            passField.widthAnchor.constraint(equalToConstant: 300),
            passField.heightAnchor.constraint(equalToConstant: 30),
            passField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passField.bottomAnchor.constraint(equalTo: loginBtn.topAnchor, constant: -30)
        ]
        
        let loginConstraints = [
            loginBtn.widthAnchor.constraint(equalToConstant: 100),
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(cheeseConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(userConstraints)
        NSLayoutConstraint.activate(passConstraints)
        NSLayoutConstraint.activate(loginConstraints)
    }
}
