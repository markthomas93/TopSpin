//
//  ExtensionDelegate+Configuration.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/29/19.
//

import Foundation
import RocketWatch

extension ExtensionDelegate {
    
    func configureNetworkLayer() {
        guard let environment = NetworkEnvironment(rawValue: BundleUtil.buildEnvironment) else {
            print("Networking Layer could not be configured.")
            return
        }
        
        NetworkManager.setEnvironment(for: environment)
    }

}
