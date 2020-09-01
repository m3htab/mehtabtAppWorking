import Firebase


class LoggedInUser : aUser, anyLoggedInUser {

    var email = ""
    var timeStamp = Timestamp()

    //setters
    func SetEmail(email: String) {
        self.email = email
    }
    func SetTimestamp(stamp: Timestamp) {
        self.timeStamp = stamp
    }
    //getters
    func GetEmail() -> String {
        return self.email
    }
    func GetTimestamp() -> Timestamp{
        return self.timeStamp
    }

}
