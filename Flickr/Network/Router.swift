//
//  Router.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURL = "https://api.flickr.com/services/rest/"
    
    // Public
    case getUserBy(username: String)
    case getPhotosOfUserWith(id: String)
    
    
    var method: HTTPMethod {
        switch self {
        case .getUserBy, .getPhotosOfUserWith: return .get
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
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: buildUserParameters(username: username))
        
        case .getPhotosOfUserWith(let userId):
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: buildGetPhotoParameters(userId: userId))
        }
        
        return urlRequest
    }
}

extension Router {
    
    typealias Dictionary = [String : Any]
    
    fileprivate func buildUserParameters(username: String) -> Dictionary {
        var params = getDefaultParameters()
        params["username"] = username
        params["method"] = "flickr.people.findByUsername"
        
        return params
    }
    
    fileprivate func buildGetPhotoParameters(userId: String) -> Dictionary {
        var params = getDefaultParameters()
        params["user_id"] = userId
        params["method"] = "flickr.people.getPublicPhotos"
        
        return params
    }
    
    fileprivate func getDefaultParameters() -> Dictionary {
        return [
            "api_key" : Headers.flickrAPIKey,
            "format" : "json",
            "nojsoncallback" : 1
        ]
    }
}
