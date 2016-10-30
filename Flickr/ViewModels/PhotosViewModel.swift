//
//  PhotosViewModel.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation

class PhotosViewModel {
    
    fileprivate var networkClient: NetworkClient!
    
    fileprivate var pageNumber = 0
    fileprivate let photosPerPage = 20
    fileprivate let userId = "29096781@N02"
    
    init(client: NetworkClient) {
        self.networkClient = client
    }
}

extension PhotosViewModel {
    
    func getUserPhotosFor(callback: @escaping (Photos?) -> Void) {
        pageNumber += 1
        
        let dispatchGroup = DispatchGroup()
        
        networkClient.network.getPhotosOfUserWith(userId: userId, photosPerPage: photosPerPage, pageNumber: pageNumber) { result in
            switch result {
            case .success(let photos):
                var photos = photos
                var photosWithSize = [Photo]()
                photos.photo.forEach() { photo in
                    
                    dispatchGroup.enter()
                    
                    self.networkClient.network.getPhotoSizesWith(photoId: photo.id) { result in
                        switch result {
                        case .success(let photoSize):
                            var photoWithSize = photo
                            photoWithSize.setPhotoSizes(sizes: photoSize)
                            photosWithSize.append(photoWithSize)
                            dispatchGroup.leave()
                            
                        case .failure: callback(nil)
                        }
                    }
                }
                
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    photos.setPhotos(photo: photosWithSize)
                    callback(photos)
                }
            case .failure: callback(nil)
            }
        }
    }
}
