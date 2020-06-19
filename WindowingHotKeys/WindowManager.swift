//
//  WindowManager.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 19/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon
import Cocoa

class WindowManager {
    private let calculators: Dictionary<MoveAction, WindowMoveCalculator> = [
        .topHalf: TopHalfCalculator(),
        .rightHalf: RightHalfCalculator(),
        .bottomHalf: BottomHalfCalculator(),
        .leftHalf: LeftHalfCalculator(),

        .topRightQuarter: TopRightQuarterCalculator(),
        .bottomRightQuarter: BottomRightQuarterCalculator(),
        .bottomLeftQuarter: BottomLeftQuarterCalculator(),
        .topLeftQuarter: TopLeftQuarterCalculator(),

        .maximize: MaximizeCalculator(),
        .center: CenterCalculator()
    ]

    func execute(action: MoveAction) {
        guard let window = AccessibilityWindow.frontmost() else { return }
        guard let screen = NSScreen.main else { return }

        // Calculate the screen frame available to the application, this is the
        // whole screen minus the space used by the menu bar and dock
        let dockHeight = screen.visibleFrame.origin.y - screen.frame.origin.y
        let availableScreenFrame = CGRect(
            x: screen.visibleFrame.origin.x,
            y: screen.visibleFrame.origin.y - dockHeight,
            width: screen.visibleFrame.size.width,
            height: screen.visibleFrame.size.height
        )

        window.rect = calculators[action]!.calculate(window: window, availableScreenFrame: availableScreenFrame)
    }

    func setupHotKeys() {
        MoveAction.allCases.forEach { action in
            _ = HotKey(
                carbonKeyCode: action.carbonKeyCode,
                carbonModifiers: UInt32(controlKey | optionKey)
            ) {
                self.execute(action: action)
            }
        }
    }
}
