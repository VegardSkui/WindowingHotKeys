//
//  BottomRightQuarterAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 03/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon
import Cocoa

class BottomRightQuarterAction: MoveAction {
    static let carbonKeyCode = UInt32(kVK_ANSI_K)
    static let carbonModifiers = UInt32(controlKey | optionKey)

    static func execute(window: AccessibilityWindow, visibleScreenFrame: CGRect) {
        let halfScreenWidth = visibleScreenFrame.size.width / 2
        let halfScreenHeight = visibleScreenFrame.size.height / 2
        window.rect = CGRect(
            x: visibleScreenFrame.origin.x + halfScreenWidth,
            y: visibleScreenFrame.origin.y + halfScreenHeight,
            width: halfScreenWidth,
            height: halfScreenHeight
        )
    }
}
