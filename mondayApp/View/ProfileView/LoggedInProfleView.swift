import SwiftUI

struct LoggedInProfileView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var session: SessionStore
    
 
    
    var body: some View {
        VStack{
            ProfileSharedViews(user: session.userData)
            Button(action: logout) {
                Text("Logout")
            }

            Text(session.userData.GetEmail()).foregroundColor(.white)

        }
    }
    
    
    
    func logout() {
        session.logout()
    }
}

struct loggedInUserView: View {
    
    var body: some View {
    
        Button(action: editProfile){
            Text("Edit")
        }
    }
    
    func editProfile(){
        print("edit profile")
    }
    
    
}

