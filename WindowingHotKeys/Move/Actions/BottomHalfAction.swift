//
//  BottomHalfAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon
import Cocoa

class BottomHalfAction: MoveAction {
    static let carbonKeyCode = UInt32(kVK_DownArrow)
    static let carbonModifiers = UInt32(controlKey | optionKey)

    static func execute(window: AccessibilityWindow, visibleScreenFrame: CGRect) {
        let halfScreenHeight = visibleScreenFrame.size.height / 2
        window.rect = CGRect(
            x: visibleScreenFrame.origin.x,
            y: visibleScreenFrame.origin.y + halfScreenHeight,
            width: visibleScreenFrame.size.width,
            height: halfScreenHeight
        )
    }
}
