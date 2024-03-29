//
//  ContentView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/24/19.
//

import SwiftUI

struct ActiveGameView: View {
    
    @State private var playerOneScore: Int = 0
    @State private var playerTwoScore: Int = 0
    @State private var playerOneServing: Bool = true
    @State private var playerTwoServing: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    if playerOneServing {
                        Circle()
                        .fill(Color.blue)
                        .frame(width: 5, height: 5)
                    }
                    
                    Text("\(playerOneScore) - \(playerTwoScore)")
                    .font(Font.system(.largeTitle, design: Font.Design.rounded))
                    
                    if playerTwoServing {
                        Circle()
                        .fill(Color.blue)
                        .frame(width: 5, height: 5)
                    }
                }
                Button(action: {
                    self.playerOneScore += 1
                    self.checkServeToggle()
                }) {
                    Text("Player 1") // Or user name
                    .font(.headline)
                }
                Button(action: {
                    self.playerTwoScore += 1
                    self.checkServeToggle()
                }) {
                    Text("Player 2")
                    .font(.body)
                }
                Button(action: {
                    self.playerOneScore = 0
                    self.playerTwoScore = 0
                }) {
                    Text("End Game")
                    .font(.body)
                }
                .accentColor(.red)
                .padding(.top, 20)
            }
        }
    }
    
    // MARK: - Logic
    
    func checkServeToggle() {
        if self.playerOneScore + self.playerTwoScore % 2 == 0 {
            self.playerOneServing.toggle()
            self.playerTwoServing.toggle()
            print(playerOneServing)
            print(playerTwoServing)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActiveGameView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm"))
            ActiveGameView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 40mm"))
        }
    }
}
#endif
