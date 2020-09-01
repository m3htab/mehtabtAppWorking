import SwiftUI
class Event : Identifiable,Equatable{
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    
    
//                                    ***EVENT MODEL***

    private var ID = ""
    private var Title = "Title is loading"
    private var Description = "Title is loading"
    private var theDate = ""
    private var Privacy = ""
    private var City = ""
    private var Address = ""
    private var Accomadation = ""
    private var isHalls = true
    private var Gallery = [galleryItem]()
    private var RelatedUsers = [postMember]()
    private var hasRelatedUsers = false
/*
Event user data is stored in two ways: as a list of user id's and list of user data

uid's must be stored in a list so firebase can query it

The uid list is parsed to check if users in user data list are still valid users
    
*/
    
    
    
//                                  Original Creator Data
    private var OC_UserData = postMember()
    private var OC_UserID: String?
//                                       Host Data
    private var H_UserDataMaster = [postMember]()
    private var loneHost : Bool?
//                                     Like+Join Data
    private var Join_Count = ""
    private var Join_UserData = [postMember]()
    private var Join_UserIDs = [""]
    private var Like_Count = ""
    private var Like_UserData = [postMember]()
    private var Like_UserIDs = [""]

    

    var Error_Status = EVENT_ERROR_STATUS.Not_attempted
    var Gallery_Status = GALLERY_STATUS.Not_Started
/*
 ***SETTERS***
*/
 func setID(id: String){
        self.ID = id
    }
    func setTitle(title: String){
        self.Title = title
    }
    func setDescription(description: String){
        self.Description = description
    }
    func setDate(date: String){
        self.theDate = date
    }
    func setCity(city: String){
        self.City = city
    }
    func setAddress(address: String){
        self.Address = address
    }
    func setAccomodation(accom: String){
        self.Accomadation = accom
    }
    func setHallState(state: Bool){
        self.isHalls = state
    }
    func setGallery(list: [galleryItem]){
        self.Gallery = list
    }
    func setHost_DataList(list: [postMember]){
        self.H_UserDataMaster = list
    }
    func setOriginalCreatorID(id: String){
        self.OC_UserID = id
    }
    func setOriginalCreatorData(data: postMember){
        self.OC_UserData = data
    }
    func setPrivacy(privacy: String){
        self.Privacy = privacy
    }

    func setLikesCount(count: String){
        self.Like_Count = count
    }
    func setLikesUserID(list: [String]){
        self.Like_UserIDs = list
    }
    func setLikesUserData(data: [postMember]){
        self.Like_UserData = data
    }
    func setJoinsCount(count: String){
        self.Join_Count = count
    }
    func setJoinsUserID(list: [String]){
        self.Join_UserIDs = list
    }
    func setJoinsUserData(data: [postMember]){
        self.Join_UserData = data
    }
    func setParseStatus(status: EVENT_ERROR_STATUS){
        self.Error_Status = status
    }
    /*
     ***GETTERS***
    */
    func getID()->String{
        return self.ID
    }
    func getTitle()->String{
        return self.Title
    }
    func getDescription()->String{
        return self.Description
    }
    func getDay()->String{
        return self.ID
    }
    func getTime()->String{
        return self.ID
    }
    func getDaysBefore()->String{
        return self.ID
    }
    func getLikeCount()->String{
        return Like_Count
    }
    func getJoinCount()-> String{
        return Join_Count
    }

    
    

    

}


struct postMember{
    var ID = ""
    var FirstName = ""
    var LastName = ""
    var PP_URL = ""

    mutating func setID(ID: String){
        self.ID = ID
    }
    mutating func setFirstName(name: String){
        self.FirstName = name
    }
    mutating func setLastName(name: String){
        self.LastName = name
    }
    mutating func setProfilePictureURL(URL: String){
        self.PP_URL = URL
    }
    
    
}

struct galleryItem{
    var Title = ""
    var URL = ""
    var User = postMember()
    
    mutating func setTitle(title: String){
        self.Title = title
    }
    mutating func setURL(url: String){
        self.URL = url
    }
    mutating func setUser(user: postMember){
        self.User = user
    }
}

struct SavedPostSearch{
    var filter: FILTERS
    var city: String
    var location: String
    var privacy: PRIVACY
    var fails: Int
    var postList: [Event]
    var emptySearch: Bool
}
