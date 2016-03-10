//
//  Discount.swift
//  LXCashRegister
//
//  Created by XianLi on 7/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class Discount: NSObject, NSCoding {
    var pirority: Int {
        return 0
    }
    var type : DiscountType {
        get {
            return DiscountType.NoDiscount
        }
    }
    
    enum DiscountType: Int {
        case NoDiscount = 0
        case PercentOff = 1
        case BuyTwoGetOne = 2
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
    }
    
    func statement(item item: Item, count: Int) -> String {
        return Discount.commonStatement(item.name, count: count, unit: item.unit, price: item.price.doubleValue, total: item.price.doubleValue * Double(count)) + "\n"
    }
    
    class func commonStatement(name: String, count: Int, unit: String, price: Double, total: Double) -> String {
        return "名称：\(name)，数量：\(count)\(unit)，单价：\(price.formatToPrice())(元)，小计：\(total.formatToPrice())(元)"
    }
    
    func savedMoney(item item: Item, count: Int) -> Double {
        return 0
    }
    
    class func createDiscountArray(json json: AnyObject?) -> [Discount] {
        guard let discountDictArr = json as? [[String: AnyObject]] else { return [Discount()]}
        
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
                case .NoDiscount:
                    discountArray.append(Discount())
                }
            }
        }
        
        if discountArray.isEmpty {
            discountArray.append(Discount())
        }
        // sort by pirority, discount with a highest pirority will be at the first place of the array
        return discountArray.sort({ (left, right) -> Bool in
            left.pirority > right.pirority
        })
    }
}
