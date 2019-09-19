//
//  ActiveMatchScoreView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/20/19.
//

import SwiftUI
import RallyWatch

struct ActiveMatchScoreView: View {
    
    @Binding var servingTeam: RallyTeam
    @Binding var teamOneScore: Int
    @Binding var teamTwoScore: Int
    @Binding var teamHasGamePoint: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            if teamHasGamePoint {
                MatchPointView()
            }
            
            HStack {
                Circle()
                .frame(width: 5, height: 5)
                    .foregroundColor(servingTeam == .one ? .green : .clear)
                
                ScoreboardView(playerScore: $teamOneScore, opponentScore: $teamTwoScore)
                
                Circle()
                .frame(width: 5, height: 5)
                    .foregroundColor(servingTeam == .two ? .green : .clear)
            }
        }
    }
}

struct MatchPointView: View {
    var body: some View {
        Text(Constants.Strings.ActiveMatch.matchPoint.uppercased())
        .fontWeight(.bold)
        .font(.footnote)
        .padding(.vertical, 2)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 6)
        .background(Color.orange)
        .cornerRadius(4)
    }
}

struct ActiveMatchScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveMatchScoreView(servingTeam: .constant(.two),
                             teamOneScore: .constant(5),
                             teamTwoScore: .constant(5),
                             teamHasGamePoint: .constant(true))
    }
}
