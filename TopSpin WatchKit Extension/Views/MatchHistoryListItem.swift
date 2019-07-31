//
//  MatchHistoryListItem.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/30/19.
//

import SwiftUI

struct MatchHistoryListItem: View {
    let match: Match
    
    var teamOneWinner: Bool {
        return match.score.winner == match.teamOne
    }
    
    var body: some View {
        HStack {
            Text(teamOneWinner ? "W" : "L")
            .foregroundColor(teamOneWinner ? .green : .red)
            .font(Font.system(.largeTitle, design: Font.Design.rounded))
            .padding(5)
            Text("\(match.score.teamOneScore) - \(match.score.teamTwoScore)")
            .font(Font.system(.largeTitle, design: Font.Design.rounded))
        }
    }
}

#if DEBUG
struct MatchHistoryListItem_Previews: PreviewProvider {
    static var previews: some View {
        MatchHistoryListItem(match: MatchHistoryView_Previews.mockGame)
        .previewLayout(.fixed(width: 200, height: 70))

    }
}
#endif
