import SwiftUI

struct PagerView: View {
    //let posts: [Post]
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    @State private var offset: CGFloat = 0
    @State private var isUserSwiping: Bool = false
    //@Binding var postPos: Int
    @Binding var showNav: Bool
    
    @Binding var currentPost: Int

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    
                    ForEach(Array(zip(self.homeViewModel.activePostList.indices, self.homeViewModel.activePostList)), id: \.0){ index, item in
                    //ForEach(self.homeViewModel.activePostList, id: \.self){viewData in
                    //ForEach(self.posts) { viewData in
                        ZStack{
                            
                            Group{
                                EventView(isSelected: Binding<Bool>(get: { self.homeViewModel.currentPost == self.homeViewModel.currentPost }, set: { _ in }), index: index, event: item)
                                    .frame(width: geometry.size.width,
                                       height: geometry.size.height)    
                            }
                            Group{
                                if (self.homeViewModel.showingEventList){
                                    EventListView(showNav:self.$showNav).environmentObject(self.homeViewModel)
                                    //.animation(.easeInOut(duration: 0.1))
                                    //.transition(.asymmetric(insertion: .opacity, removal: .move(edge: .bottom)))
                                                                  
                                }else{
                                    ZStack{
                                        HStack{
                                            Rectangle().fill(Color.green).opacity(0.01).frame(width: geometry.size.width/2, height: geometry.size.height*0.6).padding(.trailing,1).onTapGesture {
                                                if self.homeViewModel.postPos != 0{
                                                    self.homeViewModel.decrementPost()
                                                }
                                            }
                                            Spacer()
                                            Rectangle().fill(Color.blue).opacity(0.01).frame(width: geometry.size.width/2, height: geometry.size.height*0.6).padding(.trailing,1).onTapGesture {
                                                
                                                self.homeViewModel.incrementPost()
                                            }
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            Group{
                                if (self.filterViewModel.GetActivatedFilter() != FILTERS.FORYOU && self.homeViewModel.postPos == 0){
                                VStack{
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    FilterButtonsView(showNav:self.$showNav).environmentObject(self.homeViewModel).environmentObject(self.filterViewModel)
                                    Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .content.offset(y: self.isUserSwiping ? self.offset : CGFloat(self.homeViewModel.currentPost) * -geometry.size.height)
            .frame(height: geometry.size.height, alignment: .top)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        if self.homeViewModel.showingEventList == false && self.homeViewModel.postPos == 0{
                            self.isUserSwiping = true
                            self.offset = value.translation.height + -geometry.size.height * CGFloat(self.homeViewModel.currentPost)
                        }
                    })
                    .onEnded({ value in
                        if self.homeViewModel.showingEventList == false && self.homeViewModel.postPos == 0{
                            if value.predictedEndTranslation.height < -geometry.size.height / 2, self.homeViewModel.currentPost < self.homeViewModel.activePostList.count - 1 {
                                self.homeViewModel.currentPost += 1
                                
                                //zero
                                //if self.homeViewModel.viewedPosts.contains(self.homeViewModel.currentPost){
                                 //   print("not the first time viewing post")
                                    //need to fix for different filter
                                //}else{
                                 //   self.homeViewModel.viewedPosts.append(self.homeViewModel.currentPost)
                                  //  print("first time viewing post")
                               //}
                                
                                
                            }
                            if value.predictedEndTranslation.height > geometry.size.height / 2, self.homeViewModel.currentPost > 0 {
                                self.homeViewModel.currentPost -= 1
                            }
                            withAnimation {
                                self.isUserSwiping = false
                            }
                        }
                    })
                    
                )
                
            
        }
    }
}

/*
 //ForEach(self.homeViewModel.activePostList) { viewData in
     ZStack{
            EventView(event: self.homeViewModel.activePostList[self.homeViewModel.currentPost]
            ).environmentObject(self.homeViewModel).frame(width: geometry.size.width,height: geometry.size.height)
         
         VStack{
             Spacer()
             Spacer()
             Spacer()
             if (self.filterViewModel.GetActivatedFilter() != FILTERS.FORYOU){
                 FilterButtonsView(showNav:self.$showNav).environmentObject(self.homeViewModel).environmentObject(self.filterViewModel)
             }
             Spacer()
         }
     }.frame(width: geometry.size.width,
     height: geometry.size.height)
 */

/*
 if (self.homeViewModel.showingEventList){
     ZStack{
         //Image(homeViewModel.activePostList[homeViewModel.currentPost].image)
         //        .resizable()
         //        .clipped()
         //        .edgesIgnoringSafeArea(.all)
         //Image("loadingImage").resizable().clipped().edgesIgnoringSafeArea(.all)
         HStack {
             EventListView(showNav:self.$showNav).environmentObject(self.homeViewModel)
             .animation(.easeInOut(duration: 0.1))
             .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .bottom)))
         }.padding(.top,10)
     }
 }
 */

/*
 EventView(event: self.homeViewModel.activePostList[self.homeViewModel.currentPost])
 .environmentObject(self.homeViewModel).frame(width: geometry.size.width,height: geometry.size.height)
 */
