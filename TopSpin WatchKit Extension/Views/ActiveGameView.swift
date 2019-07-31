//
//  ContentView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/24/19.
//

import SwiftUI

struct ActiveGameView: View {
    let settings: MatchSetting
    
    @State private var playerOneScore: Int = 0
    @State private var playerTwoScore: Int = 0
    @State private var playerOneServing: Bool = true
    @State private var playerTwoServing: Bool = false

    var onEndGame: (() -> Void)?
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(playerOneServing ? .green : .clear)
                    
                    Text("\(playerOneScore) - \(playerTwoScore)")
                    .font(Font.system(.largeTitle, design: Font.Design.rounded))
                    
                    Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(playerTwoServing ? .green : .clear)
                }
                Button(action: {
                    self.playerOneScore += 1
                }) {
                    Text("Player 1") // Or user name
                    .font(.headline)
                }
                Button(action: {
                    self.playerTwoScore += 1
                }) {
                    Text("Player 2")
                    .font(.body)
                }
                Button(action: {
                    self.onEndGame?()
                }) {
                    Text("End Game")
                    .font(.body)
                }
                .accentColor(.red)
                .padding(.top, 20)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActiveGameView(settings: MatchSetting(limit: 21, winByTwo: true, numberOfPlayers: 2, serveInterval: 5))
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm"))
        }
    }
}
#endif
