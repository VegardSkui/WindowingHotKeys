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

    /// The position of the window relative to the global origin.
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
            // Size needs to be set both before and after position to ensure the correct result
            size = newValue.size
            position = newValue.origin
            size = newValue.size
        }
    }

    lazy private var pid: pid_t? = {
        var pid: pid_t = 0
        let error = AXUIElementGetPid(element, &pid)
        return error == .success ? pid : nil
    }()

    lazy var identifier: Int? = {
        guard let pid = pid else { return nil }

        guard let windowList = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as? Array<Dictionary<CFString, AnyObject>> else {
            print("Could not get window list")
            return nil
        }

        // Let each window owned by the same process and with the same size and position be a potential window
        let potentialWindows = windowList.filter { info in
            let rect = self.rect
            let bounds = info[kCGWindowBounds] as! Dictionary<String, CGFloat>
            return info[kCGWindowOwnerPID] as! pid_t == pid
                && bounds["X"] == rect.origin.x
                && bounds["Y"] == rect.origin.y
                && bounds["Width"] == rect.size.width
                && bounds["Height"] == rect.size.height
        }

        // Assume the first matching window is the correct one as we have no way of verifying further
        return potentialWindows.first?[kCGWindowNumber] as? Int
    }()
}
