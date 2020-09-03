//
//  Modifiers.swift
//  theApp
//
//  Created by rob ord on 10/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import SwiftUI

/*
 Auth Modifiers
 */



struct FontBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FONT_BOLD, size: FONT_BOLD_SIZE))
    }
}


struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top,30)
            .padding(.leading, 13)
    }
}

struct SigninButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.padding().background(Color.black).cornerRadius(5).shadow(radius: 10, x: 0, y: 10).padding()
    }
}

struct AuthViewSelectModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(radius: 10)
            .foregroundColor(.white)
    }
}

struct SmallNote: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(.gray)
            .padding([.leading])
    }
}

struct AuthTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading,10)
            .font(.title)
    }
}


struct DividerLong: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 270,height: 1)
            .padding(.horizontal, 30)
            .padding(.trailing,50)
            .background(Color.gray)
            .opacity(0.1)
    }
}

struct DividerShort: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 80,height: 1)
            .padding(.horizontal, 30)
            .padding(.trailing,30)
            .background(Color.gray)
            .opacity(0.1)
    }
}
/*
Filter Modifiers
*/

struct FilterTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
    }
}

struct FilterVenueItemText: ViewModifier {
    let venue: EVENT_LOCATION_TYPES
    let selectedVenue: EVENT_LOCATION_TYPES
    func body(content: Content) -> some View {
        content
            .foregroundColor(venue == selectedVenue ? .white: .black)
            .font(.footnote)
            .padding(8)
    }
}
struct FilterVenueItem: ViewModifier {
    let venue: EVENT_LOCATION_TYPES
    let selectedVenue: EVENT_LOCATION_TYPES
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(venue == selectedVenue ? COLOR_TEAL: COLOR_FILTER_UNSELECTED)
            .cornerRadius(25.0)
            .padding(.horizontal, 5)
    }
}

struct FilterCityItemText: ViewModifier {
    let city: String
    let selectedCity: String
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(city == selectedCity ? .white : .black)
            .padding(.vertical, 8)
            .padding(.horizontal, 15)
    }
}

struct FilterCityItem: ViewModifier {
    let city: String
    let selectedCity: String
    func body(content: Content) -> some View {
        content
        .frame(minWidth: 30)
        .background(city == selectedCity ? COLOR_TEAL : COLOR_FILTER_UNSELECTED)
        .cornerRadius(25.0)
        .padding(.horizontal, 5)
    }
}

struct FilterAccomodationItemText: ViewModifier {
    let accomodation: String
    let selectedAccomodation: String
    func body(content: Content) -> some View {
        content
        .font(.footnote)
        .foregroundColor(accomodation == selectedAccomodation ? .white : .black)
        .padding(.vertical, 8)
        .padding(.horizontal, 15)
    }
}

struct FilterAccomodationItem: ViewModifier {
    let accomodation: String
    let selectedAccomodation: String
    func body(content: Content) -> some View {
        content
        .frame(minWidth: 30)
        .background(accomodation == selectedAccomodation ? COLOR_TEAL : COLOR_FILTER_UNSELECTED)
        .cornerRadius(25.0)
        .padding(.horizontal, 5)
    }
}
struct FilterClearButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(COLOR_FILTER_CLEARBUTTON)
    }
}
struct FilterClearButton: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding()
    }
}
struct FilterApplyButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .padding()
    }
}
struct FilterApplyButton: ViewModifier {
    func body(content: Content) -> some View {
        content
        .frame(maxWidth: .infinity)
        .background(COLOR_TEAL)
        .cornerRadius(15.0)
    }
}
struct FilterSheetLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
    }
}

//MARK: - Event
struct EventTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .customBoldFont()
    }
}
struct EventNoResultsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .customBoldFont()
    }
}

struct EventLocationToShow: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .customBoldFont()
    }
}


struct EventDateToShow: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .customBoldFont()
    }
}


struct EventLocationType: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .customBoldFont()
    }
}
//MARK: - Event List


struct ListEventLocationToShow: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .customBoldFont()
    }
}

struct ListEventDateToShow: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .customBoldFont()
    }
}


struct ListEventLocationType: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .customBoldFont()
    }
}
struct ListTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .customBoldFont()
    }
}

struct ListCard: ViewModifier {
    func body(content: Content) -> some View {
        content
        .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.blue))
        .padding(.horizontal, 10)
    }
}


