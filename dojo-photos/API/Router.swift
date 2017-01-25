//
//  Router.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Alamofire

/*
 * We're not using this, but I'd thought it would be helpful to see how I manage
 * the wide variety of endpoints an iOS app interacts with. A single source for 
 * all of that information.
 */

public enum RouterError: Error {
    case invalidGraphUrl
}

public enum Router: URLRequestConvertible {
    
    case feed(query: String)
    
    
    // -
    var method: HTTPMethod {
        switch self {
        case .feed:                                   return .get
        }
    }
    
    var path: String {
        switch self {
        case .feed(_):                                return "/gql"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        guard let url = try PhotosApi.graphURL?.asURL() else {
            throw RouterError.invalidGraphUrl
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        /*
         * It should go without saying, but we would clearly secure this the moment
         * we fetched it during auth using the keychain
         */
        urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50X2lkIjoiMmEyODQ4M2YtNWM2Yi00ZWU5LWE4YjUtYzFlMGU5NWUwYTY5Iiwicm9sZXMiOlsiYWRtaW5pc3RyYXRvciJdLCJpc3MiOiJ3YWxkbzpjb3JlIiwiZ3JhbnRzIjpbImFsYnVtczpkZWxldGU6KiIsImFsYnVtczpjcmVhdGU6KiIsImFsYnVtczplZGl0OioiLCJhbGJ1bXM6dmlldzoqIl0sImV4cCI6MTQ4Nzg2MzA3MiwiaWF0IjoxNDg1MjcxMDcyfQ.iLOnItDCD2QssvwtlodvG_6UtuA-GpNY54E8TYLzcWU)", forHTTPHeaderField: "Authorization")
        
        switch self {
        case .feed(let query):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["query": query])
        }
        
        print(urlRequest)
        return urlRequest
    }
    
}
