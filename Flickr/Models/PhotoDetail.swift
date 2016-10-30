//
//  PhotoDetail.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PhotoDetail {
    
    fileprivate enum API: String {
        case content = "_content"
        case id, description, views, dates, taken
    }
    
    let id: String
    let description: String
    let views: Int
    let dateTaken: Date?
    
    init(data: JSON) {
        id = data[API.id.rawValue].stringValue
        description = data[API.description.rawValue][API.content.rawValue].stringValue
        views = data[API.views.rawValue].intValue
        dateTaken = Date(dateString: data[API.dates.rawValue][API.taken.rawValue].stringValue, style: .DateAndTime)
    }
    
}
