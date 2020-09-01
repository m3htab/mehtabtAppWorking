import SwiftUI

struct CalCell: View {
    
    var calDate: CalDate
    
    var cellWidth: CGFloat
    
    var body: some View {
        Text(calDate.getText())
            .fontWeight(calDate.getFontWeight())
            .foregroundColor(calDate.getTextColor())
            .frame(width: cellWidth, height: cellWidth)
            .font(.system(size: 12))
            .background(calDate.getBackgroundColor())
            .cornerRadius(cellWidth/2)
    }
}




