//
//  NetworkManagerMock.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation
import SwiftyJSON
@testable import Flickr

class NetworkManagerMock: NetworkProtocol {
    
    func getUserBy(username: String, callback: @escaping (Result<User>) -> Void) {
        
        let json = JSON(data: readjson(fileName: "User"))
        callback(.success(User(data: json)))
    }
    
    func getPhotosOfUserWith(id: String, callback: @escaping (Result<Photos>) -> Void) {
        
        let json = JSON(data: readjson(fileName: "Photos"))
        callback(.success(Photos(data: json)))
    }
}

extension NetworkManagerMock {
    
    func readjson(fileName: String) -> Data {
        let path = Bundle.main.url(forResource: fileName, withExtension: "json")
        let jsonData = try! Data(contentsOf: path!, options: .alwaysMapped)
        
        return jsonData
    }
}
