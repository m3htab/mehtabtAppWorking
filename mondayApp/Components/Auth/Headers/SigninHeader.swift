//
//  SigninHeader.swift
//  theApp
//
//  Created by rob ord on 11/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI

struct SigninHeader: View {
    var body: some View {
        HStack{
            Text("Sign in to app").modifier(AuthTitle())
            Spacer()
        }
    }
}

struct SigninHeader_Previews: PreviewProvider {
    static var previews: some View {
        SigninHeader()
    }
}
