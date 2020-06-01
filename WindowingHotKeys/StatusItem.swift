//
//  StatusItem.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import AppKit

class StatusItem {
    private let statusItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.variableLength
    )

    private let menu = NSMenu()

    init() {
        statusItem.button?.image = NSImage(named: "StatusItemIcon")
        statusItem.menu = menu

        let quitItem = NSMenuItem(
            title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )
        menu.addItem(quitItem)
    }
}
