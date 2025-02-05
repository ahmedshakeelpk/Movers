//
//  UserDefaults.swift
//  Movers
//
//  Created by Shakeel Ahmed on 02/02/2025.
//

import Foundation


extension UserDefaults {
    
    var kisGetStarted: Bool {
        get {
            // Retrieve the value from UserDefaults
            return UserDefaults.standard.bool(forKey: "kisGetStarted")
        }
        set(value) {
            // Save the value to UserDefaults
            UserDefaults.standard.set(value, forKey: "kisGetStarted")
        }
    }
    
}
