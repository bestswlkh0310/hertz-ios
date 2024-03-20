//
//  AuthInterceptor.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/20/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import Foundation
import Alamofire

public final class AuthInterceptor: RequestInterceptor {

    static let shared = AuthInterceptor()

    private init() {}

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(Config.baseURL.absoluteString) == true,
              let accessToken = UserCache.shared.getToken(for: .accessToken)
        else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        let authorization = "Bearer \(accessToken)"
        urlRequest.setValue(authorization, forHTTPHeaderField: "Authorization")
        print("adator 적용")
        completion(.success(urlRequest))
    }

    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입")
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard let refreshToken = UserCache.shared.getToken(for: .refreshToken) else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        // MARK: refresh
        Task {
            let result = await UserService.shared.refresh(refreshToken: refreshToken)
            switch result {
            case .success(let response):
                let accessToken = response.data.accessToken
                UserCache.shared.saveToken(accessToken, for: .accessToken)
                completion(.retry)
            default:
                UserCache.shared.saveToken(nil, for: .accessToken)
                UserCache.shared.saveToken(nil, for: .refreshToken)
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
