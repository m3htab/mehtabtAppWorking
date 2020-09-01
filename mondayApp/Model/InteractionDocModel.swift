

class FriendOfFriendInteraction : anyInteractionDocument{
    
    internal var postId = ""
    internal var friendIDList = [""]
    internal var uID = ""
    internal var firstName = ""
    internal var lastName = ""
    internal var smallProfilePictureURL = ""
    internal var relationToUser = RELATION_TO_USER.notSet
    internal var interactionType = INTERACTION_TYPE.notSet
    
    
    //setters
    func SetPostID(id: String) {
        self.postId = id
    }
    func SetFriendIDList(list: [String]) {
        self.friendIDList = list
    }
    func SetInteractionOwner() {
        self.interactionType = INTERACTION_TYPE.owner
    }
    func SetInteractionJoin() {
        self.interactionType = INTERACTION_TYPE.join
    }
    func SetInteractionLike() {
        self.interactionType = INTERACTION_TYPE.like
    }
    func SetUserID(ID: String){
        self.uID = ID
    }
    func SetFirstName(name: String){
        self.firstName = name
    }
    func SetLastName(name: String){
        self.lastName = name
    }
    func SetSmallProfilePictureURL(URL: String){
        self.smallProfilePictureURL = URL
    }
    func SetRelationToUser(relation: RELATION_TO_USER){
        self.relationToUser = relation
    }
    //getters
    func GetPostID() -> String {
        return self.postId
    }
    func GetFriendIDList() -> [String] {
        return self.friendIDList
    }
    func GetInteractionType()-> INTERACTION_TYPE {
        return self.interactionType
    }
    func GetUserID()->String{
        return uID
    }
    func GetFirstName()->String{
        return self.firstName
    }
    func GetLastName()->String{
        return self.lastName
    }
    func GetSmallProfilePictureURL()->String{
        return self.smallProfilePictureURL
    }
    func GetRelationToUser()-> RELATION_TO_USER{
        return self.relationToUser
    }
}
    
