//
//  InputConverterTests.swift
//  LXCashRegister
//
//  Created by XianLi on 10/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import XCTest
@testable import LXCashRegister

class InputConverterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        guard let path = NSBundle.mainBundle().pathForResource("SampleItems", ofType: "json")
            else {
                print("Faild to load testing items json file into NSData")
                return
        }
        ItemStore.readSampleDataFromFilePath(path)
    }
    
    override func tearDown() {
        ItemStore.clearAllItems()
        super.tearDown()
    }
    
    // may prepare some testing input for test case seperately later
    func testInputConverterRead() {
        XCTAssertNotNil(InputConverter.readFromFile(InputConverter.SampleInputBothDiscountFileName), "Input Convert can't read and covert input from file \(InputConverter.SampleInputBothDiscountFileName)")
    }
    
    func testInputCoverterConvert() {
        let dict = InputConverter.readFromFile(InputConverter.SampleInputOffPercentFileName) as! [String: Int]
        XCTAssertEqual(dict["ITEM0000004"], 4, "Input Convert can't convert input correctly")
    }
}
