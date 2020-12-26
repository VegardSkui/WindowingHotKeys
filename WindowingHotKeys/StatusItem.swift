//
//  StatusItem.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import AppKit
import ServiceManagement

class StatusItem {
    private let statusItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.variableLength
    )

    private let menu = NSMenu()

    init() {
        statusItem.button?.image = NSImage(named: "StatusItemIcon")
        statusItem.menu = menu

        // Launch at login
        let launchAtLoginItem = NSMenuItem(
            title: "Launch at Login",
            action: #selector(toggleLaunchAtLogin(_:)),
            keyEquivalent: ""
        )
        launchAtLoginItem.target = self
        launchAtLoginItem.state = launchAtLoginIsEnabled() ? .on : .off
        menu.addItem(launchAtLoginItem)

        menu.addItem(.separator())

        // Hide
        let hideStatusItem = NSMenuItem(
            title: "Hide status bar item",
            action: #selector(hide(_:)),
            keyEquivalent: ""
        )
        hideStatusItem.target = self
        menu.addItem(hideStatusItem)

        menu.addItem(.separator())

        // Quit
        let quitItem = NSMenuItem(
            title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )
        menu.addItem(quitItem)
    }

    @objc func hide(_ sender: NSMenuItem?) {
        // Show the user a confirmation alert
        let alert = NSAlert()
        alert.messageText = "Are you sure?"
        alert.informativeText = "The application cannot easily be quit or restarted after hiding the status bar item, see README for intructions."
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let response = alert.runModal()

        // Hide the status bar item if the user selected "OK"
        if response == .alertFirstButtonReturn {
            NSStatusBar.system.removeStatusItem(statusItem)
        }
    }

    @objc func toggleLaunchAtLogin(_ sender: NSMenuItem?) {
        SMLoginItemSetEnabled(
            "com.vegardskui.WindowingHotKeysLauncher" as CFString,
            !launchAtLoginIsEnabled()
        )
        sender?.state = launchAtLoginIsEnabled() ? .on : .off
    }

    private func launchAtLoginIsEnabled() -> Bool {
        guard let jobs = (SMCopyAllJobDictionaries(kSMDomainUserLaunchd).takeRetainedValue() as? [[String: AnyObject]]) else {
            return false
        }

        let job = jobs.first { job in
            job["Label"] as! String == "com.vegardskui.WindowingHotKeysLauncher"
        }

        return job?["OnDemand"] as? Bool ?? false
    }
}
