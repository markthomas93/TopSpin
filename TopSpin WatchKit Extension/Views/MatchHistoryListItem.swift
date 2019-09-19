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
        return match.score.playerScore > match.score.opponentScore
    }
    
    var gameResult: String {
        teamOneWinner ? Constants.Strings.General.win : Constants.Strings.General.lose
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if match.formattedDate != nil {
                Text(match.formattedDate!.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Text("\(match.score.playerScore) - \(match.score.opponentScore)")
                    .font(Font.system(.largeTitle, design: Font.Design.rounded))
                
            Text(gameResult.uppercased())
                .font(Font.system(.caption, design: Font.Design.rounded))
                .fontWeight(.bold)
                .foregroundColor(teamOneWinner ? .green : .red)
        }
        .padding(.vertical)
    }
}

#if DEBUG
struct MatchHistoryListItem_Previews: PreviewProvider {
    static var previews: some View {
        MatchHistoryListItem(match: MatchHistoryView_Previews.mockGame)
        .previewLayout(.fixed(width: 200, height: 80))

    }
}
#endif
