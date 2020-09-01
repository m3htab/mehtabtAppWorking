
import SwiftUI

struct JoinCount: View {
    
    let count: Int
    @State var hasJoined: Bool
    var body: some View {
        Button(action: performLike){
            HStack{
                if hasJoined{
                    Image("activityActive")
                }else{
                    Image("activity")
                }
                Text(String(count)).customBoldFont()
            }.foregroundColor(.white)
        }
    }
    
    func performLike(){
        self.hasJoined.toggle()
    }
    
}
