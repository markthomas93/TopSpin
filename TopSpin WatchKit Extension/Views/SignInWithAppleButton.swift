//
//  SwiftUIView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 9/14/19.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: WKInterfaceObjectRepresentable {
    
    @Binding var user: UserSignUp?
    
    typealias WKInterfaceObjectRepresentable = WKInterfaceObjectRepresentableContext<SignInWithAppleButton>

    func updateWKInterfaceObject(_ wkInterfaceObject: WKInterfaceAuthorizationAppleIDButton, context: WKInterfaceObjectRepresentableContext<SignInWithAppleButton>) {
        // No code required
    }

    class Coordinator: NSObject, ASAuthorizationControllerDelegate {

        let parent: SignInWithAppleButton

        init(_ parent: SignInWithAppleButton) {
          self.parent = parent
          
          super.init()
        }
        
        @objc func buttonPressed() {
            #if DEBUG
            parent.user = UserSignUp(name: "Will", email: "testuser0001@example.com", userCredential: "00000001")
            #else
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
            #endif
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                return
            }
            
            let user = UserSignUp(name: credential.fullName?.givenName, email: credential.email, userCredential: credential.user)
            
            print(user)
            parent.user = user
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print(error.localizedDescription)
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeWKInterfaceObject(context: WKInterfaceObjectRepresentableContext<SignInWithAppleButton>) -> WKInterfaceAuthorizationAppleIDButton {
        return WKInterfaceAuthorizationAppleIDButton(target: context.coordinator, action: #selector(Coordinator.buttonPressed))
    }
}
