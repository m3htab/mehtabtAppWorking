import Firebase

extension aUser{
    
    static func parseAUser(document: QueryDocumentSnapshot,uid: String,userFriendList: [String])->aUser?{
        let user = aUser()
        
        guard
            let parseUID = document[userRef.USER_ID] as! String?,
            let fname = document[userRef.USER_FIRSTNAME] as! String?,
            let lname = document[userRef.USER_LASTNAME] as! String?,
            let postCount = document[userRef.USER_POST_COUNT] as! Int?,
            let joinCount = document[userRef.USER_EVENT_JOINS_COUNT] as! Int?
        else{return nil}
        
        user.SetUserID(ID: parseUID)
        user.SetFirstName(name: fname)
        user.SetLastName(name: lname)
        user.SetPostCount(count: postCount)
        user.SetEventJoinsCount(count: joinCount)
        
        let bio = document[userRef.USER_BIO] as! String?
        if bio != nil{
            user.SetBio(bio: bio!)
        }
        
        let socials = document[userRef.USER_SOCIALS_LIST] as! [String:String]?
        if socials != nil{
            user.SetSocialsList(list: socials!)
        }
        
        let blockedUsers = document[userRef.USER_BLOCKED_USERS] as! [String]?
        if blockedUsers != nil{
            user.SetBlockedUsers(users: blockedUsers!)
        }
        
        let friendDataDict = document[userRef.USER_FRIEND_LIST] as! [String: [String: String]]?
        if friendDataDict != nil{
            let friendData = aUser.parseLightUserListData(data: friendDataDict!)
            if friendData != nil{
                user.SetFriendList(list: friendData!)
                user.SetFriendCount(count: String(friendData!.count))
            }
        }else{
            user.SetFriendCount(count: "0")
        }
        
        
        if uid == parseUID{
            user.SetIsCurrentUser(state: true)
        }else{
            user.SetIsCurrentUser(state: false)
        }
        user.SetIsFriend(state: Post.checkforUserInString(list: userFriendList, uid: parseUID))
        return user
    }
}
