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
  @State var open = false
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
                  
                  SecondaryButton(open: $open, icon: "bubble.left.fill", color: "Blue", offsetY: -90)
                  SecondaryButton(open: $open, icon: "trash", color: "Blue", offsetX: -60, offsetY: -60, delay: 0.2)
                  SecondaryButton(open: $open, icon: "pencil", color: "Purple", offsetX: -90, delay: 0.4)
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
              .padding(.vertical,self.expand ? 5 : 5)
              .padding(.horizontal,self.expand ? 5 : 5)
              .background(Color.white)
              .clipShape(Capsule())
              .padding(30)
              .padding(.bottom,30)
              .edgesIgnoringSafeArea(.bottom)
          }
    }
}

struct SecondaryButton: View {
    @Binding var open: Bool
    var icon = "pencil"
    var color = "Blue"
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
    
    var body: some View {
        Button(action: {}) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.system(size: 16, weight: .bold))
        }
        .padding()
        .background(Color(color))
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1: 0)
        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
    }
}
