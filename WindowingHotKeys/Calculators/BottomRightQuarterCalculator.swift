//
//  BottomRightQuarterCalculator.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 19/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Foundation

class BottomRightQuarterCalculator: WindowMoveCalculator {
    func calculate(window: AccessibilityWindow, availableScreenFrame: CGRect) -> CGRect {
        let halfScreenWidth = availableScreenFrame.size.width / 2
        let halfScreenHeight = availableScreenFrame.size.height / 2
        return CGRect(
            x: availableScreenFrame.origin.x + halfScreenWidth,
            y: availableScreenFrame.origin.y + halfScreenHeight,
            width: halfScreenWidth,
            height: halfScreenHeight
        )
    }
}
