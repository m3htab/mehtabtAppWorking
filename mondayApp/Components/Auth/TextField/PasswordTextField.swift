import SwiftUI

struct PasswordTextField: View {
    
    @Binding var password: String
    
    var body: some View {
        VStack{
            HStack {
                SecureField(TEXT_PASSWORD, text: $password)
            }.modifier(TextFieldModifier())
        
            Divider().modifier(DividerLong())
        }
    }
}
