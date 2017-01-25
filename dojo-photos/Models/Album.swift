//
//  Album.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Foundation
import RealmSwift

public class Album: Object {
    dynamic public var id = ""
    dynamic public var name = ""
    
    public var photos = List<Photo>()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
