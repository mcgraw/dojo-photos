//
//  Album.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Foundation
import RealmSwift

class Album: Object {
    dynamic var id = ""
    dynamic var name = ""
    
    var photos = List<Photo>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
