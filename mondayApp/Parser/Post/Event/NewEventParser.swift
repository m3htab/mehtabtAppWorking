import Firebase
extension Event{
    
    static func ParseNewEvent(postDoc: QueryDocumentSnapshot,friendList: [String]) -> NewEvent?{
        let eventData = NewEvent()

            
        guard
            let description = postDoc[eventRef.EVENT_DESCRIPTION] as! String?,
            let queryDate = postDoc[eventRef.EVENT_QUERYDATE] as! String?,
            let stringDate = postDoc[eventRef.EVENT_DATETIME] as! String?,
            let locationTypeString = postDoc[eventRef.EVENT_LOCATION_TYPE] as! String?,
            let publicLocationString = postDoc[eventRef.EVENT_PUBLIC_LOCATION] as! String?,
            let onJoinLocationString = postDoc[eventRef.EVENT_ONJOIN_LOCATION] as! String?,
            let city = postDoc[eventRef.EVENT_CITY] as! String?,

            let joinTypeString = postDoc[eventRef.EVENT_JOINTYPE] as! String?
        else{return nil}
        let date = Event.stringToDate(stringDate: stringDate)
        if date != nil{
            let locationType = Event.stringToLocationType(string: locationTypeString)
            let publicLocation = Event.stringToPublicLocation(string: publicLocationString)
            let onJoinLocation = Event.stringToJoinedLocation(string: onJoinLocationString)
            let joinType = Event.stringToJoinType(string: joinTypeString)
            eventData.SetDescription(string: description)
            eventData.SetQueryDate(date: queryDate)
            eventData.SetDate(date: date!)
            eventData.SetLocationType(type: locationType)
            eventData.SetPublicLocationPrivacy(type: publicLocation)
            eventData.SetOnJoinLocationPrivacy(type: onJoinLocation)
            eventData.SetCity(city: city)
            
            if let accomodation = postDoc[eventRef.EVENT_ACCOMODATION] as! String?{
                eventData.SetAccomodation(accom: accomodation)
            }
            if let locationDescription = postDoc[eventRef.EVENT_LOCATION_DESCRIPTION] as! String?{
                 eventData.SetLocationDescription(localDes: locationDescription)
            }
            if let address = postDoc[eventRef.EVENT_ADDRESS] as! String?{
                eventData.SetAddress(address: address)
            }
            
            eventData.SetJoinType(type: joinType)
            return eventData
        }
        else{
            return nil
        }
            

    }
    
    
}
