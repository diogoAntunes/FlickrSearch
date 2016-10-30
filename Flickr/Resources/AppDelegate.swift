//
//  AppDelegate.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let client = NetworkClient(network: NetworkManager.sharedInstance)
        
        client.network.getPhotosOfUserWith(id: "94949650@N02") { result in
            switch result {
            case .success(let photo): print(photo.photo.description)
            default: break
            }
        }
        
        return true
    }


}

