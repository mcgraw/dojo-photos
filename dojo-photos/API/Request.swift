//
//  Request.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

public enum RequestError: Error {
    case invalidResponse
    case networkUnavailable
    case parseError
}
