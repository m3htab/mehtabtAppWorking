//
//  SigninView.swift
//  theApp
//
//  Created by rob ord on 10/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI

struct SigninView: View {
        
    @ObservedObject var signinViewModel = SigninViewModel()
          

        
    var body: some View {
        VStack {
            SigninHeader().padding()
            EmailTextField(email: $signinViewModel.email)
            PasswordTextField(password: $signinViewModel.password)
            SigninButton(action: signIn, label: TEXT_SIGN_IN).alert(isPresented: $signinViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.signinViewModel.errorString), dismissButton: .default(Text("OK")))
                   }.padding(.top,10)
            Spacer()
        }.navigationBarBackButtonHidden(true)
    }
    
    
    
    
    func signIn() {
        
        signinViewModel.signin(email: signinViewModel.email, password: signinViewModel.password, completed: { (user) in
            print("login: \(user.email ?? "couldnt get email")")
            self.clean()
            }) { (errorMessage) in
                print("Error: \(errorMessage)")
                self.signinViewModel.showAlert = true
                self.signinViewModel.errorString = errorMessage
                self.clean()
            }
    }
          
    func clean() {
        self.signinViewModel.email = ""
        self.signinViewModel.password = ""
    }
    
}


struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
