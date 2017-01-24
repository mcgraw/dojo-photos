//
//  Photo.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Foundation
import RealmSwift

enum PhotoSize: String {
    case small      = "small"
    case small2x    = "small2x"
    case medium     = "medium"
    case medium2x   = "medium2x"
    case large      = "large"
    case large1x    = "large1x"
    case large2x    = "large2x"
}

enum PhotoType: String {
    case jpg        = "jpg"
}

class Photo: Object {
    dynamic var id = ""
    dynamic var type = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
