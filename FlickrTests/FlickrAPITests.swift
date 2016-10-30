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
        
        
        networkClient.network.getPhotosOfUserWith(userId: "testId", photosPerPage: 3, pageNumber: 1) { result in
            switch result {
            case .success(let photos):
                XCTAssert(photos.total == expectedNumberOfPhotos)
                XCTAssert(photos.photo[0].id == expectedFirstPhotoId)
                
            case .failure: XCTFail()
            }
        }
    }
    
    func testGetPhotoInformation() {
        let expectedPhotoId = "12214167964"
        let expecteDateTaken = Date(dateString: "2014-01-29 19:50:07", style: .DateAndTime)
        let expectedViews = 35
        
        networkClient.network.getPhotoInformationWith(photoId: "testId") { result in
            switch result {
            case .success(let photoInfo):
                XCTAssert(photoInfo.id == expectedPhotoId)
                XCTAssertNotNil(photoInfo.dateTaken)
                XCTAssert(photoInfo.dateTaken == expecteDateTaken)
                XCTAssert(photoInfo.views == expectedViews)
                
            case .failure: XCTFail()
            }
        }
    }
    
    func testGetPhotoSizes() {
        let expectedSizes: [PhotoSizes.Size] = [.Small, .Medium]
        
        networkClient.network.getPhotoSizesWith(photoId: "testId") { result in
            switch result {
            case .success(let photoSizes):
                XCTAssert(photoSizes.count == expectedSizes.count)
                
                photoSizes.forEach() {
                    XCTAssertNotNil($0.sourceURL)
                    XCTAssert(expectedSizes.contains($0.size))
                }
                
                
            case .failure: XCTFail()
            }
        }
    }
    
}
