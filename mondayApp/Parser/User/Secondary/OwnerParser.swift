import Firebase

extension Post{
    
    static func parseOwner(document: QueryDocumentSnapshot,friendList: [String])->PostOwner?{
        let owner = PostOwner()
        guard
            let id = document[ownerRef.OWNER_ID] as! String?,
            let fname = document[ownerRef.OWNER_FIRST_NAME] as! String?,
            let lname = document[ownerRef.OWNER_LAST_NAME] as! String?
        else{return nil}
        
        let relationToOwner = checkForAUserRelation(target: id, userFriendList: friendList)
        owner.SetUserID(ID: id)
        owner.SetFirstName(name: fname)
        owner.SetLastName(name: lname)
        owner.SetRelationToUser(relation: relationToOwner)
        return owner
    }
}
