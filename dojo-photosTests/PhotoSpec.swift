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
import Photos

class PhotoSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        // Set an in memory identifier so we don't mess with the prod/dev db
        beforeSuite {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }
        
        // Clear any data so we begin fresh
        beforeEach {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }
    }
    
}
