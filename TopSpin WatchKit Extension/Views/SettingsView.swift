//
//  SettingsView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 9/24/19.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    let isProUser: Bool
    
    // MARK: - State
    
    @State private var showMatchSetup = false
    @State private var willLogout = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center) {
                    Spacer()
                    ZStack {
                        Circle()
                        .fill(Color.blue)
                        .frame(width: 40, height: 40)
                        Text("W")
                        .bold()
                    }
                    Spacer()
                }
                
                if isProUser {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Premium ⭐️")
                        Spacer()
                    }
                }
                
                Group {
                    if !isProUser {
                        NavigationLink(destination: Text("hello")) {
                           SettingsItem(title: "Premium 🏓")
                        }
                    }
                    
                    NavigationLink(destination: MatchSettingsView(showMatchSetup: $showMatchSetup), isActive: $showMatchSetup) {
                       SettingsItem(title: "Match Setup")
                    }
                    
                    NavigationLink(destination: Text("hello")) {
                       SettingsItem(title: "Account Info")
                    }
                }
            
                Button(action: {
                    self.willLogout.toggle()
                }) {
                    Text("Log Out")
                    .font(.body)
                }
                .accentColor(.red)
                .cornerRadius(4)
            }
            .alert(isPresented: $willLogout) {
                Alert(title: Text("Are you sure you want to logout?"),
                      primaryButton: .destructive(Text(Constants.Strings.General.yes), action: self.logout),
                      secondaryButton: .cancel(Text(Constants.Strings.General.no)))
            }
        }
        .navigationBarTitle("Settings")
    }
    
    // MARK: - Private Methods
    
    private func logout() {
        UserDefaultsManager.clear()
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "LandingView", context: [] as AnyObject)])
    }
}

struct SettingsItem: View {
    
    let title: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                .font(.system(.body, design: .rounded))
                Spacer()
                Image(systemName: "chevron.right")
                .font(.caption)
                .opacity(0.5)
            }
        }
        .padding(.vertical, 12)
        .cornerRadius(4)
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView(isProUser: true)
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 5 - 44mm"))

            SettingsView(isProUser: false)
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 3 - 38mm"))

        }
    }
}
#endif
