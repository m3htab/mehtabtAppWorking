import SwiftUI

struct NameTextField: View {

    @Binding var firstName: String
    @Binding var lastName: String
    
    var body: some View {
        HStack {
            VStack{
                HStack{
                    TextField(TEXT_FIRSTNAME, text: $firstName)
                }.modifier(TextFieldModifier())
                Divider().modifier(DividerShort())
            }
            VStack{
                HStack{
                    TextField(TEXT_LASTNAME, text: $lastName)
                }.modifier(TextFieldModifier())
                Divider().modifier(DividerShort())
            }
        }
     }
}


