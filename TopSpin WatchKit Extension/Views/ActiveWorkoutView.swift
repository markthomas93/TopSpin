//
//  ActiveWorkoutView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/25/19.
//

import SwiftUI

struct ActiveWorkoutView: View {
    
    @ObservedObject var workoutManager: WorkoutManager

    var body: some View {
        VStack(alignment: .leading) {
            Text("00:11.09")
                .font(Font.system(.largeTitle, design: Font.Design.rounded))
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
            WorkoutHeartView(heartRate: $workoutManager.latestHeartRate)
        }
    }
}

struct WorkoutDataView: View {
    
    @Binding var energyBurned: Double
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Text("\(Int(energyBurned))")
                .font(.largeTitle)
            VStack(alignment: .leading, spacing: 0) {
                Text("Active".uppercased())
                .fontWeight(.semibold)
                Text("CAL")
                .fontWeight(.semibold)
            }
            .font(Font.system(.headline, design: Font.Design.rounded))
        }
    }
}

struct ActiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveWorkoutView(workoutManager: WorkoutManager())
    }
}
