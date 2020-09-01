import Firebase

protocol anyNewUser : anyLightUser{
    var email: String {get set}
    var timeStamp: Timestamp{get set}
    
    func SetTimestamp(stamp: Timestamp)
    func SetEmail(email: String)
    func GetEmail()-> String
    func GetTimestamp()-> Timestamp
}
