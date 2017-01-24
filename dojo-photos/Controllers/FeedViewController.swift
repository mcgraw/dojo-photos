//
//  FeedViewController.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - Interface
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    var activeAlbum: Album?
    
    
    // MARK: - System
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an available album
        activeAlbum = Album.first()
    }
    
    
}

typealias FeedCollectionDataSourceDelegate = FeedViewController
extension FeedCollectionDataSourceDelegate: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activeAlbum?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoId", for: indexPath) as! FeedCollectionViewCell
        
        
        return cell
    }
}


typealias FeedCollectionDelegate = FeedViewController
extension FeedCollectionDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Dive into it?
    }
    
}


typealias FeedFlowLayoutDelegate = FeedViewController
extension FeedFlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.bounds.size.width / 3) - 50 // 3 images per row
        return CGSize(width: size, height: size)
        
    }
    
}
