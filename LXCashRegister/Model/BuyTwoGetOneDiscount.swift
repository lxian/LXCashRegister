//
//  BuyTwoGetOneDiscount.swift
//  LXCashRegister
//
//  Created by XianLi on 7/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class BuyTwoGetOneDiscount: Discount {
    override var pirority: Int {
        return 2
    }
    override var type : DiscountType {
        get {
            return DiscountType.BuyTwoGetOne
        }
    }
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func statement(item item: Item, count: Int) -> String {
        let price = item.price.doubleValue
        let countIncludingFreeItems = count + (count / 2)
        let total = price * Double(count)
        let statementString = Discount.commonStatement(item.name, count: countIncludingFreeItems, unit: item.unit, price: price, total: total)
        return statementString + "\n"
    }
    
    func freeItemStatement(item item: Item, count: Int) -> String? {
        if count < 2 { return nil }
        return "名称：\(item.name)，数量：\(count / 2)瓶" + "\n"
    }
    
    override func savedMoney(item item: Item, count: Int) -> Double {
        return item.price.doubleValue * Double(count / 2)
    }
}
