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
    
    convenience init?(withPhotoId id: String) {
        let realm = try! Realm()
        if let photo = realm.objects(Photo.self).filter("id = '\(id)'").first {
            self.init()
            self.id         = photo.id
        } else {
            return nil
        }
    }
    
    func update(withJSON json: JSON) {
        let realm = try! Realm()
        try! realm.write {
            
            realm.add(self, update: true)
        }
    }

    func path(forSize size: PhotoSize) -> String {
        return "https://waldo-thumbs-staging.s3.amazonaws.com/\(size.rawValue)/\(id).\(type)"
    }
}
