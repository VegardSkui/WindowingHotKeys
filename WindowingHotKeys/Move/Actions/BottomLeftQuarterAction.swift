//
//  BottomLeftQuarterAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 03/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon
import Cocoa

class BottomLeftQuarterAction: MoveAction {
    static let carbonKeyCode = UInt32(kVK_ANSI_J)
    static let carbonModifiers = UInt32(controlKey | optionKey)

    static func execute(window: AccessibilityWindow, visibleScreenFrame: CGRect) {
        let halfScreenHeight = visibleScreenFrame.size.height / 2
        window.rect = CGRect(
            x: visibleScreenFrame.origin.x,
            y: visibleScreenFrame.origin.y + halfScreenHeight,
            width: visibleScreenFrame.size.width / 2,
            height: halfScreenHeight
        )
    }
}
