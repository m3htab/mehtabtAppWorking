import SwiftUI

struct ListJoinCount: View {
    
    let count: Int
    @State var hasJoined: Bool
    var body: some View {

        HStack{
            if hasJoined{
                Image("activityActive").foregroundColor(.red)
            }else{
                Image("activity").foregroundColor(.red)
            }
            Text(String(count)).foregroundColor(.white)
        }
        
    }
    
}
