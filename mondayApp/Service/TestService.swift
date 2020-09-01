import Firebase
import FirebaseFirestoreSwift


class TestService{
    

    
    
    static func makeTestEvent(uid:String,fname:String,lname:String,completion: @escaping (_ success: String?) -> Void){
        print("MAKING TEST EVENT")
        
        let accomodationLiv = ["Glassworks","HH","Marybone"]
        let accomodationNew = ["newcastle1","newcastle2","newcastle3"]
        let cities = ["Newcastle","Liverpool"]
        let accomPubType = [PUBLIC_LOCATIONS.city,PUBLIC_LOCATIONS.accom]
        let accomPrivateType = [JOINED_LOCATIONS.city,JOINED_LOCATIONS.accom,JOINED_LOCATIONS.address]
        let nonAccomPubType = [PUBLIC_LOCATIONS.city,PUBLIC_LOCATIONS.brief_description]
        let nonAcconPrivateType = [JOINED_LOCATIONS.city,JOINED_LOCATIONS.brief_description,JOINED_LOCATIONS.address]
        let joinTypes = [JOIN_TYPE.open,JOIN_TYPE.request]
        
        let joinRandom = Int.random(in: 0..<2)
        let locationType = Int.random(in: 0..<3)
        
        let accomRandom = Int.random(in: 0..<3)
        
        let accomOpen = Int.random(in: 0..<accomPubType.count)
        let accomPrivate = Int.random(in: 0..<accomPrivateType.count)
        
        let NotAccomOpen = Int.random(in: 0..<nonAccomPubType.count)
        let NotAccomRequest = Int.random(in: 0..<nonAcconPrivateType.count)
       
        let citiesRandom = Int.random(in: 0..<cities.count)
        
        let accomodationNewcastleRandom = Int.random(in: 0..<accomodationNew.count)
        let accomodationLiverpoolRandom = Int.random(in: 0..<accomodationLiv.count)
  
        let dateRandom = Double(Int.random(in: 0..<25))
        
        
        var venueType = EVENT_LOCATION_TYPES.notSet
        var publicType = PUBLIC_LOCATIONS.notSet
        var onJoinType = JOINED_LOCATIONS.notSet
        var accom = ""
        var city = ""
        var bd = "brief description"
        var joinType = JOIN_TYPE.notSet
        var date = Date()
        
        date.addTimeInterval(60*60*24*dateRandom)
        
        
        
        if locationType == 0{
            // acomodation
            venueType = EVENT_LOCATION_TYPES.accomodation
            city = cities[citiesRandom]
            if city == "Newcastle"{
                accom = accomodationNew[accomodationNewcastleRandom]
            }
            else if city == "Liverpool"{
                accom = accomodationLiv[accomodationLiverpoolRandom]
            }
            publicType = accomPubType[accomOpen]
            onJoinType = accomPrivateType[accomPrivate]
            joinType = joinTypes[joinRandom]
        }else if locationType == 1{
            // house
            venueType = EVENT_LOCATION_TYPES.house
            city = cities[citiesRandom]
            publicType = nonAccomPubType[NotAccomOpen]
            onJoinType = nonAcconPrivateType[NotAccomRequest]
            joinType = joinTypes[joinRandom]
        }else if locationType == 2{
            // other
            venueType = EVENT_LOCATION_TYPES.other
            city = cities[citiesRandom]
            publicType = nonAccomPubType[NotAccomOpen]
            onJoinType = nonAcconPrivateType[NotAccomRequest]
            joinType = joinTypes[joinRandom]
        }
        
        
        
        
        
        let eventToWrite = Event.buildUserEvent(ownerID: uid,
            ownerFirstName: fname,
            ownerLastName: lname,
            title: "an event title",
            description: "description",
            city: city,
            Accom: accom,
            address: "some address",
            venueType: venueType,
            briefDescription: bd,
            joinType: joinType,
            privlagedUsers: ["user to add1","user to add2"],
            date: date,
            publicLocation: publicType,
            joinedLocation: onJoinType)
        
        NetworkServiceEvent.WriteEvent(event: eventToWrite, completion: {success in
            if success != nil{
                completion(nil)
            }
            else{
                completion(success)
            }
        })
        
        
    }
    
    
    
    static func createTestEvent(){
       /*
       let city = "Newcastle"
       let location = "newcastle1"
        let privacy = PRIVACY.ALL
       let qField = EventService.createQueryList(city: city, location: location, privacy: privacy)
       
       
       
       let db = Firestore.firestore()
        enum status: String{
            case success = "success"
            case fail = "fail"
            case notChecked = "not checked"
        }
        var writeStatus = status.notChecked
        let batch = db.batch()
        
        let PublicDoc = db.collection("test_events").document("Future").collection("Timestamp").document()
        let eventID = PublicDoc.documentID
        let PrivateDoc = db.collection("test_events").document("Future").collection("Public").document(eventID).collection("Private").document("Data")
        
        //Set Public Event Data
        batch.setData(
        [
            "time": Timestamp(),
            EVENT_ID : eventID,
            EVENT_TITLE : "THIS IS THE TITLE",
            /*
            EVENT_DESCRIPTION: "A DESCRIPTION",
            EVENT_DATETIME : Date().toStringDateTime(date: Date()),
            EVENT_CREATOR_ID: "DF09S80DSF0",
            EVENT_PRIVACY:privacy.rawValue,
            EVENT_CITY: city,
            EVENT_IS_HALLS: true,
            EVENT_ACCOMODATION: location,
            EVENT_QUERY_FIELD: qField,
            EVENT_ADDRESS: "flat 2",
            "random1": Int.random(in: 1..<20001),
            "random2": Int.random(in: 1..<20001),
            "random3": Int.random(in: 1..<20001),
            
            
            EVENT_GALLERY : ["d9sf79": [EVENT_GALLERY_ITEM_URL:"www.fuckoff.com",EVENT_MEMBER_ID:"g98f7d",EVENT_MEMBER_FIRST_NAME:"a first name",EVENT_MEMBER_PICTURE_URL:"a profile pic3232",EVENT_GALLERY_ITEM_TITLE:"image caption oioi",EVENT_MEMBER_LAST_NAME:"a last name"]],

            EVENT_HOST_ID_LIST : ["DF09S80DSF0"],
            
            
            EVENT_HOST_DATA : ["d9sf79": [EVENT_MEMBER_ID:"DF09S80DSF0",EVENT_MEMBER_FIRST_NAME:"a fname",EVENT_MEMBER_PICTURE_URL:"a profile pic23842",EVENT_MEMBER_LAST_NAME:"lname"]],
            
            EVENT_JOIN_ID_LIST : ["D9SFS90","KJ3K2J","DF09S80DSF0"],
            
            
            EVENT_JOIN_DATA : ["d9sf79": [EVENT_MEMBER_ID:"DF09S80DSF0",EVENT_MEMBER_FIRST_NAME:"a fname",EVENT_MEMBER_PICTURE_URL:"a profile pic23842",EVENT_MEMBER_LAST_NAME:"lname"]],
            
            EVENT_LIKE_ID_LIST : ["DF09S80DSF0"],
            
            
            EVENT_LIKE_DATA : ["d9sf79": [EVENT_MEMBER_ID:"DF09S80DSF0",EVENT_MEMBER_FIRST_NAME:"a fname",EVENT_MEMBER_PICTURE_URL:"a profile pic23842",EVENT_MEMBER_LAST_NAME:"lname"]],
            */
            EVENT_LIKE_COUNT : Int.random(in: 1..<100),
            EVENT_JOIN_COUNT : Int.random(in: 1..<100)

        ], forDocument: PublicDoc)
        
        //Set Private Event Data
        batch.setData(["Address" : "some address","EVENTID": eventID], forDocument: PrivateDoc)
        
        
        //Write Public and Private Data
        batch.commit() { err in
           print("it tried commit")
           if let err = err {
                writeStatus = status.fail
                print(err)
               print(err)
            } else{
                writeStatus = status.success
            }
        }
        print(writeStatus)
        return writeStatus.rawValue
    }
    */

    }
}
