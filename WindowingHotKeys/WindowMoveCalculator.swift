//
//  WindowMoveCalculator.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 19/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Foundation

protocol WindowMoveCalculator {
    func calculate(window: AccessibilityWindow, availableScreenFrame: CGRect) -> CGRect
}
