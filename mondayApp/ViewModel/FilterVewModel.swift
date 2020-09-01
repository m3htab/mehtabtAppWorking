import SwiftUI


class FilterViewModel : ObservableObject{
    
    
    private let daysInFilter = 28
    private let allFilters = [FILTERS.EVERYONE, FILTERS.FORYOU, FILTERS.POPULAR]
    private let allVenues = [EVENT_LOCATION_TYPES.all, EVENT_LOCATION_TYPES.accomodation, EVENT_LOCATION_TYPES.house, EVENT_LOCATION_TYPES.other]
    private let allCities = ["All","Newcastle","Liverpool","Manchester","Leeds","Glassgow","London"]
    private var allLocations = ["Liverpool":["All","Glassworks","Marybone","Horizon heights","HH"],"Newcastle":["All","newcastle1","newcastle2","newcastle3"],"Manchester": ["All","m1","m2"]]
    
    
    @Published private var activatedFilter = FILTERS.EVERYONE
    /*
     User selected search options
     */
    
    //dates
    @Published private var isSelectingCustomDate = false
    private var hasSelectedCustomDate = false
    @Published private var customDateActivated = false
    @Published private var selectedDates: [Date]//this causes bug , and selected date in one day in future after selected
    @Published private var activatedDates: [Date]
    private var trueDates = [Date]()
    private var currentDateTime = Date()
    //everyone filters
    @Published private var EselectedCity = "All"
    @Published private var EselectedVenue = EVENT_LOCATION_TYPES.all
    @Published private var EselectedAccomodation = "All"
    private var EactivatedCity = "All"
    private var EactivatedVenue = EVENT_LOCATION_TYPES.all
    private var EactivatedAccomodation = "All"
    private var EAccomodationList = [""]
    //popular filters
    @Published private var PselectedCity = "All"
    @Published private var PselectedVenue = EVENT_LOCATION_TYPES.all
    @Published private var PselectedAccomodation = "All"
    private var PactivatedCity = "All"
    private var PactivatedVenue = EVENT_LOCATION_TYPES.all
    private var PactivatedAccomodation = "All"
    private var PAccomodationList = [""]

    @Published private var defaultCity: String
    
    
    init(defaultCity: String) {
        self.PactivatedCity = defaultCity
        self.PselectedCity = defaultCity
        self.defaultCity = defaultCity
        
        let currentDate = Date()
        
        self.currentDateTime = currentDate
        self.activatedDates = [currentDate]
        self.selectedDates = [currentDate]
        
        
    }
    
    /*
     Getters
     */
    func GetDaysInFilter()->Int{
        return self.daysInFilter
    }
    func GetAllFilters()->[FILTERS]{
        return self.allFilters
    }
    func GetActivatedFilter()->FILTERS{
        return self.activatedFilter
    }
    func GetAllVenue()->[EVENT_LOCATION_TYPES]{
        return self.allVenues
    }
    func GetAllCities()->[String]{
        return self.allCities
    }
    func GetAllLocations()->[String:[String]]{
        return self.allLocations
    }
    func GetSelectedAccomodationList(city: String) -> [String]{
        guard let list = allLocations[city] as [String]? else{return [""]}
        return list
    }
    func GetHasSelectedCustomDate()-> Bool{
        return self.hasSelectedCustomDate
    }
    func GetIsSelectingCustomDate()-> Bool{
        return self.isSelectingCustomDate
    }
    func GetSelectedDates()-> [Date]{
        return self.selectedDates
    }
    func GetSelectedDatesCount()-> Int{
        return self.selectedDates.count
    }
    func GetActivatedDates()-> [Date]{
        return self.activatedDates
    }
    func GetTrueDates()->[Date]{
        return self.trueDates
    }
    func GetCurrentDateTime()->Date{
        return self.currentDateTime
    }
    func GetEveryoneSelectedCity()->String{
        return self.EselectedCity
    }
    func GetEveryoneSelectedAccomodation()->String{
        return self.EselectedAccomodation
    }
    func GetEveryoneSelectedVenue()->EVENT_LOCATION_TYPES{
        return self.EselectedVenue
    }
    func GetEveryoneActivatedCity()->String{
        return self.EactivatedCity
    }
    func GetEveryoneActivatedAccomodation()->String{
        return self.EactivatedAccomodation
    }
    func GetEveryoneActivatedVenue()->EVENT_LOCATION_TYPES{
        return self.EactivatedVenue
    }
    func GetEveryoneAccomodationList()->[String]{
        return self.EAccomodationList
    }
    func GetPopularSelectedCity()->String{
        return self.PselectedCity
    }
    func GetPopularSelectedAccomodation()->String{
        return self.PselectedAccomodation
    }
    func GetPopularSelectedVenue()->EVENT_LOCATION_TYPES{
        return self.PselectedVenue
    }
    func GetPopularActivatedCity()->String{
        return self.PactivatedCity
    }
    func GetPopularActivatedAccomodation()->String{
        return self.PactivatedAccomodation
    }
    func GetPopularActivatedVenue()->EVENT_LOCATION_TYPES{
        return self.PactivatedVenue
    }
    func GetPopularAccomodationList()->[String]{
        return self.PAccomodationList
    }
    func GetDefaultCity()->String{
        return self.defaultCity
    }

    /*
     Setters
     */
    func SetActivatedFilter(filter: FILTERS){
        self.activatedFilter = filter
    }
    func SetHasSelectedCustomDate(state: Bool){
        self.hasSelectedCustomDate = state
    }
    func SetIsSelectingCustomDate(state: Bool){
        self.isSelectingCustomDate = state
    }
    func ToggleIsSelectingCustomDate(){
        self.isSelectingCustomDate.toggle()
    }
    func SetCustomDateActivated(state: Bool){
        self.customDateActivated = state
    }
    func SetSelectedDates(dates: [Date]){
        self.selectedDates = dates
    }
    func SetActivatedDates(dates: [Date]){
        self.activatedDates = dates
    }
    func SetTrueDates(dates: [Date]){
        self.trueDates = dates
    }
    func SetEveryoneSelectedCity(city: String){
        self.EselectedCity = city
    }
    func SetEveryoneSelectedAccomodation(Accomodation: String){
        self.EselectedAccomodation = Accomodation
    }
    func SetEveryoneSelectedVenue(Venue: EVENT_LOCATION_TYPES){
        self.EselectedVenue = Venue
    }
    func SetEveryoneActivatedCity(city: String){
        self.EactivatedCity = city
    }
    func SetEveryoneActivatedAccomodation(Accomodation: String){
        self.EactivatedAccomodation = Accomodation
    }
    func SetEveryoneActivatedVenue(Venue: EVENT_LOCATION_TYPES){
        self.EactivatedVenue = Venue
    }
    func SetEveryoneAccomodationList(list: [String]){
        self.EAccomodationList = list
    }
    func SetPopularSelectedCity(city: String){
        self.PselectedCity = city
    }
    func SetPopularSelectedAccomodation(Accomodation: String){
        self.PselectedAccomodation = Accomodation
    }
    func SetPopularSelectedVenue(Venue: EVENT_LOCATION_TYPES){
        self.PselectedVenue = Venue
    }
    func SetPopularActivatedCity(city: String){
        self.PactivatedCity = city
    }
    func SetPopularActivatedAccomodation(Accomodation: String){
        self.PactivatedAccomodation = Accomodation
    }
    func SetPopularActivatedVenue(Venue: EVENT_LOCATION_TYPES){
        self.PactivatedVenue = Venue
    }
    func SetPopularAccomodationList(list: [String]){
        self.PAccomodationList = list
    }
    func SetDefaultCity(city: String){
        self.defaultCity = city
    }
    
    
    
    func RemoveSelectedDate(position: Int){
        self.selectedDates.remove(at: position)
    }
    func AddDateToSelected(date: Date){
        self.selectedDates.append(date)
    }
    
    
    
    

    func updateAccomList(city: String){
        guard let list = allLocations[city] as [String]? else{
            switch activatedFilter{
                case FILTERS.EVERYONE:
                    self.EAccomodationList = [""]
                case FILTERS.POPULAR:
                    self.PAccomodationList = [""]
                default:
                    print("error")
            }
            return}
        switch activatedFilter{
            case FILTERS.EVERYONE:
                self.EAccomodationList = list
            case FILTERS.POPULAR:
                self.PAccomodationList = list
            default:
                print("error")

        }
    }
    

    
    func getAllDates() -> [Date]{
        var dateList = [Date]()
        var date = Date()
        for _ in 0...daysInFilter{
            dateList.append(date)
            date = date.addingTimeInterval(TimeInterval((60*60*24)))
        }
        return dateList
        
    }
    
    func resetSelected(){
        SetEveryoneSelectedCity(city: GetEveryoneActivatedCity())
        SetEveryoneSelectedAccomodation(Accomodation: GetEveryoneActivatedAccomodation())
        SetEveryoneSelectedVenue(Venue: GetEveryoneActivatedVenue())
        SetEveryoneAccomodationList(list: GetSelectedAccomodationList(city: GetEveryoneSelectedCity()))
        
        SetPopularSelectedCity(city: GetPopularActivatedCity())
        SetPopularSelectedAccomodation(Accomodation: GetPopularActivatedAccomodation())
        SetPopularSelectedVenue(Venue: GetPopularActivatedVenue())
        SetPopularAccomodationList(list: GetSelectedAccomodationList(city: GetPopularSelectedCity()))
        
        SetIsSelectingCustomDate(state: GetHasSelectedCustomDate())
        SetSelectedDates(dates: GetActivatedDates())
       
    }
    
    func SetTrueDates(){//this corrects selected dates being one day behind
        self.trueDates = [Date]()
        
        if self.activatedDates[0] == currentDateTime{
            //if default selected date(only correct date) is still selected
            for (i,date) in self.activatedDates.enumerated(){
                if i != 0{
                    self.trueDates.append(date.addingTimeInterval(TimeInterval(60*60*23)))
                }else{
                    self.trueDates.append(date)
                }
            }
        }else{
            //default selected date has been reselected(so now incorrect) or has been deselected
            for date in self.activatedDates{
                self.trueDates.append(date.addingTimeInterval(TimeInterval(60*60*23)))
            }
        }
    }
    func CheckForEveryoneChanges()->Bool{
        if GetEveryoneSelectedCity() != GetEveryoneActivatedCity() || GetEveryoneSelectedAccomodation() != GetEveryoneActivatedAccomodation() || GetEveryoneSelectedVenue() != GetEveryoneActivatedVenue() || GetIsSelectingCustomDate() == GetHasSelectedCustomDate(){
            return true
        }else{
            return false
            print("same query")
        }
    }
    func CheckForPopularChanges()->Bool{
        if GetPopularSelectedCity() != GetPopularActivatedCity() || GetPopularSelectedAccomodation() != GetPopularActivatedAccomodation() || GetPopularSelectedVenue() != GetPopularActivatedVenue() || GetSelectedDates() != GetActivatedDates(){
            return true
        }else{
            return false
        }
    }
    
    static func FormatCalenderDateToQueryString(dateList: [Date])-> [String]{
        var formattedList = [""]

        
        for date in dateList{
            let string = Event.dateToQueryString(date: date)
            formattedList.append(string)
        }
        return formattedList
    }
    
    
    
    func ClearEveryoneFilter(){
        SetEveryoneSelectedCity(city: "All")
        SetEveryoneSelectedVenue(Venue: EVENT_LOCATION_TYPES.all)
        SetEveryoneAccomodationList(list: [""])
        SetSelectedDates(dates: [GetCurrentDateTime()])
    }
    
    func ApplyEveryoneFilter(){
        SetEveryoneActivatedCity(city: GetEveryoneSelectedCity())
        SetEveryoneActivatedAccomodation(Accomodation: GetEveryoneSelectedAccomodation())
        SetEveryoneActivatedVenue(Venue: GetEveryoneSelectedVenue())
        
        if !(GetIsSelectingCustomDate() == true && GetSelectedDates() == []){
            SetHasSelectedCustomDate(state: GetIsSelectingCustomDate())
            SetActivatedDates(dates: GetSelectedDates())
            SetTrueDates()
        }
        

        
    }
    func ClearPopularFilter(){
        SetPopularSelectedCity(city: "All")
        SetPopularSelectedVenue(Venue: EVENT_LOCATION_TYPES.all)
        SetPopularAccomodationList(list: [""])
        SetSelectedDates(dates: [GetCurrentDateTime()])
    }
    
    func ApplyPopularFilter(){
        SetPopularActivatedCity(city: GetPopularSelectedCity())
        SetPopularActivatedAccomodation(Accomodation: GetPopularSelectedAccomodation())
        SetPopularActivatedVenue(Venue: GetPopularSelectedVenue())
        if !(GetIsSelectingCustomDate() == true && GetSelectedDates() == []){
            SetHasSelectedCustomDate(state: GetIsSelectingCustomDate())
            SetActivatedDates(dates: GetSelectedDates())
            SetTrueDates()
        }
        
    }
    
    
}



