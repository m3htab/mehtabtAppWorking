import Firebase
import FirebaseFirestoreSwift


class EveryoneService{
    
    
    static func loadEveryoneFeed(homeViewModel: HomeViewModel, city: String,accomodation: String,venue: EVENT_LOCATION_TYPES,fromCarousel: Bool,customDate: Bool,dates: [String],currentDate:Date,uid:String,friendList: [String]){
        
        let loadSavedResult = HomeViewModel.tryLoadEventSavedFeed(homeViewModel: homeViewModel, feedType: FILTERS.EVERYONE, city: city, accomodation: accomodation, venue: venue,fromCarousel: fromCarousel, customDate: customDate,dates:dates)
        if loadSavedResult == false{
            print("**************NEW EVERYONE SEARCH***********")
            HomeViewModel.resetFeed(homeViewModel: homeViewModel)
            
            let searchContainter = SavedEveryoneEventFeed.createFeed(city: city, accomodation: accomodation, venue: venue,fails: 0, postList: [Event]())
            homeViewModel.savedEveryoneEventFeeds.append(searchContainter)
            
            EveryoneService.getEveryoneEvents(homeViewModel: homeViewModel, city: city, accomodation: accomodation, venue: venue, fails : 0,postPosition: 0,customDate: customDate,dates: dates,currentDate:currentDate,uid:uid,friendList: friendList)
        }
    }
    
    //MARK: - Recursive event downloader
    static func getEveryoneEvents(homeViewModel: HomeViewModel,city: String,accomodation: String,venue: EVENT_LOCATION_TYPES, fails: Int, postPosition: Int,customDate: Bool,dates: [String],currentDate:Date,uid:String,friendList: [String]){
        print("EVERYONE Function called")
        print("fails:", fails)
        print("Downloading for post position:",postPosition)
        
        var failedAttempts = fails
        var onSuccessPosition = postPosition
        guard
            let savedIndex = SavedEveryoneEventFeed.getIndex(savedSearches: homeViewModel.savedEveryoneEventFeeds,city: city, accomodation: accomodation, venue: venue)
        else{print("could'nt find saved search");return}
        
        if city == "All"{
            //MARK: - Random Event
            NetworkServiceEvent.GetEventPublicObjectByRandom(
                    city: city,
                    venue: venue,
                    accomodation: accomodation,
                    customDate: customDate,
                    dates: dates,
                    currentDate: currentDate,
                    uid:uid,
                    friendList: friendList,
                    completion: { event in



                        
                        if event == nil{
                            let event = Event()
                            event.SetPostID(id: "No results")
                            homeViewModel.activePostList[0] = event// put empty event here
                            print("no results found")
                            failedAttempts += 1
                            
                            if failedAttempts > FAILED_ATTEMPTS_LIMIT && homeViewModel.savedEveryoneEventFeeds[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                                getEveryoneEvents(homeViewModel: homeViewModel, city: city, accomodation: accomodation, venue: venue, fails: failedAttempts, postPosition: postPosition, customDate: customDate,dates:dates,currentDate:currentDate,uid:uid,friendList: friendList)
                            }else{
                                print("this is last call")
                                return
                            }
                        }
                        else{
                            print("Event Downloaded and parsed for position",postPosition)
                            if Event.testForDupeEvent(postList: homeViewModel.savedEveryoneEventFeeds[savedIndex].postList, post: event!) != nil{
                                failedAttempts += 1
                                if failedAttempts < FAILED_ATTEMPTS_LIMIT && homeViewModel.savedEveryoneEventFeeds[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                                    getEveryoneEvents(homeViewModel: homeViewModel, city: city, accomodation: accomodation, venue: venue, fails: failedAttempts, postPosition: postPosition, customDate: customDate,dates:dates,currentDate:currentDate,uid:uid,friendList: friendList)
                                }else{
                                    print("this is last call")
                                    return
                                }
                            }else{
                                //update the saved search
                                homeViewModel.savedEveryoneEventFeeds[savedIndex].postList.append(event!)
                                //update the active list

                                homeViewModel.activePostList.append(event!)
                                
                                onSuccessPosition += 1
                                if failedAttempts < FAILED_ATTEMPTS_LIMIT && homeViewModel.savedEveryoneEventFeeds[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                                    getEveryoneEvents(homeViewModel: homeViewModel, city: city, accomodation: accomodation, venue: venue, fails: failedAttempts, postPosition: onSuccessPosition, customDate: customDate,dates:dates,currentDate:currentDate,uid:uid,friendList: friendList)
                                }else{
                                    print("this is last call")
                                }
                                return
                            }
                        }
                })

            }else{
                //MARK: - Ordered Feed
            EveryoneService.firstDateSearch(homeViewModel: homeViewModel, city: city, venue: venue, accomodation: accomodation, completion: { event,doc in
                
                if event != nil && doc != nil{
                    homeViewModel.activePostList.append(event!)
                    homeViewModel.savedEveryoneEventFeeds[savedIndex].postList.append(event!)
                    homeViewModel.savedEveryoneEventFeeds[savedIndex].lastDoc = doc
                    EveryoneService.recursiveDateSearch(homeViewModel: homeViewModel, city: city, venue: venue, accomodation: accomodation, startPostition: doc!, savedIndex: savedIndex)
                }else {
                    let event = Event()
                    event.SetPostID(id: "No results")//     PUT EMPTY EVENT HERE
                    homeViewModel.savedEveryoneEventFeeds[savedIndex].postList.append(event)
                    homeViewModel.activePostList.append(event)
                }

            })

            }
        }
    
    static func firstDateSearch(homeViewModel: HomeViewModel,city: String,venue: EVENT_LOCATION_TYPES,accomodation:String, completion: @escaping (_ data: Event?,_ doc: DocumentSnapshot?) -> Void){
        let query = EveryoneQueries.dateInitialQueryGenerator(type: venue, city: city, accomodation: accomodation)
        EventService.GetEventPublicObjectByQuery(query: query, needDoc: true, completion: { event,doc in
            if event != nil && doc != nil{
                completion(event,doc)
            }else{
                completion(nil,nil)
            }
        })
        
    }
    
    static func recursiveDateSearch(homeViewModel: HomeViewModel,city: String,venue: EVENT_LOCATION_TYPES,accomodation:String,startPostition: DocumentSnapshot,savedIndex: Int){
        print("recursve everyone search called")
        let query = EveryoneQueries.dateRecursiveQueryGenerator(type: venue, city: city, accomodation: accomodation, startPosition: startPostition)
        EventService.GetEventPublicObjectByQuery(query: query,needDoc: true, completion: {event,doc in
            if event != nil && doc != nil{
                homeViewModel.activePostList.append(event!)
                homeViewModel.savedEveryoneEventFeeds[savedIndex].postList.append(event!)
                homeViewModel.savedEveryoneEventFeeds[savedIndex].lastDoc = doc
                if homeViewModel.savedEveryoneEventFeeds[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                    recursiveDateSearch(homeViewModel: homeViewModel, city: city, venue: venue,accomodation: accomodation,startPostition: doc!, savedIndex: savedIndex)
                }
            }
        })
        
    }

    
    
    
    
}
