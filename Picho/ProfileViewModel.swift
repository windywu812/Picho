//
//  ProfileViewModel.swift
//  iChol
//
//  Created by Windy on 08/11/20.
//

import UIKit

class ProfileViewModel {
    
    var fullName: String = ""
    var secondSection: [String] = []
    var isSync: Bool = false
    var imageProfile: String = ""
    
    let secondSectionLabel = ["Gender", "Age", "Height", "Weight"]
    let thirdSectionLabel = ["Sync to HealthKit", "Notifications"]
    
    init() {
        fetchUserDefault()
    }
    
    func handleSwitch(value: Bool) {
        isSync.toggle()
        
        if value {
            UserDefaultService.isSyncHealthKit = isSync
            HealthKitService.shared.authorization()
        }
    }
    
    func fetchUserDefault() {
        fullName = UserDefaultService.name
        
        secondSection = [
            UserDefaultService.gender,
            UserDefaultService.age,
            UserDefaultService.height,
            UserDefaultService.weight
        ]
        
        isSync = UserDefaultService.isSyncHealthKit
    }
    
    func savePic(image: UIImage, key: String) {
        if let pngRepresentation = image.pngData() {
            UserDefaults.standard.set(pngRepresentation, forKey: key)
        }
    }
    
    func getPic(forKey key: String) -> UIImage? {
        if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
            let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    
}
