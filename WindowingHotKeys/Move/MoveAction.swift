//
//  MoveAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Cocoa

protocol MoveAction {
    static var carbonKeyCode: UInt32 { get }
    static var carbonModifiers: UInt32 { get }

    static func execute(window: AccessibilityWindow, visibleScreenFrame: CGRect)
}

extension MoveAction {
    static func setupHotKey() {
        _ = HotKey(
            carbonKeyCode: carbonKeyCode,
            carbonModifiers: carbonModifiers
        ) {
            guard let window = AccessibilityWindow.frontmost() else {
                return
            }

            guard let screen = NSScreen.main else {
                return
            }

            execute(window: window, visibleScreenFrame: screen.visibleFrame)
        }
    }
}
