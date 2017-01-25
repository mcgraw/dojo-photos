//
//  FeedViewController.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import UIKit
import PromiseKit

class FeedViewController: UIViewController {
    
    // MARK: - Interface
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            loadingView.layer.cornerRadius = 4
            loadingView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var loadingViewActivity: UIActivityIndicatorView!
    @IBOutlet weak var loadingViewBottomContraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var activeAlbum: Album?
    
    // MARK: - System
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an available album
        activeAlbum = Album.first()
    }
    
    // MARK: - Data Handling
    func shouldFetchNextBatch() {
        guard let count = activeAlbum?.photos.count else {
            return
        }
        showLoading()
        
        // Setting an offset to 50 with a limit value of 50 for example, will retrieve photos 51-100
        firstly {
            PhotosApi.shared.photo.feed(offset: count)
        }.then { _ -> Void in
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: self.indexPaths(start: count, count: PhotosApi.photoFetchLimit))
                self.collectionView.reloadData()
            }, completion: { done in
                self.hideLoading()
            })
        }.catch { error in
            print("Failed to fetch next batch. \(error)")
            self.hideLoading()
            
            // TODO: Show error to user
        }
    }
    
    private func indexPaths(start: Int, count: Int) -> [IndexPath] {
        var paths = [IndexPath]()
        for idx in start..<start+count {
            paths.append(IndexPath(row: idx, section: 0))
        }
        return paths
    }
    
    // MARK: - Loading Indicator
    func showLoading() {
        loadingViewActivity.startAnimating()
        
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.225) { 
            self.loadingViewBottomContraint.constant = -10
            self.view.layoutIfNeeded()
        }
    }
    
    func hideLoading() {
        loadingViewActivity.stopAnimating()
        
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.225) {
            self.loadingViewBottomContraint.constant = self.loadingView.bounds.height * -1
            self.view.layoutIfNeeded()
        }
    }
    
}

typealias FeedScrollViewDelegate = FeedViewController
extension FeedScrollViewDelegate: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if loadingViewActivity.isAnimating { return }
        
        // If we've gone lower than 20% of the remaining scroll distance, fire off a request for more photos
        let threshold = scrollView.contentSize.height - (scrollView.contentSize.height * 0.20)
        if (scrollView.contentOffset.y + scrollView.bounds.height) > threshold {
            shouldFetchNextBatch()
        }
    }
    
}

typealias FeedCollectionDataSourceDelegate = FeedViewController
extension FeedCollectionDataSourceDelegate: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activeAlbum?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoId", for: indexPath) as! FeedCollectionViewCell
        
        if let photo = activeAlbum?.photos[indexPath.item],
             let url = URL(string: photo.path(forSize: .medium)) {
            cell.updateImage(withURL: url)
        }
        
        return cell
    }
}


typealias FeedCollectionDelegate = FeedViewController
extension FeedCollectionDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FeedCollectionViewCell
        print("Debug: \(cell.url)")
    }
    
}


typealias FeedFlowLayoutDelegate = FeedViewController
extension FeedFlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.bounds.size.width / 3) - 15 // 3 images per row
        return CGSize(width: size, height: size)
        
    }
    
}
