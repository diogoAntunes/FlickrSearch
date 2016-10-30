//
//  NetworkProtocol.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation

enum BackendError: Error {
    case fail
}

enum Result<T> {
    case success(T)
    case failure(error: Error)
}

protocol NetworkProtocol {
    
    func getUserBy(username: String, callback: @escaping (Result<User>) -> Void)
    func getPhotosOfUserWith(id: String, callback: @escaping (Result<Photos>) -> Void)
}
