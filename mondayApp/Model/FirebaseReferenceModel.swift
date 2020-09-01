import Firebase
class dbLocations{
    static var DB_EVENT_ROOT = Firestore.firestore().collection("test_posts").document("event").collection("future")
    
    static func DB_EVENT_PUBLIC_DOC(eventID: String)-> DocumentReference{
        return DB_EVENT_ROOT.document(eventID)
    }
    static func DB_EVENT_JOIN_DOC(eventID: String)-> DocumentReference{
        return DB_EVENT_ROOT.document(eventID).collection("join").document(eventID)
    }
    //static func DB_EVENT_JOIN_COLLECTION_GROUP()-
    
    
    static func DB_EVENT_PRIVATE_DOC(eventID: String)-> DocumentReference{
        return DB_EVENT_ROOT.document(eventID).collection("private").document(eventID)
    }
    static let DB_USERS_ROOT = Firestore.firestore().collection("Users")
    
    static func DB_USER_DOC_BY_ID(id: String)-> DocumentReference{
        return DB_USERS_ROOT.document(id)
    }
    
    static func DB_USERS_PRIVATE_COLLECTION(userID: String)-> CollectionReference{
        return DB_USERS_ROOT.document(userID).collection("private")
    }
    static func DB_USERS_PRIVATE_DOC(id: String)-> DocumentReference{
        return DB_USERS_ROOT.document(id).collection("private").document(id)
    }
    
    static var DB_BATCH = Firestore.firestore().batch()
    
    static var INTERACTION_COLLECTION = "User Interaction"
    
}
class Ref {
    // Storage
    
    //storage root location
    static var STORAGE_ROOT = Storage.storage().reference(forURL: "gs://fresher-testing.appspot.com")
    
    //storage location of user profile pictures
    static var STORAGE_PROFILE_PICTURE = STORAGE_ROOT.child("ProfilePicture")
    
    //get the storage location for a profile picture of any user
    static func STORAGE_PROFILE_PICTURE_USERID(userId: String) -> StorageReference {
        return STORAGE_PROFILE_PICTURE.child(userId)
    }
    
    // Firestore
    
    //database root location
    static var FIRESTORE_ROOT = Firestore.firestore()
    //database user documents location
    static var FIRESTORE_COLLECTION_USERS = FIRESTORE_ROOT.collection("users")
    //get any user's document reference
    static func FIRESTORE_DOCUMENT_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_USERS.document(userId)
    }
}





class postRef{
    static let POST_ID = "ID"
    static let POST_OWNER = "Owner"
    static let POST_TYPE = "Post Type"
    static let POST_TITLE = "Title"
    static let POST_LIKE_COUNT = "Like Count"
    static let POST_LIKE_DATA = "Like Data"
    static let POST_LIKE_IDLIST = "Like ID List"
    static let POST_DATE_UPLOADED = "Upload Datetime"
    static let POST_MEMBER_MEDIUM_URL = "Medium URL"
    static let POST_MEMBER_SMALL_URL = "Small URL"
    static let POST_MEMBER_ID = "User ID"
    static let POST_MEMBER_FIRSTNAME = "First Name"
    static let POST_MEMBER_LASTNAME = "Last Name"
    static let POST_WHO_CAN_ADD = "Users who can upload to gallery"
}
class ownerRef{
    static let OWNER_ID = "Owner Id"
    static let OWNER_FIRST_NAME = "Owner First Name"
    static let OWNER_LAST_NAME = "Owner Last Name"
}
class galleryRef{
    ///Gallery meta data
    static let GALLERY_PARENT_POST_ID = "Post ID"
    static let GALLERY_TITLE = "Gallery Title"
    static let GALLERY_PRIVILEGED_USER_IDS = "Privileged Users"
    ///[string:string:any] array for each item in the gallery
    static let GALLERY_ITEMS = "Posts In The Gallery"
    ///Data for a gallery item, media is stored under item id
    static let GALLERY_ITEM_PARENT_POST_ID = "Post ID"
    static let GALLERY_ITEM_ID = "Gallery Item ID"
    static let GALLERY_ITEM_TITLE = "Title"
    static let GALLERY_ITEM_USER_ID = "User ID"
    static let GALLERY_ITEM_FIRSTNAME = "First Name"
    static let GALLERY_ITEM_LASTNAME = "Last Name"
    static let GALLERY_ITEM_SMALL_URL = "Small URL"
    static let GALLERY_ITEM_MEDIUM_URL = "Medium URL"
}

class eventRef{
    static let EVENT_DESCRIPTION = "Description"
    static let EVENT_JOIN_COUNT = "Join Count"
    static let EVENT_JOIN_DATA = "Join Data"
    static let EVENT_JOIN_IDLIST = "Join Id list"
    static let EVENT_DATETIME = "Start Datetime"
    static let EVENT_LOCATION_TYPE = "Location Type"
    static let EVENT_PUBLIC_LOCATION = "Public Location"
    static let EVENT_ONJOIN_LOCATION = "On Join Location"
    static let EVENT_CITY = "City"
    static let EVENT_ACCOMODATION = "Accomodation"
    static let EVENT_LOCATION_DESCRIPTION = "Location Description"
    static let EVENT_ADDRESS = "Address"
    static let EVENT_JOINTYPE = "Join Type"
    static let EVENT_QUERYDATE = "Query Date"
    static let EVENT_DATE_AS_DATE = "Date as Date"
    static let EVENT_TCQUERYFIELD = "Type City Query Field"
    
    static let NON_VISIBLE = "private"
}
class queryDoc{
    let QUERY_FRIEND_LIST = "Friend List"
    let QUERY_USER_ID = "User ID"
    let QUERY_LIKE_VALUE = "Has Liked"
    let QUERY_JOIN_VALUE = "Has Joined"
    let QUERY_HOST_VALUE = "Is Hosting"
    let QUERY_EVENT_ID = "Event ID"
}


class userRef{
    
    static let USER_ID = "User ID"
    static let USER_FIRSTNAME = "First Name"
    static let USER_LASTNAME = "Last Name"
    static let USER_EMAIL = "Email"
    static let USER_SMALL_URL = "Small url"
    static let USER_MEDIUM_URL = "Medium url"
    static let USER_LARGE_URL = "Large url"
    static let USER_FRIEND_LIST = "Friend List"
    static let USER_SOCIALS_LIST = "User's Socials"
    static let USER_BIO = "Bio"
    static let USER_POST_COUNT = "Post Count"
    static let USER_EVENT_JOINS_COUNT = "Event Join Count"
    static let USER_BLOCKED_USERS = "Blocked Users"
    static let USER_TIMESTAMP = "Last Login"
    
    static let LIGHT_USER_ID = "User Id"
    static let LIGHT_USER_FIRSTNAME = "First Name"
    static let LIGHT_USER_LASTNAME = "Last Name"
    static let LIGHT_USER_SMALL_URL = "URL"
    
    
}











/*
let EVENT_DESCRIPTION = "Description"
let EVENT_DATETIME = "DateTime"
let EVENT_QUERYDATE = "QueryDate"
let EVENT_CREATOR_ID = "Creator ID"
let EVENT_PRIVACY = "Privacy"
let EVENT_CITY = "City"
let EVENT_IS_HALLS = "Is Event In Halls"
let EVENT_ACCOMODATION = "Accomodation"
let EVENT_ADDRESS = "Address"
let EVENT_GALLERY = "Gallery"
let EVENT_GALLERY_ITEM_URL = "URL"
let EVENT_GALLERY_ITEM_TITLE = "Title"
let EVENT_MEMBER_ID = "ID"
let EVENT_MEMBER_FIRST_NAME = "First Name"
let EVENT_MEMBER_LAST_NAME = "Last Name"
let EVENT_MEMBER_PICTURE_URL = "Profile Picture"
let EVENT_HOST_ID_LIST = "Host IDs"
let EVENT_HOST_DATA = "Host Data"
let EVENT_LIKE_ID_LIST = "Liked ID List"
let EVENT_LIKE_DATA = "Liked User Data"
let EVENT_LIKE_COUNT = "Like Count"
let EVENT_JOIN_ID_LIST = "Joined ID List"
let EVENT_JOIN_DATA = "Joined User Data"
let EVENT_JOIN_COUNT = "Join Count"
let EVENT_QUERY_FIELD = "Query Field"
*/
