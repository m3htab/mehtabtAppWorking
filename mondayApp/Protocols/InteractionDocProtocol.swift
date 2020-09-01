
///A document for saving interaction to a post

protocol anyInteractionDocument: anyRelatedUser {
    var postId: String {get set}
    var friendIDList: [String] {get set}
    
    func SetPostID(id: String)
    func SetFriendIDList(list: [String])
    func GetPostID()->String
    func GetFriendIDList()->[String]
    
}
