//
//  ProfileSharedViews.swift
//  theApp
//
//  Created by rob ord on 31/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI

struct ProfileSharedViews: View {
    
    var user: aUser
    
    
    var body: some View {
        HStack{
            Text(user.GetFirstName()).foregroundColor(.white)
            Text(user.GetLastName()).foregroundColor(.white)
        }
    }
}

struct ProfileSharedViews_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSharedViews(user: UserProfile())
    }
}
