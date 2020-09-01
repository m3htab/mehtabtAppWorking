import SwiftUI

struct EventView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @Binding var isSelected: Bool
    let index: Int

    let event: Event
    

    
    
    //@Binding var isSelected: Bool
    var body: some View {
        ZStack{
            
        
            Group{
                if homeViewModel.postPos == 0{
                    ZStack{
                        Image(String(index)).resizable().aspectRatio(contentMode: .fit)
                        .clipped()
                        mainEventView(event: event, homeViewModel: homeViewModel)
                    }
                    
                }else{
                    eventGalleryView(event: event, homeViewModel: homeViewModel,pos: homeViewModel.postPos)
                }
            }
        
        }

        
    }
    

}

struct mainEventView: View{
    let event: Event
    let homeViewModel: HomeViewModel
    
    var body: some View{
        Group{
            if homeViewModel.showingEventList == false{
                if event.GetPostID() != "No results"{
  
                  
                            HStack{
                                VStack(alignment: .leading){
                                    Text("ID:  "+event.GetPostID()).foregroundColor(.white)
                                    Text(event.GetLocationType().rawValue).locationTypeText()
                                    Text(event.GetLocationToShow()).locationToShowText()
                                    Text(event.GetDateToShow()).dateToShowText()
                                    Text(String(event.GetCanUserAdd())).dateToShowText()
                                }
                                Spacer()
                            }
                        
                            VStack{
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                EventStats(likeCount: event.GetLikeCount(),hasliked: event.GetHasLiked(), joinCount: event.GetJoinCount(),hasJoined: event.GetHasUserJoined())
                                Spacer()
                        }


                    
                //.background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.white))
                }else{
                    Text("No results").noResultsText()
                }
            }
        }
    }
}

struct eventGalleryView: View{
    let event: Event
    let homeViewModel: HomeViewModel
    var pos: Int
    var body: some View{
        Group{
            Text(String(pos)).foregroundColor(Color.white)
        }
    }
}
