import Foundation
protocol anyEventPost: anyPost,anyNewEvent {
    var joinCount: Int {get set}
    var joinData: [PostMember] {get set}
    var hasUserJoined: Bool {get set}
    var dateToShow: String {get set}
    var locationToShow: String {get set}

    var date: Date{get set}//for editing
    
    func SetJoinCount(count: Int)
    func SetJoinData(data: [PostMember])
    func SetHasUserJoined(state: Bool)
    func SetDateToShow(date: String)
    func SetLocationToShow(location: String)
    func GetJoinCount() -> Int
    func GetJoinData() -> [PostMember]
    func GetHasUserJoined() -> Bool
    func GetDateToShow()-> String
    func GetLocationToShow() -> String
}
