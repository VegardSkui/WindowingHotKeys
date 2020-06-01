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

    static func execute(window: AccessibilityWindow, visibleScreenFrame: CGRect) {
        let halfScreenWidth = visibleScreenFrame.size.width / 2
        window.rect = CGRect(
            x: visibleScreenFrame.origin.x + halfScreenWidth,
            y: visibleScreenFrame.origin.y,
            width: halfScreenWidth,
            height: visibleScreenFrame.size.height
        )
    }
}
