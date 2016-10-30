//
//  Photo.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Photo {
    
    fileprivate enum API: String { case id, title }
    
    let id: String
    let title: String
    
    var sizes: [PhotoSizes]?
    
    init(data: JSON) {
        id = data[API.id.rawValue].stringValue
        title = data[API.title.rawValue].stringValue
    }
    
    mutating func setPhotoSizes(sizes: [PhotoSizes]) {
        self.sizes = sizes
    }
}
