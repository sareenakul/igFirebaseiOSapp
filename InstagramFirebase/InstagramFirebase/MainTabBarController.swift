//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Akul Sareen on 2025-02-06.
//
import AssetsLibrary
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layout = UICollectionViewFlowLayout()
        
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileController)
        
        
        tabBar.isTranslucent = false

        
        tabBar.tintColor = .black
        
        let imageSizeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        
        navController.tabBarItem.image = UIImage(named: "unSelectedUser")?.withConfiguration(imageSizeConfig)/*.withRenderingMode(.alwaysOriginal)*/
        
        navController.tabBarItem.selectedImage = UIImage(named: "selectedUser")?.withConfiguration(imageSizeConfig)/*.withRenderingMode(.alwaysOriginal)*/
        
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        
        viewControllers = [navController, UIViewController()]
    }
}
