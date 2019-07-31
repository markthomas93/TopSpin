//
//  MatchHistoryHostingController.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/31/19.
//

import WatchKit
import Foundation
import SwiftUI

class MatchHistoryHostingController: WKHostingController<MatchHistoryView> {
    override var body: MatchHistoryView {
        return MatchHistoryView(matches: [MatchHistoryView_Previews.mockGame, MatchHistoryView_Previews.mockGame, MatchHistoryView_Previews.mockGame, MatchHistoryView_Previews.mockGame])
    }
}
