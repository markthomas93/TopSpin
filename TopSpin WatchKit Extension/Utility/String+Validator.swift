//
//  String+Validator.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/29/19.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return compareFormatsUsingPattern(emailRegex, userInput: self)
    }
    
    func compareFormatsUsingPattern(_ pattern: String, userInput: String) -> Bool {
        let compare = NSPredicate(format: "SELF MATCHES %@", pattern)
        return compare.evaluate(with: userInput)
    }

    func isValidPassword() -> Bool {
        return count >= 6
    }
}
