import Firebase
import Foundation

class aUser: PostMember,anyUser{
    
    var friendList = [LightUser]()
    var socialsList = ["":""]
    var postCount = 0
    var collectionList = [String]()
    var bio = ""
    var friendCount = ""
    var eventJoinsCount = 0
    var blockedUsers = [""]
    var isCurrentUser = false
    var isFriend = false
    
    /*
     Setters
     */
    func SetFriendList(list: [LightUser]){
        self.friendList = list
    }
    func SetSocialsList(list: [String:String]){
        self.socialsList = list
    }
    func SetPostCount(count: Int){
        self.postCount = count
    }
    func SetCollectionList(list: [String]){
        self.collectionList = list
    }
    func SetBio(bio: String){
        self.bio = bio
    }
    func SetFriendCount(count: String){
        self.friendCount = count
    }
    func SetEventJoinsCount(count: Int){
        self.eventJoinsCount = count
    }
    func SetBlockedUsers(users: [String]) {
        self.blockedUsers = users
    }
    func SetIsCurrentUser(state: Bool){
        self.isCurrentUser = state
    }
    func SetIsFriend(state: Bool){
        self.isFriend = state
    }
    /*
     Getters
     */

    func GetFriendList()-> [LightUser]{
        return self.friendList
    }
    func GetSocialsList()-> [String:String]{
        return self.socialsList
    }
    func GetPostCount()-> Int{
        return self.postCount
    }
    func GetCollectionList()->[String]{
        return self.collectionList
    }
    func GetBio()->String{
        return self.bio
    }
    func GetFriendCount()->String{
        return self.friendCount
    }
    func GetEventJoinsCount()-> Int{
        return self.eventJoinsCount
    }
    func GetBlockedUsers() -> [String] {
        return self.blockedUsers
    }
    func GetIsCurrentUser()-> Bool{
        return self.isCurrentUser
    }
    func GetIsFriend()-> Bool{
        return self.isFriend
    }
    
}
