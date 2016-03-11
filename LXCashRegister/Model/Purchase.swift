//
//  Purchase.swift
//  LXCashRegister
//
//  Created by XianLi on 8/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class Purchase: NSObject {
    var count: Int = 0
    var item: Item
    
    init?(json: AnyObject?) {
        guard let json = json as? [String: AnyObject],
            let count     = json["count"] as? Int,
            let barCode     = json["barCode"] as? String,
            let item        = ItemStore.fetchItem(barCode: barCode) else {
                self.item = Item() // surpress the compiler warning on item not initilized
                super.init()
                return nil
        }
        self.count = count
        self.item = item
        super.init()
    }
    
    class func createPurchaseArray(json: AnyObject?) -> [Purchase]? {
        guard let purchaseDictArr = json as? [[String: AnyObject]]? else {
            return nil
        }
        
        var purchases = [Purchase]()
        purchaseDictArr?.forEach({ (dict) -> () in
            if let purchase = Purchase(json: dict) {
                    purchases.append(purchase)
            }
        })
        return purchases
    }
}
