import Firebase


extension Post{
    static func ParsePost(postDoc: QueryDocumentSnapshot,uid: String,friendList: [String])->Post?{
         
        let post = Post()
        guard let usersThatCanAdd = postDoc[postRef.POST_WHO_CAN_ADD] as! [String]? else{return nil}
        post.SetPrivilagedUsers(users: usersThatCanAdd)
        if let likeCount = postDoc[postRef.POST_LIKE_COUNT] as! Int?{
            post.SetLikeCount(count: likeCount)
            if let likeData = postDoc[postRef.POST_LIKE_DATA] as! [String: [String: String]]?{
                if let likeIds = postDoc[postRef.POST_LIKE_IDLIST] as! [String]?{
                    
                    let hasLiked = Post.checkforUserInString(list: likeIds, uid: uid)
                    if hasLiked{
                        post.SetHasLiked(liked: true)
                    }else{
                        post.SetHasLiked(liked: false)
                    }
                    let parsedLikeData = Post.parsePostMemberListData(data: likeData, officalIDList: likeIds, friendList: friendList)
                    if parsedLikeData != nil{
                        post.SetLikeData(data: parsedLikeData!)
                        let relatedLikedUsers = Post.findRelatedUsers(users: parsedLikeData!, type: INTERACTION_TYPE.like)
                        if relatedLikedUsers != nil{
                            post.SetRelatedUsers(users: relatedLikedUsers!)
                        }
                    }
                }
            }
        }else{
            post.SetLikeCount(count: 0)
            post.SetHasLiked(liked: false)
        }
        return post
         
     }
}
