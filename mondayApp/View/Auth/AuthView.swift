/*
  AuthView.swift
  
  View For User Authentication
 
 
 
*/

import SwiftUI

struct AuthView: View {
    var body: some View {
        
        VStack{
            NavigationView{
                VStack{
                    Spacer()
                    Group(){
                        NavigationLink(destination: SigninView()){
                            SigninViewButtonView()
                        }
                        NavigationLink(destination: SignupView()){
                            SignupViewButtonView()
                        }
                    }.padding(.top, -8)
                }
            }
        }.edgesIgnoringSafeArea(.all).padding(.bottom,40)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

