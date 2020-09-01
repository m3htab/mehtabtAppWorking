import SwiftUI

struct EmailTextField: View {
    
    @Binding var email: String
    
    var body: some View {
        VStack{
            HStack {
                TextField(TEXT_EMAIL, text: $email)
            }.modifier(TextFieldModifier())
            
            Divider().modifier(DividerLong())
        }
    }
}



