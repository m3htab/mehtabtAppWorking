import SwiftUI


struct EveryoneFilterView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var filterViewModel: FilterViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
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
                        .padding(.bottom, 5)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(filterViewModel.GetAllCities(), id: \.self) {city in
                                Button(action: {
                                    self.filterViewModel.SetEveryoneSelectedCity(city: city)
                                    self.filterViewModel.updateAccomList(city: self.filterViewModel.GetEveryoneSelectedCity())
                                    if city == "All"{self.filterViewModel.SetEveryoneSelectedAccomodation(Accomodation: "All")}})
                                {
                                    Text(city)
                                        .fontWeight(.semibold)
                                        .cityItemText(city: city,selectedCity: self.filterViewModel.GetEveryoneSelectedCity())
                                }.cityItem(city: city, selectedCity: self.filterViewModel.GetEveryoneSelectedCity())
                            }
                        }.padding(.top,5)
                    }
                }
                Group{
                    Text(FILTER_VENUE_TEXT)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    HStack {
                        ForEach(filterViewModel.GetAllVenue(), id: \.self) {venue in
                            Button(action: {self.filterViewModel.SetEveryoneSelectedVenue(Venue: venue)})
                            {
                                Text(venue.rawValue)
                                    .fontWeight(.semibold)
                                    .venueItemText(venue: venue, selectedVenue: self.filterViewModel.GetEveryoneSelectedVenue())
                            }
                            .venueItem(venue: venue, selectedVenue: self.filterViewModel.GetEveryoneSelectedVenue())
                        }
                    }.padding(.top,5)
                }

                Group{
                    if (filterViewModel.GetEveryoneAccomodationList() != [""] && filterViewModel.GetEveryoneSelectedVenue() == EVENT_LOCATION_TYPES.accomodation){
                        Text(FILTER_ACCOMODATION_TEXT).fontWeight(.bold)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(filterViewModel.GetEveryoneAccomodationList(), id: \.self) {Accomodation in
                                    Button(action: {self.filterViewModel.SetEveryoneSelectedAccomodation(Accomodation: Accomodation)})
                                    {
                                        Text(Accomodation)
                                            .fontWeight(.semibold)
                                            .accomodationItemText(accomodation: Accomodation, selectedAccomodation: self.filterViewModel.GetEveryoneSelectedAccomodation())
                                    }
                                    .accomodationItem(accomodation: Accomodation, selectedAccomodation: self.filterViewModel.GetEveryoneSelectedAccomodation())
                                }
                            }
                        }
                        Divider()
                    }
                }
                /*Group{
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
                }*/
                Spacer()
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
        self.filterViewModel.ClearEveryoneFilter()
        if self.toggle.isCalendarOn == true{
            self.toggle.isCalendarOn = false
        }
    }
    
    func applyFilter() {
        
        if self.filterViewModel.GetSelectedDatesCount() <= 9{
            //if self.filterViewModel.CheckForEveryoneChanges(){
                filterViewModel.ApplyEveryoneFilter()
                HomeViewModel.loadNewFeed(homeViewModel: self.homeViewModel, filterViewModel: self.filterViewModel, newFilter: FILTERS.EVERYONE, fromCarousel: false)
                let dats = FilterViewModel.FormatCalenderDateToQueryString(dateList: filterViewModel.GetTrueDates())
                for date in dats{
                    print(date)
                }
            //}
            self.presentationMode.wrappedValue.dismiss()
        }else{
            showTooManyDatesAlert = true
        }
    }
}


