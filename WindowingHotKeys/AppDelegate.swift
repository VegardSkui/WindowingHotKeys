//
//  AppDelegate.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = StatusItem()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Request accessibility privileges from the user and register the hot
        // keys as soon as they are granted
        requestAccessibilityPrivileges {
            HotKeyController.setupEventHandler()
            WindowManager().setupHotKeys()
        }
    }

    // MARK: - Request Accessibility Privileges

    private var requestWindow: NSWindow!

    /// Requests accessibility privileges from the user, calling `grantedHandler` as soon as they are granted (possibly immediately).
    private func requestAccessibilityPrivileges(grantedHandler: @escaping () -> Void) {
        if AXIsProcessTrusted() {
            grantedHandler()
            return
        }

        let view = RequestAccessibilityPrivilegesView()
        requestWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 400),
            styleMask: [.titled, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        requestWindow.title = "WindowingHotKeys"
        requestWindow.center()
        requestWindow.setFrameAutosaveName("Request Accessibility Privileges Window")
        requestWindow.contentView = NSHostingView(rootView: view)
        requestWindow.makeKeyAndOrderFront(nil)

        pollAccessibilityPrivileges(grantedHandler: grantedHandler)
    }

    /// Checks if accessibility privileges have been granted about every 300 ms, calling `grantedHandler` when they're granted.
    private func pollAccessibilityPrivileges(grantedHandler: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if AXIsProcessTrusted() {
                self.requestWindow.close()
                grantedHandler()
            } else {
                self.pollAccessibilityPrivileges(grantedHandler: grantedHandler)
            }
        }
    }
}
