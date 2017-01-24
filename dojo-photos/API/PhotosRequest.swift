//
//  PhotosRequest.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import Alamofire
import PromiseKit
import SwiftyJSON

public class PhotosRequest {
        
    /*
     * Fetch the photo feed
     *
     * To pull the next batch, simply adjust the offset. Setting it to 50 with 
     * a limit value of 50 for example, will retrieve photos 51-100.
     */
    public func feed(withLimit limit: Int = 50, offset: Int) -> Promise<Void> {
        return Promise { fufill, reject in
            print("> Begin fetch for photos with limit \(limit) offset by \(offset)")
            let headers = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50X2lkIjoiMmEyODQ4M2YtNWM2Yi00ZWU5LWE4YjUtYzFlMGU5NWUwYTY5Iiwicm9sZXMiOlsiYWRtaW5pc3RyYXRvciJdLCJpc3MiOiJ3YWxkbzpjb3JlIiwiZ3JhbnRzIjpbImFsYnVtczpkZWxldGU6KiIsImFsYnVtczpjcmVhdGU6KiIsImFsYnVtczplZGl0OioiLCJhbGJ1bXM6dmlldzoqIl0sImV4cCI6MTQ4Nzg2MzA3MiwiaWF0IjoxNDg1MjcxMDcyfQ.iLOnItDCD2QssvwtlodvG_6UtuA-GpNY54E8TYLzcWU"]
            
            let urlParams = ["query": "query { album(id: \"YWxidW06YTQwYzc5ODEtMzE1Zi00MWIyLTk5NjktMTI5NjIyZDAzNjA5\") { id, name, photos(slice: { limit: \(limit), offset: \(offset) }) { records { urls { size_code url width height quality mime }}}}}"]
            
            Alamofire.request(PhotosApi.graphPath, method: .get, parameters: urlParams, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if (response.result.error == nil) {
                        print("< Fetch for more photos complete")
                        if let data = response.data {
                            let json = JSON(data: data)
                            
                            let albumData = json["data"]["album"]
                            if let albumId = albumData["id"].string {
                                if let mutable = Album(withAlbumId: albumId) {
                                    mutable.update(withJSON: albumData)
                                } else {
                                    let album = Album()
                                    album.id = albumId
                                    album.update(withJSON: albumData)
                                }
                                fufill()
                            } else {
                                reject(RequestError.parseError)
                            }
                        } else {
                            reject(RequestError.parseError)
                        }
                    } else {
                        print("< Fetch for more photos failed")
                        reject(response.result.error ?? RequestError.invalidResponse)
                    }
            }

        }
    }
    
}
