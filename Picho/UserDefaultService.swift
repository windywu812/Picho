//
//  UserDefaultService.swift
//  iChol
//
//  Created by Windy on 08/11/20.
//

import Foundation

class UserDefaultService {
    
    static private let hasLaunchKey = "hasLaunchKey"
    static private let firstNameKey = "firstNameKey"
    static private let lastNameKey = "lastNameKey"
    static private let genderKey = "genderKey"
    static private let ageKey = "ageKey"
    static private let heightKey = "heightKey"
    static private let weightKey = "weightKey"
    static private let isSyncHealthKitKey = "isSyncHealthKitKey"
 
    static var hasLaunched: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasLaunchKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasLaunchKey)
        }
    }
    
    static var firstName: String {
        get {
            return UserDefaults.standard.string(forKey: firstNameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: firstNameKey)
        }
    }
   
    static var lastName: String {
        get {
            return UserDefaults.standard.string(forKey: lastNameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: lastNameKey)
        }
    }
    
    static var gender: String {
        get {
            return UserDefaults.standard.string(forKey: genderKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: genderKey)
        }
    }
    
    static var age: String {
        get {
            return UserDefaults.standard.string(forKey: ageKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: ageKey)
        }
    }
    
    static var height: String {
        get {
            return UserDefaults.standard.string(forKey: heightKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: heightKey)
        }
    }
    
    static var weight: String {
        get {
            return UserDefaults.standard.string(forKey: weightKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: weightKey)
        }
    }
    
    static var isSyncHealthKit: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isSyncHealthKitKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isSyncHealthKitKey)
        }
    }
    
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
    
}
