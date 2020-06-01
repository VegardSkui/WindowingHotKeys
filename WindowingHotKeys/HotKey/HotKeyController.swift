//
//  HotKeyController.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import Carbon

class HotKeyController {
    private struct HotKeyInfo {
        let hotKey: HotKey
        let carbonHotKeyId: UInt32
        let eventHotKeyRef: EventHotKeyRef? = nil
    }

    static private var hotKeyPressedSpec = EventTypeSpec(
        eventClass: OSType(kEventClassKeyboard),
        eventKind: UInt32(kEventHotKeyPressed)
    )

    static private let signature: FourCharCode = {
        var result: FourCharCode = 0
        for character in "WiHK".utf8 {
            result = (result << 8) | FourCharCode(character)
        }
        return result
    }()

    static private var eventHandlerRef: EventHandlerRef?

    static private var hotKeyCount: UInt32 = 0

    static private var hotKeys = [HotKeyInfo]()

    static func register(_ hotKey: HotKey) {
        let info = HotKeyInfo(hotKey: hotKey, carbonHotKeyId: hotKeyCount)
        hotKeys.append(info)
        hotKeyCount += 1

        var eventHotKeyRef: EventHotKeyRef?
        let hotKeyId = EventHotKeyID(signature: signature, id: info.carbonHotKeyId)
        let status = RegisterEventHotKey(
            hotKey.carbonKeyCode,
            hotKey.carbonModifiers,
            hotKeyId,
            GetEventDispatcherTarget(),
            0,
            &eventHotKeyRef
        )

        if status != noErr {
            fatalError("An error occured while registering a hot key")
        } else {
            print("Hot key registered")
        }
    }

    static func unregister(_ hotKey: HotKey) {
        guard let index = hotKeys.firstIndex(where: { info in
            return info.hotKey == hotKey
        }) else {
            fatalError("Cannot unregistered hot key which isn't registered")
        }

        let info = hotKeys[index]

        UnregisterEventHotKey(info.eventHotKeyRef)

        hotKeys.remove(at: index)
    }

    static func setupEventHandler() {
        let status = InstallEventHandler(
            GetEventDispatcherTarget(),
            hotKeyEventHandler,
            1,
            &hotKeyPressedSpec,
            nil,
            &eventHandlerRef
        )

        if status != noErr {
            fatalError("An error occured while installing the event handler")
        } else {
            print("Event handler installed")
        }
    }

    static func handleCarbonEvent(_ eventRef: EventRef?) -> OSStatus {
        guard let eventRef = eventRef else {
            return OSStatus(eventNotHandledErr)
        }

        var hotKeyId = EventHotKeyID()
        let status = GetEventParameter(
            eventRef,
            UInt32(kEventParamDirectObject),
            UInt32(typeEventHotKeyID),
            nil,
            MemoryLayout<EventHotKeyID>.size,
            nil,
            &hotKeyId
        )

        if status != noErr {
            fatalError("Could not get hot key id: \(status)")
        }

        guard hotKeyId.signature == signature else {
            return OSStatus(eventNotHandledErr)
        }

        guard let info = hotKeys.first(where: { info in
            info.carbonHotKeyId == hotKeyId.id
        }) else {
            fatalError("Hot key id not found")
        }

        info.hotKey.handler()
        
        return noErr
    }
}

private func hotKeyEventHandler(
    eventHandlerCallRef: EventHandlerCallRef?,
    eventRef: EventRef?,
    userData: UnsafeMutableRawPointer?
) -> OSStatus {
    return HotKeyController.handleCarbonEvent(eventRef)
}
