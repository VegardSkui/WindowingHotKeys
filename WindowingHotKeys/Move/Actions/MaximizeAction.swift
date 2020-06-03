//
//  MaximizeAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 03/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon
import Cocoa

class MaximizeAction: MoveAction {
    static let carbonKeyCode = UInt32(kVK_Return)
    static let carbonModifiers = UInt32(controlKey | optionKey)

    static func execute(window: AccessibilityWindow, visibleScreenFrame: CGRect) {
        window.rect = CGRect(
            x: visibleScreenFrame.origin.x,
            y: visibleScreenFrame.origin.y,
            width: visibleScreenFrame.size.width,
            height: visibleScreenFrame.size.height
        )
    }
}
