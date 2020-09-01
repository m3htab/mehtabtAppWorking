/*
  SignupViewModel.swift
  
  View Model for signup screen
 
 
 
*/

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class SignupViewModel: ObservableObject {
    
     var firstName: String = ""
     var lastName: String = ""
     var email: String = ""
     var password: String = ""
     var image: Image = Image(IMAGE_USER_PLACEHOLDER)
     var imageData: Data = Data()
     var errorString = ""
     @Published var showImagePicker: Bool = false
     @Published var showAlert: Bool = false
    
    //method to create a new user
    func signup(firstName: String, lastName:String, email: String, password: String, imageData: Data, completed: @escaping(_ user: Bool) -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty && !imageData.isEmpty {
            //create a user with a profile picture
            AuthNetworkService.signupUserWithPicture(firstName: firstName,lastName: lastName, email: email, password: password, imageData: imageData, onSuccess: completed)
        } else {
            showAlert = true
            errorString = "Please fill in all fields"
        }
    }
}
