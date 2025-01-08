//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by Akul Sareen on 2025-01-05.
//

import UIKit

class ViewController: UIViewController {
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "PlusPhoto"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.textColor = .black
        emailTextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        emailTextField.borderStyle = .roundedRect
        emailTextField.font = UIFont.systemFont(ofSize: 15)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return emailTextField
    }()
    
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = .black
        passwordTextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordTextField
    }()
    
    let userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.placeholder = "Username"
        userNameTextField.textColor = .black
        userNameTextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.font = UIFont.systemFont(ofSize: 15)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return userNameTextField
    }()
    
    let signUpButton: UIButton = {
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        return signUpButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Adds auto-layout to the element
        view.addSubview(addPhotoButton)
        addPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        setUpInputFields()
        
//        view.addSubview(signUpButton)
        

    }
    
    private func setUpInputFields(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField , passwordTextField, signUpButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 7
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 40).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 190).isActive = true
    }
        


}

