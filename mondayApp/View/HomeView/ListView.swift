import SwiftUI

struct EventListView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var showNav : Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                ForEach(homeViewModel.activePostList, id: \.self) { post in
                    EventListCardView(post: post,showNav:self.$showNav).environmentObject(self.homeViewModel)
                    
                }
            }
        }.padding(.top,150)

    }
    
}
