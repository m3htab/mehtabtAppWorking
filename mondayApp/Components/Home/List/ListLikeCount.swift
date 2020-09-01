
import SwiftUI

struct ListLikeCount: View {
    
    var count: Int
    @State var hasLiked: Bool
    var body: some View {
        HStack{
            if hasLiked{
                Image(systemName: "suit.heart.fill").foregroundColor(.red)
            }else{
                Image(systemName: "suit.heart").foregroundColor(.red)
            }
            Text(String(count)).foregroundColor(.white)
        }
        
    }

    
}

