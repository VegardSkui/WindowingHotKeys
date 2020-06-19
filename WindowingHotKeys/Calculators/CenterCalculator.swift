//
//  CenterCalculator.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 19/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Foundation

class CenterCalculator: WindowMoveCalculator {
    func calculate(window: AccessibilityWindow, availableScreenFrame: CGRect) -> CGRect {
        return CGRect(
            x: availableScreenFrame.origin.x + (availableScreenFrame.size.width - window.rect.size.width) / 2,
            y: availableScreenFrame.origin.y + (availableScreenFrame.size.height - window.rect.size.height) / 2,
            width: window.rect.size.width,
            height: window.rect.size.height
        )
    }
}
