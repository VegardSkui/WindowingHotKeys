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

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        HotKeyController.setupEventHandler()

        requestAccessibilityPrivileges {
            self.setupHotKeys()
        }

        if AXIsProcessTrusted() {
            setupHotKeys()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    private func setupHotKeys() {
        BottomHalfAction.setupHotKey()
        LeftHalfAction.setupHotKey()
        RightHalfAction.setupHotKey()
        TopHalfAction.setupHotKey()
    }

    // MARK: - Request Accessibility Privileges

    private var requestWindow: NSWindow!

    private func requestAccessibilityPrivileges(completion: @escaping () -> Void) {
        if AXIsProcessTrusted() {
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

        pollAccessibilityPrivileges(completion: completion)
    }

    private func pollAccessibilityPrivileges(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if AXIsProcessTrusted() {
                self.requestWindow.close()
                completion()
            } else {
                self.pollAccessibilityPrivileges(completion: completion)
            }
        }
    }
}
