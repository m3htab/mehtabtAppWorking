
///anyRelatedUser can appear in the post as user x liked this event,  user x joined this event ect

protocol anyRelatedUser: anyPostMember {
    var interactionType: INTERACTION_TYPE {get set}
    
    func SetInteractionOwner()
    func SetInteractionLike()
    func SetInteractionJoin()
    func GetInteractionType()-> INTERACTION_TYPE
}
