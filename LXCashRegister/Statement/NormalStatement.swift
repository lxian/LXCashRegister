//
//  NormalStatement.swift
//  LXCashRegister
//
//  Created by XianLi on 9/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class NormalStatement: NSObject {
    class func outputString(purchases: [Purchase]?) -> String {
        var resultStr = ""
        guard let purchases = purchases else { return resultStr }
        
        purchases.forEach { (purchase) -> () in
            let item = purchase.item
            let count = purchase.count
            let discount = item.discounts.first ?? Discount()
            
            resultStr += discount.statement(item: item, count: count)
        }
        return resultStr
    }
}
