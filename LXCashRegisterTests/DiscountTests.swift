//
//  DiscountTests.swift
//  LXCashRegister
//
//  Created by XianLi on 8/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import XCTest
@testable import LXCashRegister

class DiscountTests: XCTestCase {
    static let TestJson = [
        [
            "type": 0,
            "offPercent": 100
        ],
        [
            "type": 1
        ]
    ]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDiscountCreation() {
        let discounts = Discount.createDiscountArray(json: DiscountTests.TestJson)
        
        XCTAssertTrue(discounts.count == 2, "Discount createDiscountArray fails, actual result = \(discounts)")
        XCTAssertTrue(discounts[0].pirority > discounts[1].pirority, "Discount createDiscountArray didn't sort the array on pirority, actual result \(discounts)")
    }
}