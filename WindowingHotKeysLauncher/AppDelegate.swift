//
//  AppDelegate.swift
//  WindowingHotKeysLauncher
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let mainBundleIdentifier = "com.vegardskui.WindowingHotKeys"

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Determine if the main application is already running
        let isRunning = !NSRunningApplication.runningApplications(
            withBundleIdentifier: mainBundleIdentifier
        ).isEmpty

        // If it's not running, find the root location of the whole application
        // bundle and launch it, this will launch the main application
        if !isRunning {
            let pathComponents = (Bundle.main.bundlePath as NSString).pathComponents
            let mainPath = NSString.path(
                withComponents: Array(pathComponents[0...(pathComponents.count - 5)])
            )
            NSWorkspace.shared.launchApplication(mainPath)
        }

        // Terminate the launcher app
        NSApp.terminate(nil)
    }
}
