import Firebase

protocol anyNewPost{
    var postID: String {get set}
    var postOwner: PostOwner {get set}
    var postType: POST_TYPE {get set}
    var title: String {get set}
    var gallery: Gallery {get set}
    var dateUploaded: Timestamp {get set}
    var privilegedUsers: [String] {get set}
    var isOwner: Bool {get set}
    var canUserAdd: Bool {get set}
    
    func SetPostID(id: String)
    func SetPostOwner(owner: PostOwner)
    func SetPostType(type: POST_TYPE)
    func SetTitle(title: String)
    func SetGallery(gallery: Gallery)
    func SetDateUploaded(date: Timestamp)
    func SetPrivilagedUsers(users: [String])
    func SetIsOwner(owner: Bool)
    func SetCanUserAdd(can: Bool)
    func GetPostID() ->String
    func GetPostOwner() ->PostOwner
    func GetPostType() ->POST_TYPE
    func GetTitle() ->String
    func GetGallery() ->Gallery
    func GetDateUploaded() -> Timestamp
    func GetPrivilagesUsers()-> [String]
    func GetIsOwner() -> Bool
    func GetCanUserAdd() -> Bool
}
