import Firebase


extension Event{
    static func ParseJoinedEvent(ownedDoc: QueryDocumentSnapshot)->NewEvent?{
        let joinedEvent = NewEvent()
        guard
            let accomodation = ownedDoc[eventRef.EVENT_ACCOMODATION] as! String?,
            let locationDescription = ownedDoc[eventRef.EVENT_LOCATION_DESCRIPTION] as! String?,
            let address = ownedDoc[eventRef.EVENT_ADDRESS] as! String?
        else{return nil}
        joinedEvent.SetAccomodation(accom: accomodation)
        joinedEvent.SetLocationDescription(localDes: locationDescription)
        joinedEvent.SetAddress(address: address)
        return joinedEvent
    }
}
