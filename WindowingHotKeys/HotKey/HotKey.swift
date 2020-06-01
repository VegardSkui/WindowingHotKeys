//
//  HotKey.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Foundation

class HotKey {
    let identifier = UUID()

    let carbonKeyCode: UInt32
    let carbonModifiers: UInt32

    let handler: () -> Void

    init(carbonKeyCode: UInt32, carbonModifiers: UInt32, handler: @escaping () -> Void) {
        self.carbonKeyCode = carbonKeyCode
        self.carbonModifiers = carbonModifiers
        self.handler = handler

        HotKeyController.register(self)
    }

    deinit {
        HotKeyController.unregister(self)
    }
}

extension HotKey: Equatable {
    static func ==(lhs: HotKey, rhs: HotKey) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
