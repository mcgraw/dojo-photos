//
//  AppConfig.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Foundation

class AppConfig {
    
    static let shared = AppConfig()
    
    var graph = ""
    
    init() {
        guard let value = Bundle.main.infoDictionary?["GraphURL"] as? String else {
            return
        }
        graph = value
    }
    
}
