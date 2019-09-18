//
//  MatchDetailView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/6/19.
//

import SwiftUI

struct MatchDetailView: View {
    
    var match: Match
    
    private var userDidWin: Bool {
        return match.score.playerScore > match.score.opponentScore
    }
    
    private var winningTeamName: String {
        return userDidWin ? "Player One" : "Opponent"
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Final Score:")
                    .font(.headline)
                ScoreboardView(playerScore: .constant(match.score.playerScore), opponentScore: .constant(match.score.opponentScore))
                
                Text("Winner:")
                    .font(.subheadline)
                
                Text(winningTeamName)
                    .font(.title)
                Text(userDidWin ? "🎉" : "😭")
                    .font(.title)
                
                if match.workout?.maxHeartRate != nil && match.workout?.maxHeartRate != 0 {
                    VStack(spacing: 4) {
                        Text("Max Heart Rate:")
                        WorkoutHeartView(heartRate: .constant(match.workout!.maxHeartRate))
                    }.padding(.top, 4)
                }
            }
        }
        .navigationBarTitle(match.formattedDate ?? "Match Detail")
    }
}

#if DEBUG
struct MatchDetailView_Previews: PreviewProvider {
    static let mockGame = Match(score: Score(playerScore: 11,
                                             opponentScore: 13),
                                workout: WorkoutSession(maxHeartRate: 80))
    
    static var previews: some View {
        MatchDetailView(match: MatchDetailView_Previews.mockGame)
    }
}
#endif
