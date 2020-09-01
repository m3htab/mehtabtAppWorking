
import SwiftUI
class HomeViewModel: ObservableObject{
    /*
     State of Home components
     */
    @Published var showingComments = false
    @Published var showingCarousel = false
    @Published var showingEventList = false
    @Published var showingPostDetails = true
    @Published var currentPost: Int = 0
    @Published var postPos: Int = 0
    @Published var currentGalleryPosition = 0
    var viewedPosts = [0]
    /*
     Feed Data
     */
    var savedEveryoneEventFeeds = [SavedEveryoneEventFeed]()
    var savedPopularEventFeeds = [SavedPopularEventFeed]()
    var savedForYouEventFeed = [SavedForYouEventFeed]()
    
    @Published var activePostList = [Event(),Event(),Event(),Event(),Event(),Event(),Event(),Event(),Event(),Event(),Event(),Event(),Event(),Event(),]
    
    var savedEveryonePosition = 0
    var savedPopularPosition = 0
    var savedForYouPosition = 0
    

    
    
    func incrementPost(){
        postPos += 1
        print(postPos)
    }
    func decrementPost(){
        postPos -= 1
        print(postPos)
    }
    func resetPostPos(){
        postPos = 0
    }
    
    
    // MARK: - LOAD NEW FEED
    static func loadNewFeed(homeViewModel: HomeViewModel, filterViewModel: FilterViewModel,newFilter: FILTERS,fromCarousel:Bool){
        
        var customDate = false
        var formattedDates = [""]
        if filterViewModel.GetHasSelectedCustomDate(){
            formattedDates = FilterViewModel.FormatCalenderDateToQueryString(dateList: filterViewModel.GetTrueDates())
            customDate = true
        }
        switch newFilter {
        case FILTERS.EVERYONE:
            let city = filterViewModel.GetEveryoneActivatedCity()
            let venue = filterViewModel.GetEveryoneActivatedVenue()
            let accomodation = filterViewModel.GetEveryoneActivatedAccomodation()
            EveryoneService.loadEveryoneFeed(homeViewModel: homeViewModel, city: city, accomodation: accomodation, venue: venue, fromCarousel: fromCarousel,customDate: customDate,dates: formattedDates,currentDate:Date(),uid:"",friendList: [""])

        case FILTERS.POPULAR:
            let city = filterViewModel.GetPopularActivatedCity()
            let venue = filterViewModel.GetPopularActivatedVenue()
            PopularService.loadPopularFeed(homeViewModel: homeViewModel, city: city, venue: venue, fromCarousel: fromCarousel,customDate: customDate,dates: formattedDates)
        case FILTERS.FORYOU:
            break
            //ForYouService.loadForYouFeed(homeViewModel: homeViewModel, fromCarousel: fromCarousel)
        default:
            return
        }
 
    }
    

    

    

    //MARK: - TRY LOAD SAVED FEED
    static func tryLoadEventSavedFeed(homeViewModel: HomeViewModel,feedType: FILTERS,city: String, accomodation: String, venue: EVENT_LOCATION_TYPES,fromCarousel: Bool,customDate: Bool,dates: [String])-> Bool{
    
        var lastPosition = 0
        var newList = [Event]()
        
        switch feedType{
        case FILTERS.EVERYONE:
            let indexOfSearch = SavedEveryoneEventFeed.getIndex(savedSearches: homeViewModel.savedEveryoneEventFeeds,city: city, accomodation: accomodation, venue: venue)
            if indexOfSearch != nil{
                newList = homeViewModel.savedEveryoneEventFeeds[indexOfSearch!].postList
                if fromCarousel{
                    lastPosition = homeViewModel.savedEveryonePosition
                }
            }
        
        case FILTERS.POPULAR:
            let indexOfSearch = SavedPopularEventFeed.getIndex(savedSearches: homeViewModel.savedPopularEventFeeds,city: city, venue: venue,customDate: customDate,dates: dates)
            if indexOfSearch != nil{
                newList = homeViewModel.savedPopularEventFeeds[indexOfSearch!].postList
                if fromCarousel{
                    lastPosition = homeViewModel.savedPopularPosition
                }
            }
        
        case FILTERS.FORYOU:
            if (homeViewModel.savedForYouEventFeed.isEmpty){
                return false
            }else{
                if homeViewModel.savedForYouEventFeed[0].postList.isEmpty{
                    return false
                }else{
                    newList = homeViewModel.savedForYouEventFeed[0].postList
                    if fromCarousel{
                        lastPosition = homeViewModel.savedForYouPosition
                    }
                }
            }
        }
        
        if newList.isEmpty{
            let emptyEvent = Event()
            emptyEvent.SetPostID(id: "this feed is empty")
            homeViewModel.activePostList = [emptyEvent]
            homeViewModel.currentPost = 0
            return false
        }else{
            loadEventFeed(homeViewModel: homeViewModel, feed: newList, position: lastPosition)
            return true
        }
    }

    static func resetFeed(homeViewModel: HomeViewModel){
        homeViewModel.currentPost = 0
        homeViewModel.activePostList = [Event]()
    }
    
    static func loadEventFeed(homeViewModel: HomeViewModel,feed: [Event],position: Int){
        homeViewModel.currentPost = 0
        homeViewModel.activePostList = feed
        
        /*
        homeViewModel.activePostList[0] = feed[position]
        homeViewModel.currentPost = 0
        homeViewModel.activePostList = feed
        homeViewModel.currentPost = position
        
        var count = 0
        
        for event in homeViewModel.activePostList{
            if feed[count] != nil{
                homeViewModel.activePostList[count] = feed[count]
            }
            if count == position{
                homeViewModel.currentPost = position
            }
            count += 1
        }
        */
        
        
        
        /*
        if fromCarousel == true{
            print("carousel switch")
            let lastPosition = homeViewModel.savedEveryonePosition
            homeViewModel.currentPost = 0
            homeViewModel.activePostList = [newList[lastPosition]]
            for event in newList{
                if count > 0{
                    homeViewModel.activePostList.append(event)
                }
                count += 1
            }
            if lastPosition != 0{
                homeViewModel.currentPost = lastPosition
                homeViewModel.activePostList[0] = newList[0]
            }
        }else{
            homeViewModel.currentPost = 0
            homeViewModel.activePostList = [newList[0]]
            if newList.count > 1{
                for savedEvent in newList{
                    if count > 0{
                        homeViewModel.activePostList.append(savedEvent)
                    }
                    count += 1
                }
            }
        }
        */
    }
    
    
    
    
    
    
    
}

    







