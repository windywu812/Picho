//
//  AppCoordinator.swift
//  iChol
//
//  Created by Windy on 07/11/20.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private let tabBar: UITabBarController
    
    private var mainViewController: UINavigationController!
    private var historyViewController: UINavigationController!
    private var profileViewController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
        self.tabBar = UITabBarController()
    }
    
    func start() {
        
        setupHomeVC()
        setupHistoryVC()
        setupProfileVC()
        
        tabBar.viewControllers = [
            mainViewController,
            historyViewController,
            profileViewController
        ]
        
        window.tintColor = Color.green
        window.backgroundColor = Color.background
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
        window.rootViewController = tabBar
    }
    
    private func setupHomeVC() {
        mainViewController = UINavigationController(rootViewController: MainViewController())
        mainViewController.tabBarItem = UITabBarItem(
            title: "Journal",
            image: UIImage(named: "journal"), tag: 0)
    }
   
    private func setupHistoryVC() {
        
        historyViewController = UINavigationController(rootViewController: HistoryViewController())
        historyViewController.tabBarItem = UITabBarItem(
            title: "Progress",
            image: UIImage(named: "history"), tag: 1)
    }
    
    private func setupProfileVC() {
        profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile"), tag: 2)
    }
    
}
