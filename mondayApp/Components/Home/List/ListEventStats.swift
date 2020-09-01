

import SwiftUI

struct ListEventStats: View {
    
    let likeCount: Int
    var hasliked: Bool
    let joinCount: Int
    var hasJoined: Bool
    
    var body: some View {
        HStack{
            ListJoinCount(count:joinCount,hasJoined: hasliked)
            ListLikeCount(count:likeCount,hasLiked: hasliked)
        }
    }
}

