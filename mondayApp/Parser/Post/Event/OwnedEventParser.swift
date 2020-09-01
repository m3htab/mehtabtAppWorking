import Firebase


extension Event{
    static func ParseOwnedEvent(ownedDoc: QueryDocumentSnapshot)->NewEvent?{
        let ownedEvent = NewEvent()
        guard
            let accomodation = ownedDoc[eventRef.EVENT_ACCOMODATION] as! String?,
            let locationDescription = ownedDoc[eventRef.EVENT_LOCATION_DESCRIPTION] as! String?,
            let address = ownedDoc[eventRef.EVENT_ADDRESS] as! String?
        else{return nil}
        ownedEvent.SetAccomodation(accom: accomodation)
        ownedEvent.SetLocationDescription(localDes: locationDescription)
        ownedEvent.SetAddress(address: address)
        return ownedEvent
    }
}
