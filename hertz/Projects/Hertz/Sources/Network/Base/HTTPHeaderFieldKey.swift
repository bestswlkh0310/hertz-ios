//
//  HttpHeaderKey.swift
//  Hertz
//
//  Created by dgsw8th71 on 3/20/24.
//  Copyright © 2024 bestswlkh0310. All rights reserved.
//

import Foundation
import Moya

public enum Authorization {
    case authorization
    case unauthorization
}

extension TargetType {
    public var authorization: Authorization { .authorization }
}
