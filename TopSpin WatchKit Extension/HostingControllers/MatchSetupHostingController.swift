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
        
        setupView.onComplete = { [weak self] settings in
            
            DispatchQueue.main.async {
                self?.showActiveView(with: settings, workoutManager: WorkoutManager())
            }
        }
        
        return setupView
    }
    
    private func showActiveView(with settings: MatchSetting, workoutManager: WorkoutManager) {
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "ActiveMatch",
                                                                            context: (settings, workoutManager) as AnyObject)])
    }
}
