//
//  PercentOffDiscountTest.swift
//  LXCashRegister
//
//  Created by XianLi on 8/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import XCTest
@testable import LXCashRegister

class PercentOffDiscountTest: XCTestCase {
    static let TestJson = [
            "type": 1,
            "offPercent": 100
        ]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPercentOffDiscountCreation() {
        let discount = PercentOffDiscount(json: PercentOffDiscountTest.TestJson)
        
        XCTAssertNotNil(discount, "PercentOffDiscount not created")
        
        if let discount = discount {
            XCTAssertEqual(discount.offPercent, 1, "PercentOffDiscount off precent not init correctly")
        }
    }
    
}
