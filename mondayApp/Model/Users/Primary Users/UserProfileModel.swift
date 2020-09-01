
class UserProfile: aUser,anyUserProfile{
    
    var hasBlockedCurrentUser = false
    
    //setters
    func SetHasBlockedCurrentUser(state: Bool) {
        self.hasBlockedCurrentUser = state
    }

    //getters
    func GetHasBlockedCurrentUser() ->Bool{
        return self.hasBlockedCurrentUser
    }

}
