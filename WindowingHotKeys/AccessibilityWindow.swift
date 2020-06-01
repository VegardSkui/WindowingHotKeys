//
//  AccessibilityWindow.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Cocoa

class AccessibilityWindow {
    let element: AXUIElement

    init(_ element: AXUIElement) {
        self.element = element
    }

    static func frontmost() -> AccessibilityWindow? {
        guard let frontmostApplication = NSWorkspace.shared.frontmostApplication else {
            print("Could not get frontmost application")
            return nil
        }

        let element = AXUIElementCreateApplication(frontmostApplication.processIdentifier)

        var focusedWindow: AnyObject?
        let error = AXUIElementCopyAttributeValue(
            element,
            NSAccessibility.Attribute.focusedWindow as CFString,
            &focusedWindow
        )

        if error != .success {
            print("An error occured while getting the frontmost window: \(error)")
            return nil
        }

        return AccessibilityWindow(focusedWindow as! AXUIElement)
    }

    private var position: CGPoint? {
        get {
            var rawValue: AnyObject?
            let error = AXUIElementCopyAttributeValue(element, kAXPositionAttribute as CFString, &rawValue)

            if error != .success {
                print(error)
                return nil
            }

            var result: CGPoint? = CGPoint()
            let success = AXValueGetValue(rawValue as! AXValue, .cgPoint, &result)
            return success ? result : nil
        }
        set {
            guard let value = AXValue.from(value: newValue, type: .cgPoint) else {
                return
            }

            let error = AXUIElementSetAttributeValue(element, kAXPositionAttribute as CFString, value)

            if error != .success {
                print(error)
            }
        }
    }

    private var size: CGSize? {
        get {
            var rawValue: AnyObject?
            let error = AXUIElementCopyAttributeValue(element, kAXSizeAttribute as CFString, &rawValue)

            if error != .success {
                print(error)
                return nil
            }

            var result: CGSize? = CGSize()
            let success = AXValueGetValue(rawValue as! AXValue, .cgSize, &result)
            return success ? result : nil
        }
        set {
            guard let value = AXValue.from(value: newValue, type: .cgSize) else {
                return
            }

            let error = AXUIElementSetAttributeValue(element, kAXSizeAttribute as CFString, value)

            if error != .success {
                print(error)
            }
        }
    }

    var rect: CGRect {
        get {
            guard let position = position, let size = size else {
                return CGRect.null
            }
            return CGRect(origin: position, size: size)
        }
        set {
            position = newValue.origin
            size = newValue.size
        }
    }
}
