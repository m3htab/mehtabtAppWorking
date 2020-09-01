
import Foundation


class GalleryItem: anyGalleryItem{
    
    internal var parentPostID = ""
    internal var itemID = ""
    internal var title = ""
    internal var user = GalleryMember()
    
    //setters
    func SetParentPostID(id: String){
        self.parentPostID = id
    }
    func SetItemID(id: String){
        self.itemID = id
    }
    func SetTitle(title: String){
        self.title = title
    }
    func SetUser(user: GalleryMember){
        self.user = user
    }
    //getters
    func GetParentPostID()->String{
        return self.parentPostID
    }
    func GetItemID()->String{
        return self.itemID
    }
    func GetTitle()->String{
        return self.title
    }
    func GetUser()->GalleryMember{
        return self.user
    }
}
