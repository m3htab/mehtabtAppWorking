//
//  MainView.swift
//  theApp
//
//  Created by rob ord on 10/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    @EnvironmentObject var appState: AppState
    @State var showNav = true
    @State var selected : Int
    
    var comeFrom : String

    var body: some View {
            ZStack(alignment: .bottom){
                VStack{
                    if self.selected == 0{
                        Home(showNav: $showNav).environmentObject(filterViewModel)
                    }
                    else if self.selected == 1{
                        GeometryReader{_ in
                            activityView().environmentObject(self.appState)
                        }
                    }
                    else if self.selected == 2{
                        GeometryReader{_ in
                            createView().environmentObject(self.appState)
                        }
                    }
                    else if self.selected == 3{
                        GeometryReader{_ in
                            LoggedInProfileView()
                        }
                    }
                    else if self.selected == 4{
                        GeometryReader{_ in
                            messagesView().environmentObject(self.appState)
                        }
                    }
                }
                if(showNav) {logginInNavBar(selected: self.$selected)}
            }
        
        }
}

struct logginInNavBar : View {
      
  @Binding var selected : Int
  @State var expand = true //can use this to change size of bar
      
  var body : some View{
          
      VStack{
          Spacer()
          HStack(alignment: .center){
              
              Spacer(minLength: 0)
              HStack(alignment: .bottom){
                  
                  Button(action: {self.selected = 0}) {
                      if (self.selected == 0) {Image("homeActive").foregroundColor(.red)}
                      else {Image("home").foregroundColor(.gray)}
                  }
                  Spacer(minLength: 15)
                  
                  Button(action: {self.selected = 1}) {
                      if (self.selected == 1) {Image("activityActive").foregroundColor(.blue)}
                      else {Image("activity").foregroundColor(.gray)}
                  }
                  Spacer(minLength: 15)
                      
                  Button(action: {self.selected = 2}) {
                      if (self.selected == 2) {Image("create").foregroundColor(.red)}
                      else {Image("create").foregroundColor(.gray)}
                  }
                  Spacer(minLength: 15)
                      
                  Button(action: {self.selected = 3}) {
                      if (self.selected == 3) {Image("userActive").foregroundColor(.blue)}
                      else {Image("user").foregroundColor(.gray)}
                  }
                  Spacer(minLength: 15)
                      
                  Button(action: {self.selected = 4}) {
                      if (self.selected == 4) {Image("messagesActive").foregroundColor(.blue)}
                      else {Image("messages").foregroundColor(.gray)}
                  }

              }
              .padding(.vertical,self.expand ? 20 : 8)
              .padding(.horizontal,self.expand ? 35 : 8)
              .background(Color.white)
              .clipShape(Capsule())
              .padding(22)
              .padding(.bottom,30)
          }
      }.edgesIgnoringSafeArea(.bottom)
          

      }
  }
