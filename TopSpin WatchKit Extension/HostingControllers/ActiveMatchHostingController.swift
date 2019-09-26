//
//  ActiveMatchHostingController.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/24/19.
//

import WatchKit
import SwiftUI

class ActiveMatchHostingController: WKHostingController<ActiveGameView> {
    
    override var body: ActiveGameView {
        let active = ActiveGameView() {
            DispatchQueue.main.async {
                let viewNames = ["Settings", "Home", "MatchHistory"]
                WKInterfaceController.reloadRootPageControllers(withNames: viewNames, contexts: nil, orientation: .horizontal, pageIndex: 1)
            }
        }
        
        return active
    }
}
