import Firebase
import Foundation

struct SavedPopularEventFeed{

    var city: String
    var venue: EVENT_LOCATION_TYPES
    var postList: [Event]
    var customDate: Bool
    var dateList: [String]
    var lastDoc: DocumentSnapshot?
    
    static func getIndex(savedSearches: [SavedPopularEventFeed],city: String, venue: EVENT_LOCATION_TYPES,customDate: Bool,dates: [String]) -> Int?{
        guard let index = savedSearches.firstIndex(where: {$0.city == city && $0.venue == venue && $0.customDate == customDate && $0.dateList == dates})
        else{return nil}
        return index
    }
    

    
    static func createFeed(city: String,venue: EVENT_LOCATION_TYPES,fails: Int, postList: [Event],customDate: Bool,dates: [String]) -> SavedPopularEventFeed{
        let aSearch = SavedPopularEventFeed.init(city: city, venue: venue,postList: postList, customDate: customDate,dateList: dates)
        return aSearch
    }
}
