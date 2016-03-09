//
//  PercentOffDiscount.swift
//  LXCashRegister
//
//  Created by XianLi on 7/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class PercentOffDiscount: Discount {
    var offPercent: Double = 0
    override var type : DiscountType {
        get {
            return DiscountType.PercentOff
        }
    }
    
    init?(json: AnyObject?) {
        guard let json = json as? [String: AnyObject],
            let offPercent = json["offPercent"] as? Double
            else {
                super.init()
                return nil
        }
        self.offPercent = offPercent
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        offPercent = aDecoder.decodeDoubleForKey("offPercent")
        super.init(coder: aDecoder)
    }

    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(offPercent, forKey: "offPercent")
        super.encodeWithCoder(aCoder)
    }
    
    override func statement(item item: Item, count: Int) -> String {
        let price = item.price.doubleValue
        let total = price * Double(count) * (1 - offPercent)
        let save  = savedMoney(item: item, count: count)
        var statementString = Discount.commonStatement(item.name, count: count, unit: item.unit, price: price, total: total)
        statementString += " 节省\(save.formatToPrice())(元)"
        statementString += "\n"
        return statementString
    }
    
    override func savedMoney(item item: Item, count: Int) -> Double {
        return item.price.doubleValue * Double(count) * offPercent
    }
}
