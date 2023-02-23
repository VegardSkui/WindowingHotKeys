//
//  AXError-Extensions.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import ApplicationServices

extension AXError: CustomStringConvertible {
    fileprivate var valueAsString: String {
        switch self {
            case .apiDisabled:
                return "apiDisabled"
            case .actionUnsupported:
                return "actionUnsupported"
            case .attributeUnsupported:
                return "attributeUnsupported"
            case .cannotComplete:
                return "cannotComplete"
            case .failure:
                return "failure"
            case .illegalArgument:
                return "illegalArgument"
            case .invalidUIElement:
                return "invalidUIElement"
            case .invalidUIElementObserver:
                return "invalidUIElementObserver"
            case .noValue:
                return "noValue"
            case .notEnoughPrecision:
                return "notEnoughPrecision"
            case .notImplemented:
                return "notImplemented"
            case .notificationAlreadyRegistered:
                return "notificationAlreadyRegistered"
            case .notificationNotRegistered:
                return "notificationNotRegistered"
            case .notificationUnsupported:
                return "notificationUnsupported"
            case .parameterizedAttributeUnsupported:
                return "parameterizedAttributeUnsupported"
            case .success:
                return "success"
            @unknown default:
                return "unknown"
        }
    }

    public var description: String {
        return "AXError.\(valueAsString)"
    }
}
