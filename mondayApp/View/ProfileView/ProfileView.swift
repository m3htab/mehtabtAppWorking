//
//  ProfileView.swift
//  theApp
//
//  Created by rob ord on 31/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var user: UserProfile
    
    var body: some View {
        
        
        ProfileSharedViews(user: user)
        
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: UserProfile())
    }
}
