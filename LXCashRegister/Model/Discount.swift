//
//  Discount.swift
//  LXCashRegister
//
//  Created by XianLi on 7/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class Discount: NSObject, NSCoding {
    var pirority: Int = 0
    
    enum DiscountType: Int {
        case PercentOff = 0
        case BuyTwoGetOne = 1
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
    }
    
    func statement(item item: Item, count: Int) -> String {
        return ""
    }
    
    class func createDiscountArray(json: AnyObject?) -> [Discount] {
        guard let discountDictArr = json as? [[String: AnyObject]] else { return [] }
        var discountArray = [Discount]()
        discountDictArr.forEach { (discountDict) -> () in
            if let typeRaw = discountDict["type"] as? Int,
            let type = DiscountType(rawValue: typeRaw){
                switch(type) {
                case .PercentOff:
                    guard let discount = PercentOffDiscount(json: discountDict) else { break }
                    discountArray.append(discount)
                case .BuyTwoGetOne:
                    discountArray.append(BuyTwoGetOneDiscount())
                }
            }
        }
        
        // sort by pirority, discount with a highest pirority will be at the first place of the array
        return discountArray.sort({ (left, right) -> Bool in
            left.pirority > right.pirority
        })
    }
}
