//
//  PhotoSpec.swift
//  Photos
//
//  Created by David McGraw on 1/25/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import SwiftyJSON

@testable import Photos

class PhotoSpec: BaseSpec {
    
    override func spec() {
        super.spec()
        
        let photoPath = "https://waldo-thumbs-staging.s3.amazonaws.com/small2x/3b568ff2-f408-4824-996b-0116c06b0a6f.jpg"
        let photoId = "3b568ff2-f408-4824-996b-0116c06b0a6f"
        let photoType = PhotoType.jpg
        
        describe("photo") {
            describe("create photo with id and type") {
                it("initializes") {
                    self.createPhoto(withId: photoId, type: photoType)
                    
                    let photo = Photo(withPhotoId: photoId)
                    expect(photo?.id) == photoId
                    expect(photo?.type) == photoType.rawValue
                }
            }
            
            describe("get photo path with") {
                it("formats properly") {
                    self.createPhoto(withId: photoId, type: photoType)
                    let photo = Photo(withPhotoId: photoId)
            
                    let path = photo?.path(forSize: .small2x)
                    expect(path) == photoPath
                }
            }
        }
        
    }
    
}


extension PhotoSpec {
    
    func createPhoto(withId id: String, type: PhotoType) {
        let realm = try! Realm()
        try! realm.write {
            let photo = Photo()
            photo.id = id
            photo.type = type.rawValue
            realm.add(photo)
        }
    }
    
}
