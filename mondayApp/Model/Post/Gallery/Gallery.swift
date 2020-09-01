//
//  Gallery.swift
//  theApp
//
//  Created by rob ord on 24/08/2020.
//  Copyright © 2020 Rob Ord. All rights reserved.
//

import Foundation

class Gallery : anyGallery{
    var galleryOwner = PostOwner()
    var galleryParentPostID = ""
    var galleryTitle = ""
    var galleryItems = [GalleryItem]()
    var galleryCanUserAdd = false
    

    
    func GetGalleryOwner() ->PostOwner{
        return self.galleryOwner
    }
    func GetGalleryParentPostID() -> String{
        return self.galleryParentPostID
    }
    func GetGalleryTitle() -> String{
        return self.galleryTitle
    }
    func GetGalleryItems() ->[GalleryItem]{
        return self.galleryItems
    }
    func GetGalleryCanUserAdd() -> Bool{
        return self.galleryCanUserAdd
    }
    func SetGalleryOwner(owner: PostOwner){
        self.galleryOwner = owner
    }
    func SetGalleryParentPostID(id: String){
        self.galleryParentPostID = id
    }
    func SetGalleryTitle(title: String){
        self.galleryTitle = title
    }
    func SetGalleryItems(items: [GalleryItem]){
        self.galleryItems = items
    }
    func SetGalleryCanUserAdd(canAdd: Bool){
        self.galleryCanUserAdd = canAdd
    }
    
}
