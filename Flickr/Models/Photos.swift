//
//  Photos.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Photos {
    
    fileprivate enum API: String { case page, pages, perpage, total, photo, photos }
    
    var page: Int
    var pages: Int
    let perpage: Int
    let total: Int
    
    var photo: [Photo]
}

extension Photos {
    
    init(data: JSON) {
        page = data[API.page.rawValue].intValue
        pages = data[API.pages.rawValue].intValue
        perpage = data[API.perpage.rawValue].intValue
        total = data[API.total.rawValue].intValue
        photo = data[API.photo.rawValue].arrayValue.map({ Photo(data: $0) })
    }
    
    mutating func setPhotos(photo: [Photo]) {
        self.photo = photo
    }
    
    mutating func updatePhotos(photo: [Photo]) {
        self.photo.append(contentsOf: photo)
    }
    
    mutating func updatePagesInformation(page: Int, pages: Int) {
        self.page = page
        self.pages = pages
    }
}

extension Photos {

    var canLoadMore: Bool {
        return page < pages
    }
}
