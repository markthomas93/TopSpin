//
//  LandingHostingController.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/29/19.
//

import WatchKit
import SwiftUI

class LandingHostingController: WKHostingController<LandingView> {
    override var body: LandingView {
        LandingView()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if UserDefaultsManager.loggedInUser != nil {
            DispatchQueue.main.async {
                let viewNames = ["Settings", "Home", "MatchHistory"]
                WKInterfaceController.reloadRootPageControllers(withNames: viewNames, contexts: nil, orientation: .horizontal, pageIndex: 1)
            }
        }
    }
}
