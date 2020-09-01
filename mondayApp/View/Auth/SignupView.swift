//
//  SignupView.swift
//  theApp
//
//  Created by rob ord on 10/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI

struct SignupView: View {

    @ObservedObject var signupViewModel = SignupViewModel()
    

    
    var body: some View {
        VStack {
            SignupHeader()
            signupViewModel.image.resizable().aspectRatio(contentMode: .fill).frame(width: 100, height: 100)
                .clipShape(Circle())
                .onTapGesture {
                    print("Tapped")
                    self.signupViewModel.showImagePicker = true
            }
            NameTextField(firstName: $signupViewModel.firstName,lastName: $signupViewModel.lastName)
            EmailTextField(email: $signupViewModel.email)
            VStack(alignment: .leading) {
                PasswordTextField(password: $signupViewModel.password)
            }
            SignupButton(action: signUp, label: TEXT_SIGN_UP).alert(isPresented: $signupViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.signupViewModel.errorString), dismissButton: .default(Text("OK")))
            }
            Divider()
            Text(TEXT_SIGNUP_NOTE).font(.footnote).foregroundColor(.gray).padding().lineLimit(nil)
            Spacer()
        }.sheet(isPresented: $signupViewModel.showImagePicker) {
            // ImagePickerController()
            ImagePicker(showImagePicker: self.$signupViewModel.showImagePicker, pickedImage: self.$signupViewModel.image, imageData: self.$signupViewModel.imageData)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func signUp() {
        signupViewModel.signup(firstName: signupViewModel.firstName,lastName : signupViewModel.lastName, email: signupViewModel.email, password: signupViewModel.password, imageData: signupViewModel.imageData, completed: { (user) in
            self.clean()
            // Switch to the Main App
        }) { (errorMessage) in
            print("Error: \(errorMessage)")
            self.signupViewModel.showAlert = true
            self.signupViewModel.errorString = errorMessage
            self.clean()
        }
    }
    
    func clean() {
        self.signupViewModel.firstName = ""
        self.signupViewModel.lastName = ""
        self.signupViewModel.email = ""
        self.signupViewModel.password = ""
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}


