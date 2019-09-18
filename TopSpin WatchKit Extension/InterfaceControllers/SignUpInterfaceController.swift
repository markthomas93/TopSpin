//
//  SignUpInterfaceController.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/31/19.
//

import WatchKit
import Foundation
import AuthenticationServices

class SignUpInterfaceController: WKInterfaceController {

    @IBOutlet weak var button: WKInterfaceAuthorizationAppleIDButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        UserDefaultsManager.userToken = nil
        
        if UserDefaultsManager.userToken != nil { // TODO
            WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "MatchSetup", context: [] as AnyObject),
                                                                               (name: "MatchHistory", context: [] as AnyObject)])
        }
    }

    @IBAction func buttonTapped() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}

extension SignUpInterfaceController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let name = credential.fullName?.givenName,
            let email = credential.email else {
            return
        }
        
        let user = UserSignUp(name: name, email: email, userCredential: credential.user)
        
        print(user)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
}
