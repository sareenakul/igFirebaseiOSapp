//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by Akul Sareen on 2025-01-05.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage




class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "PlusPhoto"), for: .normal)
        
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleAddPhoto(){
        let uiImagePickerController = UIImagePickerController()
        
        uiImagePickerController.delegate = self
        uiImagePickerController.allowsEditing = true
        present(uiImagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            addPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            addPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
            
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width/2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderColor = UIColor.black.cgColor
        addPhotoButton.layer.borderWidth = 3
            
            dismiss(animated: true, completion: nil)
        
        
        
    }
    
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
    
    var isSubmitting = false
    
    @objc func handleSignUp() {
        guard !isSubmitting else {  // Prevent submitting if the process is already ongoing
               return
           }
        
        isSubmitting = true
        
        guard let email = emailTextField.text, !email.isEmpty else {
            print("Email is empty")
            isSubmitting = false
            return
        }
        
        guard let username = userNameTextField.text, !username.isEmpty else {
            print("Username is empty")
            isSubmitting = false
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("Password is empty")
            isSubmitting = false
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
            if let error = error as NSError? {
                // Handle email already in use error
                if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    print("The email address is already in use by another account.")
                } else {
                    print("Failed to create the user: \(error.localizedDescription)")
                }
                self.isSubmitting = false
                return
            }
            
            guard let user = authResult?.user else {
                print("User creation successful but no user object returned")
                self.isSubmitting = false
                return
            }
            
            guard let image = self.addPhotoButton.imageView?.image else{
                print("No image selected")
                return
            }
            
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else {
                print("Failed to compress image")
                return
            }
            
            let filename = UUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images/\(filename).jpg")
            
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if let error = error{
                    print("Failed to upload profile image: \(error.localizedDescription)")
                    self.isSubmitting = false
                    return
                }
                
                print("Image successfully uploaded with metadata: \(String(describing: metadata))")
                
                storageRef.downloadURL{ (url, error) in
                    guard let profileImageURL = url?.absoluteString else {
                        print("Failed to get the URL:",  error?.localizedDescription ?? "Unknown error")
                        return
                    }
                    
                    print("Successfully added image to Storage: ", profileImageURL)
                    
                    let uid = user.uid
                    let values = ["username": username, "email": email, "profileImageURL": profileImageURL]
                    //let values = [uid: usernameValues]
                    Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: {(error, ref) in
                        if let error = error{
                            print("Failed to save user info to Database: \(error.localizedDescription)")
                            self.isSubmitting = false
                            return
                        }
                        print("Successfully added the user info to the firebase database with uid: \(uid)")
                        self.isSubmitting = false
                    })
                }
                
                
                
            }
            
            

            
        }
    )}


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

