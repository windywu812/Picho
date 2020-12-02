//
//  TabBarController.swift
//  Picho
//
//  Created by Windy on 15/11/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    private var mainViewController: UINavigationController!
    private var historyViewController: UINavigationController!
    private var profileViewController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHomeVC()
        setupHistoryVC()
        setupProfileVC()
        
        viewControllers = [
            mainViewController,
            historyViewController,
            profileViewController
        ]
    }
    
    private func setupHomeVC() {
        mainViewController = UINavigationController(rootViewController: JournalViewController())
        mainViewController.navigationBar.prefersLargeTitles = true
        mainViewController.tabBarItem = UITabBarItem(
            title: "Journal",
            image: UIImage(named: "journal"), tag: 0)
    }
   
    private func setupHistoryVC() {
        historyViewController = UINavigationController(rootViewController: HistoryTableViewController(style: .grouped))
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
