import Firebase


class NetworkServiceUser{
    
    static func GetUserPublicDocByID(userID: String, completion: @escaping (_ user: UserProfile?) -> Void){
       // print("NETWORK CALL: get user doc ")
        let query = dbLocations.DB_USERS_ROOT.whereField(userRef.USER_ID, isEqualTo: userID)
        query.getDocuments(){ (queryDocuments, err) in
            if err != nil {
                completion(nil)
            }else {
                if (queryDocuments!.documents.isEmpty){
                    completion(nil)
                }else{
                for document in queryDocuments!.documents{
                    let user = UserProfile.parseUserProfile(document: document, uid: "", friendList: [""])
                    completion(user)
                }
                }
            }
        }
    }
    
    
    static func CreateNewUser(userObj: LoggedInUser, completion: @escaping (_ state: Bool) -> Void){
       // print("NETWORK CALL: create user")
        let batch = dbLocations.DB_BATCH
        let publicDoc = dbLocations.DB_USER_DOC_BY_ID(id: userObj.GetUserID())
        let privateDoc = dbLocations.DB_USERS_PRIVATE_DOC(id: userObj.GetUserID())
        
        let publicData = [
            userRef.USER_ID: userObj.GetUserID(),
            userRef.USER_FIRSTNAME: userObj.GetFirstName(),
            userRef.USER_LASTNAME: userObj.GetLastName(),
            userRef.USER_EVENT_JOINS_COUNT: 0,
            userRef.USER_POST_COUNT: 0
            ] as [String : Any]
        
        let privateData = [
            userRef.USER_EMAIL: userObj.GetEmail(),
            userRef.USER_ID: userObj.GetUserID()
        ]
        
        batch.setData(publicData, forDocument: publicDoc)
        batch.setData(privateData, forDocument: privateDoc)
        
        batch.commit() { err in
            if err != nil {
                completion(false)
            }else{
                completion(true)
            }
        }
        
    }
    
    static func GetUserPrivateData(userID: String,publicData:aUser,publicDoc:QueryDocumentSnapshot, completion: @escaping (_ user: LoggedInUser?) -> Void){
        //print("NETWORK CALL: get user private data")
        let query = dbLocations.DB_USERS_PRIVATE_COLLECTION(userID: userID).whereField(userRef.USER_ID, isEqualTo: userID)
        query.getDocuments(){ (queryDocuments, err) in
            if err != nil {
                completion(nil)
            }else {
                if (queryDocuments!.documents.isEmpty){
                    completion(nil)
                }else{
                for document in queryDocuments!.documents{
                    
                    let userData = LoggedInUser.parseLoggedInUser(user: publicData, document: publicDoc, privateDocument: document)
                
                    completion(userData)
                    
                }
                }
            }
        }
    }
    
    static func GetBaseUserDataWithDoc(userID: String, completion: @escaping (_ user: aUser?,_ doc: DocumentSnapshot?) -> Void){
       // print("NETWORK CALL: get base user data")
        let query = dbLocations.DB_USERS_ROOT.whereField(userRef.USER_ID, isEqualTo: userID)
        query.getDocuments(){ (queryDocuments, err) in
            //print("finished downloading base doc")
            if err != nil {
                completion(nil,nil)

            }else {
                if (queryDocuments!.documents.isEmpty){
                    completion(nil,nil)

                }else{
                for document in queryDocuments!.documents{
                    //print("found user doc trying parse")
                    let baseUser = aUser.parseAUser(document: document, uid: userID, userFriendList: [""])
                    
                    completion(baseUser,document)
                }
                }
            }
        }
    }


    static func UpdateUserDoc(userID: String,data: [String:Any],completion: @escaping (_ success: Bool) -> Void){
        //print("NETWORK CALL: updating user doc")
        let userDocRef = dbLocations.DB_USER_DOC_BY_ID(id: userID)
        userDocRef.updateData(data){ err in
            if err != nil{
                completion(false)
            }else{
                completion(true)
            }
        }
    }


}
