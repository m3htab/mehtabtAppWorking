//
//  SignupButton.swift
//  theApp
//
//  Created by rob ord on 10/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI


struct SignupButton: View {
    var action: () -> Void
    var label: String
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(label).fontWeight(.bold).foregroundColor(Color.white)
                Spacer()
            }
            
        }.modifier(SigninButtonModifier())
    }
}
