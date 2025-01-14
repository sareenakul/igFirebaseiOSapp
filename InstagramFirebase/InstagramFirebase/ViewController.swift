//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by Akul Sareen on 2025-01-05.
//

import UIKit
import Firebase
import FirebaseAuth




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
        emailTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return emailTextField
    }()
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && userNameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        if isFormValid{
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        } else{
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
//
    }
    
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = .black
        passwordTextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
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
        userNameTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
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
        
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        signUpButton.isEnabled = false
        
        return signUpButton
    }()
    
    @objc func handleSignUp(){
        
        guard let email = emailTextField.text, !email.isEmpty else{
            return
        }
        
        guard let username = userNameTextField.text, !username.isEmpty else{
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else{
            return
        }
        
        
        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            if let error = error{
                print("Failed to create the user: \(error)")
                return
            }
            guard let user = authResult?.user else{
                return
            }
            print("Successful user creation: \(user.uid)")
        }
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Adds auto-layout to the element
        view.addSubview(addPhotoButton)
        
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addPhotoButton.anchor(top: view.topAnchor, bottom: nil, left: nil, right: nil, paddingTop: 60, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 140, height: 140)
        setUpInputFields()

    }
    
    private func setUpInputFields(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField , passwordTextField, signUpButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 7
        
        view.addSubview(stackView)
        
        
        
        stackView.anchor(top: addPhotoButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 40, paddingRight: -40, width: 0, height: 200)
    }
}

extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingBottom: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat){
        
        //Unwrap to be learnt
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right{
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        if width != 0{
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0{
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

