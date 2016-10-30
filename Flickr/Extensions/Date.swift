//
//  Date.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import Foundation

extension Date {
    
    enum Style: String {
        case DateAndTime = "yy-MM-dd HH:mm:ss"
    }
    
    init?(dateString: String, style: Style) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = style.rawValue
        
        guard let d = dateFormatter.date(from: dateString) else { return nil }
        
        self.init(timeInterval: 0, since: d)
    }
}
