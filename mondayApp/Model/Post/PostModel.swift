import Firebase
import Foundation

class Post: NewPost, anyPost{
    

    var likeCount = PostDefaltValue.likeCount
    var likeData = [PostMember]()
    var relatedUsers = [RelatedUser]()
    var hasLiked = false

    /*
     Setters
     */

    func SetLikeCount(count: Int){
        self.likeCount = count
    }
    func SetLikeData(data: [PostMember]){
        self.likeData = data
    }
    func SetRelatedUsers(users: [RelatedUser]){
        self.relatedUsers = users
    }

    func SetHasLiked(liked: Bool){
        self.hasLiked = liked
    }
    func UpdateRelatedUsers(users: [RelatedUser]){
        for user in users{
            self.relatedUsers.append(user)
        }
    }
   /*
     Getters
     */
    
    func GetLikeCount() ->Int{
        return self.likeCount
    }
    func GetLikeData() ->[PostMember]{
        return self.likeData
    }
    func GetRelatedUsers() ->[RelatedUser]{
        return self.relatedUsers
    }
    func GetHasLiked() ->Bool{
        return self.hasLiked
    }
}
