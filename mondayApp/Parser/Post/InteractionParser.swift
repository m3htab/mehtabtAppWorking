import Firebase

extension FriendOfFriendInteraction{
    static func parseQueryDoc(document: QueryDocumentSnapshot) -> FriendOfFriendInteraction{
        let doc = FriendOfFriendInteraction()
        /*
        guard
            let eid = document[QUERY_EVENT_ID] as! String?,
            let uid = document[QUERY_USER_ID] as! String?,
            let like = document[QUERY_LIKE_VALUE] as! String?,
            let join = document[QUERY_JOIN_VALUE] as! String?,
            let host = document[QUERY_HOST_VALUE] as! String?,
            let friends = document[QUERY_FRIEND_LIST] as! [String]?
        else{doc.setErrorStatus(status: DOWNLOAD_STATUS.Fail); return doc}
    
        doc.setEventID(id: eid)
        doc.setUserID(id: uid)
        doc.setLikeStatus(status: like)
        doc.setJoinStatus(status: join)
        doc.setHostStatus(status: host)
        doc.setFriendList(friends: friends)
        doc.setErrorStatus(status: DOWNLOAD_STATUS.Success)
        */
        return doc
    }
}
