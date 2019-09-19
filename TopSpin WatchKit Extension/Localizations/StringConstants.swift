//
//  StringConstants.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 9/19/19.
//

import Foundation

extension Constants {
    
    struct Strings {
        struct General {
            static var playerOne: String {
                return NSLocalizedString(LocalizationKeys.General.playerOne, comment: "Player One")
            }
            
            static var playerTwo: String {
                return NSLocalizedString(LocalizationKeys.General.playerTwo, comment: "")
            }
            
            static var opponent: String {
                return NSLocalizedString(LocalizationKeys.General.opponent, comment: "")
            }
            
            static var yes: String {
                return NSLocalizedString(LocalizationKeys.General.yes, comment: "")
            }
            
            static var no: String {
                return NSLocalizedString(LocalizationKeys.General.no, comment: "")
            }
            
            static var win: String {
                return NSLocalizedString(LocalizationKeys.General.win, comment: "")
            }
            
            static var lose: String {
                return NSLocalizedString(LocalizationKeys.General.lose, comment: "")
            }
            
            static var uhOhEmoji: String {
                return NSLocalizedString(LocalizationKeys.General.uhOhEmoji, comment: "")
            }
            
            static var okay: String {
                return NSLocalizedString(LocalizationKeys.General.okay, comment: "")
            }
        }
        
        struct ActiveMatch {
            static var endGame: String {
                return NSLocalizedString(LocalizationKeys.ActiveMatch.endGame, comment: "")
            }
            
            static var cancelMatchWarning: String {
                return NSLocalizedString(LocalizationKeys.ActiveMatch.cancelMatch, comment: "")
            }
            
            static var playAgain: String {
                return NSLocalizedString(LocalizationKeys.ActiveMatch.playAgain, comment: "")
            }
            
            static var goAgain: String {
                return NSLocalizedString(LocalizationKeys.ActiveMatch.goAgain, comment: "")
            }
            
            static var winner: String {
                return NSLocalizedString(LocalizationKeys.ActiveMatch.winner, comment: "")
            }
            
            static var ohNo: String {
                return NSLocalizedString(LocalizationKeys.ActiveMatch.ohNo, comment: "")
            }
            
            static var onYea: String {
                return NSLocalizedString(LocalizationKeys.ActiveMatch.ohYea, comment: "")
            }
            
            static var notThisTime: String {
                return NSLocalizedString(LocalizationKeys.ActiveMatch.notThisTime, comment: "")
            }
            
            static var matchPoint: String {
                return NSLocalizedString(LocalizationKeys.ActiveMatch.matchPoint, comment: "")
            }
        }
        
        struct MatchHistory {
            static var loadingMatchHistory: String {
                return NSLocalizedString(LocalizationKeys.MatchHistory.loading, comment: "")
            }
            
            static var noMatchHistory: String {
                return NSLocalizedString(LocalizationKeys.MatchHistory.noMatchHistory, comment: "")
            }
            
            static var failed: String {
                return NSLocalizedString(LocalizationKeys.MatchHistory.failed, comment: "")
            }
            
            static var matchHistoryTitle: String {
                return NSLocalizedString(LocalizationKeys.MatchHistory.title, comment: "")
            }
        }
        
        struct MatchSetup {
            static var winByTwo: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.winByTwo, comment: "")
            }
            
            static var numberOfPlayers: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.numberOfPlayers, comment: "")
            }
            
            static var numberTwo: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.number2, comment: "")
            }
            
            static var numberFour: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.number4, comment: "")
            }
            
            static var numberFive: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.number5, comment: "")
            }
            
            static var serveInterval: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.serveInterval, comment: "")
            }
            
            static var workout: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.workout, comment: "")
            }
            
            static var startGame: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.startGame, comment: "")
            }
            
            static var logOut: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.logOut, comment: "")
            }
            
            static var matchSetupTitle: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.title, comment: "")
            }
            
            static var scoreLimit: String {
                return NSLocalizedString(LocalizationKeys.MatchSetup.scoreLimit, comment: "")
            }
        }
        
        struct MatchHistoryDetail {
            static var finalScore: String {
                return NSLocalizedString(LocalizationKeys.MatchHistoryDetail.finalScore, comment: "")
            }
            
            static var winner: String {
                return NSLocalizedString(LocalizationKeys.MatchHistoryDetail.winner, comment: "")
            }
            
            static var maxHeartRate: String {
                return NSLocalizedString(LocalizationKeys.MatchHistoryDetail.maxHeartRate, comment: "")
            }
            
            static var matchDetailTitle: String {
                return NSLocalizedString(LocalizationKeys.MatchHistoryDetail.title, comment: "")
            }
        }
    }
}
