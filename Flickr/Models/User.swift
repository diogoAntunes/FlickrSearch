//
//  User.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    
    fileprivate enum API: String {
        case id, username, user
        case content = "_content"
    }
    
    let id: String
    let username: String
    
}

extension User {
    
    init(data: JSON) {
        id = data[API.user.rawValue][API.id.rawValue].stringValue
        username = data[API.user.rawValue][API.username.rawValue][API.content.rawValue].stringValue
    }
}
