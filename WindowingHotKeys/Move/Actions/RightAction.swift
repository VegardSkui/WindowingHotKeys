//
//  RightAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon

class RightAction: MoveAction {
    static let carbonKeyCode = UInt32(kVK_RightArrow)
    static let carbonModifiers = UInt32(controlKey | optionKey)

    static func execute() {
        guard let window = AccessibilityWindow.frontmost() else {
            return
        }

        var rect = window.rect
        rect.origin.x += 20
        window.rect = rect
    }
}
