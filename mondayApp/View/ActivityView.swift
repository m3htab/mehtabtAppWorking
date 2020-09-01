import SwiftUI

struct activityView: View {
    
    @EnvironmentObject var appState: AppState
    
    
    var body: some View {
        ZStack{
            Text("activity").foregroundColor(.white)
        }
    }
}


