//
//  RequestAccessibilityTrustView.swift
//  WindowingHotKeys
//
//  Created by Vegard Skui on 01/06/2020.
//  Copyright © 2020 Vegard Skui. All rights reserved.
//

import SwiftUI

struct RequestAccessibilityPrivilegesView: View {
    var body: some View {
        VStack {
            Text("This application requires accessibility privileges to function properly")
            Button(action: {
                NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")!)
            }) {
                Text("Open System Preferences")
            }
        }
    }
}

struct RequestAccessibilityPrivilegesView_Previews: PreviewProvider {
    static var previews: some View {
        RequestAccessibilityPrivilegesView()
    }
}
