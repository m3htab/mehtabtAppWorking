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
    @State var open = false

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
  @State var open = false
  @Binding var selected : Int
  @State var expand = true //can use this to change size of bar
      
  var body : some View{
          
      VStack{
          Spacer()
          HStack(alignment: .center){
              
              Spacer(minLength: 15)
              HStack(alignment: .bottom){
                  
                  Button(action: {self.selected = 0}) {
                      if (self.selected == 0) {Image("homeActive").foregroundColor(.red)}
                      else {Image("home").foregroundColor(.gray)}
                  }
                  Spacer(minLength: 15)
                  
                  Button(action: {self.selected = 1}) {
                      if (self.selected == 1) {Image("activityActive").foregroundColor(.red)}
                      else {Image("activity").foregroundColor(.gray)}
                  }
                  Spacer(minLength: 15)
                    
                
                
                
                
                
                
                  Button(action: {self.open.toggle()}) {
                      Image(systemName: "plus")
                       

                    .rotationEffect(.degrees(open ? 45 : 0))
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
                    }
                    .padding(15)
                    .background(Color.red)
                    .mask(Circle())
                    .shadow(color: Color.red, radius: 1)
                    .zIndex(1)


    
                
                
                
                
                  Spacer(minLength: 15)
                      
                  Button(action: {self.selected = 3}) {
                      if (self.selected == 3) {Image("userActive").foregroundColor(.red)}
                      else {Image("user").foregroundColor(.gray)}
                  }
                  Spacer(minLength: 15)
                      
                  Button(action: {self.selected = 4}) {
                      if (self.selected == 4) {Image("messagesActive").foregroundColor(.red)}
                      else {Image("messages").foregroundColor(.gray)}
                  }

              }
              .padding(.vertical,self.expand ? 7 : 8)
              .padding(.horizontal,self.expand ? 7: 8)
              .background(Color.white)
              .clipShape(Capsule())
              .padding(20)
              .padding(.bottom,30)
              
              }
          }.edgesIgnoringSafeArea(.bottom)
            
        }
    }
