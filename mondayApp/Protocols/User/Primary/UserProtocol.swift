
///any user is the base user for profile view

protocol anyUser: anyPostMember{
    var friendList: [LightUser] {get set}
    var socialsList: [String:String] {get set}
    var postCount: Int {get set}
    var collectionList: [String]{get set}
    var bio: String {get set}
    var friendCount: String {get set}
    var eventJoinsCount: Int {get set}
    var blockedUsers: [String] {get set}
    var isCurrentUser: Bool {get set}
    var isFriend: Bool {get set}
    
    func SetFriendList(list: [LightUser])
    func SetSocialsList(list: [String:String])
    func SetPostCount(count: Int)
    func SetCollectionList(list: [String])
    func SetBio(bio: String)
    func SetFriendCount(count: String)
    func SetEventJoinsCount(count: Int)
    func SetBlockedUsers(users: [String])
    func SetIsCurrentUser(state: Bool)
    func SetIsFriend(state: Bool)
    
    
    func GetFriendList()-> [LightUser]
    func GetSocialsList()-> [String:String]
    func GetPostCount()-> Int
    func GetCollectionList()->[String]
    func GetBio()->String
    func GetFriendCount()->String
    func GetEventJoinsCount()-> Int
    func GetBlockedUsers()-> [String]
    func GetIsCurrentUser()-> Bool
    func GetIsFriend()-> Bool
}
