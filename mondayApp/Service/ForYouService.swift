import Firebase
import FirebaseFirestoreSwift

class ForYouService{
/*
    static func loadForYouFeed(homeViewModel: HomeViewModel,fromCarousel: Bool){
        let loadSavedResult = HomeViewModel.tryLoadSavedSearch(homeViewModel: homeViewModel, filter: FILTERS.FORYOU, city: "FY", location: "FY", privacy: PRIVACY.ALL,fromCarousel: fromCarousel, customDate: false,dates:[""])
        if loadSavedResult{
            print("found saved f search")
        }
        else{
            print("new f search")
            let searchContainer = HomeViewModel.createASavedSearchItem(filter: FILTERS.FORYOU, city: "", location: "", privacy: PRIVACY.ALL, fails: 0, postList: [Event](),customDate: false,dates: [""])
            homeViewModel.savedSearches.append(searchContainer)
            //ForYouService.getForYouEvents(homeViewModel: homeViewModel, fails: 0, postPosition: 0, friends: [""])

        }
    }
    
    
    
    
    
    static func getForYouEvents(homeViewModel: HomeViewModel, fails:Int, postPosition: Int,friends: [String]){
        print("for you search called")
        var failedAttempts = fails
        var onSuccessPosition = postPosition
        let shuffleFriendList = friends.shuffled()
        var queryFriendList = [String]()
        var count = 0
        for friend in shuffleFriendList{
            if count >= 10{
                break
            }
            queryFriendList.append(friend)
            count += 1
        }
               
        let downloadMethod = Int.random(in: 1..<3)
        
        switch downloadMethod {
        case 1:
            print("getting friend liked")
            // Get friend liked post
            getRandomFriendLikedEvent(friends: queryFriendList, completion:  { event in
                
                guard
                    let savedIndex = HomeViewModel.getIndexOfSavedSearch(savedSearches: homeViewModel.savedSearches, filter: FILTERS.FORYOU, city: "", location: "", privacy: PRIVACY.ALL, customDate: false,dates:[""])
                else{print("could'nt find saved search");return}
                
                
                //if no results call self again
                if event.GetErrorStatus() == EVENT_ERROR_STATUS.No_results{
                    print("no friend results")
                    failedAttempts += 1
                    getForYouEvents(homeViewModel: homeViewModel, fails: failedAttempts, postPosition: postPosition, friends: friends)
                }else{
                    if event.GetErrorStatus() == EVENT_ERROR_STATUS.No_Error{
                        if HomeViewModel.testForDupeEvent(postList: homeViewModel.savedSearches[savedIndex].postList, post: event) != nil{
                            failedAttempts += 1
                            if failedAttempts < FAILED_ATTEMPTS_LIMIT && homeViewModel.savedSearches[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                                 getForYouEvents(homeViewModel: homeViewModel, fails: failedAttempts, postPosition: postPosition, friends: friends)
                            }else{
                                print("last call")
                            }
                            
                        }else{
                            homeViewModel.savedSearches[savedIndex].postList.append(event)
                            homeViewModel.savedSearches[savedIndex].emptySearch = false
                            
                            if postPosition == 0{
                                homeViewModel.activePostList[postPosition] = event
                            }else{
                                homeViewModel.activePostList.append(event)
                            }
                            onSuccessPosition += 1
                            if failedAttempts < FAILED_ATTEMPTS_LIMIT && homeViewModel.savedSearches[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                                getForYouEvents(homeViewModel: homeViewModel, fails: failedAttempts, postPosition: onSuccessPosition, friends: friends)
                            }else{
                                print("last call")
                            }
                            
                        }

                    }
                    print("parse failed")
                    failedAttempts += 1
                    if failedAttempts < FAILED_ATTEMPTS_LIMIT && homeViewModel.savedSearches[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                         getForYouEvents(homeViewModel: homeViewModel, fails: failedAttempts, postPosition: postPosition, friends: friends)
                    }else{
                        print("last call")
                    }
                    
                }

                
            })
        case 2:
            print("getting fof interaction")
            
            getRandomFOFEventID(friends: queryFriendList, completion: { doc in
                let eventID = doc.EventID
                
                EventService.getEventWithID(ID: EVENT_ID, completion: { event in
                    guard
                        let savedIndex = HomeViewModel.getIndexOfSavedSearch(savedSearches: homeViewModel.savedSearches, filter: FILTERS.FORYOU, city: "", location: "", privacy: PRIVACY.ALL, customDate: false,dates:[""])
                    else{print("could'nt find saved search");return}
                    
                    
                    //if no results call self again
                    if event.GetErrorStatus() == EVENT_ERROR_STATUS.No_results{
                        print("no friend results")
                        failedAttempts += 1
                        getForYouEvents(homeViewModel: homeViewModel, fails: failedAttempts, postPosition: postPosition, friends: friends)
                    }else{
                        if event.GetErrorStatus() == EVENT_ERROR_STATUS.No_Error{
                            if HomeViewModel.testForDupeEvent(postList: homeViewModel.savedSearches[savedIndex].postList, post: event) != nil{
                                failedAttempts += 1
                                if failedAttempts < FAILED_ATTEMPTS_LIMIT && homeViewModel.savedSearches[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                                     getForYouEvents(homeViewModel: homeViewModel, fails: failedAttempts, postPosition: postPosition, friends: friends)
                                }else{
                                    print("last call")
                                }
                                
                            }else{
                                homeViewModel.savedSearches[savedIndex].postList.append(event)
                                homeViewModel.savedSearches[savedIndex].emptySearch = false
                                
                                if postPosition == 0{
                                    homeViewModel.activePostList[postPosition] = event
                                }else{
                                    homeViewModel.activePostList.append(event)
                                }
                                onSuccessPosition += 1
                                if failedAttempts < FAILED_ATTEMPTS_LIMIT && homeViewModel.savedSearches[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                                    getForYouEvents(homeViewModel: homeViewModel, fails: failedAttempts, postPosition: onSuccessPosition, friends: friends)
                                }else{
                                    print("last call")
                                }
                                
                            }

                        }
                        print("parse failed")
                        failedAttempts += 1
                        if failedAttempts < FAILED_ATTEMPTS_LIMIT && homeViewModel.savedSearches[savedIndex].postList.count < POSTS_TO_DOWNLOAD{
                             getForYouEvents(homeViewModel: homeViewModel, fails: failedAttempts, postPosition: postPosition, friends: friends)
                        }else{
                            print("last call")
                        }
                    }
                    
                    
                })
            })
            
        default:
            return
        }
        
        
    }
    

    static func getRandomFOFEventID(friends: [String],completion: @escaping (_ data: QueryDoc) -> Void){
        let db = Firestore.firestore()
        var query: Query
        var backup: Query
        let random = Int.random(in: 1..<20001)
        let randomFieldNo = Int.random(in: 1..<4)
        let field = "random" + String(randomFieldNo)

        let q1 = db.collectionGroup("Extra Query Data")
            .whereField(field, isLessThanOrEqualTo: random)
            .whereField(QUERY_FRIEND_LIST, arrayContainsAny: friends)
            .order(by: field, descending: true)
            .limit(to: 1)
        let q2 = db.collectionGroup("Extra Query Data")
            .whereField(field, isGreaterThanOrEqualTo: random)
            .whereField(QUERY_FRIEND_LIST, arrayContainsAny: friends)
            .order(by: field)
            .limit(to: 1)
        
        if (random % 2 == 0){
            query = q1
            backup = q2
        }else{
            query = q2
            backup = q1
        }
        query.getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print(err)
            } else {
                if(querySnapshot!.documents.isEmpty){
                    print("couldnt find first time")
                    backup.getDocuments(){ (querySnapshotB, err) in
                        if let err = err{
                            print(err)
                        }else{
                            if(querySnapshotB!.documents.isEmpty){
                                var doc = QueryDoc()
                                doc.setErrorStatus(status: DOWNLOAD_STATUS.Fail)
                                completion(doc)
                                print("couldnt find second")
                            }else{
                                for document in querySnapshotB!.documents{
                                   let parsedDoc = EventService.parseQueryDoc(document: document)
                                    completion(parsedDoc)

                                }
                                
                            }
                        }
                    }
                }else{
                for document in querySnapshot!.documents {
                    let parsedDoc = EventService.parseQueryDoc(document: document)
                     completion(parsedDoc)

                }
                
                
                }
              }
        }
    }
    
    
    
    
    
    
    
    
    static func getRandomFriendLikedEvent(friends: [String],completion: @escaping (_ data: Event) -> Void){
        let db = Firestore.firestore()
        var query: Query
        var backup: Query
        let random = Int.random(in: 1..<20001)
        let randomFieldNo = Int.random(in: 1..<4)
        let field = "random" + String(randomFieldNo)
        

        let q1 = db.collection("test_events").document("Future").collection("Public")
            .whereField(field, isLessThanOrEqualTo: random)
            .whereField(EVENT_LIKE_ID_LIST, arrayContainsAny: friends)
            .order(by: field, descending: true)
            .limit(to: 1)
        let q2 = db.collection("test_events").document("Future").collection("Public")
            .whereField(field, isGreaterThanOrEqualTo: random)
            .whereField(EVENT_LIKE_ID_LIST, arrayContainsAny: friends)
            .order(by: field)
            .limit(to: 1)
        

        if (random % 2 == 0){
            query = q1
            backup = q2
        }else{
            query = q2
            backup = q1
        }
        query.getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print(err)
            } else {
                if(querySnapshot!.documents.isEmpty){
                    print("couldnt find first time")
                    backup.getDocuments(){ (querySnapshotB, err) in
                        if let err = err{
                            print(err)
                        }else{
                            if(querySnapshotB!.documents.isEmpty){
                                var event = Event()
                                event.SetErrorStatus(status: EVENT_ERROR_STATUS.No_results)
                                completion(event)
                                print("couldnt find second")
                            }else{
                                for document in querySnapshotB!.documents{
                                   let parsedEvent = EventService.parseEventDoc(document: document)
                                    completion(parsedEvent)

                                }
                                
                            }
                        }
                    }
                }else{
                for document in querySnapshot!.documents {
                    let parsedEvent = EventService.parseEventDoc(document: document)
                    completion(parsedEvent)

                }
                
                
                }
              }
        }
        
        
        
        
    }
    
*/
}
