import Firebase
import SwiftUI



class NetworkServiceEvent{
    
    static func GetEventObjectByQueryExecute(query: Query, completion: @escaping (_ event: Event?,_ doc: DocumentSnapshot?) -> Void){
        print("NETWORK CALL: event query execute")
        query.getDocuments(){ (queryDocuments, err) in
            if err != nil {
                completion(nil,nil)
            }else {
                if (queryDocuments!.documents.isEmpty){
                    completion(nil,nil)
                }else{
                for document in queryDocuments!.documents{
                    let foundEvent = Event.ParseEvent(eventDoc: document,uid:"",friendList:[""],currentDate:Date())
                    if foundEvent != nil{
                        if foundEvent!.GetIsOwner(){
                            //get private document
                        }
                        else if foundEvent!.hasUserJoined{
                            //get joined doucument
                        }
                    }
                    completion(foundEvent,document)
                    
                }
                }
            }
        }
    }
    
    
    
    
    
    

    static func GetEventPublicObjectByRandom(city: String,venue: EVENT_LOCATION_TYPES,accomodation: String,customDate: Bool,dates:[String],currentDate: Date,uid:String,friendList:[String],completion: @escaping (_ data: Event?) -> Void){
        
        ///how random works(top answer)
        ///https://stackoverflow.com/questions/46798981/firestore-how-to-get-random-documents-in-a-collection
        
        let query = EveryoneQueries.everyoneQueryGenerator(type: venue, city: city, accom: accomodation, customDate: customDate, dates: dates)
        
        
        
        
        query.0.getDocuments(){ (querySnapshot, err) in
            if err != nil {
                 completion(nil)
             } else {
                 if(querySnapshot!.documents.isEmpty){
                    print("couldnt find first time")
                    query.1.getDocuments(){ (querySnapshotB, err) in
                        if err != nil{
                             completion(nil)
                         }else{
                             if(querySnapshotB!.documents.isEmpty){
                                 completion(nil)
                                 print("couldnt find second")
                             }else{
                                 for document in querySnapshotB!.documents{
                                    let parsedEvent = Event.ParseEvent(eventDoc: document, uid: uid, friendList: friendList,currentDate: currentDate)
                                     if parsedEvent != nil{
                                         let completeEvent = Event.tryGetPrivateData(event: parsedEvent!)
                                         completion(completeEvent)
                                     }else{
                                         completion(nil)
                                     }
                                 }
                             }
                         }
                     }
                 }else{
                     for document in querySnapshot!.documents {
                        let parsedEvent = Event.ParseEvent(eventDoc: document, uid: uid, friendList: friendList,currentDate: currentDate)
                        if parsedEvent != nil{
                            let completeEvent = Event.tryGetPrivateData(event: parsedEvent!)
                            completion(completeEvent)
                        }else{
                            completion(nil)
                        }


                     }
                 }
               }
         }
     }
    
//MARK: - WRITE TEST EVENT
    
    
static func WriteEvent(event: Event,completion: @escaping (_ success: String?) -> Void){
        
        var batch = Firestore.firestore().batch()
        let publicDoc = dbLocations.DB_EVENT_ROOT.document()
        let newEventID = publicDoc.documentID
        let privateDoc = dbLocations.DB_EVENT_PRIVATE_DOC(eventID: newEventID)
        let joinDoc = dbLocations.DB_EVENT_JOIN_DOC(eventID: newEventID )
        let interactionDoc = publicDoc.collection(dbLocations.INTERACTION_COLLECTION)
        var pubAccom = privateLocation.privateLocation
        var pubBD = privateLocation.privateLocation
        var joinAccom = privateLocation.privateLocation
        var joinBD = privateLocation.privateLocation
        var joinAddress = privateLocation.privateLocation
        
    let query = Event.createQueryList(city: event.GetCity(), type: event.GetLocationType().rawValue)
    
    
        switch event.GetLocationType(){
            case EVENT_LOCATION_TYPES.accomodation:
                switch event.GetPublicLocationPrivacy() {
                    case PUBLIC_LOCATIONS.accom:
                        pubAccom = event.GetAccomodation()
                    default:
                        break
                }
                switch event.GetOnJoinLocationPrivacy(){
                    
                case JOINED_LOCATIONS.accom:
                    joinAccom = event.GetAccomodation()
                case JOINED_LOCATIONS.address:
                    joinAccom = event.GetAccomodation()
                    joinAddress = event.GetAddress()
                default:
                    break
            }

            case EVENT_LOCATION_TYPES.house:
                switch event.GetPublicLocationPrivacy(){
                    case PUBLIC_LOCATIONS.brief_description:
                        pubBD = event.GetLocationDescription()
                    default:
                        break
                }
                switch event.GetOnJoinLocationPrivacy(){
                    case JOINED_LOCATIONS.brief_description:
                        joinBD = event.GetLocationDescription()
                    case JOINED_LOCATIONS.address:
                        joinAddress = event.GetAddress()
                    default:
                        break
                }
            case EVENT_LOCATION_TYPES.other:
                switch event.GetPublicLocationPrivacy(){
                    case PUBLIC_LOCATIONS.brief_description:
                        pubBD = event.GetLocationDescription()
                    default:
                        break
                }
                switch event.GetOnJoinLocationPrivacy(){
                    case JOINED_LOCATIONS.brief_description:
                        joinBD = event.GetLocationDescription()
                    case JOINED_LOCATIONS.address:
                        joinAddress = event.GetAddress()
                    default:
                        break
                }
            default:
                break
        }
        
        let publicData :[String:Any] = [
            postRef.POST_ID: newEventID,
            postRef.POST_TYPE: event.GetPostType().rawValue,
            ownerRef.OWNER_ID: event.GetPostOwner().GetUserID(),
            ownerRef.OWNER_FIRST_NAME: event.GetPostOwner().GetFirstName(),
            ownerRef.OWNER_LAST_NAME: event.GetPostOwner().GetLastName(),
            postRef.POST_TITLE: event.GetTitle(),
            postRef.POST_DATE_UPLOADED: Timestamp(),
            postRef.POST_WHO_CAN_ADD: event.GetPrivilagesUsers(),
            postRef.POST_LIKE_COUNT: 0,
            eventRef.EVENT_JOIN_COUNT: Int.random(in: 1..<100),
            eventRef.EVENT_DESCRIPTION: event.GetDescription(),
            eventRef.EVENT_QUERYDATE: event.GetQueryDate(),
            eventRef.EVENT_DATETIME: Event.dateToString(date: event.GetDate()),
            eventRef.EVENT_DATE_AS_DATE: event.GetDate(),
            eventRef.EVENT_TCQUERYFIELD: query,
            eventRef.EVENT_LOCATION_TYPE: event.GetLocationType().rawValue,
            eventRef.EVENT_PUBLIC_LOCATION: event.GetPublicLocationPrivacy().rawValue,
            eventRef.EVENT_ONJOIN_LOCATION: event.GetOnJoinLocationPrivacy().rawValue,
            eventRef.EVENT_CITY: event.GetCity(),
            eventRef.EVENT_ACCOMODATION: pubAccom,
            eventRef.EVENT_LOCATION_DESCRIPTION: pubBD,
            eventRef.EVENT_JOINTYPE: event.GetJoinType().rawValue,
            "random1": Int.random(in: 1..<20001),
            "random2": Int.random(in: 1..<20001),
            "random3": Int.random(in: 1..<20001)
        ]
        let joinData :[String:Any] = [
            postRef.POST_ID: newEventID,
            eventRef.EVENT_ACCOMODATION: joinAccom,
            eventRef.EVENT_LOCATION_DESCRIPTION: joinBD,
            eventRef.EVENT_ADDRESS: joinAddress
        ]
        let privateData :[String:Any] = [
            postRef.POST_ID: newEventID,
            eventRef.EVENT_ACCOMODATION: event.GetAccomodation(),
            eventRef.EVENT_LOCATION_DESCRIPTION: event.GetLocationDescription(),
            eventRef.EVENT_ADDRESS: event.GetAddress()
        ]
    
    
        batch.setData(publicData, forDocument: publicDoc)
        batch.setData(joinData,forDocument: joinDoc)
        batch.setData(privateData,forDocument: privateDoc)
        print("ABOUT TO BATCH")
        batch.commit() { err in
            print("IN BATCH")
            if err != nil{
                print("BATCH FAIL")
                completion(nil)
            }else{
                print("BATCH SUCCESS")
                completion("success")
            }
        
        }
    
    
    }

}
