//
//  MatchSetupHostingController.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/31/19.
//

import WatchKit
import Foundation
import SwiftUI

class MatchSetupHostingController: WKHostingController<MatchSetupView> {
    override var body: MatchSetupView {
        var setupView = MatchSetupView()
        
        setupView.onComplete = { settings in
            DispatchQueue.main.async {
                WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "ActiveMatch", context: settings as AnyObject),
                                                                                   (name: "MatchHistory", context: [] as AnyObject)])
            }
        }
        
        return setupView
    }
}
