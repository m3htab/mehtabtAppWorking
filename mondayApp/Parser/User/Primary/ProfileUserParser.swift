import Firebase


extension UserProfile{
    static func parseUserProfile(document: QueryDocumentSnapshot,uid: String,friendList:[String])->UserProfile?{
        
        let user = UserProfile()
        let baseUser = aUser.parseAUser(document: document, uid: uid, userFriendList: friendList)
        if baseUser != nil{
            user.SetUserID(ID: baseUser!.GetUserID())
            user.SetFirstName(name: baseUser!.GetFirstName())
            user.SetLastName(name: baseUser!.GetLastName())
            user.SetBio(bio: baseUser!.GetBio())
            user.SetPostCount(count: baseUser!.GetPostCount())
            user.SetSocialsList(list: baseUser!.GetSocialsList())
            user.SetEventJoinsCount(count: baseUser!.GetEventJoinsCount())
            user.SetFriendList(list: baseUser!.GetFriendList())
            user.SetFriendCount(count: baseUser!.GetFriendCount())
            user.SetIsCurrentUser(state: baseUser!.GetIsCurrentUser())
            user.SetIsFriend(state: baseUser!.GetIsFriend())
            user.SetBlockedUsers(users: baseUser!.GetBlockedUsers())
        }else{
            return nil
        }

        if Post.checkforUserInString(list: user.blockedUsers, uid: uid){
            user.SetHasBlockedCurrentUser(state: true)
        }else{
            user.SetHasBlockedCurrentUser(state: false)
        }
        
        
        return user
    }
}
