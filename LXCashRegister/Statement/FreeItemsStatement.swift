//
//  FreeItemsStatement.swift
//  LXCashRegister
//
//  Created by XianLi on 9/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class FreeItemsStatement: NSObject {
    class func outputString(purchases: [Purchase]?) -> String? {
        guard let purchases = purchases else { return nil }
        
        var resultStr = ""
        purchases.forEach { (purchase) -> () in
            let item = purchase.item
            let count = purchase.count
            if let discount = item.discounts.first as? BuyTwoGetOneDiscount {
                resultStr += discount.freeItemStatement(item: item, count: count) ?? ""
            }
        }
        
        if resultStr.isEmpty {
            return nil
        }
        return resultStr
    }
}
