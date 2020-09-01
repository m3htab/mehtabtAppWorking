import SwiftUI

struct Home: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    @State private var currentPost: Int = 0
    @Binding var showNav : Bool

    @State private var offset: CGSize = .zero
    @State private var didJustSwipe = false
    

    var body: some View {
        
        
        ZStack(alignment: .topLeading) {


            PagerView(showNav: $showNav,currentPost: self.$currentPost).environmentObject(homeViewModel).edgesIgnoringSafeArea(.all).environmentObject(filterViewModel)
            //SwiperView(posts: self.posts, currentPost: self.$currentPost)
            .edgesIgnoringSafeArea(.all)
            
            
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom))
                .frame(height: 140)
                .edgesIgnoringSafeArea(.top)
            
            
            CarouselView().padding(.top,50)
        }
    }
    
}

