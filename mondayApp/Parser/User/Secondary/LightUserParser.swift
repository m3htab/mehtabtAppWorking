import Firebase

extension aUser{

    static func parseLightUserListData(data: [String: [String: String]])->[LightUser]?{
        var list = [LightUser]()
        for user in data{
            guard
                let uid = user.value[userRef.LIGHT_USER_ID] ,
                let fname = user.value[userRef.LIGHT_USER_FIRSTNAME] ,
                let lname = user.value[userRef.LIGHT_USER_LASTNAME]
            else{return nil}
            let lightUser = LightUser()
            lightUser.SetUserID(ID: uid)
            lightUser.SetFirstName(name: fname)
            lightUser.SetLastName(name: lname)
            list.append(lightUser)
        }
        return list
    }
}
