import SwiftUI
import Foundation

extension View{
    func customBoldFont() -> some View{
        self.modifier(FontBold())
    }
}





//Filter View
extension View{
    func filterTitle() -> some View{
        self.modifier(FilterTitle())
    }
    func venueItemText(venue: EVENT_LOCATION_TYPES,selectedVenue: EVENT_LOCATION_TYPES) -> some View{
        self.modifier(FilterVenueItemText(venue: venue,selectedVenue: selectedVenue))
    }
    func venueItem(venue: EVENT_LOCATION_TYPES,selectedVenue: EVENT_LOCATION_TYPES) -> some View{
        self.modifier(FilterVenueItem(venue: venue, selectedVenue: selectedVenue))
    }
    func cityItemText(city: String,selectedCity: String) -> some View{
        self.modifier(FilterCityItemText(city: city,selectedCity: selectedCity))
    }
    func cityItem(city: String,selectedCity: String) -> some View{
        self.modifier(FilterCityItem(city: city, selectedCity: selectedCity))
    }
    func accomodationItemText(accomodation: String,selectedAccomodation: String) -> some View{
        self.modifier(FilterAccomodationItemText(accomodation: accomodation,selectedAccomodation: selectedAccomodation))
    }
    func accomodationItem(accomodation: String,selectedAccomodation: String) -> some View{
        self.modifier(FilterAccomodationItem(accomodation: accomodation, selectedAccomodation: selectedAccomodation))
    }
    func filterClearButtonText()-> some View{
        self.modifier(FilterClearButtonText())
    }
    func filterClearButton()-> some View{
        self.modifier(FilterClearButton())
    }
    func filterApplyButtonText()-> some View{
        self.modifier(FilterApplyButtonText())
    }
    func filterApplyButton()-> some View{
        self.modifier(FilterApplyButton())
    }
    func filterSheet()-> some View{
        self.modifier(FilterSheetLayout())
    }
}
//for event extensions
extension View{
    func noResultsText()-> some View{
        self.modifier(EventNoResultsModifier())
    }
    func locationToShowText()-> some View{
        self.modifier(EventLocationToShow())
    }
    func dateToShowText()-> some View{
        self.modifier(EventDateToShow())
    }
    func locationTypeText()-> some View{
        self.modifier(EventLocationType())
    }
    func titleText()-> some View{
        self.modifier(EventTitle())
    }
    
    
    
}

extension View{
    func listCard()-> some View{
        self.modifier(ListCard())
    }
    func listLocationToShowText()-> some View{
        self.modifier(ListEventLocationToShow())
    }
    func listDateToShowText()-> some View{
        self.modifier(ListEventDateToShow())
    }
    func listLocationTypeText()-> some View{
        self.modifier(ListEventLocationType())
    }
    func listTitleText()-> some View{
        self.modifier(ListTitle())
    }
}
