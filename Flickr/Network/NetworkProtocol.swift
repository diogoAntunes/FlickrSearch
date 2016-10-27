//
//  NetworkProtocol.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Failure(error: Error)
}

protocol NetworkProtocol {
    
    func getUserBy(id: String, callback: @escaping (Result<User>) -> Void)
}
