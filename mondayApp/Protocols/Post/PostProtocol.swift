
protocol anyPost : anyNewPost{
    var likeCount: Int {get set}
    var likeData: [PostMember] {get set}
    var relatedUsers: [RelatedUser] {get set}
    var hasLiked: Bool {get set}

    
    func SetLikeCount(count: Int)
    func SetLikeData(data: [PostMember])
    func SetRelatedUsers(users: [RelatedUser])
    func SetHasLiked(liked: Bool)
    func UpdateRelatedUsers(users: [RelatedUser])
    func GetLikeCount() ->Int
    func GetLikeData() ->[PostMember]
    func GetRelatedUsers() ->[RelatedUser]
    func GetHasLiked() ->Bool


}
