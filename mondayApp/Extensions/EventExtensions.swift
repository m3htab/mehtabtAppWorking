import Foundation
import SwiftUI
import Firebase



extension Event{
    static func tryGetPrivateData(event: Event)->Event{
        
        if event.GetIsOwner(){
            //get owner doc
            return event
        }else if event.GetHasUserJoined(){
            //get join doc
            return event
        }
        
        return event
        
        
    }
}
extension Event{
    static func testForDupeEvent(postList: [Event], post: Event) -> Bool?{
        guard let dupeIndex = postList.firstIndex(of: post)else{return nil}
        print("found dupe")
        return true
    }
}
//MARK: - Dates
extension Event{
    static func dateToQueryString(date: Date)->String{
        let df = DateFormatter()
        df.dateFormat = EVENT_DATETIME_FORMAT
        let dateTimeString = df.string(from: date)
        return String(dateTimeString[0..<10])
    }
    static func dateToString(date: Date) -> String{
        let df = DateFormatter()
        df.dateFormat = EVENT_DATETIME_FORMAT
        let stringDate = df.string(from: date)
        return stringDate
    }
    static func stringToDate(stringDate: String)->Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = EVENT_DATETIME_FORMAT
        return formatter.date(from: stringDate)
    }
    static func dateToShow(currentDate: Date,dayOfEvent:Date)->String{
        
        //print(dayOfEvent)
        let aDay:Double = 60*60*24
        let time = Event.getHourMin(date: dayOfEvent)
        if currentDate.addingTimeInterval(aDay*6) > dayOfEvent{
            let todayWeekDay = Event.getWeekDay(date: currentDate)
            let tomorrowWeekDay = Event.getWeekDay(date: currentDate.addingTimeInterval(aDay))
            let dateWeekDay = Event.getWeekDay(date: dayOfEvent)
            
            if todayWeekDay == dateWeekDay{
                return "TODAY "+time
            }
            else if tomorrowWeekDay == dateWeekDay{
                return "TOMORROW "+time
            }
            else{
                return dateWeekDay.uppercased()+" "+time
            }
        }else{
            
            let day = getDay(date: dayOfEvent)
            let month = getTextMonth(date: dayOfEvent)
            
            
            return day+" "+month.uppercased()+" "+time
        }
    }
    static func getWeekDay(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.string(from: date)
        return day
    }
    static func getDate(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = EVENT_DATE_FORMAT
        let day = dateFormatter.string(from: date)
        return day
    }
    static func getDay(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = EVENT_DAY_FORMAT
        let day = dateFormatter.string(from: date)
        return day
    }
    static func getTextMonth(date: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = EVENT_MONTH_FORMAT
        let month = dateFormatter.string(from: date)
        return month
    }
    static func getHourMin(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = EVENT_TIME_FORMAT
        let day = dateFormatter.string(from: date)
        return day
    }
}

extension Event{
    static func getLocationToShow(hasJoined: Bool,publicLocation: PUBLIC_LOCATIONS,onJoinLocation: JOINED_LOCATIONS,city: String,accom:String,address:String,briefDescription: String,locationType: EVENT_LOCATION_TYPES)->String{
        
        if hasJoined{
            
            switch locationType {
                case EVENT_LOCATION_TYPES.accomodation:
                    if onJoinLocation == JOINED_LOCATIONS.address{
                        return accom+", "+address
                    }
                    else if onJoinLocation == JOINED_LOCATIONS.accom{
                        return accom+" "+city
                    }
                    else if onJoinLocation == JOINED_LOCATIONS.city{
                        return city
                    }
                case EVENT_LOCATION_TYPES.house:
                    if onJoinLocation == JOINED_LOCATIONS.address{
                        return address
                    }
                    else if onJoinLocation == JOINED_LOCATIONS.brief_description{
                        return city+", "+briefDescription
                    }
                    else if onJoinLocation == JOINED_LOCATIONS.city{
                        return city
                    }
                case EVENT_LOCATION_TYPES.other:
                    if onJoinLocation == JOINED_LOCATIONS.address{
                        return city+", "+address
                    }
                    else if onJoinLocation == JOINED_LOCATIONS.brief_description{
                        return city+", "+briefDescription
                    }
                    else if onJoinLocation == JOINED_LOCATIONS.city{
                        return city
                    }
                default:
                    break
            }
        }
        else{
            switch locationType {
                case EVENT_LOCATION_TYPES.accomodation:
                    if publicLocation == PUBLIC_LOCATIONS.accom{
                        return accom+" "+city
                    }
                    else if publicLocation == PUBLIC_LOCATIONS.city{
                        return city
                    }
                case EVENT_LOCATION_TYPES.house:
                    if publicLocation == PUBLIC_LOCATIONS.brief_description{
                        return city+", "+briefDescription
                    }
                    else if publicLocation == PUBLIC_LOCATIONS.city{
                        return city
                    }
                case EVENT_LOCATION_TYPES.other:
                    if publicLocation == PUBLIC_LOCATIONS.brief_description{
                        return city+", "+briefDescription
                    }
                    else if publicLocation == PUBLIC_LOCATIONS.city{
                        return city
                    }
                default:
                    break
            }
        }
        return city
    }

    
    
    
}


/*
 Generating event query field
 */
extension Event{
    static func createQueryList(city: String,type: String)->[String]{
        var query = [""]
        let q1 = "AllAll"
        let q2 = type+"All"
        let q3 = "All"+city
        let q4 = type+city
        query[0] = q1
        query.append(q2)
        query.append(q3)
        query.append(q4)
        return query
    }
    static func pickQuery(city: String,type: String)->Int{
        if city == "All" && type == EVENT_LOCATION_TYPES.all.rawValue{
            return 0
        }
        else if city == "All" && type != EVENT_LOCATION_TYPES.all.rawValue{
            return 1
        }
        else if city != "All" && type == EVENT_LOCATION_TYPES.all.rawValue{
            return 2
        }
        else if city != "All" && type != EVENT_LOCATION_TYPES.all.rawValue{
            return 3
        }
        else{
            return 0
        }
    }
    static func GetTypeCityQuery(city: String,type:EVENT_LOCATION_TYPES) -> String{
        let queryList = Event.createQueryList(city: city, type: type.rawValue)
        let pos = Event.pickQuery(city: city, type: type.rawValue)
        return queryList[pos]
    }
}
/*
 Getting emuns from server string data
 */
extension Event{
    static func stringToJoinType(string: String)-> JOIN_TYPE{
        switch string {
        case JOIN_TYPE.open.rawValue:
            return JOIN_TYPE.open
        case JOIN_TYPE.request.rawValue:
            return JOIN_TYPE.request
        default:
            return JOIN_TYPE.request
        }
    }
    static func stringToJoinedLocation(string: String)-> JOINED_LOCATIONS{
        switch string {
        case JOINED_LOCATIONS.city.rawValue:
            return JOINED_LOCATIONS.city
        case JOINED_LOCATIONS.accom.rawValue:
            return JOINED_LOCATIONS.accom
        case JOINED_LOCATIONS.brief_description.rawValue:
            return JOINED_LOCATIONS.brief_description
        case JOINED_LOCATIONS.address.rawValue:
            return JOINED_LOCATIONS.address
        default:
            return JOINED_LOCATIONS.city
        }
    }
    static func stringToPublicLocation(string: String)-> PUBLIC_LOCATIONS{
        switch string{
            case PUBLIC_LOCATIONS.city.rawValue:
                return PUBLIC_LOCATIONS.city
            case PUBLIC_LOCATIONS.accom.rawValue:
                return PUBLIC_LOCATIONS.accom
            case PUBLIC_LOCATIONS.brief_description.rawValue:
                return PUBLIC_LOCATIONS.brief_description
            default:
                return PUBLIC_LOCATIONS.city
            
        }
    }
    static func stringToLocationType(string: String)-> EVENT_LOCATION_TYPES{
        switch string{
            case EVENT_LOCATION_TYPES.accomodation.rawValue:
                return EVENT_LOCATION_TYPES.accomodation
            case EVENT_LOCATION_TYPES.house.rawValue:
                return EVENT_LOCATION_TYPES.house
            case EVENT_LOCATION_TYPES.other.rawValue:
                return EVENT_LOCATION_TYPES.other
            default:
                return EVENT_LOCATION_TYPES.other
        }
    }
    
}

extension Event{
    static func ==(lhs: Event, rhs: Event)-> Bool{
        return lhs.postID == rhs.postID
    }
}
