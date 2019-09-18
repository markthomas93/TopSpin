//
//  ActiveMatchHostingController.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/24/19.
//

import WatchKit
import SwiftUI

class ActiveMatchHostingController: WKHostingController<ActiveGameView> {
    
    // MARK: - Properties
    
    private var workoutManager: WorkoutManager!
    private var matchSettings: MatchSetting!
    
    // MARK: - Body
    
    override var body: ActiveGameView {
        let active = ActiveGameView(settings: matchSettings, workoutManager: workoutManager) {
            
            DispatchQueue.main.async {
                WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "MatchSetup", context: [] as AnyObject),
                                                                                   (name: "MatchHistory", context: [] as AnyObject)])
            }
        }
        
        return active
    }
    
    // MARK: - Awake
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let context = context as? (settings: MatchSetting, workoutManager: WorkoutManager?) else {
            return
        }
        
        workoutManager = context.workoutManager
        matchSettings = context.settings
    }
}
