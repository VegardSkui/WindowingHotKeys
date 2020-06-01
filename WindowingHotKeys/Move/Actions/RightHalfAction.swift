//
//  RightHalfAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon
import Cocoa

class RightHalfAction: MoveAction {
    static let carbonKeyCode = UInt32(kVK_RightArrow)
    static let carbonModifiers = UInt32(controlKey | optionKey)

    static func execute() {
        guard let window = AccessibilityWindow.frontmost() else {
            return
        }

        guard let screenFrame = NSScreen.main?.frame else {
            return
        }

        let halfScreenWidth = screenFrame.size.width / 2
        let rect = CGRect(
            x: screenFrame.origin.x + halfScreenWidth,
            y: screenFrame.origin.y,
            width: halfScreenWidth,
            height: screenFrame.size.height
        )

        window.rect = rect
    }
}
