//
//  PhotoSizes.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PhotoSizes {
    
    fileprivate enum API: String { case label, source }
    
    enum Size: String { case Small, Medium }
    
    let size: Size
    let sourceURL: URL?
    
    init?(data: JSON) {
        guard let expectedSize = Size(rawValue: data[API.label.rawValue].stringValue) else { return nil }
        
        size = expectedSize
        sourceURL = URL(string: data[API.source.rawValue].stringValue)
    }
    
}
