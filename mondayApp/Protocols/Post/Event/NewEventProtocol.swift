import Foundation

protocol anyNewEvent {
    var description: String {get set}
    var queryDate: String {get set}
    var date: Date {get set}
    var locationType: EVENT_LOCATION_TYPES {get set}
    var publicLocationPrivacy: PUBLIC_LOCATIONS {get set}
    var onJoinLocationPrivacy: JOINED_LOCATIONS {get set}
    var city: String {get set}
    var accomodation: String {get set}
    var locationDescription: String {get set}
    var address: String {get set}
    var joinType: JOIN_TYPE {get set}
    
    func SetDescription(string: String)
    func SetQueryDate(date: String)
    func SetDate(date: Date)
    func SetLocationType(type: EVENT_LOCATION_TYPES)
    func SetPublicLocationPrivacy(type: PUBLIC_LOCATIONS)
    func SetOnJoinLocationPrivacy(type : JOINED_LOCATIONS)
    func SetCity(city: String)
    func SetAccomodation(accom: String)
    func SetLocationDescription(localDes: String)
    func SetAddress(address: String)
    func SetJoinType(type: JOIN_TYPE)
    func GetDescription() -> String
    func GetQueryDate() -> String
    func GetDate() -> Date
    func GetLocationType() -> EVENT_LOCATION_TYPES
    func GetPublicLocationPrivacy() -> PUBLIC_LOCATIONS
    func GetOnJoinLocationPrivacy() -> JOINED_LOCATIONS
    func GetCity() -> String
    func GetAccomodation() -> String
    func GetLocationDescription() -> String
    func GetAddress() -> String
    func GetJoinType()-> JOIN_TYPE
}
