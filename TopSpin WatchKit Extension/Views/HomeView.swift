//
//  HomeView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 9/24/19.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var dataManager: HomeDataManager = HomeDataManager()
    
    var body: some View {
        LoadingView(isShowing: $dataManager.loading) {
            self.homeView()
        }.alert(isPresented: $dataManager.didError) {
            Alert(title: Text(Constants.Strings.General.uhOhEmoji),
                  message: Text(dataManager.errorMessage ?? ""),
                  dismissButton: .cancel(Text(Constants.Strings.General.okay)))
        }
    }
    
    // MARK: - Private Methods
    
    private func homeView() -> some View {
        VStack(alignment: .leading) {
            Text("17 Games Played")
            Text("500 kCal Burned")
            Text("Avg Heart Rate 85 bpm")
            Spacer()
            HStack {
                Button(action: startSeries) {
                    HStack {
                        Text("Start Series")
                        .font(.system(.headline, design: .rounded))
                    }
                }
                .accentColor(.gray)
                
                Button(action: startMatch) {
                    HStack {
                        Text("Start Match")
                        .font(.system(.headline, design: .rounded))
                    }
                }
                .accentColor(.green)
            }
        }
        .navigationBarTitle("🏓 Top Spin")
        .onAppear(perform: dataManager.getMatchSettings)
    }
    
    private func startMatch() {
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [
            (name: "ActiveMatch",
             context: "" as AnyObject)
        ])
    }
    
    private func startSeries() {
        
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
