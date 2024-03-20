//
//  UserCache.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/20/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import Foundation

// TODO: change to Keychain
public class UserCache {
    private init() {}
    
    public static let shared = UserCache()
    
    public func saveToken(_ token: String, for type: JwtType) {
        UserDefaults.standard.setValue(token, forKey: type.rawValue)
    }
    
    public func getToken(for type: JwtType) -> String? {
        UserDefaults.standard.string(forKey: type.rawValue)
    }
}
