//
//  ActiveMatchHostingController.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/24/19.
//

import WatchKit
import Foundation
import SwiftUI

class ActiveMatchHostingController: WKHostingController<ActiveGameView> {
    
    private var settings: MatchSetting!
    
    override var body: ActiveGameView {
        var active = ActiveGameView(settings: settings)
        
        active.onEndGame = {
            DispatchQueue.main.async {
                WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "MatchSetup", context: [] as AnyObject)])
            }
        }
        
        return active
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let settings = context as? MatchSetting else {
            return
        }
        
        self.settings = settings
    }
}
