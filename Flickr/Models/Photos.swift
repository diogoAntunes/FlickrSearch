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
    
    struct Photo {
        
        fileprivate enum API: String { case id, title }
        
        let id: String
        let title: String
//        let smallPhotoURL: URL?
//        let bigPhotoURL: URL?
        
        init(data: JSON) {
            id = data[API.id.rawValue].stringValue
            title = data[API.title.rawValue].stringValue
        }
    }
    
    fileprivate enum API: String { case page, pages, perpage, total, photo, photos }
    
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
    
    init(data: JSON) {
        page = data[API.page.rawValue].intValue
        pages = data[API.pages.rawValue].intValue
        perpage = data[API.perpage.rawValue].intValue
        total = data[API.total.rawValue].intValue
        photo = data[API.photo.rawValue].arrayValue.map({ Photo(data: $0) })
    }
}
