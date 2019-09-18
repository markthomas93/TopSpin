//
//  ActiveWorkoutHostingController.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/25/19.
//

import WatchKit
import SwiftUI

class ActiveWorkoutHostingController: WKHostingController<ActiveWorkoutView> {
    
    private var workoutManager: WorkoutManager!
    
    override var body: ActiveWorkoutView {
        ActiveWorkoutView(workoutManager: workoutManager)
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let manager = context as? WorkoutManager else {
            return
        }
        
        workoutManager = manager
    }
}
