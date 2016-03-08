//
//  BuyTwoGetOneDiscount.swift
//  LXCashRegister
//
//  Created by XianLi on 7/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class BuyTwoGetOneDiscount: Discount {
    let BuyTwoGetOneDiscountPirority = 1
    
    override init() {
        super.init()
        pirority = BuyTwoGetOneDiscountPirority
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        pirority = BuyTwoGetOneDiscountPirority
    }
    
    override func statement(item item: Item, count: Int) -> String {
        return "Not implmented"
    }
    
    func freeItemStatement(item item: Item, count: Int) -> String {
        return "Not implemented"
    }
}
