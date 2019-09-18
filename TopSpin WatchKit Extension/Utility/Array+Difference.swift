//
//  Array+Difference.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 9/2/19.
//

import Foundation

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
