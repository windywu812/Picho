//
//  UserDefaultService.swift
//  iChol
//
//  Created by Windy on 08/11/20.
//

import Foundation

class UserDefaultService {
    
    static private let hasLaunchKey = "hasLaunchKey"
    static private let nameKey = "nameKey"
    static private let genderKey = "genderKey"
    static private let ageKey = "ageKey"
    static private let heightKey = "heightKey"
    static private let weightKey = "weightKey"
    static private let isSyncHealthKitKey = "isSyncHealthKitKey"
    static private let hasBreakfastKey = "hasBreakfastKey"
    static private let hasLunchKey = "hasLunchKey"
    static private let hasDinnerKey = "hasDinnerKey"
    static private let currentDateKey = "currentDateKey"
    static let photoProfileKey = "photoKey"
 
    static var hasLaunched: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasLaunchKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasLaunchKey)
        }
    }
    
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
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
    
    static var age: String? {
        get {
            return UserDefaults.standard.string(forKey: ageKey) ?? "0"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: ageKey)
        }
    }
    
    static var height: String? {
        get {
            return UserDefaults.standard.string(forKey: heightKey) ?? "0"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: heightKey)
        }
    }
    
    static var weight: String? {
        get {
            return UserDefaults.standard.string(forKey: weightKey) ?? "0"
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
    
    static var hasBreakfast: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasBreakfastKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasBreakfastKey)
        }
    }
    
    static var hasLunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasLunchKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasLunchKey)
        }
    }
    
    static var hasDinner: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasDinnerKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasDinnerKey)
        }
    }
    
    static var currentDate: String {
        get {
            return UserDefaults.standard.string(forKey: currentDateKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentDateKey)
        }
    }
    
    static func resetDay() {
        UserDefaultService.hasBreakfast = false
        UserDefaultService.hasLunch = false
        UserDefaultService.hasDinner = false
    }
    
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
    
}
