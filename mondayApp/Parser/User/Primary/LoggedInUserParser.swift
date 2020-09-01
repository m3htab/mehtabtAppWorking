import Firebase

extension LoggedInUser{
    static func parseLoggedInUser(user: aUser,document: QueryDocumentSnapshot,privateDocument:QueryDocumentSnapshot)->LoggedInUser?{
        
        let loggedInUser = LoggedInUser()
        
        loggedInUser.SetUserID(ID: user.GetUserID())
        loggedInUser.SetFirstName(name: user.GetFirstName())
        loggedInUser.SetLastName(name: user.GetLastName())
        loggedInUser.SetBio(bio: user.GetBio())
        loggedInUser.SetPostCount(count: user.GetPostCount())
        loggedInUser.SetSocialsList(list: user.GetSocialsList())
        loggedInUser.SetEventJoinsCount(count: user.GetEventJoinsCount())
        loggedInUser.SetFriendList(list: user.GetFriendList())
        loggedInUser.SetFriendCount(count: user.GetFriendCount())
        loggedInUser.SetIsCurrentUser(state: user.GetIsCurrentUser())
        loggedInUser.SetIsFriend(state: user.GetIsFriend())
        loggedInUser.SetBlockedUsers(users: user.GetBlockedUsers())
        
        
        if let timeStamp = document[userRef.USER_TIMESTAMP] as! Timestamp?{
            loggedInUser.SetTimestamp(stamp: timeStamp)
        }
        guard
            let email = privateDocument[userRef.USER_EMAIL] as! String?
        else{return nil}
        
        loggedInUser.SetEmail(email: email)
        
        
        return loggedInUser
        }
}
