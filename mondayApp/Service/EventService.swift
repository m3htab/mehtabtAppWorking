import Firebase
import FirebaseFirestoreSwift


class EventService{
    
    
    static func GetEventPublicObjectByID(eventID: String,needDoc: Bool, completion: @escaping (_ event: Event?,_ doc: DocumentSnapshot?) -> Void){
        let query = dbLocations.DB_EVENT_ROOT.whereField(postRef.POST_ID, isEqualTo: eventID)
        NetworkServiceEvent.GetEventObjectByQueryExecute(query: query, completion: { event,doc in
            
            if event != nil && doc != nil{
                if needDoc{
                    completion(event,doc)
                }else{
                    completion(event,nil)
                }
            }else{
                completion(nil,nil)
            }
        })
    }
    
    
    static func GetEventPublicObjectByQuery(query: Query,needDoc: Bool, completion: @escaping (_ event: Event?,_ doc: DocumentSnapshot?) -> Void){
        NetworkServiceEvent.GetEventObjectByQueryExecute(query: query, completion: { event,doc in
            if event != nil && doc != nil{
                if needDoc{
                    completion(event,doc)
                }else{
                    completion(event,nil)
                }
            }else{
                completion(nil,nil)
            }
            
        })
    }
    


    
    
}

    
    





























    
    

    

    /*
    static func getEventWithID(ID: String,completion: @escaping (_ data: Event) -> Void){
        let db = Firestore.firestore()
        let query = db.collection("Future").whereField(EVENT_ID, isEqualTo: ID)
        
        query.getDocuments(){ (querySnapshot, err) in
            
            if let err = err {
                print(err)
            } else {
                for document in querySnapshot!.documents {
                    let parsed = parseEventDoc(document: document)
                    completion(parsed)
                }
              }
        }
        
    }
    */
 
 
    /*
    static func parseEventDoc(document: QueryDocumentSnapshot) -> Event{
        var event = Event()
        var foundCreatorData = false
        guard
            let id = document[EVENT_ID] as! String?,
            let title = document[EVENT_TITLE] as! String?,
            let description = document[EVENT_DESCRIPTION] as! String?,
            let creatorid = document[EVENT_CREATOR_ID] as! String?,
            let privacy = document[EVENT_PRIVACY] as! String?,
            let city = document[EVENT_CITY] as! String?,
            let accom = document[EVENT_ACCOMODATION] as! String?,
            let address = document[EVENT_ADDRESS] as! String?,
            let isHalls = document[EVENT_IS_HALLS] as! Bool?
        else {event.SetErrorStatus(status: EVENT_ERROR_STATUS.MainData_Error); return event}
        event.SetID(id: id)
        event.SetTitle(title: title)
        event.SetDescription(description: description)
        event.SetOriginalCreatorID(id: creatorid)
        event.SetPrivacy(privacy: privacy)
        event.SetCity(city: city)
        event.SetAddress(address: address)
        event.SetAccomodation(accom: accom)
        event.SetHallState(state: isHalls)
        // Parse Gallery data
        
        
        
        
        guard
            let gallery = document[EVENT_GALLERY] as! [String: [String: String]]?
        else{event.SetErrorStatus(status: EVENT_ERROR_STATUS.Gallery_Error); return event}
        var glist = [GalleryItem]()
        for item in gallery{
            guard
                let url = item.value[EVENT_GALLERY_ITEM_URL] as String?,
                let title = item.value[EVENT_GALLERY_ITEM_TITLE] as String?,
                let uid = item.value[EVENT_MEMBER_ID] as String?,
                let fname = item.value[EVENT_MEMBER_FIRST_NAME] as String?,
                let lname = item.value[EVENT_MEMBER_LAST_NAME] as String?,
                let userURL = item.value[EVENT_MEMBER_PICTURE_URL] as String?
            //consider not using guard here and scraping failures
            else{event.SetErrorStatus(status: EVENT_ERROR_STATUS.Gallery_Error); return event}
            var user = PostMember()
            user.SetID(ID: uid)
            user.SetFirstName(name: fname)
            user.SetLastName(name: lname)
            user.SetProfilePictureURL(URL: userURL)
            var gItem = GalleryItem()
            gItem.SetTitle(title: title)
            gItem.SetURL(url: url)
            gItem.SetUser(user: user)
            glist.append(gItem)
        }
        
        
        
        
        
        
        if (glist.isEmpty){
            event.SetErrorStatus(status: EVENT_ERROR_STATUS.Gallery_Error); return event
        }else{
            event.SetGallery(list: glist)
        }
        //Parse Host data
        guard
            let idList = document[EVENT_HOST_ID_LIST] as! [String]?,
            let hostData = document[EVENT_HOST_DATA] as! [String: [String: String]]?
        else{event.SetErrorStatus(status: EVENT_ERROR_STATUS.Host_Error); return event}
        var hlist = [PostMember]()
        for host in hostData{
            guard
                let uid = host.value[EVENT_MEMBER_ID] as String?,
                let fname = host.value[EVENT_MEMBER_FIRST_NAME] as String?,
                let lname = host.value[EVENT_MEMBER_LAST_NAME] as String?,
                let pp = host.value[EVENT_MEMBER_PICTURE_URL] as String?
            else{event.SetErrorStatus(status: EVENT_ERROR_STATUS.Host_Error); return event}
            if(uid == creatorid){
                var creator = PostMember()
                creator.SetID(ID: uid)
                creator.SetFirstName(name: fname)
                creator.SetLastName(name: lname)
                creator.SetProfilePictureURL(URL: pp)
                event.SetOriginalCreatorData(data: creator)
                foundCreatorData = true
            }
            else if (idList.contains(uid)){
                var host = PostMember()
                host.SetID(ID: uid)
                host.SetFirstName(name: fname)
                host.SetLastName(name: lname)
                host.SetProfilePictureURL(URL: pp)
                hlist.append(host)
            }
        }
        if (foundCreatorData == true){
            event.SetHost_DataList(list: hlist)
        }else{
            event.SetErrorStatus(status: EVENT_ERROR_STATUS.Creator_Error); return event
        }
        //Parse event stats
        guard
            let likeIDList = document[EVENT_LIKE_ID_LIST] as! [String]?,
            let joinIDList = document[EVENT_JOIN_ID_LIST] as! [String]?,
            let likeData = document[EVENT_LIKE_DATA] as! [String: [String: String]]?,
            let joinData = document[EVENT_JOIN_DATA] as! [String: [String: String]]?,
            let likeCount = document[EVENT_LIKE_COUNT] as! Int?,
            let joinCount = document[EVENT_JOIN_COUNT] as! Int?
        else{event.SetErrorStatus(status: EVENT_ERROR_STATUS.Stats_Error); return event}
        let lc = String(likeCount)
        let jc = String(joinCount)
        event.SetLikesUserID(list: likeIDList)
        event.SetLikesCount(count: lc)
        event.SetJoinsUserID(list: joinIDList)
        event.SetJoinsCount(count: jc)
        var likeUserDataList = [PostMember]()
        var joinUserDataList = [PostMember]()
        //get data for liked users
        
        
        
        
        
        for user in likeData{
            guard
                let uid = user.value[EVENT_MEMBER_ID] as String?,
                let fname = user.value[EVENT_MEMBER_FIRST_NAME] as String?,
                let lname = user.value[EVENT_MEMBER_LAST_NAME] as String?,
                let pp = user.value[EVENT_MEMBER_PICTURE_URL] as String?
            else{event.SetErrorStatus(status: EVENT_ERROR_STATUS.Stats_Error); return event}
            if (likeIDList.contains(uid)){
                var likedUser = PostMember()
                likedUser.SetID(ID: uid)
                likedUser.SetFirstName(name: fname)
                likedUser.SetLastName(name: lname)
                likedUser.SetProfilePictureURL(URL: pp)
                likeUserDataList.append(likedUser)
            }
        }
        event.SetLikesUserData(data: likeUserDataList)
        //get data for joined users
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        for user in joinData{
            guard
                let uid = user.value[EVENT_MEMBER_ID] as String?,
                let fname = user.value[EVENT_MEMBER_FIRST_NAME] as String?,
                let lname = user.value[EVENT_MEMBER_LAST_NAME] as String?,
                let pp = user.value[EVENT_MEMBER_PICTURE_URL] as String?
            else{event.SetErrorStatus(status: EVENT_ERROR_STATUS.Stats_Error); return event}
            if (joinIDList.contains(uid)){
                var joinedUser = PostMember()
                joinedUser.SetID(ID: uid)
                joinedUser.SetFirstName(name: fname)
                joinedUser.SetLastName(name: lname)
                joinedUser.SetProfilePictureURL(URL: pp)
                joinUserDataList.append(joinedUser)
            }
        }
        event.SetJoinsUserData(data: joinUserDataList)
        guard
            let date = document[EVENT_DATETIME] as! String?
        else{event.SetErrorStatus(status: EVENT_ERROR_STATUS.Date_Error); return event}
        event.SetFullDateAsString(date: "fake date for now")
        event.SetErrorStatus(status: EVENT_ERROR_STATUS.No_Error)
        return event
    }
    
    */



