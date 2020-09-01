import Firebase


extension Post{
    static func ParseNewPost(postDoc: QueryDocumentSnapshot,uid: String,friendList: [String])-> NewPost?{
        let newPost =  NewPost()
        guard
            let postId = postDoc[postRef.POST_ID] as! String?,
            let postType = postDoc[postRef.POST_TYPE] as! String?,
            let title = postDoc[postRef.POST_TITLE] as! String?,
            let dateUploaded = postDoc[postRef.POST_DATE_UPLOADED] as! Timestamp?,
            let privilegedUsers = postDoc[postRef.POST_WHO_CAN_ADD] as! [String]?
        else{return nil}
     
        newPost.SetPostID(id: postId)
        newPost.SetPostType(type: Post.stringToPostType(string: postType))
        newPost.SetTitle(title: title)
        newPost.SetDateUploaded(date: dateUploaded)
        newPost.SetPrivilagedUsers(users: privilegedUsers)
        let canAdd = Post.checkforUserInString(list: privilegedUsers, uid: uid)
        newPost.SetCanUserAdd(can: canAdd)
        if let owner = Post.parseOwner(document: postDoc, friendList: friendList){
            newPost.SetPostOwner(owner: owner)
            let isOwner = Post.checkIfOwner(owner: owner, uid: uid)
            newPost.SetIsOwner(owner: isOwner)
            return newPost
        }else{
            return nil
        }
    }
}
