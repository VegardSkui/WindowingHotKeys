//
//  MoveAction.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon

enum MoveAction: CaseIterable {
    case topHalf
    case rightHalf
    case bottomHalf
    case leftHalf

    case topRightQuarter
    case bottomRightQuarter
    case bottomLeftQuarter
    case topLeftQuarter

    case maximize
    case center
    case restore

    var carbonKeyCode: UInt32 {
        switch self {
            case .topHalf: return UInt32(kVK_UpArrow)
            case .rightHalf: return UInt32(kVK_RightArrow)
            case .bottomHalf: return UInt32(kVK_DownArrow)
            case .leftHalf: return UInt32(kVK_LeftArrow)

            case .topRightQuarter: return UInt32(kVK_ANSI_I)
            case .bottomRightQuarter: return UInt32(kVK_ANSI_K)
            case .bottomLeftQuarter: return UInt32(kVK_ANSI_J)
            case .topLeftQuarter: return UInt32(kVK_ANSI_U)

            case .maximize: return UInt32(kVK_Return)
            case .center: return UInt32(kVK_ANSI_C)
            case .restore: return UInt32(kVK_Delete)
        }
    }
}
