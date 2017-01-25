//
//  FeedCollectionViewCell.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import UIKit
import Alamofire

class FeedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Interface
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    var url: URL?
    
    
    // MARK: - System
    
    override func prepareForReuse() {
        imageView.af_cancelImageRequest()
        imageView.image = nil
    }
    
    // MARK: - Images
    
    func updateImage(withURL url: URL) {        
        self.url = url
        imageView.af_setImage(withURL: url, imageTransition: .crossDissolve(0.225), runImageTransitionIfCached: false)
    }

}
