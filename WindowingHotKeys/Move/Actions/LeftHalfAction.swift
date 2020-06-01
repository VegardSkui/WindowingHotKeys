//
//  LeftHalfAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon
import Cocoa

class LeftHalfAction: MoveAction {
    static let carbonKeyCode = UInt32(kVK_LeftArrow)
    static let carbonModifiers = UInt32(controlKey | optionKey)

    static func execute(window: AccessibilityWindow, visibleScreenFrame: CGRect) {
        window.rect = CGRect(
            x: visibleScreenFrame.origin.x,
            y: visibleScreenFrame.origin.y,
            width: visibleScreenFrame.size.width / 2,
            height: visibleScreenFrame.size.height
        )
    }
}
