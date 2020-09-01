
///anyPostMember can appear in the list of liked or joined users of a post

protocol anyPostMember: anyLightUser {
    var relationToUser: RELATION_TO_USER {get set}
    mutating func SetRelationToUser(relation: RELATION_TO_USER)
    func GetRelationToUser()-> RELATION_TO_USER
}
