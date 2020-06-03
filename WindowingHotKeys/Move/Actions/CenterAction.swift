//
//  CenterAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 03/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon
import Cocoa

class CenterAction: MoveAction {
    static let carbonKeyCode = UInt32(kVK_ANSI_C)
    static let carbonModifiers = UInt32(controlKey | optionKey)

    static func execute(window: AccessibilityWindow, visibleScreenFrame: CGRect) {
        window.rect.origin = CGPoint(
            x: visibleScreenFrame.origin.x + (visibleScreenFrame.size.width - window.rect.size.width) / 2,
            y: visibleScreenFrame.origin.y + (visibleScreenFrame.size.height - window.rect.size.height) / 2
        )
    }
}
