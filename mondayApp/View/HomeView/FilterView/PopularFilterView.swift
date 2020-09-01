import SwiftUI


struct PopularFilterView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    @State var isSelectedFilter : Bool = true
    
    
    @State var showTooManyDatesAlert = false
    @Binding var toggle: ToggleModel
    
    var body: some View {
      VStack {
            Text(FILTER_TITLE_TEXT)
                .bold()
                .padding(.top, 10)
                .filterTitle()
            Divider()
                VStack(alignment: .leading) {
                    Group{
                        Text(FILTER_CITY_TEXT)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(filterViewModel.GetAllCities(), id: \.self) {city in
                                    Button(action: {
                                        self.filterViewModel.SetPopularSelectedCity(city: city)
                                        self.filterViewModel.updateAccomList(city: self.filterViewModel.GetPopularSelectedCity())
                                        if city == "All"{self.filterViewModel.SetPopularSelectedAccomodation(Accomodation: "All")}})
                                    {
                                        Text(city)
                                            .fontWeight(.semibold)
                                            .cityItemText(city: city,selectedCity: self.filterViewModel.GetPopularSelectedCity())
                                    }.cityItem(city: city, selectedCity: self.filterViewModel.GetPopularSelectedCity())
                                }
                            }
                        }
                        
                    }
                    Group{
                        Text(FILTER_VENUE_TEXT)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        HStack {
                            ForEach(filterViewModel.GetAllVenue(), id: \.self) {venue in
                                Button(action: {self.filterViewModel.SetPopularSelectedVenue(Venue: venue)})
                                {
                                    Text(venue.rawValue)
                                        .fontWeight(.semibold)
                                        .venueItemText(venue: venue, selectedVenue: self.filterViewModel.GetPopularSelectedVenue())
                                }
                                .venueItem(venue: venue, selectedVenue: self.filterViewModel.GetPopularSelectedVenue())
                        }
                        }
                        
                    }


                    Group{
                        Toggle("",isOn: $toggle.isCalendarOn).toggleStyle(ColoredToggleStyle(label: FILTER_CUSTOMDATE_TEXT))
                        
                        if filterViewModel.GetIsSelectingCustomDate(){
                            CalViewController(calendarManager: CalendarManager(
                                calendar: Calendar.current,
                                minimumDate: Date(),
                                maximumDate: Date().addingTimeInterval(TimeInterval((60*60*24*filterViewModel.GetDaysInFilter()))),
                                selectedDates: filterViewModel.GetSelectedDates(),
                                mode: 3)
                                ).environmentObject(filterViewModel)
                        }else{
                            Spacer()
                        }
                    }
                    Group{
                        HStack {
                            Button(action: clearFilter)
                            {
                                Text(FILTER_CLEAR_BUTTON_TEXT).filterClearButtonText()
                            }.filterClearButton()
                            Spacer()
                            Button(action: applyFilter)
                            {
                                Text(FILTER_APPLY_BUTTON_TEXT)
                                    .fontWeight(.heavy)
                                    .filterApplyButtonText().filterApplyButton()
                            }
                        }.font(.headline)
                    }
                }.filterSheet()
            }.alert(isPresented: $showTooManyDatesAlert){
                     Alert(title: Text(FILTER_DATEERROR_TITLE), message: Text(FILTER_DATEERROR_MESSAGE), dismissButton: .default(Text(FILTER_DATEERROR_OK)))
        }
        
        
    
    }
    
    func clearFilter() {
        
        self.filterViewModel.ClearPopularFilter()
        if self.toggle.isCalendarOn == true{
            self.toggle.isCalendarOn = false
        }

    }
    
    func applyFilter() {

        if self.filterViewModel.GetSelectedDatesCount() <= 9{
            filterViewModel.ApplyPopularFilter()
            HomeViewModel.loadNewFeed(homeViewModel: self.homeViewModel, filterViewModel: self.filterViewModel, newFilter: FILTERS.POPULAR, fromCarousel: false)
            self.presentationMode.wrappedValue.dismiss()
        }else{
            showTooManyDatesAlert = true
        }
    }
}

