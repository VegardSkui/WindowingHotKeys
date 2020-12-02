//
//  WindowingHotKeys.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 21/11/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Cocoa

@main
struct WindowingHotKeys {
    static func main() {
        // Limit the application to a single running instance, multiple
        // instances may occur if there are multiple copies of the app bundle
        terminateOtherRunningInstances()

        let delegate = AppDelegate()
        NSApplication.shared.delegate = delegate
        NSApplication.shared.run()
    }

    /// Terminates every other running instance of the application for the current user.
    private static func terminateOtherRunningInstances() {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
        let runningInstances = NSRunningApplication.runningApplications(withBundleIdentifier: bundleIdentifier)

        // If there is only one running instance, it must be this one
        guard runningInstances.count != 1 else { return }

        let currentProcessIdentifier = NSRunningApplication.current.processIdentifier
        runningInstances.forEach { instance in
            // Skip the current instance
            guard instance.processIdentifier != currentProcessIdentifier else { return }

            let success = instance.terminate()
            if success {
                print("Terminated running instance with pid \(instance.processIdentifier)")
            } else {
                print("Could not terminate running instance with pid \(instance.processIdentifier)")
            }
        }
    }
}
