//
//  NetworkService.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/20/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import Foundation

public final class NetworkService {
    private init() {}
    
    public let userService = UserService()
    public let musicService = MusicService()
}

extension NetworkService {
    
    public static let shared = NetworkService()
    
}
