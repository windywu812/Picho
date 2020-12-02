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
    
    let secondSectionLabel = [NSLocalizedString("Gender", comment: ""),NSLocalizedString("Age", comment: "") ,NSLocalizedString("Height", comment: ""),NSLocalizedString("Weight", comment: "") ]
    let thirdSectionLabel = [NSLocalizedString("Sync to HealthKit", comment: ""),NSLocalizedString("Notifications", comment: "") ]
    
    init() {
        fetchUserDefault()
    }
    
    func handleSwitch(value: Bool) {
        isSync.toggle()
        
        if value {
            UserDefaultService.isSyncHealthKit = isSync
            HealthKitService.shared.authorization()
        } else {
            
        }
        
    }
    
    func fetchUserDefault() {
        fullName = UserDefaultService.name
        
        secondSection = [
            UserDefaultService.gender,
            UserDefaultService.age ?? String(0),
            UserDefaultService.height ?? String(0),
            UserDefaultService.weight ?? String(0)
        ]
        
        isSync = UserDefaultService.isSyncHealthKit
    }
    
    func savePic(image: UIImage?, key: String) {
        guard let image = image else { return }
        if let pngRepresentation = image.pngData() {
            UserDefaults.standard.set(pngRepresentation, forKey: key)
        }
    }
    
    func getPic(forKey key: String) -> UIImage {
        if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
            let image = UIImage(data: imageData) {
            return image
        }
        return UIImage(systemName: "person.circle")!
    }
    
    
}
