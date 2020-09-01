import Firebase

extension Post{
    
    static func parsePostMemberListData(data: [String: [String: String]],officalIDList:[String],friendList: [String])->[PostMember]?{
        var list = [PostMember]()
        
        for user in data{
            guard
                let uid = user.value[postRef.POST_MEMBER_ID] ,
                let fname = user.value[postRef.POST_MEMBER_FIRSTNAME] ,
                let lname = user.value[postRef.POST_MEMBER_LASTNAME]
            else{return nil}
            
            if officalIDList.contains(uid){
                let postMember = PostMember()
                postMember.SetUserID(ID: uid)
                postMember.SetFirstName(name: fname)
                postMember.SetLastName(name: lname)
                postMember.SetRelationToUser(relation: Post.checkForAUserRelation(target: uid, userFriendList: friendList))
                list.append(postMember)
            }
        }
        return list
    }
    
}
