//
//  ContentView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/24/19.
//

import SwiftUI
import Combine
import RallyWatch

struct ActiveGameView: View {
        
    // MARK: - Bindings
    
    @ObservedObject var workoutManager: WorkoutManager
    @ObservedObject private var controller: RallyMatchController
    @State private var didTapEndGame: Bool = false

    // MARK: - Properties
    
    private var dataManager = SaveMatchDataManager()
    private var onEndGame: (() -> Void)?
    private var startWorkout: Bool
    
    var body: some View {
        activeGameView()
    }
    
    // MARK: - Initializer
    
    init(settings: MatchSetting, workoutManager: WorkoutManager, onEndGame: (() -> Void)?) {
        self.controller = RallyMatchController(settings: settings)
        self.workoutManager = workoutManager
        self.onEndGame = onEndGame
        self.startWorkout = settings.startWorkout
        
        if settings.startWorkout {
            workoutManager.startWorkoutSession()
        }
    }
    
    // MARK: - Private Methods
    
    private func activeGameView() -> some View {
        ScrollView {
            VStack(spacing: 5) {
                ActiveMatchScoreView(servingTeam: $controller.servingTeam,
                                     teamOneScore: $controller.teamOneScore,
                                     teamTwoScore: $controller.teamTwoScore,
                                     teamHasGamePoint: $controller.teamHasGamePoint)
                
                if startWorkout {
                    WorkoutHeartView(heartRate: $workoutManager.latestHeartRate)
                }
                
                VStack(spacing: 10) {
                    Button(action: {
                        self.controller.teamOneScore += 1
                    }) {
                        Text("Player 1") // Or user name
                        .font(.headline)
                    }
                    Button(action: {
                        self.controller.teamTwoScore += 1
                    }) {
                        Text("Player 2")
                        .font(.body)
                    }
                }
                Button(action: {
                    self.didTapEndGame.toggle()
                }) {
                    Text("End Game")
                    .font(.body)
                }
                .accentColor(.red)
                .padding(.top, 20)
                .alert(isPresented: $didTapEndGame) {
                    Alert(title: Text("Are you sure you want to cancel this game?"),
                          primaryButton: .destructive(Text("Yes"), action: self.endMatch),
                          secondaryButton: .cancel(Text("No")))
                }
            }
        }
        .alert(isPresented: $controller.teamDidWin) {            
            let winningTeam = controller.winningTeam
            let messageText = winningTeam == .one ? "Play again?" : "Go again?"
            
            return Alert(title: Text(winningTeam == .one ? "Winner!" : "Oh no!"),
                         message: Text(messageText),
                         primaryButton: .cancel(Text("Oh yea!"), action: {
                            self.saveMatch()
                            self.controller.setNewGame()
                         }),
                         secondaryButton: .default(Text("Not this time"), action: {
                            self.saveMatch()
                            self.endMatch()
                         }))
        }
    }
    
    private func saveMatch() {
        let match = Match(score: Score(playerScore: controller.teamOneScore,
                                       opponentScore: controller.teamTwoScore),
                          workout: workoutManager.getCurrentWorkoutSession())
        
        dataManager.save(match)
    }
    
    private func endMatch() {
        workoutManager.completeWorkout()
        onEndGame?()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActiveGameView(settings: MatchSetting(limit: 11, winByTwo: true, numberOfPlayers: 2, serveInterval: 2, startWorkout: false),
                           workoutManager: WorkoutManager(),
                           onEndGame: {
                print("End")
            })
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 3 - 38mm"))
        }
    }
}
#endif
