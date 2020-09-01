/*
  SigninViewModel.swift
  
  View Model for signin screen
 
 
 
*/

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class SigninViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""

    var errorString = ""
    @Published var showAlert: Bool = false

    
    
    func signin(email: String, password: String, completed: @escaping(_ user: User) -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if !email.isEmpty && !password.isEmpty {
            //Sign in user
            AuthNetworkService.signInUser(email: email, password: password, onSuccess: completed, onError: onError)
        } else {
            showAlert = true
            errorString = "Please fill in all fields"
        }
       
    }
}
