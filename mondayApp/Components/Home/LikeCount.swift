
import SwiftUI

struct LikeCount: View {
    
    var count: Int
    @State var hasLiked: Bool
    var body: some View {
        Button(action: performLike){
            HStack{
                if hasLiked{
                    Image(systemName: "suit.heart.fill")
                }else{
                    Image(systemName: "suit.heart")
                }
                Text(String(count)).customBoldFont()
            }.foregroundColor(.white)
        }
    }
    
    func performLike(){
        self.hasLiked.toggle()

    }
    
}

