
enum INTERACTION_TYPE{
    case like
    case join
    case owner
    case notSet
}
enum POST_ERROR_STATUS: String{
    case No_Error = ""
    case Post_String_Error = "Error code 1"
    case Post_Owner_Error = "Error code 2"
    case Gallery_Error = "Error code 3"
    case Creator_Error = "Error code 4"
    case Event_String_Error = "Error code 5"
    case Date_Error = "Error code 6"
    case No_results = "Could'nt find any results"
    case Not_attempted = "No parse attempted"
    case Firebase_Error = "Firebase error"
    case Cant_Find_Post = "Cound find post"
    case Error = "case 7"
}
enum RELATION_TO_USER{
    case isUser
    case friend
    case none
    case notSet
}
enum POST_TYPE: String{
    case event = "event"
    case collection = "collection"
    case notSet = "notSet"
}
enum DOWNLOAD_STATUS {
    case Not_attempted
    case Fail
    case Success
}
enum GALLERY_STATUS{
    case Not_Started
    case In_Progress
    case First_Two_Finished
    case Finished
}
enum FILTERS: String{
    case EVERYONE = "Everyone"
    case POPULAR = "Popular"
    case FORYOU = "For You"
}
enum PRIVACY: String{
    case ALL = "All"
    case OPEN = "Open"
    case REQUEST = "Request"
}
enum EVENT_DATE_VIEWTYPE{
    case hoursAndMinutes
    case days
    case date
    case notSet
}
enum COLLECTION_DATE_VIEWTYPE{
    case minutes
    case hour
    case hours
    case days
}

enum EVENT_LOCATION_TYPES: String{
    case accomodation = "Halls"
    case house = "House/Flat"
    case other = "Other"
    case all = "all"
    case notSet = "not set"
}

enum PUBLIC_LOCATIONS: String{
    case city = "city"
    case accom = "accom"
    case brief_description = "bf"
    case notSet = "not set"
}

enum JOINED_LOCATIONS: String{
    case city = "city"
    case accom = "accom"
    case brief_description = "bd"
    case address = "address"
    case notSet = "not set"
}
enum JOIN_TYPE: String{
    case open = "open"
    case request = "request"
    case notSet = "not set"
}
let y = PUBLIC_LOCATIONS.notSet
