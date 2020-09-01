//
//  ContentView.swift
//  theApp
//
//  Created by rob ord on 10/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI
import Foundation

struct InitialView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var filterViewModel: FilterViewModel
    func listen() {
        session.listenAuthenticationState()
    }
    
    var body: some View {
        //set screen size
        ZStack{
        GeometryReader { geo in
            Color.clear
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    self.appState.safeArea = (geo.safeAreaInsets.top, geo.safeAreaInsets.bottom)
                    self.appState.size =
                        (geo.size.height, geo.size.width)
            }
        }
        
        
        
        Group {
            if session.isLoggedIn {
                
                MainView(selected:0, comeFrom: "start").environmentObject(self.appState).environmentObject(self.homeViewModel).environmentObject(filterViewModel).environmentObject(self.session)
            } else {
                AuthMainView(selected: 0)
            }

        }.onAppear(perform: listen)
        }.background(Color.black).edgesIgnoringSafeArea(.all)
    }
}
