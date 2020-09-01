import Firebase

class EveryoneQueries{
    
    
    static func INITAL_QUERY_ACCOMODATION(accomodation: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .order(by: eventRef.EVENT_DATE_AS_DATE, descending: false)
        .limit(to: 1)
    }
    
    static func INITIAL_QUERY_NOACCOMODATION(TCQuery: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .order(by: eventRef.EVENT_DATE_AS_DATE, descending: false)
        .limit(to: 1)
    }
    static func RECURSIVE_QUERY_NOACCOMODATION(TCQuery: String,startPosition:DocumentSnapshot)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .order(by: eventRef.EVENT_DATE_AS_DATE, descending: false)
        .start(afterDocument: startPosition)
        .limit(to: 1)
    }
    static func RECURSIVE_QUERY_ACCOMODATION(accomodation: String,startPosition:DocumentSnapshot)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .order(by: eventRef.EVENT_DATE_AS_DATE, descending: false)
        .start(afterDocument: startPosition)
        .limit(to: 1)
    }
    
    
    
    
    
    
    static func NOT_ACCOMODATION_LOWER_NODATE(field: String,random:Int,TCQuery: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(field, isLessThanOrEqualTo: random)
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .order(by: field, descending: true)
        .limit(to: 1)
    }
    static func NOT_ACCOMODATION_LOWER_DATE(field: String,random:Int,dates: [String],TCQuery: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(field, isLessThanOrEqualTo: random)
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .whereField(eventRef.EVENT_QUERYDATE, in: dates)
        .order(by: field, descending: true)
        .limit(to: 1)
    }
    static func NOT_ACCOMODATION_HIGHER_NODATE(field: String,random:Int,TCQuery: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(field, isGreaterThanOrEqualTo: random)
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .order(by: field)
        .limit(to: 1)
    }
    static func NOT_ACCOMODATION_HIGHER_DATE(field: String,random:Int,dates: [String],TCQuery: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(field, isGreaterThanOrEqualTo: random)
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .whereField(eventRef.EVENT_QUERYDATE, in: dates)
        .order(by: field)
        .limit(to: 1)
    }
    static func ACCOMODATION_LOWER_NODATE(field: String,random:Int,accomodation: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(field, isLessThanOrEqualTo: random)
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .order(by: field, descending: true)
        .limit(to: 1)
    }
    static func ACCOMODATION_LOWER_DATE(field: String,random:Int,accomodation: String,dates: [String])-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(field, isLessThanOrEqualTo: random)
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .whereField(eventRef.EVENT_QUERYDATE, in: dates)
        .order(by: field, descending: true)
        .limit(to: 1)
    }
    static func ACCOMODATION_HIGHER_NODATE(field: String,random:Int,accomodation: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(field, isGreaterThanOrEqualTo: random)
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .order(by: field)
        .limit(to: 1)
    }
    static func ACCOMODATION_HIGHER_DATE(field: String,random:Int,accomodation: String,dates: [String])-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(field, isGreaterThanOrEqualTo: random)
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .whereField(eventRef.EVENT_QUERYDATE, in: dates)
        .order(by: field)
        .limit(to: 1)
    }
    
    static func everyoneQueryGenerator(type: EVENT_LOCATION_TYPES, city: String,accom: String,customDate:Bool,dates: [String])->(Query,Query){
        
        let random = Int.random(in: 1..<15000)
        let QueryRandomField = Int.random(in: 1..<4)
        let field = "random"+String(QueryRandomField)
        let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
        switch type{
            case EVENT_LOCATION_TYPES.house:
                if customDate{
                    if random % 2 == 0{
                        return (EveryoneQueries.NOT_ACCOMODATION_LOWER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_HIGHER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery))
                    }else{
                        return (EveryoneQueries.NOT_ACCOMODATION_HIGHER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_LOWER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery))
                    }
                }
                else{
                    if random % 2 == 0{
                        return (EveryoneQueries.NOT_ACCOMODATION_LOWER_NODATE(field: field, random: random,TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_HIGHER_NODATE(field: field, random: random,TCQuery: TCQuery))
                    }else{
                        return (EveryoneQueries.NOT_ACCOMODATION_HIGHER_NODATE(field: field, random: random,TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_LOWER_NODATE(field: field, random: random,TCQuery: TCQuery))
                    }
                }
        
            case EVENT_LOCATION_TYPES.other:
                if customDate{
                    if random % 2 == 0{
                        return (EveryoneQueries.NOT_ACCOMODATION_LOWER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_HIGHER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery))
                    }else{
                        return (EveryoneQueries.NOT_ACCOMODATION_HIGHER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_LOWER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery))
                    }
                }
                else{
                    if random % 2 == 0{
                        return (EveryoneQueries.NOT_ACCOMODATION_LOWER_NODATE(field: field, random: random,TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_HIGHER_NODATE(field: field, random: random,TCQuery: TCQuery))
                    }else{
                        return (EveryoneQueries.NOT_ACCOMODATION_HIGHER_NODATE(field: field, random: random,TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_LOWER_NODATE(field: field, random: random,TCQuery: TCQuery))
                    }
                }
            case EVENT_LOCATION_TYPES.all:
                
                if customDate{
                    if random % 2 == 0{
                        return (EveryoneQueries.NOT_ACCOMODATION_LOWER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_HIGHER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery))
                    }else{
                        return (EveryoneQueries.NOT_ACCOMODATION_HIGHER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_LOWER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery))
                    }
                }
                else{
                    if random % 2 == 0{
                        return (EveryoneQueries.NOT_ACCOMODATION_LOWER_NODATE(field: field, random: random,TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_HIGHER_NODATE(field: field, random: random,TCQuery: TCQuery))
                    }else{
                        return (EveryoneQueries.NOT_ACCOMODATION_HIGHER_NODATE(field: field, random: random,TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_LOWER_NODATE(field: field, random: random,TCQuery: TCQuery))
                    }
                }
            case EVENT_LOCATION_TYPES.accomodation:
                if customDate{
                    if random % 2 == 0{
                        if accom == "All"{
                            return (EveryoneQueries.NOT_ACCOMODATION_LOWER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_HIGHER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery))
                        }else{
                            return (EveryoneQueries.ACCOMODATION_LOWER_DATE(field: field, random: random, accomodation: accom, dates: dates),EveryoneQueries.ACCOMODATION_HIGHER_DATE(field: field, random: random, accomodation: accom, dates: dates))
                        }
                    }else{
                        if accom == "All"{
                            return (EveryoneQueries.NOT_ACCOMODATION_HIGHER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_LOWER_DATE(field: field, random: random, dates: dates, TCQuery: TCQuery))
                        }else{
                            return (EveryoneQueries.ACCOMODATION_HIGHER_DATE(field: field, random: random, accomodation: accom, dates: dates),EveryoneQueries.ACCOMODATION_LOWER_DATE(field: field, random: random, accomodation: accom, dates: dates))
                        }
                    }
                }else{
                    if random % 2 == 0{
                        if accom == "All"{
                            return (EveryoneQueries.NOT_ACCOMODATION_LOWER_NODATE(field: field, random: random,TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_HIGHER_NODATE(field: field, random: random,TCQuery: TCQuery))
                        }else{
                            return (EveryoneQueries.ACCOMODATION_LOWER_NODATE(field: field, random: random, accomodation: accom),EveryoneQueries.ACCOMODATION_HIGHER_NODATE(field: field, random: random, accomodation: accom))
                        }
                    }else{
                        if accom == "All"{
                            return (EveryoneQueries.NOT_ACCOMODATION_HIGHER_NODATE(field: field, random: random,TCQuery: TCQuery),EveryoneQueries.NOT_ACCOMODATION_LOWER_NODATE(field: field, random: random,TCQuery: TCQuery))
                        }else{
                            return (EveryoneQueries.ACCOMODATION_HIGHER_NODATE(field: field, random: random, accomodation: accom),EveryoneQueries.ACCOMODATION_LOWER_NODATE(field: field, random: random, accomodation: accom))
                        }
                    }
                }
            default:
                return (EveryoneQueries.NOT_ACCOMODATION_HIGHER_NODATE(field: field, random: random, TCQuery: "AllAll"),EveryoneQueries.NOT_ACCOMODATION_LOWER_NODATE(field: field, random: random, TCQuery: "AllAll"))
        }
    }
    
    static func dateInitialQueryGenerator(type: EVENT_LOCATION_TYPES,city:String,accomodation: String)-> Query{
        if type == EVENT_LOCATION_TYPES.accomodation && accomodation != "All"{
            return INITAL_QUERY_ACCOMODATION(accomodation: accomodation)
        }else{
            let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
            return INITIAL_QUERY_NOACCOMODATION(TCQuery: TCQuery)
        }
    }
    static func dateRecursiveQueryGenerator(type: EVENT_LOCATION_TYPES,city:String,accomodation: String,startPosition: DocumentSnapshot)-> Query{
        if type == EVENT_LOCATION_TYPES.accomodation && accomodation != "All"{
            return RECURSIVE_QUERY_ACCOMODATION(accomodation: accomodation,startPosition: startPosition)
        }else{
            let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
            return RECURSIVE_QUERY_NOACCOMODATION(TCQuery: TCQuery,startPosition: startPosition)
        }
    }
    
    
}

class PopularQueries{
    static func INITAL_QUERY_DATE_ACCOMODATION(accomodation: String,dates: [String])-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .whereField(eventRef.EVENT_QUERYDATE, in: dates)
        .order(by: eventRef.EVENT_JOIN_COUNT, descending: true)
        .limit(to: 1)
    }
    static func INITAL_QUERY_NODATE_ACCOMODATION(accomodation: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .order(by: eventRef.EVENT_JOIN_COUNT, descending: true)
        .limit(to: 1)
    }
    static func RECURSIVE_QUERY_DATE_ACCOMODATION(accomodation: String,dates: [String], startPosition:DocumentSnapshot)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .whereField(eventRef.EVENT_QUERYDATE, in: dates)
        .order(by: eventRef.EVENT_JOIN_COUNT, descending: true)
        .start(afterDocument: startPosition)
        .limit(to: 1)
    }
    static func RECURSIVE_QUERY_NODATE_ACCOMODATION(accomodation: String,startPosition:DocumentSnapshot)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_ACCOMODATION, isEqualTo: accomodation)
        .order(by: eventRef.EVENT_JOIN_COUNT, descending: true)
        .start(afterDocument: startPosition)
        .limit(to: 1)
    }
    static func INITIAL_QUERY_NODATE_NOACCOMODATION(TCQuery: String)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .order(by: eventRef.EVENT_JOIN_COUNT, descending: true)
        .limit(to: 1)
    }
    static func INITIAL_QUERY_DATE_NOACCOMODATION(TCQuery: String,dates: [String])-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .whereField(eventRef.EVENT_QUERYDATE, in: dates)
        .order(by: eventRef.EVENT_JOIN_COUNT, descending: true)
        .limit(to: 1)
    }
    static func RECURSIVE_QUERY_NODATE_NOACCOMODATION(TCQuery: String,startPosition:DocumentSnapshot)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .order(by: eventRef.EVENT_JOIN_COUNT, descending: true)
        .start(afterDocument: startPosition)
        .limit(to: 1)
    }
    static func RECURSIVE_QUERY_DATE_NOACCOMODATION(TCQuery: String,dates: [String],startPosition:DocumentSnapshot)-> Query{
        return dbLocations.DB_EVENT_ROOT
        .whereField(eventRef.EVENT_TCQUERYFIELD, arrayContains: TCQuery)
        .whereField(eventRef.EVENT_QUERYDATE, in: dates)
        .order(by: eventRef.EVENT_JOIN_COUNT, descending: true)
        .start(afterDocument: startPosition)
        .limit(to: 1)
    }
    static func popularInitialQueryGenerator(type: EVENT_LOCATION_TYPES,city:String,customDate: Bool,dates:[String])-> Query{
        /*
        switch type {
        case EVENT_LOCATION_TYPES.house:
            
            if customDate{
                return INITIAL_QUERY_DATE_NOACCOMODATION(TCQuery: TCQuery, dates: dates)
            }else{
                return INITIAL_QUERY_NODATE_NOACCOMODATION(TCQuery: TCQuery)
            }
        case EVENT_LOCATION_TYPES.other:
            let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
            if customDate{
                return INITIAL_QUERY_DATE_NOACCOMODATION(TCQuery: TCQuery, dates: dates)
            }else{
                return INITIAL_QUERY_NODATE_NOACCOMODATION(TCQuery: TCQuery)
            }
        case EVENT_LOCATION_TYPES.all:
            let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
            if customDate{
                return INITIAL_QUERY_DATE_NOACCOMODATION(TCQuery: TCQuery, dates: dates)
            }else{
                return INITIAL_QUERY_NODATE_NOACCOMODATION(TCQuery: TCQuery)
            }
        case EVENT_LOCATION_TYPES.accomodation:
            if customDate{
                return INITAL_QUERY_DATE_ACCOMODATION(accomodation: accomodation, dates: dates)
            }else{
                return INITAL_QUERY_NODATE_ACCOMODATION(accomodation: accomodation)
            }
            
            
        default:
            return INITIAL_QUERY_NODATE_NOACCOMODATION(TCQuery: "AllAll")
        }*/
        let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
        if customDate{
            return INITIAL_QUERY_DATE_NOACCOMODATION(TCQuery: TCQuery, dates: dates)
        }else{
            return INITIAL_QUERY_NODATE_NOACCOMODATION(TCQuery: TCQuery)
            
        }
    }
    
    
    
    static func popularRecursiveQueryGenerator(type: EVENT_LOCATION_TYPES,city:String,customDate: Bool,dates:[String], startPosition: DocumentSnapshot)-> Query{
        /*
        switch type {
        case EVENT_LOCATION_TYPES.house:
                let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
                if customDate{
                    return RECURSIVE_QUERY_DATE_NOACCOMODATION(TCQuery: TCQuery, dates: dates,startPosition: startPosition)
                }else{
                    return RECURSIVE_QUERY_NODATE_NOACCOMODATION(TCQuery: TCQuery,startPosition: startPosition)
                }
            case EVENT_LOCATION_TYPES.other:
                let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
                if customDate{
                    return RECURSIVE_QUERY_DATE_NOACCOMODATION(TCQuery: TCQuery, dates: dates,startPosition: startPosition)
                }else{
                    return RECURSIVE_QUERY_NODATE_NOACCOMODATION(TCQuery: TCQuery,startPosition: startPosition)
                }
            case EVENT_LOCATION_TYPES.all:
                let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
                if customDate{
                    return RECURSIVE_QUERY_DATE_NOACCOMODATION(TCQuery: TCQuery, dates: dates,startPosition: startPosition)
                }else{
                    return RECURSIVE_QUERY_NODATE_NOACCOMODATION(TCQuery: TCQuery,startPosition: startPosition)
                }
            case EVENT_LOCATION_TYPES.accomodation:
                if customDate{
                    return RECURSIVE_QUERY_DATE_ACCOMODATION(accomodation: accomodation, dates: dates,startPosition: startPosition)
                }else{
                    return RECURSIVE_QUERY_NODATE_ACCOMODATION(accomodation: accomodation,startPosition: startPosition)
                }
                
                
            default:
                return RECURSIVE_QUERY_NODATE_NOACCOMODATION(TCQuery: "AllAll",startPosition: startPosition)
        }*/
        let TCQuery = Event.GetTypeCityQuery(city:city,type:type)
        if customDate{
            return RECURSIVE_QUERY_DATE_NOACCOMODATION(TCQuery: TCQuery, dates: dates,startPosition: startPosition)
        }else{
            return RECURSIVE_QUERY_NODATE_NOACCOMODATION(TCQuery: TCQuery,startPosition: startPosition)
        }
        
    }
    
    
}
