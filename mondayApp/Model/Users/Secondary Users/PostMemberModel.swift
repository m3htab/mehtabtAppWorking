class PostMember : LightUser, anyPostMember{
    
    internal var relationToUser = RELATION_TO_USER.notSet
    
    //getters
    func GetRelationToUser()-> RELATION_TO_USER{
        return self.relationToUser
    }
    //setters
    func SetRelationToUser(relation: RELATION_TO_USER){
        self.relationToUser = relation
    }
}
