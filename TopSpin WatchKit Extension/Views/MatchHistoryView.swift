//
//  MatchHistoryView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/26/19.
//

import SwiftUI

struct MatchHistoryView: View {
    let matches: [Match]
    
    var body: some View {
        List(matches) { match in
            MatchHistoryListItem(match: match)
        }
        .navigationBarTitle(Text("Match History"))
    }
}

#if DEBUG
struct MatchHistoryView_Previews: PreviewProvider {
    
    static let mockGame = Match(id: 0, settings: MatchSetting(limit: 21,
                                                    winByTwo: true,
                                                    numberOfPlayers: 2,
                                                    serveInterval: 5),
                                teamOne: Team(players: [Player(name: "Bill")]),
                                teamTwo: Team(players: [Player(name: "Doug")]),
                                score: Score(teamOneScore: 11,
                                             teamTwoScore: 8,
                                             teamOne: Team(players: [Player(name: "Bill")]),
                                             teamTwo: Team(players: [Player(name: "Doug")])))
    
    static var previews: some View {
        MatchHistoryView(matches: [MatchHistoryView_Previews.mockGame, MatchHistoryView_Previews.mockGame, MatchHistoryView_Previews.mockGame, MatchHistoryView_Previews.mockGame])
    }
}
#endif
