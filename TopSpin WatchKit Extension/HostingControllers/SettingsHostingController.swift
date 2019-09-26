//
//  SettingsHostingController.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 9/24/19.
//

import WatchKit
import SwiftUI

class SettingsHostingController: WKHostingController<SettingsView> {
    override var body: SettingsView {
        SettingsView(isProUser: true)
    }
}
