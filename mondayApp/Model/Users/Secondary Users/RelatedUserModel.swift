class RelatedUser: PostMember,anyRelatedUser{
    
    internal var interactionType = INTERACTION_TYPE.notSet
    
    //getters
    func GetInteractionType()-> INTERACTION_TYPE {
        return self.interactionType
    }
    //setters
     func SetInteractionOwner() {
        self.interactionType = INTERACTION_TYPE.owner
    }
     func SetInteractionJoin() {
        self.interactionType = INTERACTION_TYPE.join
    }
     func SetInteractionLike() {
        self.interactionType = INTERACTION_TYPE.like
    }

}
