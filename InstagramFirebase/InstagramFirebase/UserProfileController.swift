//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by Akul Sareen on 2025-02-06.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UserProfileController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tabBarController?.tabBar.isHidden = false
        
        collectionView.backgroundColor = .white
        navigationItem.title = Auth.auth().currentUser?.uid
        
        fetchUser()
        
    }
    
    fileprivate func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: {(snapshot) in print(snapshot.value ?? "")}) {
            (error) in print("Failed to fetch user: \(error.localizedDescription)")
        }
    }
}
