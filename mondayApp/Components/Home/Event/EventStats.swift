
import SwiftUI

struct EventStats: View {
    
    let likeCount: Int
    var hasliked: Bool
    let joinCount: Int
    var hasJoined: Bool
    
    var body: some View {
        HStack{
            Spacer()
            Image(systemName: "camera.fill").foregroundColor(Color.white)
            Spacer()
            JoinCount(count:joinCount,hasJoined: hasliked)
            Spacer()
            LikeCount(count:likeCount,hasLiked: hasliked)
            Spacer()
        }
    }
}

