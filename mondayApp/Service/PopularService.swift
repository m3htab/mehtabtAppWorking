import Firebase
import FirebaseFirestoreSwift

class PopularService{
    
    static func loadPopularFeed(homeViewModel: HomeViewModel, city: String, venue: EVENT_LOCATION_TYPES, fromCarousel: Bool,customDate: Bool,dates: [String]){
        
        let loadSavedResult = HomeViewModel.tryLoadEventSavedFeed(homeViewModel: homeViewModel, feedType: FILTERS.POPULAR, city: city, accomodation: "", venue: venue,fromCarousel: fromCarousel,customDate: customDate,dates: dates)
        if loadSavedResult == false{
            print("new pop search")

            
            let searchContainter = SavedPopularEventFeed.createFeed(city: city, venue: venue, fails: 0, postList: [Event](), customDate: customDate, dates: dates)
            homeViewModel.savedPopularEventFeeds.append(searchContainter)
            guard
                let savedIndex = SavedPopularEventFeed.getIndex(savedSearches: homeViewModel.savedPopularEventFeeds,city: city, venue: venue, customDate: customDate,dates: dates)
            else{return}

           HomeViewModel.resetFeed(homeViewModel: homeViewModel)
            
            
            PopularService.getFirstEventInPopSearch(homeViewModel: homeViewModel, city: city, venue: venue,customDate: customDate,dates: dates, completion: { event,doc in
                if event != nil && doc != nil{
                    homeViewModel.activePostList.append(event!)
                    homeViewModel.savedPopularEventFeeds[savedIndex].postList.append(event!)
                    homeViewModel.savedPopularEventFeeds[savedIndex].lastDoc = doc
                    PopularService.popSearch(homeViewModel: homeViewModel, city: city, venue: venue, startPostition: doc!, savedIndex: savedIndex, customDate: customDate,dates: dates)
                }else {
                    let event = Event()
                    event.SetPostID(id: "No results")//     PUT EMPTY EVENT HERE
                    homeViewModel.savedPopularEventFeeds[savedIndex].postList.append(event)
                    homeViewModel.activePostList.append(event)
                }
            })
        }
    }
    
    static func getFirstEventInPopSearch(homeViewModel: HomeViewModel,city: String,venue: EVENT_LOCATION_TYPES,customDate: Bool,dates: [String], completion: @escaping (_ data: Event?,_ doc: DocumentSnapshot?) -> Void){
        let query = PopularQueries.popularInitialQueryGenerator(type: venue, city: city,customDate: customDate, dates: dates)
        EventService.GetEventPublicObjectByQuery(query: query, needDoc: true, completion: { event,doc in
            if event != nil && doc != nil{
                completion(event,doc)
            }else{
                completion(nil,nil)
            }
        })
        
    }
    static func popSearch(homeViewModel: HomeViewModel,city: String,venue: EVENT_LOCATION_TYPES,startPostition: DocumentSnapshot,savedIndex: Int,customDate: Bool,dates: [String]){
        print("recursve pop search called")
        let query = PopularQueries.popularRecursiveQueryGenerator(type: venue, city: city, customDate: customDate, dates: dates, startPosition: startPostition)
        EventService.GetEventPublicObjectByQuery(query: query,needDoc: true, completion: {event,doc in
            if event != nil && doc != nil{
                homeViewModel.activePostList.append(event!)
                homeViewModel.savedPopularEventFeeds[savedIndex].postList.append(event!)
                homeViewModel.savedPopularEventFeeds[savedIndex].lastDoc = doc
                if homeViewModel.savedPopularEventFeeds[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                    popSearch(homeViewModel: homeViewModel, city: city, venue: venue,startPostition: doc!, savedIndex: savedIndex,customDate: customDate,dates: dates)
                }
            }
        })
        
    }

}
