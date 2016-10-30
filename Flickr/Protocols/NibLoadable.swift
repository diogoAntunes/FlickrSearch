//
//  NibLoadable.swift
//  Flickr
//
//  Created by Diogo Antunes on 30/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import UIKit

protocol NibLoadable: class { }

extension NibLoadable where Self: UIView {
    static var nibName: String { return String(describing: self) }
}

extension UICollectionViewCell: NibLoadable { }
