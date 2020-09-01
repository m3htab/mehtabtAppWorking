import Firebase

class NewPost: anyNewPost{
    
    var postID = PostDefaltValue.postID
    var postOwner = PostOwner()
    var postType = POST_TYPE.notSet
    var title = PostDefaltValue.title
    var gallery = Gallery()
    var dateUploaded = PostDefaltValue.dateUploaded
    var privilegedUsers = [""]
    var isOwner = false
    var canUserAdd = false
    
    func SetPostID(id: String){
        self.postID = id
    }
    func SetPostOwner(owner: PostOwner){
        self.postOwner = owner
    }
    func SetPostType(type: POST_TYPE){
        self.postType = type
    }
    func SetTitle(title: String){
        self.title = title
    }
    func SetGallery(gallery: Gallery){
        self.gallery = gallery
    }
    func SetDateUploaded(date: Timestamp){
        self.dateUploaded = date
    }
    func SetPrivilagedUsers(users: [String]){
        self.privilegedUsers = users
    }
    func SetIsOwner(owner: Bool){
         self.isOwner = owner
     }
    func SetCanUserAdd(can: Bool){
        self.canUserAdd = can
    }
    
    func GetPostID() ->String{
        return self.postID
    }
    func GetPostOwner() ->PostOwner{
        return self.postOwner
    }
    func GetPostType() ->POST_TYPE{
        return self.postType
    }
    func GetTitle() ->String{
        return self.title
    }
    func GetGallery() ->Gallery{
        return self.gallery
    }
    func GetDateUploaded() -> Timestamp{
        return self.dateUploaded
    }
    func GetPrivilagesUsers()-> [String]{
        return self.privilegedUsers
    }
    func GetIsOwner() -> Bool{
        return self.isOwner
    }
    func GetCanUserAdd() -> Bool{
        return self.canUserAdd
    }
}
