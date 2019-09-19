//
//  MatchHistoryView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/26/19.
//

import SwiftUI

struct MatchHistoryView: View {
    
    @ObservedObject var matchHistoryWebService = MatchHistoryWebService()
    
    var body: some View {
        mainView
    }
    
    private var mainView: some View {
        VStack {
            if matchHistoryWebService.matches.isEmpty && matchHistoryWebService.isLoading {
                Text(Constants.Strings.MatchHistory.loadingMatchHistory)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            } else if matchHistoryWebService.matches.isEmpty {
                Text(Constants.Strings.MatchHistory.noMatchHistory)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.gray)
            } else if matchHistoryWebService.didFail {
                Text(Constants.Strings.MatchHistory.failed)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.gray)
            } else {
                List(matchHistoryWebService.matches.sorted(by: { $0.date > $1.date})) { match in //
                    NavigationLink(destination: MatchDetailView(match: match)) {
                        MatchHistoryListItem(match: match)
                    }
                }
            }
        }
        .onAppear(perform: matchHistoryWebService.fetch)
        .navigationBarTitle(Constants.Strings.MatchHistory.matchHistoryTitle)
    }
}

#if DEBUG

struct MatchHistoryView_Previews: PreviewProvider {
    
    static let mockGame = Match(score: Score(playerScore: 11,
                                             opponentScore: 8),
                                workout: WorkoutSession(maxHeartRate: 80))
    
    static var previews: some View {
        Group {
            MatchHistoryView()
        }
    }
}
#endif
