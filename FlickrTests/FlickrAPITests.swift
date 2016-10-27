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
    
    func testUserAPI() {
        let expectedUserId = "146081126@N03"
        let expectedUserName = "diogo.antunes"
        
        networkClient.network.getUserBy(id: "testId") { result in
            switch result {
            case .Success(let user):
                XCTAssert(user.id == expectedUserId)
                XCTAssert(user.username == expectedUserName)
            case .Failure: XCTFail()
            }
        }
    }
    
}
