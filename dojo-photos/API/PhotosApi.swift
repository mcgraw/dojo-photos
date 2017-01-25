//
//  PhotosApi.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Foundation
import RealmSwift

public class PhotosApi {
    
    // MARK: - Shared API Resources
    public let photo = PhotosRequest()
    
    // MARK: - Properties
    private struct Constants {
        static let shared = PhotosApi()
        static let thumbPath = Bundle.main.infoDictionary?["S3PhotoURL"] as? String
        static let graphPath = Bundle.main.infoDictionary?["GraphURL"] as? String
        static let graphURL = URL(string: PhotosApi.graphPath)
        static let fetchLimit = 50
    }
    
    class public var shared: PhotosApi {
        return Constants.shared
    }
    
    class public var thumbPath: String {
        return Constants.thumbPath ?? ""
    }
    
    class public var graphPath: String {
        return Constants.graphPath ?? ""
    }
    
    class public var graphURL: URL? {
        return Constants.graphURL
    }
    
    class public var photoFetchLimit: Int {
        return Constants.fetchLimit
    }
        
    // MARK: - System
    public init() {
        // What endpoint is the API on?
        print("API endpoint: \(PhotosApi.graphPath)")
        
        // What s3 bucket are we using for photos?
        print("S3 bucket: \(PhotosApi.thumbPath)")
        
        // Database configuration, migration, etc
        print("Database local file path: \(Realm.Configuration.defaultConfiguration.fileURL)")
        
        // Monitor network reachability
        //     Ideally we'd throw in even more here to track if:
        //       a) we can reach any network
        //       b) we can reach our servers
    }
        
}
