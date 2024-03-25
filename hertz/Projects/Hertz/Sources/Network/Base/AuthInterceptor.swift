//
//  AuthInterceptor.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/20/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

public final class AuthInterceptor: RequestInterceptor {

    private let maxRetryCount: Int = 3

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let accessToken = UserCache.shared.getToken(for: .accessToken)
        else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
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
        print("validating refresh...")
        if request.retryCount >= maxRetryCount {
            completion(.doNotRetry)
            return
        }
        
        
        guard let refreshToken = UserCache.shared.getToken(for: .refreshToken) else {
            UserCache.shared.deleteTokenAll()
            completion(.doNotRetry)
            return
        }
        
        print("refreshing...")
        Task {
            let result = await NetworkService.shared.userService.refresh(refreshToken: refreshToken)
            switch result {
            case .success(let response):
                let accessToken = response.data.accessToken
                UserCache.shared.saveToken(accessToken, for: .accessToken)
                completion(.retry)
            case .authFailure:
                logout()
                completion(.doNotRetry)
                break
            default:
                completion(.doNotRetry)
            }
        }
    }
    
    func logout() {
        DispatchQueue.main.async {
            UserCache.shared.deleteTokenAll()
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: StartViewController())
        }
    }
}
