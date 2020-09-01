import SwiftUI

struct FilterView: View{
    @EnvironmentObject var filterViewModel: FilterViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var toggle: ToggleModel
    var body: some View {
        Group{
            if(filterViewModel.GetActivatedFilter() == FILTERS.EVERYONE){
                EveryoneFilterView(toggle: $toggle).environmentObject(self.homeViewModel).environmentObject(filterViewModel)
            }
            else if (filterViewModel.GetActivatedFilter() == FILTERS.POPULAR){
                PopularFilterView(toggle: $toggle).environmentObject(self.homeViewModel).environmentObject(filterViewModel)
            }
        }
    
    }
}
