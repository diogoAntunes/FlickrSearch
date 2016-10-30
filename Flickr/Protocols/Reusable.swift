//
//  Reusable.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import UIKit

protocol Reusable: class {}

extension Reusable where Self: UIView {
    
    static var reuseIdentifier: String { return String(describing: self) }
    
}

extension UICollectionViewCell: Reusable { }
