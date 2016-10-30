//
//  PhotoDetailViewController.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var ivPhoto: UIImageView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
        
        if let photo = photo {
            let mediumSizePhoto = photo.sizes?.filter({ $0.size == .Medium }).first
            ivPhoto.kf.setImage(with: mediumSizePhoto?.sourceURL)
        }
    }
    
    func didTapView() {
        dismiss(animated: true, completion: nil)
    }
    
}
