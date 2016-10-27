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
    
    static let baseURL = "https://api.flickr.com/services/rest/?method="
    
    // Public
    case getUserBy(id: String)
    
    var path: String {
        switch self {
        case .getUserBy: return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUserBy: return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
            
            
        case .getUserBy:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            urlRequest.setValue(Headers.AcceptValue, forHTTPHeaderField: Headers.Accept)
            urlRequest.setValue(Headers.ContentTypeValueJson, forHTTPHeaderField: Headers.ContentType)
        }
        
        return urlRequest
    }
    
}
