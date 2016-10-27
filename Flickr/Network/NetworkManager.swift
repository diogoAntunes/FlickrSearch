//
//  NetworkManager.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation

class NetworkManager {
    
    /** Singleton **/
    static let sharedInstance = NetworkManager()
    fileprivate init() { }
}

extension NetworkManager: NetworkProtocol {
    
    func getUserBy(id: String, callback: @escaping (Result<User>) -> Void) {
        
    }
}
