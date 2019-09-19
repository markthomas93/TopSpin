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
        return userDidWin ? Constants.Strings.General.playerOne : Constants.Strings.General.opponent
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(Constants.Strings.MatchHistoryDetail.finalScore)
                    .font(.headline)
                ScoreboardView(playerScore: .constant(match.score.playerScore), opponentScore: .constant(match.score.opponentScore))
                
                Text(Constants.Strings.MatchHistoryDetail.winner)
                    .font(.subheadline)
                
                Text(winningTeamName)
                    .font(.title)
                Text(userDidWin ? "🎉" : "😭")
                    .font(.title)
                
                if match.workout?.maxHeartRate != nil && match.workout?.maxHeartRate != 0 {
                    VStack(spacing: 4) {
                        Text(Constants.Strings.MatchHistoryDetail.maxHeartRate)
                        WorkoutHeartView(heartRate: .constant(match.workout!.maxHeartRate))
                    }.padding(.top, 4)
                }
            }
        }
        .navigationBarTitle(match.formattedDate ?? Constants.Strings.MatchHistoryDetail.matchDetailTitle)
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
