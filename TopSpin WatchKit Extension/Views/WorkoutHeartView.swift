//
//  WorkoutHeartView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/27/19.
//

import SwiftUI

struct WorkoutHeartView: View {
    
    @Binding var heartRate: Double
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "heart")
                .font(.caption)
                .foregroundColor(.red)
            Text("\(Int(heartRate)) bpm")
                .font(Font.system(.caption, design: Font.Design.rounded))
                .foregroundColor(heartRate == 0 ? .secondary : .white)
        }
    }
}
struct WorkoutHeartView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHeartView(heartRate: .constant(90))
    }
}
