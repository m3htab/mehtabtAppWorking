//
//  SessionStore.swift
//  theApp
//
//  Created by rob ord on 10/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import Foundation
import Combine
import FirebaseAuth
import SwiftUI

class SessionStore: ObservableObject {
    

    @Published var isLoggedIn = false
    var time: Date?
    var userSession: User?
    var handle: AuthStateDidChangeListenerHandle?
    @Published var userData = LoggedInUser()
   
    
    
    
    func listenAuthenticationState() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.isLoggedIn = true
                UserService.handleSignIn(uid: user.uid, completion: { userObj in
                    if userObj != nil{
                        //print("Server Time: ",userObj.GetTimestamp().dateValue())
                        self.userData = userObj
                        self.time = userObj.GetTimestamp().dateValue()
                    }
                })
            } else {
                self.isLoggedIn = false
                self.userSession = nil
            }
        })
    }
    
    
    func logout() {
        do {
            try Auth.auth().signOut()
            
        } catch  {
            
        }
    }
    
    // stop listening for auth changes
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
