//
//  NetworkManager.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

extension Request {
    public func debugLog() -> Self {
        debugPrint(self)
        return self
    }
}

class NetworkManager {
    
    /** Singleton **/
    static let sharedInstance = NetworkManager()
    fileprivate init() { }
}

extension NetworkManager: NetworkProtocol {
    
    func getUserBy(username: String, callback: @escaping (Result<User>) -> Void) {
        alamofireCall(.getUserBy(username: username),
                      success: { response in
                        callback(.success(User(data: response)))
        }, failure: { error in
            callback(.failure(error: error))
        })
    }
    
    func getPhotosOfUserWith(userId: String, photosPerPage: Int, pageNumber: Int, callback: @escaping (Result<Photos>) -> Void) {
        alamofireCall(.getPhotosOfUserWith(userId: userId, photosPerPage: photosPerPage, pageNumber: pageNumber),
                      success: { response in
                        callback(.success(Photos(data: response["photos"])))
        }, failure: { error in
            callback(.failure(error: error))
        })
    }
    
    func getPhotoInformationWith(photoId: String, callback: @escaping (Result<PhotoDetail>) -> Void) {
        alamofireCall(.getPhotoInformationWith(photoId: photoId),
                      success: { response in
                        callback(.success(PhotoDetail(data: response["photo"])))
        }, failure: { error in
            callback(.failure(error: error))
        })
    }
    
    func getPhotoSizesWith(photoId: String, callback: @escaping (Result<[PhotoSizes]>) -> Void) {
        alamofireCall(.getPhotoSizesWith(photoId: photoId),
                      success: { response in
                        callback(.success(response["sizes"]["size"].arrayValue.flatMap({ PhotoSizes(data: $0) })))
        }, failure: { error in
            callback(.failure(error: error))
        })
    }
}

extension NetworkManager {
    typealias successResponse = (_ result: JSON) -> Void
    typealias failureResponse = (_ error: BackendError) -> Void
    
    fileprivate func alamofireCall(_ requestURL: Router, success: @escaping successResponse, failure: @escaping failureResponse) {
        Alamofire.request(requestURL)
            .debugLog()
            .validate()
            .responseData() { response in
                switch response.result {
                case .success(let data): success(JSON(data: data))
                case .failure: failure(.fail)
                }
        }
    }
}

