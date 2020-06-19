//
//  BottomLeftQuarterCalculator.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 19/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Foundation

class BottomLeftQuarterCalculator: WindowMoveCalculator {
    func calculate(window: AccessibilityWindow, availableScreenFrame: CGRect) -> CGRect {
        let halfScreenHeight = availableScreenFrame.size.height / 2
        return CGRect(
            x: availableScreenFrame.origin.x,
            y: availableScreenFrame.origin.y + halfScreenHeight,
            width: availableScreenFrame.size.width / 2,
            height: halfScreenHeight
        )
    }
}
