//
//  Photo+Database.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import RealmSwift
import SwiftyJSON

extension Photo {
    
    convenience public init?(withPhotoId id: String) {
        let realm = try! Realm()
        if let photo = realm.objects(Photo.self).filter("id = '\(id)'").first {
            self.init()
            self.id         = photo.id
            self.type       = photo.type
        } else {
            return nil
        }
    }
    
    public func update(withJSON json: JSON) {
        let realm = try! Realm()
        try! realm.write {
            
            // Maintain explicit record data for paths
            // Skipping for now so this project doesn't take forever longer
            
            realm.add(self, update: true)
        }
    }

    public func path(forSize size: PhotoSize) -> String {
        return "\(PhotosApi.thumbPath)/\(size.rawValue)/\(id).\(type)"
    }
}
