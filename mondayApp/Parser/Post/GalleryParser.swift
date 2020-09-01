import Firebase

extension Post{
    
    static func parseGallery(document: QueryDocumentSnapshot,friendList: [String],owner: PostOwner,uid: String)->Gallery?{
        guard
            let rawGalleryItemData = document[galleryRef.GALLERY_ITEMS] as! [String: [String: String]]?,
            let galleryTitle = document[galleryRef.GALLERY_TITLE] as! String?,
            let usersCanAdd = document[galleryRef.GALLERY_PRIVILEGED_USER_IDS] as! [String]?,
            let parentPostId = document[galleryRef.GALLERY_PARENT_POST_ID] as! String?
        else{return nil}
        let gallery = Gallery()
        var galleryItemList = [GalleryItem]()
        
        gallery.SetGalleryOwner(owner: owner)
        gallery.SetGalleryParentPostID(id: parentPostId)
        gallery.SetGalleryTitle(title: galleryTitle)
        
        let canUserAdd = Post.checkforUserInString(list: usersCanAdd, uid: uid)
        gallery.SetGalleryCanUserAdd(canAdd: canUserAdd)
        
        for item in rawGalleryItemData{
            guard
                let postid = item.value[galleryRef.GALLERY_ITEM_PARENT_POST_ID] as String?,
                let itemid = item.value[galleryRef.GALLERY_ITEM_ID] as String?,
                let title = item.value[galleryRef.GALLERY_ITEM_TITLE] as String?,
                let uid = item.value[galleryRef.GALLERY_ITEM_USER_ID] as String?,
                let fname = item.value[galleryRef.GALLERY_ITEM_FIRSTNAME] as String?,
                let lname = item.value[galleryRef.GALLERY_ITEM_LASTNAME] as String?
            else{return nil}
            
            let item = GalleryItem()
            let user = GalleryMember()
            user.SetUserID(ID: uid)
            user.SetFirstName(name: fname)
            user.SetLastName(name: lname)
            user.SetRelationToUser(relation: Post.checkForAUserRelation(target: uid, userFriendList: friendList))
            item.SetParentPostID(id: postid)
            item.SetItemID(id: itemid)
            item.SetTitle(title: title)
            item.SetUser(user: user)
            galleryItemList.append(item)
        }
        gallery.SetGalleryItems(items: galleryItemList)
        return gallery
    }
    
    
}
