class LightUser : anyLightUser{
    internal var uID = ""
    internal var firstName = ""
    internal var lastName = ""
    //getters
    func GetUserID()->String{
        return uID
    }
    func GetFirstName()->String{
        return self.firstName
    }
    func GetLastName()->String{
        return self.lastName
    }
    //setters
    func SetUserID(ID: String){
        self.uID = ID
    }
    func SetFirstName(name: String){
        self.firstName = name
    }
    func SetLastName(name: String){
        self.lastName = name
    }
}
