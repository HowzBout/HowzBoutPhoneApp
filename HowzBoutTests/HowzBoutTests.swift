//
//  HowzBoutTests.swift
//  HowzBoutTests
//
//  Created by Thomas Annerino on 8/23/17.
//  Copyright © 2017 HowzBout, LLC. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON
@testable import HowzBout

class HowzBoutTests: XCTestCase {
    let timeout: TimeInterval = 30.0
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        testHowzBoutAPICall()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testHowzBoutAPICall() {
        var response: DataResponse<Any>?
        let expectation = self.expectation(description: "GET request should succeed:")
        var json = JSON()
        Alamofire.request("http://localhost:55175/Yelp/pizza/60506").responseJSON { resp in
            response = resp
            expectation.fulfill()
            if let value = resp.result.value {
                json = JSON(value)
            }
        }
        waitForExpectations(timeout: timeout, handler: nil)
        print("Result: " + json["total"].stringValue)
        
        
        XCTAssertNotNil(json["total"].stringValue == "96")
    }
    
    func testUtilitiesGetAllYelpMerchants() {
        
        var json = JSON()
        var util: Utilities = Utilities()
        let expectation = self.expectation(description: "Method should succeed:")
        json = util.GetAllYelpMerchants(term: "pizza", latitude: "-122.406417", longitude: "37.785834")
        expectation.fulfill()
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNotNil(json)
        
        XCTAssertNotNil(json["total"].stringValue == "96")
        print("Total: " + json["total"].stringValue)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
