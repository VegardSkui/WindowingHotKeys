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
        let isRunning = !NSRunningApplication.runningApplications(
            withBundleIdentifier: mainBundleIdentifier
        ).isEmpty

        if !isRunning {
            let pathComponents = (Bundle.main.bundlePath as NSString).pathComponents
            let mainPath = NSString.path(
                withComponents: Array(pathComponents[0...(pathComponents.count - 5)])
            )
            NSWorkspace.shared.launchApplication(mainPath)
        }

        NSApp.terminate(nil)
    }
}
