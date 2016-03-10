//
//  ItemTests.swift
//  LXCashRegister
//
//  Created by XianLi on 6/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import XCTest
import CoreData
@testable import LXCashRegister

class ItemTests: XCTestCase {
    static let TestItemBarCode = "ITEM9999999"
    static let TestItemJsonDict:[String: AnyObject] = ["barCode": "ITEM9999999",
                            "name": "someItem",
                            "price": 99,
                            "unit": "kg",
                            "discounts": [
                                [
                                    "type": 1,
                                    "offPercent": 5
                                ],
                                [
                                    "type": 2
                                ]
                            ]]
    var createdItems = [Item?]()
    
    override func setUp() {
        super.setUp()
        createdItems.removeAll()
    }
    
    override func tearDown() {
        createdItems.forEach {
            guard let item = $0 else { return }
            CoreDataStack.sharedInstance.managedObjectContext.deleteObject(item)
        }
        super.tearDown()
    }
    
    func testItemCreationFromJson() {
        let item = Item(json: ItemTests.TestItemJsonDict)
        XCTAssertNotNil(item, "Item Should be created with a valid json")
        
        if let item = item {
            
            XCTAssertEqual(item.barCode, ItemTests.TestItemBarCode, "Item property barCode is not created correctly")
            XCTAssertEqual(item.name, ItemTests.TestItemJsonDict["name"] as? String, "Item property name is not created correctly")
            XCTAssertEqual(item.price, ItemTests.TestItemJsonDict["price"] as? NSNumber, "Item property price is not created correctly")
            XCTAssertEqual(item.unit, ItemTests.TestItemJsonDict["unit"] as? String, "Item property unit is not created correctly")
            
            XCTAssertNotNil(item.discounts[0] as? BuyTwoGetOneDiscount, "Item property discount[0] (BuyTwoGetOneDiscount) is not created correctly ")
            XCTAssertEqual((item.discounts[1] as! PercentOffDiscount).offPercent, 0.05, "Item property discount[0] (PercentOffDiscount)is not created correctly")
        }
        
        createdItems.append(item)
    }
    
    func testItemCreationFailureOnInvalidJson() {
        ["barCode", "name", "price"].forEach { key in
            var json = ItemTests.TestItemJsonDict
            json.removeValueForKey(key)
            let item = Item(json: json)
            XCTAssertNil(item, "Item Shouldn't be created with an invalid json")
            createdItems.append(item)
        }
    }
    
    func testItemFetching() {
        let item = Item(json: ItemTests.TestItemJsonDict)
        let fetchdItem = Item(json: ItemTests.TestItemJsonDict)
        ItemStore.fetchItem(barCode: ItemTests.TestItemBarCode)
        XCTAssertNotNil(fetchdItem, "Item fetching failed")
        if let item = item, fetchdItem = fetchdItem {
            XCTAssert(item == fetchdItem, "Item fetched is not correct, expected")
        }
        createdItems.append(item)
        createdItems.append(fetchdItem)
    }
}
