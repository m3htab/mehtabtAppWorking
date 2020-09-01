import SwiftUI

struct FilterButtonsView: View {
    @Environment(\.presentationMode) var presentationMode

    
    @Binding var showNav : Bool
    @State private var showingFilters = false
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    
    var body: some View {
        VStack{
            if homeViewModel.showingEventList == false{
                HStack {
                    Spacer()
                    Button(action: {
                        self.filterViewModel.resetSelected()
                        self.showingFilters.toggle()})
                    {
                        Image(systemName: "calendar").resizable().frame(width:25,height: 25)
                    }
                    .sheet(isPresented: self.$showingFilters) {
                        FilterView(toggle: ToggleModel(filterViewModel: self.filterViewModel,isCalendarOn:  self.filterViewModel.GetHasSelectedCustomDate())).environmentObject(self.homeViewModel).environmentObject(self.filterViewModel)}
                    
                    Button(action: {withAnimation {
                        self.homeViewModel.showingEventList.toggle()
                        self.showNav.toggle()}})
                    {
                        Image(systemName: "magnifyingglass").resizable().frame(width:25,height: 25)
                        
                    }.padding(25)
                }.foregroundColor(.white)
                 .font(.headline)
            }else{
                Text("")
            }
        }
    }
    
    

    
}
