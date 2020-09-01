import Firebase

extension Event{
    static func ParseEvent(eventDoc: QueryDocumentSnapshot,uid: String,friendList: [String],currentDate:Date) -> Event?{
        let event = Event()

        guard let newPostData = Post.ParseNewPost(postDoc: eventDoc, uid: uid, friendList: friendList) as NewPost?else{return nil}
        event.SetPostID(id: newPostData.GetPostID())
        event.SetPostOwner(owner: newPostData.GetPostOwner())
        event.SetPostType(type: newPostData.GetPostType())
        event.SetTitle(title: newPostData.GetTitle())
        event.SetDateUploaded(date: newPostData.GetDateUploaded())
        event.SetPrivilagedUsers(users: newPostData.GetPrivilagesUsers())
        event.SetIsOwner(owner: newPostData.GetIsOwner())
        event.SetCanUserAdd(can: newPostData.GetCanUserAdd())
        
        guard let postData = Post.ParsePost(postDoc: eventDoc, uid: uid, friendList: friendList) as Post?else{return nil}
        event.SetLikeCount(count: postData.GetLikeCount())
        event.SetLikeData(data: postData.GetLikeData())
        event.SetRelatedUsers(users: postData.GetRelatedUsers())
        event.SetHasLiked(liked: postData.GetHasLiked())
        
        guard let newEventData = Event.ParseNewEvent(postDoc: eventDoc, friendList: friendList) as NewEvent?else{return nil}
        
        event.SetDescription(string: newEventData.GetDescription())
        event.SetQueryDate(date: newEventData.GetQueryDate())
        event.SetDate(date: newEventData.GetDate())
        event.SetLocationType(type: newEventData.GetLocationType())
        event.SetPublicLocationPrivacy(type: newEventData.GetPublicLocationPrivacy())
        event.SetOnJoinLocationPrivacy(type: newEventData.GetOnJoinLocationPrivacy())
        event.SetCity(city: newEventData.GetCity())
        event.SetAccomodation(accom: newEventData.GetAccomodation())
        event.SetLocationDescription(localDes: newEventData.GetLocationDescription())
        event.SetAddress(address: newEventData.GetAddress())
        event.SetJoinType(type: newEventData.GetJoinType())
        
        
        if let joinCount = eventDoc[eventRef.EVENT_JOIN_COUNT] as! Int?{
            event.SetJoinCount(count: joinCount)
            if let joinData = eventDoc[eventRef.EVENT_JOIN_DATA] as! [String: [String: String]]?{
                if let joinIds = eventDoc[eventRef.EVENT_JOIN_IDLIST] as! [String]?{
                    
                    let hasJoined = Post.checkforUserInString(list: joinIds, uid: uid)
                    if hasJoined{
                        event.SetHasUserJoined(state: true)
                    }else{
                        event.SetHasUserJoined(state: false)
                    }
                    let parsedJoinData = Post.parsePostMemberListData(data: joinData, officalIDList: joinIds, friendList: friendList)
                    if parsedJoinData != nil{
                        event.SetJoinData(data: parsedJoinData!)
                        let relatedJoinedUsers = Post.findRelatedUsers(users: parsedJoinData!, type: INTERACTION_TYPE.join)
                        if relatedJoinedUsers != nil{
                            event.UpdateRelatedUsers(users: relatedJoinedUsers!)
                        }
                    }
                }
            }
        }else{
            event.SetJoinCount(count: 0)
            event.SetHasUserJoined(state: false)
        }
        
        let dateToShow = Event.dateToShow(currentDate: Date(),dayOfEvent: event.GetDate())
        event.SetDateToShow(date: dateToShow)
        let locationToShow = Event.getLocationToShow(hasJoined: event.GetHasUserJoined(), publicLocation: event.GetPublicLocationPrivacy(), onJoinLocation: event.GetOnJoinLocationPrivacy(), city: event.GetCity(), accom: event.GetAccomodation(), address: event.GetAddress(), briefDescription: event.GetLocationDescription(), locationType: event.GetLocationType())
        event.SetLocationToShow(location: locationToShow)

        return event
        
    }
}
