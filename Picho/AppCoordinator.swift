//
//  AppCoordinator.swift
//  iChol
//
//  Created by Windy on 07/11/20.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private var tabBar: TabBarController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
     
        FatSecretCredentials.setConsumerKey(APIKey.apiKey)
        FatSecretCredentials.setSharedSecret(APIKey.apiSecret)
        
        tabBar = TabBarController()
        
        window.tintColor = Color.green
        window.backgroundColor = Color.background
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
        
        if UserDefaultService.hasLaunched {
            window.rootViewController = tabBar
        } else {
            window.rootViewController = PageControlDescription()
            let labelCells = ["Breakfast", "Lunch", "Dinner", "Snacks", "Water", "Weigh In", "Reflection"]
            let timeLabels = ["08:00", "12:00", "19:00", "16:00", "12:00", "12:00", "20:00"]

            for index in 0..<7 {
                CoreDataService.shared.addNotification(id: labelCells[index], isOn: false, timeLabel: timeLabels[index])
            }
        }
        
    }
    
}
