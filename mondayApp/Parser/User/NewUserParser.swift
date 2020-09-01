import Firebase

extension aUser{
    static func parseNewUser(doc : QueryDocumentSnapshot)->LightUser?{
        guard
            let email = doc[userRef.LIGHT_USER_ID] as! String?,
            let timeStamp = doc[userRef.LIGHT_USER_FIRSTNAME] as! Timestamp?
        else{return nil}
            
        let newUser = NewUser()
        newUser.SetTimestamp(stamp: timeStamp)
        newUser.SetEmail(email: email)
        
        return newUser
    }
}
