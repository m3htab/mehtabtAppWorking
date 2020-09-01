//
//  SigninViewButton.swift
//  theApp
//
//  Created by rob ord on 11/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI



struct SigninViewButtonView : View {
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(.red).frame(height: 100)
            Text("LOG IN").modifier(AuthViewSelectModifier())
        }
    }
}

struct SignupViewButtonView: View {
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(.blue).frame(height: 100)
            Text("SIGN UP").modifier(AuthViewSelectModifier())
        }
    }
}


