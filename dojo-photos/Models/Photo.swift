//
//  Photo.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Foundation
import RealmSwift

public enum PhotoSize: String {
    case small      = "small"
    case small2x    = "small2x"
    case medium     = "medium"
    case medium2x   = "medium2x"
    case large      = "large"
    case large1x    = "large1x"
    case large2x    = "large2x"
}

public enum PhotoType: String {
    case jpg        = "jpg"
}

public class Photo: Object {
    dynamic public var id = ""
    dynamic public var type = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
}
