import Firebase


class UserService{
    
    
    static func getLoggedInUserData(uid: String,completion: @escaping (_ user: LoggedInUser) -> Void){
        NetworkServiceUser.GetBaseUserDataWithDoc(userID: uid, completion: {user,doc in
            if user != nil && doc != nil {
                NetworkServiceUser.GetUserPrivateData(userID: uid, publicData: user!, publicDoc: doc! as! QueryDocumentSnapshot, completion: { user in
                    if user != nil{
                        completion(user!)
                    }
                })
            }
        })
    }
    
    
    
    static func getPublicUserObjectByID(id: String, completion: @escaping (_ user: UserProfile?) -> Void){
        NetworkServiceUser.GetUserPublicDocByID(userID:id, completion: {user in
            if user != nil{
                completion(user)
            }else{
                completion(nil)
            }
        })
    }
    
    
    static func createNewUser(id:String,firstName: String,lastName: String,email:String, largeProfilePicture: String, completion: @escaping (_ state: Bool) -> Void){
        let newUser = LoggedInUser.buildNewLoggedInUser(uid: id,firstName:firstName,lastName: lastName,largeProfilePic: largeProfilePicture,email: email)
        NetworkServiceUser.CreateNewUser(userObj: newUser, completion: { state in
            if state == true{
                completion(true)
            }else{
                completion(false)
            }
        })
    }
    
    static func writeTimeStamp(uid: String,completion: @escaping (_ success: Bool) -> Void){
        let updateData = [userRef.USER_TIMESTAMP:Timestamp()]
        NetworkServiceUser.UpdateUserDoc(userID: uid,data: updateData, completion: { success in
            if success == true{
                completion(success)
                //print("update success")
            }else{
                //print("update fail")
                completion(success)
            }
        })
    }
    
    
    
    
    
    static func handleSignIn(uid:String, completion: @escaping (_ userObj: LoggedInUser) -> Void){
        UserService.writeTimeStamp(uid: uid, completion: { success in
            UserService.getLoggedInUserData(uid: uid, completion: { user in
                completion(user)
            })
        })
    }

}

