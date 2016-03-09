//
//  SummaryStatement.swift
//  LXCashRegister
//
//  Created by XianLi on 9/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class SummaryStatement: NSObject {
    class func outputString(purchases: [Purchase]?) -> String {
        return SummaryStatement.totalPrice(purchases) + (SummaryStatement.totalSaved(purchases) ?? "")
    }
    
    class func totalPrice(purchases: [Purchase]?) -> String {
        let format = "总计：%.02f(元)\n"
        guard let purchases = purchases else { return String(format: format, arguments: [0]) }
        
        let total = purchases.reduce(0) { (sum, p) -> Double in
            sum + p.totalPrice
        }
        
        return String(format: format, arguments: [total])
    }
    
    class func totalSaved(purchases: [Purchase]?) -> String? {
        guard let purchases = purchases else { return nil }
        let format = "节省：%.2f(元)\n"
        
        let total = purchases.reduce(0) { (sum, p) -> Double in
            sum + (p.item.discounts.first ?? Discount()).savedMoney(item: p.item, count: p.count)
        }
        
        if total == 0 { return nil }
        return String(format: format, arguments: [total])
    }
}
