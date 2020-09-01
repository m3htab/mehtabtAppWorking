import SwiftUI

struct EventListCardView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var post: Event
    @Binding var showNav : Bool

    

    
    var body: some View {
        HStack {

            VStack(alignment: .leading) {
                Text(post.GetTitle()).listTitleText()
                HStack{
                    Text(post.GetLocationType().rawValue).listLocationTypeText()
                    Spacer()
                    Text(post.GetLocationToShow()).listLocationToShowText()
                }.padding(.leading,3).padding(.trailing,5)
                HStack{
                    Text(post.GetDateToShow()).listDateToShowText()
                    Spacer()
                    ListEventStats(likeCount: post.GetLikeCount(),hasliked: post.GetHasLiked(), joinCount: post.GetJoinCount(),hasJoined: post.GetHasUserJoined())
                }.padding(.leading,3).padding(.trailing,5)
                
            }.padding(.all,3)

        }.listCard().onTapGesture {
                guard let index = self.homeViewModel.activePostList.firstIndex(of: self.post)else{return}
                self.homeViewModel.currentPost = index
                self.homeViewModel.showingEventList.toggle()
                self.showNav.toggle()
        }
         
    }
}

