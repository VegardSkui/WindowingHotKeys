//
//  TopLeftQuarterCalculator.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 19/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Foundation

class TopLeftQuarterCalculator: WindowMoveCalculator {
    func calculate(window: AccessibilityWindow, availableScreenFrame: CGRect) -> CGRect {
        return CGRect(
            x: availableScreenFrame.origin.x,
            y: availableScreenFrame.origin.y,
            width: availableScreenFrame.size.width / 2,
            height: availableScreenFrame.size.height / 2
        )
    }
}
