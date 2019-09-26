//
//  LocalizationKeys.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 9/19/19.
//

import Foundation

struct LocalizationKeys {
    
    struct General {
        static let playerOne = "player.one"
        static let playerTwo = "player.two"
        static let opponent = "opponent"
        static let yes = "yes"
        static let no = "no"
        static let win = "win"
        static let lose = "lose"
        static let uhOhEmoji = "uh.oh.emoji.sweatdrop"
        static let okay = "okay"
    }
    
    struct ActiveMatch {
        static let endGame = "end.game"
        static let cancelMatch = "cancel.match.warning"
        static let playAgain = "play.again"
        static let goAgain = "go.again"
        static let winner = "winner"
        static let ohNo = "oh.no"
        static let ohYea = "oh.yea"
        static let notThisTime = "not.this.time"
        static let matchPoint = "match.point"
    }
    
    struct MatchHistory {
        static let loading = "match.history.loading"
        static let noMatchHistory = "no.match.history"
        static let failed = "match.history.failed"
        static let title = "match.history.title"
    }
    
    struct MatchSetup {
        static let winByTwo = "win.by.two"
        static let numberOfPlayers = "number.of.players"
        static let number2 = "2"
        static let number4 = "4"
        static let number5 = "5"
        static let serveInterval = "serve.interval"
        static let workout = "workout"
        static let save = "save"
        static let logOut = "log.out"
        static let scoreLimit = "score.limit"
        static let title = "match.setup.title"
    }
    
    struct MatchHistoryDetail {
        static let finalScore = "final.score"
        static let winner = "winner"
        static let maxHeartRate = "max.heart.rate"
        static let title = "match.history.detail.title"
    }
}

