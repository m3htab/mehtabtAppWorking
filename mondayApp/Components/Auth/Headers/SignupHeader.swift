//
//  SignupHeader.swift
//  theApp
//
//  Created by rob ord on 11/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI

struct SignupHeader: View {
    var body: some View {
        HStack{
            Text("Create an app Account").modifier(AuthTitle())
            Spacer()
        }
    }
}

struct SignupHeader_Previews: PreviewProvider {
    static var previews: some View {
        SignupHeader()
    }
}
