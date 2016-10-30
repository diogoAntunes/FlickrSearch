//
//  Router.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation
import Alamofire

enum Flickr {
    
    enum Method {
        static let getUserBy = "flickr.people.findByUsername"
        static let getUserPhotos = "flickr.people.getPublicPhotos"
        static let getPhotoInformation = "flickr.photos.getInfo"
        static let getPhotoSizes = "flickr.photos.getSizes"
    }
    
    enum API {
        static let username = "username"
        static let userId = "user_id"
        static let photoId = "photo_id"
        static let method = "method"
        
        static let perPage = "per_page"
        static let page = "page"
    }
}

enum Router: URLRequestConvertible {
    
    static let baseURL = "https://api.flickr.com/services/rest/"
    
    case getUserBy(username: String)
    case getPhotosOfUserWith(userId: String, photosPerPage: Int, pageNumber: Int)
    case getPhotoInformationWith(photoId: String)
    case getPhotoSizesWith(photoId: String)
    
    var method: HTTPMethod {
        switch self {
        case .getUserBy, .getPhotosOfUserWith, .getPhotoInformationWith, .getPhotoSizesWith: return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(Headers.AcceptValue, forHTTPHeaderField: Headers.Accept)
        urlRequest.setValue(Headers.ContentTypeValueJson, forHTTPHeaderField: Headers.ContentType)
        
        switch self {
            
        case .getUserBy(let username):
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: userParams(username: username))
            
        case .getPhotosOfUserWith(let userId, let photosPerPage, let pageNumber):
            urlRequest = try URLEncoding.queryString.encode(urlRequest,
                                                            with: photoParams(userId: userId, photosPerPage: photosPerPage, pageNumber: pageNumber))
            
        case .getPhotoInformationWith(let photoId):
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: photoInformationParams(photoId: photoId))
            
        case .getPhotoSizesWith(let photoId):
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: photoSizesParams(photoId: photoId))
        }
        
        return urlRequest
    }
}

extension Router {
    
    typealias Dictionary = [String : Any]
    
    
    fileprivate func userParams(username: String) -> Dictionary {
        var params = getDefaultParameters
        params[Flickr.API.username] = username
        params[Flickr.API.method] = Flickr.Method.getUserBy
        
        return params
    }
    
    fileprivate func photoParams(userId: String, photosPerPage: Int, pageNumber: Int) -> Dictionary {
        var params = getDefaultParameters
        params[Flickr.API.userId] = userId
        params[Flickr.API.perPage] = photosPerPage
        params[Flickr.API.page] = pageNumber
        params[Flickr.API.method] = Flickr.Method.getUserPhotos
        
        return params
    }
    
    fileprivate func photoInformationParams(photoId: String) -> Dictionary {
        var params = getDefaultParameters
        params[Flickr.API.photoId] = photoId
        params[Flickr.API.method] = Flickr.Method.getPhotoInformation
        
        return params
    }
    
    fileprivate func photoSizesParams(photoId: String) -> Dictionary {
        var params = getDefaultParameters
        params[Flickr.API.photoId] = photoId
        params[Flickr.API.method] = Flickr.Method.getPhotoSizes
        
        return params
    }
    
    fileprivate var getDefaultParameters: Dictionary {
        return [
            "api_key" : Headers.flickrAPIKey,
            "format" : "json",
            "nojsoncallback" : 1
        ]
    }
}
