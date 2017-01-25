//
//  AlbumSpec.swift
//  Photos
//
//  Created by David McGraw on 1/25/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

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

class AlbumSpec: BaseSpec {
    
    override func spec() {
        super.spec()
        
        let albumId = "MDJNRncxd1EzYnFMTFg4YVJFc3RKdmhu"
        let albumName = "hello"
        
        let photoPath = "https://waldo-thumbs-staging.s3.amazonaws.com/small2x/3b568ff2-f408-4824-996b-0116c06b0a6f.jpg"
        let photoId = "3b568ff2-f408-4824-996b-0116c06b0a6f"
        let photoType = PhotoType.jpg
        
        describe("album") {
            describe("create album with id and name") {
                it("initializes") {
                    self.createAlbum(withId: albumId, name: albumName)
                    
                    let album = Album(withAlbumId: albumId)
                    expect(album?.id) == albumId
                    expect(album?.name) == albumName
                }
            }
            
            describe("photo url") {
                it("parses") {
                    let comps = Album().parse(withPath: photoPath)
                    
                    expect(comps.id) == photoId
                    expect(comps.type) == photoType.rawValue
                }
            }
            
            describe("update album from JSON") {
                it("initializes and contains photos") {
                    let json = self.getJSONObjectFromFile(withFilename: "GraphRequestData", forClass: AlbumSpec.self)
                    expect(json) != nil
                    
                    _ = Album.updateAlbum(fromJSON: json!)
                    let album = Album(withAlbumId: albumId)
                    
                    expect(album?.id) == albumId
                    expect(album?.name) == albumName
                    expect(album?.photos.count) == 5
                }
            }
        }
        
    }
    
}


extension AlbumSpec {
    
    func createAlbum(withId id: String, name: String) {
        let realm = try! Realm()
        try! realm.write {
            let album = Album()
            album.id = id
            album.name = name
            realm.add(album)
        }
    }
        
}
