//
//  MoveAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Foundation

protocol MoveAction {
    static var carbonKeyCode: UInt32 { get }
    static var carbonModifiers: UInt32 { get }

    static func execute()
}

extension MoveAction {
    static func setupHotKey() {
        _ = HotKey(
            carbonKeyCode: carbonKeyCode,
            carbonModifiers: carbonModifiers,
            handler: execute
        )
    }
}
