//
//  BaseSpec.swift
//  Photos
//
//  Created by David McGraw on 1/25/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import SwiftyJSON

class BaseSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        beforeSuite {
            self.useTestDatabase()
        }
        
        beforeEach {
            self.clearTestDatabase()
        }
    }
    
}

extension BaseSpec {
    
    // Set an in memory identifier so we don't mess with the prod/dev db
    func useTestDatabase() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    // Clear any data so we begin fresh
    func clearTestDatabase() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    // Get a JSON representation of a local json file
    func getJSONObjectFromFile(withFilename name: String, forClass: AnyClass = BaseSpec.self) -> JSON? {
        let bundle = Bundle(for: forClass)
        if let path = bundle.path(forResource: name, ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                return JSON(data: data)
            } catch {
                return nil
            }
        }
        return nil
    }
    
}
