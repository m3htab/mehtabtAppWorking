
protocol anyGallery {
    var galleryOwner: PostOwner {get set}
    var galleryParentPostID: String {get set}
    var galleryTitle: String {get set}
    var galleryItems: [GalleryItem] {get set}
    var galleryCanUserAdd: Bool {get set}
    
    func GetGalleryOwner() ->PostOwner
    func GetGalleryParentPostID() ->String
    func GetGalleryTitle() ->String
    func GetGalleryItems() ->[GalleryItem]
    func GetGalleryCanUserAdd()->Bool
    func SetGalleryOwner(owner: PostOwner)
    func SetGalleryParentPostID(id: String)
    func SetGalleryTitle(title: String)
    func SetGalleryItems(items: [GalleryItem])
    func SetGalleryCanUserAdd(canAdd: Bool)
}
