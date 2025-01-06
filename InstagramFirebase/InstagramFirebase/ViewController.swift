//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by Akul Sareen on 2025-01-05.
//

import UIKit

class ViewController: UIViewController {
    
    let addPhotoButton: UIButton = {
        
        
        let button = UIButton()
        button.setImage(UIImage(named: "PlusPhoto"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.textColor = .lightGray
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return emailTextField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Adds auto-layout to the element
        view.addSubview(addPhotoButton)
        addPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        //end last comment
        
        view.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 40).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 60).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }


}

