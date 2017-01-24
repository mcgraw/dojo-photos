//
//  OnboardViewController.swift
//  Photos
//
//  Created by David McGraw on 1/24/17.
//  Copyright © 2017 David McGraw. All rights reserved.
//

import UIKit
import PromiseKit

class OnboardViewController: UIViewController {
    
    // MARK: - Interface
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var titleMessage: UILabel!
    @IBOutlet weak var statusMessage: UILabel!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    // MARK: - System
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do we have a preloaded album with photos?
        if let album = Album.first(), album.photos.count > 0 {
            onboardDidComplete()
        } else {
            // The view will actually be visible at this point, introduce a slight delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showStatus(withMessage: "One moment while we load a few photos", loading: true)
            }
            
            // Welcome the user and prefetch photos
            firstly {
                PhotosApi.shared.photo.feed(withLimit: 50, offset: 0)
            }.then {
                self.onboardDidComplete()
            }.catch { error in
                print("Failed to fetch the next set of photos for the feed. \(error)")
            }
        }
    }
    
    // MARK: - Animation
    func onboardDidComplete() {
        self.dismissStatus {
            UIView.animate(withDuration: 0.225, animations: {
                self.background.alpha = 0
                self.titleMessage.alpha = 0
            }) { done in
                self.performSegue(withIdentifier: "photoFeedSegue", sender: self)
            }
        }
    }
    
    // MARK: - Status Message
    func showStatus(withMessage message: String, loading: Bool) {
        // Set the text and force an auto layout update
        statusMessage.text = message
        view.layoutIfNeeded()
        
        if loading {
            activity.startAnimating()
        } else {
            activity.stopAnimating()
        }
        
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.225) { 
            self.statusViewBottomConstraint.constant = -4
            self.view.layoutIfNeeded()
        }
    }
    
    func dismissStatus(completed: @escaping () -> Void) {
        if statusViewBottomConstraint.constant != -4 {
            return completed()
        }
        activity.stopAnimating()
        
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.4, animations: {
            self.statusViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { done in
            UIView.animate(withDuration: 0.225, animations: {
                self.statusViewBottomConstraint.constant = -64
                self.view.layoutIfNeeded()
            }) { done in
                completed()
            }
        }
        
    }
    
}
