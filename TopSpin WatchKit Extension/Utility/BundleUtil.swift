//
//  BundleUtil.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/29/19.
//

import Foundation

class BundleUtil {
    
    static var buildEnvironment: Int {
        guard let buildModeString = Bundle.main.infoDictionary!["BUILD_ENVIRONMENT"] as? String,
            let buildMode = Int(buildModeString) else {
                fatalError()
        }
        
        return buildMode
    }
    
}
