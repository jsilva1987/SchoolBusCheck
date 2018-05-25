//
//  SchoolBusCheckTests.swift
//  SchoolBusCheckTests
//
//  Created by trink2 on 5/22/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import XCTest
@testable import SchoolBusCheck

class SchoolBusCheckTests: XCTestCase {
    
    var requestMock = RequestManagerMock()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequestParsing() {
        let requestManager = RequestManager(delegate: requestMock)
        
        requestMock.didComplete = ({ response in
            XCTAssert(response.count == 4)
            
            for bus in response {
                XCTAssertNotNil(bus.id)
                XCTAssertNotNil(bus.name)
                XCTAssertNotNil(bus.description)
                XCTAssertNotNil(bus.imageUrl)
                XCTAssertNotNil(bus.routeUrl)
            }
        })
        
        requestManager.requestRoutes()
    }
    
    func testRequestImage() {
        let requestManager = RequestManager()
        let bus = SchoolBus()
        bus.imageUrl = "https://cdn0.iconfinder.com/data/icons/kameleon-free-pack-rounded/110/Bus-128.png"
        
        XCTAssertNotNil(requestManager.requestBusImage(bus))
    }
    
}
