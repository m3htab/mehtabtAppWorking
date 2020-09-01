
/// anyUserProfile is the model for viewing a profile of user which is not current user

protocol anyUserProfile: anyUser{
    var hasBlockedCurrentUser: Bool {get set}
    
    func SetHasBlockedCurrentUser(state: Bool)
    func GetHasBlockedCurrentUser() -> Bool
}
