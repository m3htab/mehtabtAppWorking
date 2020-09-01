

extension Post{
    static func findRelatedUsers(users: [PostMember],type:INTERACTION_TYPE)->[RelatedUser]?{
        var relatedList = [RelatedUser]()
        for user in users{
            if user.GetRelationToUser() == RELATION_TO_USER.friend{
                let friend = RelatedUser()
                friend.SetUserID(ID: user.GetUserID())
                friend.SetFirstName(name: user.GetFirstName())
                friend.SetFirstName(name: user.GetLastName())
                friend.SetRelationToUser(relation: RELATION_TO_USER.friend)
                switch type {
                case INTERACTION_TYPE.like:
                    friend.SetInteractionLike()
                case INTERACTION_TYPE.join:
                    friend.SetInteractionJoin()
                default:
                    break
                }
                relatedList.append(friend)
            }
        }
        if relatedList.isEmpty{
            return nil
        }else{
            return relatedList
        }
    }
    static func checkforUserInString(list: [String],uid: String) -> Bool{
        if list.contains(uid){
            return true
        }else{
            return false
        }
    }
    static func checkIfOwner(owner: PostOwner,uid:String) -> Bool{
        if owner.GetUserID() == uid{
            return true
        }
        else{
            return false
        }
    }
    static func checkForAUserRelation(target: String, userFriendList: [String])-> RELATION_TO_USER{
        if userFriendList.contains(target){
            return RELATION_TO_USER.friend
        }else{
            return RELATION_TO_USER.none
        }
    }
    
}

extension Post{
    static func stringToPostType(string: String)-> POST_TYPE{
        switch string {
        case POST_TYPE.event.rawValue:
            return POST_TYPE.event
        case POST_TYPE.collection.rawValue:
            return POST_TYPE.collection
        case POST_TYPE.notSet.rawValue:
            return POST_TYPE.notSet
        default:
            return POST_TYPE.notSet
        }
    }
}

