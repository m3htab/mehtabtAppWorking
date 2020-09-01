import Firebase
import Foundation

struct SavedEveryoneEventFeed{

    var city: String
    var accomodation: String
    var venue: EVENT_LOCATION_TYPES
    var fails: Int
    var postList: [Event]
    var lastDoc: DocumentSnapshot?
    
    
    static func getIndex(savedSearches: [SavedEveryoneEventFeed],city: String, accomodation: String, venue: EVENT_LOCATION_TYPES) -> Int?{
        guard let index = savedSearches.firstIndex(where: {$0.city == city && $0.accomodation == accomodation && $0.venue == venue})
        else{return nil}
        return index
    }
    

    
    static func createFeed(city: String, accomodation: String,venue: EVENT_LOCATION_TYPES,fails: Int, postList: [Event]) -> SavedEveryoneEventFeed{
        let aSearch = SavedEveryoneEventFeed.init(city: city, accomodation: accomodation, venue: venue, fails: fails, postList: postList)
        return aSearch
    }
}


