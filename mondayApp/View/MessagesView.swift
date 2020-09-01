import SwiftUI

struct messagesView: View {
   
    @EnvironmentObject var appState: AppState
    

    
    var body: some View {
        ZStack{
            Text("messages").foregroundColor(.white)
        }
    }
}


