//
//  ScoreboardView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/22/19.
//

import SwiftUI

struct ScoreboardView: View {
    
    @Binding var playerScore: Int
    @Binding var opponentScore: Int
    
    var body: some View {
        HStack {
            Text("\(playerScore)")
            Text("-")
            Text("\(opponentScore)")
        }
        .font(.system(.title, design: .rounded))
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView(playerScore: .constant(5), opponentScore: .constant(4))
    }
}
