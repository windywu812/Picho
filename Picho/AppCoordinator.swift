//
//  AppCoordinator.swift
//  iChol
//
//  Created by Windy on 07/11/20.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private var tabBar: UITabBarController!
    private var mainViewController: UINavigationController!
    private var historyViewController: UINavigationController!
    private var profileViewController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        FatSecretCredentials.setConsumerKey(APIKey.apiKey)
        FatSecretCredentials.setSharedSecret(APIKey.apiSecret)
        
        setupHomeVC()
        setupHistoryVC()
        setupProfileVC()
        
        tabBar = UITabBarController()
        tabBar.viewControllers = [
            mainViewController,
            historyViewController,
            profileViewController
        ]
        
        window.tintColor = Color.green
        window.backgroundColor = Color.background
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
        
        if UserDefaultService.hasLaunched {
            window.rootViewController = tabBar
        } else {
            window.rootViewController = PageControlDescription()
        }
        
    }
    
    private func setupHomeVC() {
        mainViewController = UINavigationController(rootViewController: MainViewController())
        mainViewController.navigationBar.prefersLargeTitles = true
        mainViewController.tabBarItem = UITabBarItem(
            title: "Journal",
            image: UIImage(named: "journal"), tag: 0)
    }
   
    private func setupHistoryVC() {
        historyViewController = UINavigationController(rootViewController: HistoryViewController())
        historyViewController.navigationBar.prefersLargeTitles = true
        historyViewController.tabBarItem = UITabBarItem(
            title: "Progress",
            image: UIImage(named: "history"), tag: 1)
    }
    
    private func setupProfileVC() {
        profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.navigationBar.prefersLargeTitles = true
        profileViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "Profile"), tag: 2)
    }
    
}
