//
//  PurchaseTests.swift
//  LXCashRegister
//
//  Created by XianLi on 8/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import XCTest
import CoreData
@testable import LXCashRegister

class PurchaseTests: XCTestCase {
    static let PurchaseTestingJson = [
        [
            "barCode": "ITEM0000000",
            "count":   12
        ],
        [
            "barCode": "ITEM0000001",
            "count":   5
        ]
    ]
    
    override func setUp() {
        super.setUp()
        guard let path = NSBundle(forClass: PurchaseTests.classForCoder()).pathForResource("TestingItems", ofType: "json")
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
    
    func testPurchaseCreation() {
        let purchase = Purchase(json: PurchaseTests.PurchaseTestingJson[0])
        
        XCTAssertNotNil(purchase, "Purchase is not created")
        if let purchase = purchase {
            XCTAssertEqual(purchase.count, 12, "Purchase property count is not init correctly")
            
            XCTAssertEqual(purchase.item.name, "苹果", "Purchase property item is not init correctly")
        }
    }
    
    func testPurchaseArrayCreation() {
        let purchases = Purchase.createPurchaseArray(PurchaseTests.PurchaseTestingJson)
        
        XCTAssertNotNil(purchases, "Purchases array is not created")
        if let purchases = purchases {
            XCTAssertEqual(purchases.count, 2, "Purchases array is not created correctly")
        }
    }
}
