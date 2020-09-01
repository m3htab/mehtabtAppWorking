
protocol anyGalleryItem{
    var parentPostID: String {get set}
    var itemID: String {get set}
    var title: String {get set}
    var user: GalleryMember {get set}
    
    func SetParentPostID(id: String)
    func SetItemID(id: String)
    func SetTitle(title: String)
    func SetUser(user: GalleryMember)
    func GetParentPostID()->String
    func GetItemID()->String
    func GetTitle()->String
    func GetUser()->GalleryMember
}
