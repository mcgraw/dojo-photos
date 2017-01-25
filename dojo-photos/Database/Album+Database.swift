//
//  Album+Database.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import RealmSwift
import SwiftyJSON

extension Album {
    
    // MARK: - Class
    class public func first() -> Album? {
        return try! Realm().objects(Album.self).first
    }
    
    
    // MARK: - Initializers
    convenience public init?(withAlbumId id: String) {
        let realm = try! Realm()
        if let album = realm.objects(Album.self).filter("id = '\(id)'").first {
            self.init()
            self.id         = album.id
            self.name       = album.name
            self.photos     = album.photos
        } else {
            return nil
        }
    }

    // MARK: - CRUD (update only for now)
    public func update(withJSON json: JSON) {
        self.name          = json["name"].stringValue
        
        let realm = try! Realm()
        try! realm.write {
            let records = json["photos"]["records"]
            for photo in records {
                if let firstUrl = photo.1["urls"].first?.1 {
                    let details = parse(withPath: firstUrl["url"].stringValue)
                    if let _ = Photo(withPhotoId: details.id) {
                        // Nothing to update for now
                    } else {
                        let photo = Photo()
                        photo.id = details.id
                        photo.type = details.type
                        photos.append(photo)
                    }
                }
            }
            realm.add(self, update: true)
        }
    }
    
    // MARK: - Convenience
    
    /*
     * Take a given path and get the UUID and filetype from it
     * 
     * Temporary solution to avoid spending more time building out models and tests
     */
    public func parse(withPath path: String) -> (id: String, type: String) {
        let comps = path.components(separatedBy: "/")
        let filename = comps.last?.components(separatedBy: ".")
        if let photoId = filename?.first, let type = filename?.last {
            return (photoId, type)
        }
        return ("", "")
    }
    
}
