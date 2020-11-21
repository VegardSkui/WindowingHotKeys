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
        let delegate = AppDelegate()
        NSApplication.shared.delegate = delegate
        NSApplication.shared.run()
    }
}
