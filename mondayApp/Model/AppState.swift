import SwiftUI

class AppState: ObservableObject {
    
    //Safe Area size
    @Published var safeArea: (top: CGFloat, bottom: CGFloat)
    @Published var size: (height: CGFloat, width: CGFloat)
    @Published var serverTimeOnSignin: Date?
    
    init() {
        self.safeArea = (0, 0)
        self.size = (0, 0)
    }
}
