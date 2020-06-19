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

    private var lastUserPositionedRect = [Int: CGRect]()
    private var lastAppPositionedRect = [Int: CGRect]()

    func execute(action: MoveAction) {
        guard let window = AccessibilityWindow.frontmost() else { return }
        guard let screen = NSScreen.main else { return }

        if action == .restore {
            restore(window: window)
            return
        }

        // Update the last user positioned rect entry if the current rect is not
        // equal to the last app positioned rect
        // Note that the force unwrap is safe since the if-statement would
        // short-circuit if the identifier is not present in the dictionary
        if let identifier = window.identifier,
            !lastAppPositionedRect.keys.contains(identifier)
            || !window.rect.equalTo(lastAppPositionedRect[identifier]!) {
            lastUserPositionedRect[identifier] = window.rect
        }

        // Calculate the screen frame available to the application, this is the
        // whole screen minus the space used by the menu bar and dock
        let dockHeight = screen.visibleFrame.origin.y - screen.frame.origin.y
        let availableScreenFrame = CGRect(
            x: screen.visibleFrame.origin.x,
            y: screen.visibleFrame.origin.y - dockHeight,
            width: screen.visibleFrame.size.width,
            height: screen.visibleFrame.size.height
        )

        // Calculate the new window rect and move
        window.rect = calculators[action]!.calculate(
            window: window,
            availableScreenFrame: availableScreenFrame
        )

        // Update the last app positioned rect entry
        if let identifier = window.identifier {
            lastAppPositionedRect[identifier] = window.rect
        }
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

    private func restore(window: AccessibilityWindow) {
        guard let identifier = window.identifier else { return }
        guard let lastUserPositionedRect = lastUserPositionedRect[identifier] else { return }

        window.rect = lastUserPositionedRect
    }
}
