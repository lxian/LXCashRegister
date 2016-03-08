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
        return "Not implmented"
    }
}
