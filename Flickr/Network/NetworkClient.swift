//
//  NetworkClient.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation

class NetworkClient {
    
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
}
