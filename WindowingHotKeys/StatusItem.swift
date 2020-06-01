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

        let launchAtLoginItem = NSMenuItem(
            title: "Launch at Login",
            action: #selector(toggleLaunchAtLogin(_:)),
            keyEquivalent: ""
        )
        launchAtLoginItem.target = self
        launchAtLoginItem.state = launchAtLoginIsEnabled() ? .on : .off
        menu.addItem(launchAtLoginItem)

        menu.addItem(NSMenuItem.separator())

        let quitItem = NSMenuItem(
            title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )
        menu.addItem(quitItem)
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
