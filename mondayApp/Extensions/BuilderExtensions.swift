import Foundation
import Firebase
extension Event{
    static func buildUserEvent(ownerID: String,ownerFirstName:String,ownerLastName:String,title:String,description:String,city: String,Accom: String,address:String,venueType:EVENT_LOCATION_TYPES,briefDescription:String,joinType:JOIN_TYPE,privlagedUsers: [String],date: Date,publicLocation: PUBLIC_LOCATIONS,joinedLocation: JOINED_LOCATIONS)-> Event{
        
        let newEvent = Event()
        
        
        let aDocID = dbLocations.DB_EVENT_ROOT.document()
        let postid = aDocID.documentID
        
        let eventOwner = PostOwner()
        let querydate = Event.dateToQueryString(date: date)
        eventOwner.SetUserID(ID: ownerID)
        eventOwner.SetFirstName(name: ownerFirstName)
        eventOwner.SetLastName(name: ownerLastName)
        
        newEvent.SetPostID(id: postid)
        newEvent.SetPostOwner(owner: eventOwner)
        newEvent.SetTitle(title: title)
        newEvent.SetDescription(string: description)
        newEvent.SetPostType(type: POST_TYPE.event)
        newEvent.SetLocationType(type: venueType)
        newEvent.SetCity(city: city)
        newEvent.SetAddress(address: address)
        newEvent.SetPrivilagedUsers(users: privlagedUsers)
        newEvent.SetDateUploaded(date: Timestamp())
        newEvent.SetQueryDate(date: querydate)
        newEvent.SetDate(date: date)
        newEvent.SetJoinType(type: joinType)
        
        
        if newEvent.GetLocationType() == EVENT_LOCATION_TYPES.accomodation{
            newEvent.SetAccomodation(accom: Accom)
            newEvent.SetLocationDescription(localDes: "private")
        }
        else{
            newEvent.SetAccomodation(accom: "private")
            newEvent.SetLocationDescription(localDes: briefDescription)
        }
        
        switch publicLocation {
        case PUBLIC_LOCATIONS.city:
            newEvent.SetPublicLocationPrivacy(type: PUBLIC_LOCATIONS.city)
        case PUBLIC_LOCATIONS.accom:
            newEvent.SetPublicLocationPrivacy(type: PUBLIC_LOCATIONS.accom)
        case PUBLIC_LOCATIONS.brief_description:
            newEvent.SetPublicLocationPrivacy(type: PUBLIC_LOCATIONS.brief_description)
        default:
            newEvent.SetPublicLocationPrivacy(type: PUBLIC_LOCATIONS.city)
        }
        switch joinedLocation {
        case JOINED_LOCATIONS.city:
            newEvent.SetOnJoinLocationPrivacy(type: JOINED_LOCATIONS.city)
        case JOINED_LOCATIONS.accom:
            newEvent.SetOnJoinLocationPrivacy(type: JOINED_LOCATIONS.accom)
        case JOINED_LOCATIONS.brief_description:
            newEvent.SetOnJoinLocationPrivacy(type: JOINED_LOCATIONS.brief_description)
        case JOINED_LOCATIONS.address:
            newEvent.SetOnJoinLocationPrivacy(type: JOINED_LOCATIONS.address)
        default:
            newEvent.SetOnJoinLocationPrivacy(type: JOINED_LOCATIONS.city)
        }
        
        return newEvent
    }
}
extension LoggedInUser{
    static func buildNewLoggedInUser(uid:String,firstName:String,lastName:String,largeProfilePic:String,email:String)->LoggedInUser{
        
        var newUser = LoggedInUser()
        newUser.SetUserID(ID: uid)
        newUser.SetFirstName(name: firstName)
        newUser.SetLastName(name: lastName)
        newUser.SetEmail(email: email)
        
        return newUser
    }
}
