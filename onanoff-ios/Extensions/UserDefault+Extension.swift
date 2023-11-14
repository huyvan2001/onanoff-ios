//
//  UserDefault+Extension.swift
//  DescendantsDNA
//
//  Created by Dmytro Davydenko on 19/07/2023.
//

import Foundation

struct StandardPair<T> {
    let key: String
    
//    var suiteName: String {
//        switch .environment {
//        case .production:
//            return "bundle-production"
//        case .development:
//            return "bundle.dev"
//        case .staging:
//            return "bundle.staging"
//        }
//    }
    
    var value: T? {
        set {
//            let userDefaults = UserDefaults(suiteName: suiteName)
            let userDefaults = UserDefaults.standard
            
            if let safeValue = newValue {
                userDefaults.set(safeValue, forKey: key)
            } else {
                userDefaults.removeObject(forKey: key)
            }
        }
        get {
//            let userDefaults = UserDefaults(suiteName: suiteName)
            let userDefaults = UserDefaults.standard
            return userDefaults.object(forKey: key) as? T
        }
    }
}

extension UserDefaults {
    static var authToken = StandardPair<String>(key: "authToken")
}
