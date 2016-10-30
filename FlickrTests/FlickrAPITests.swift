//
//  FlickrAPITests.swift
//  Flickr
//
//  Created by Diogo Antunes on 27/10/2016.
//  Copyright © 2016 Diogo Antunes. All rights reserved.
//

import XCTest
@testable import Flickr

class FlickrAPITests: XCTestCase {
    
    fileprivate var networkClient: NetworkClient!
    fileprivate let session = NetworkManagerMock()
    
    override func setUp() {
        super.setUp()
        
        networkClient = NetworkClient(network: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetUser() {
        let expectedUserId = "146081126@N03"
        let expectedUserName = "diogo.antunes"
        
        networkClient.network.getUserBy(username: "testUsername") { result in
            switch result {
            case .success(let user):
                XCTAssert(user.id == expectedUserId)
                XCTAssert(user.username == expectedUserName)
            case .failure: XCTFail()
            }
        }
    }
    
    func testGetPhotosOfUser() {
        let expectedNumberOfPhotos = 38
        let expectedFirstPhotoId = "12214167964"
        
        
        networkClient.network.getPhotosOfUserWith(id: "testId") { result in
            switch result {
            case .success(let photos):
                XCTAssert(photos.total == expectedNumberOfPhotos)
                XCTAssert(photos.photo[0].id == expectedFirstPhotoId)
                
            case .failure: XCTFail()
            }
        }
    }
    
}
