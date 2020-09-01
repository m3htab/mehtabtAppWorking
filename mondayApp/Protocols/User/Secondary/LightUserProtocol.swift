
protocol anyLightUser{
    var uID: String {get set}
    var firstName: String {get set}
    var lastName: String {get set}
    
    func SetUserID(ID: String)
    func SetFirstName(name: String)
    func SetLastName(name: String)
    func GetUserID()-> String
    func GetFirstName()-> String
    func GetLastName()-> String
}

