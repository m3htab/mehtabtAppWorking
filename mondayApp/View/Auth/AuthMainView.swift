/*
  AuthMainView.swift
  
  Main View for when a user is not signed in
 
 
 
*/
import SwiftUI

struct AuthMainView: View {
    @State var showNav = true
    @State var selected : Int
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                if self.selected == 0{
                    GeometryReader{_ in
                        AuthHomeView()
                    }
                }
                else if self.selected == 1{
                    GeometryReader{_ in
                        AuthView()
                    }
                }
            }
            if(showNav) {NavBar(selected: self.$selected)}
        }
    }
}

struct NavBar : View {
    @Binding var selected : Int
    
    var body : some View{
        VStack{
            Spacer()
            HStack(alignment: .center){
                HStack(alignment: .bottom){
                    Button(action: {self.selected = 0}) {
                        if (self.selected == 0) {Image("homeActive").foregroundColor(.red)}
                        else {Image("home").foregroundColor(.gray)}
                    }.padding(.trailing, 20.0)
                    Button(action: {self.selected = 1}) {
                        if (self.selected == 1) {Image("userActive").foregroundColor(.blue)}
                        else {Image("user").foregroundColor(.gray)}
                    }
                }
                .padding(.vertical,15)
                .padding(.horizontal,35)
                .background(Color.black)
                .clipShape(Capsule())
                .padding(15)
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}
struct AuthMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuthMainView(selected: 0)
    }
}
