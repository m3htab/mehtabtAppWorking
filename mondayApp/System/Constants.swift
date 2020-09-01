import SwiftUI
import Firebase
import FirebaseStorage

let EVENT_DATETIME_FORMAT = "YYYY-MM-dd HH:mm:ss"
let EVENT_DATE_FORMAT = "YYYY-MM-dd"
let EVENT_DAY_FORMAT = "dd"
let EVENT_TIME_FORMAT = "HH:MM"
let EVENT_MONTH_FORMAT = "MMM"



let FONT_BOLD = "Lato-Black"
let FONT_BOLD_SIZE = CGFloat(32)






class privateLocation{
    static let privateLocation = "private"
}
//Everyone Algorithm
let EVEYONE_PROBABILITY_RANDOM = 700
let EVEYONE_PROBABILITY_RELATED = 85
let EVEYONE_PROBABILITY_POPULAR = 100

//Feed Settings
let FAILED_ATTEMPTS_LIMIT = 2
let POSTS_TO_DOWNLOAD = 3


// Colours
let COLOR_LIGHT_GRAY = Color(red: 0, green: 0, blue: 0, opacity: 0.15)
let COLOR_TEAL = Color(red: 80 / 255, green: 201 / 255, blue: 206 / 255)


//Filter Page Visible
let FILTER_TITLE_TEXT = "Search"
let FILTER_VENUE_TEXT = "Venue"
let FILTER_CITY_TEXT = "City"
let FILTER_ACCOMODATION_TEXT = "Accomodation"
let FILTER_CUSTOMDATE_TEXT = "Custom Date"
let FILTER_CLEAR_BUTTON_TEXT = "Clear"
let FILTER_APPLY_BUTTON_TEXT = "See Results"
let FILTER_DATEERROR_TITLE = "Oops"
let FILTER_DATEERROR_MESSAGE = "Please pick a maximum of 10 dates"
let FILTER_DATEERROR_OK = "Ok"
let COLOR_FILTER_UNSELECTED = Color(red: 238 / 255, green: 240 / 255, blue: 244 / 255)
let COLOR_FILTER_CLEARBUTTON = Color(red: 175 / 255, green: 185 / 255, blue: 201 / 255)





// Sign in and Sign up pages
let TEXT_NEED_AN_ACCOUNT = "Don't have an account?"
let TEXT_SIGN_UP = "Sign up"
let TEXT_SIGN_IN = "Sign in"
let TEXT_EMAIL = "Email"
let TEXT_FIRSTNAME = "First Name"
let TEXT_LASTNAME = "Last Name"
let TEXT_PASSWORD = "Password"
let TEXT_SIGNIN_HEADLINE = "Photo Sharing"
let TEXT_SIGNIN_SUBHEADLINE = "The essiest way to share photos with family and friends"
let TEXT_SIGNUP_NOTE = "An account will allow you to save and access photo information across devices. You can delete your account at any time and your information will not be shared."
let TEXT_SIGNUP_PASSWORD_REQUIRED = "At least 8 characters required"
let IMAGE_USER_PLACEHOLDER = "user-placeholder"



class PostDefaltValue{
    static let postID = "default id"
    static let postOwner = ""
    static let title = ""
    static let likeCount = 0
    static let dateUploaded = Timestamp()
}

class EventDefaultValue{
    static let description = ""
    static let joinCount = 0
    static let daysUntilStart = ""
    static let timeUntilStart = ""
    static let startsOnDate = ""
    static let locationToShow = ""
    static let city = ""
    static let accomodation = ""
    static let locationDescription = ""
    static let address = ""
}
