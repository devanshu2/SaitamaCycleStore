//
//  PlaceTests.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 13/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import XCTest

class PlaceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPlace1() {
        let data = ["location" : ["lat":34.23, "lng":3.11], "id" : "33434", "name" : "somename" ] as [String : Any]
        let obj = Place(dataDictionary: data)
        XCTAssertNotNil(obj, "Expected was not nil")
    }
    
    func testPlace2() {
        let data = [ "id" : "33434", "name" : "somename" ] as [String : Any]
        let obj = Place(dataDictionary: data)
        XCTAssertNil(obj, "Expected was nil")
    }
    
    func testPlace3() {
        let data = ["location" : ["lat":34.23, "lng":3.11], "name" : "somename" ] as [String : Any]
        let obj = Place(dataDictionary: data)
        XCTAssertNil(obj, "Expected was nil")
    }
}
