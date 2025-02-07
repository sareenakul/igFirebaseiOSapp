//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Akul Sareen on 2025-02-06.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layout = UICollectionViewFlowLayout()
        
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image
        navController
        
        viewControllers = [navController]
    }
}
