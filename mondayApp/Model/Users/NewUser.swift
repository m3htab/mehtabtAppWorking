import Firebase

class NewUser: LightUser, anyNewUser{
    
    var email = ""
    var timeStamp = Timestamp()
    
    //setters
    func SetTimestamp(stamp: Timestamp){
        self.timeStamp = stamp
    }
    func SetEmail(email: String){
        self.email = email
    }
    //getters
    func GetEmail()-> String{
        return self.email
    }
    func GetTimestamp()-> Timestamp{
        return self.timeStamp
    }
}




