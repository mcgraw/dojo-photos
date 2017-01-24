//
//  AppImageManager.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Foundation
import AlamofireImage

class AppImageManager {
    
    // MARK: - Properties
    private struct Constants {
        static let shared = AppImageManager()
    }
    
    class var shared: AppImageManager {
        return Constants.shared
    }
    
    var imageCache = AutoPurgingImageCache(memoryCapacity: 100_000_000,
                                           preferredMemoryUsageAfterPurge: 60_000_000)
    
    // MARK: - Cache
    
    
    
}
