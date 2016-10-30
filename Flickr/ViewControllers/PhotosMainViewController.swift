//
//  PhotosMainViewController.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import UIKit
import Kingfisher

class PhotosMainViewController: UIViewController {
    
    fileprivate enum Segue: String {
        case photoDetail = "segueToDetailPhoto"
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(PhotoCollectionViewCell.self)
        }
    }
    
    fileprivate lazy var viewModel: PhotosViewModel = {
      return PhotosViewModel(client: NetworkClient(network: NetworkManager.sharedInstance))
    }()
    
    
    fileprivate var userPhotos: Photos?
    fileprivate var selectedPhoto: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getUserPhotosFor() { photos in
            self.userPhotos = photos
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let photoDetailVC = segue.destination as? PhotoDetailViewController, let selectedPhoto = selectedPhoto {
            photoDetailVC.photo = selectedPhoto
        }
    }
    
    fileprivate func loadPhotos() {
        viewModel.getUserPhotosFor() { photos in
            if let photos = photos {
                self.userPhotos?.updatePhotos(photo: photos.photo)
                self.userPhotos?.updatePagesInformation(page: photos.page, pages: photos.pages)
                self.collectionView.reloadData()
            }
        }
    }
}

extension PhotosMainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let userPhotos = userPhotos else { return 0 }
        
        return userPhotos.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PhotoCollectionViewCell
        let row = indexPath.row
        
        guard let userPhotos = userPhotos else { return cell }
        
        if row == userPhotos.photo.count - 3 && userPhotos.canLoadMore {
            loadPhotos()
        }
        
        let photo = userPhotos.photo[row]
        let smallSizePhoto = photo.sizes?.filter({ $0.size == .Small }).first
        
        cell.ivPhoto.kf.setImage(with: smallSizePhoto?.sourceURL)
        return cell
    }
}

extension PhotosMainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let userPhotos = userPhotos else { return }
        
        selectedPhoto = userPhotos.photo[indexPath.row]
        performSegue(withIdentifier: Segue.photoDetail.rawValue, sender: self)
    }
}
