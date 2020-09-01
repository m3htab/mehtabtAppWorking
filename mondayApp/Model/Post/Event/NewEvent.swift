import Firebase

class NewEvent : NewPost, anyNewEvent{
    
    
    var description = EventDefaultValue.description
    var queryDate = ""
    var date = Date()
    var locationType = EVENT_LOCATION_TYPES.notSet
    var publicLocationPrivacy = PUBLIC_LOCATIONS.notSet
    var onJoinLocationPrivacy = JOINED_LOCATIONS.notSet
    var city = EventDefaultValue.city
    var accomodation = EventDefaultValue.accomodation
    var locationDescription = EventDefaultValue.locationDescription
    var address = EventDefaultValue.address
    var joinType = JOIN_TYPE.notSet
    
    //setters
    func SetDescription(string: String) {
        self.description = string
    }
    func SetQueryDate(date: String){
        self.queryDate = date
    }
    func SetDate(date: Date){
        self.date = date
    }
    func SetLocationType(type: EVENT_LOCATION_TYPES) {
        self.locationType = type
    }
    func SetPublicLocationPrivacy(type: PUBLIC_LOCATIONS) {
        self.publicLocationPrivacy = type
    }
    func SetOnJoinLocationPrivacy(type: JOINED_LOCATIONS) {
        self.onJoinLocationPrivacy = type
    }
    func SetCity(city: String) {
        self.city = city
    }
    func SetAccomodation(accom: String) {
        self.accomodation = accom
    }
    func SetLocationDescription(localDes: String) {
        self.locationDescription = localDes
    }
    func SetAddress(address: String) {
        self.address = address
    }
    func SetJoinType(type: JOIN_TYPE) {
        self.joinType = type
    }
    
    func GetDescription() -> String {
        return self.description
    }
    func GetQueryDate()-> String{
        return self.queryDate
    }
    func GetDate()-> Date{
        return self.date
    }
    func GetLocationType()-> EVENT_LOCATION_TYPES{
        return self.locationType
    }
    func GetPublicLocationPrivacy() -> PUBLIC_LOCATIONS {
        return self.publicLocationPrivacy
    }
    func GetOnJoinLocationPrivacy() -> JOINED_LOCATIONS {
        return self.onJoinLocationPrivacy
    }
    func GetCity() -> String {
        return self.city
    }
    func GetAccomodation() -> String {
        return self.accomodation
    }
    func GetLocationDescription() -> String {
        return self.locationDescription
    }
    func GetAddress() -> String {
        return self.address
    }
    func GetJoinType() -> JOIN_TYPE {
        return self.joinType
    }
    
}
