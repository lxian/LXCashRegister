//
//  FullStatement.swift
//  LXCashRegister
//
//  Created by XianLi on 9/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class FullStatement: NSObject {
    static let Header = "***<没钱赚商店>购物清单***\n"
    static let BuyTwoGetOneSectionHeader = "买二赠一商品：\n"
    static let SectionSeperator = "----------------------\n"
    static let Footer = "**********************\n"
    
    class func outputString(purchases: [Purchase]?) -> String {
        var resultStr = FullStatement.Header
        resultStr += NormalStatement.outputString(purchases)
        resultStr += FullStatement.SectionSeperator
        
        if let freeItemsStatementString = FreeItemsStatement.outputString(purchases) {
            resultStr += BuyTwoGetOneSectionHeader
            resultStr += freeItemsStatementString
            resultStr += FullStatement.SectionSeperator
        }
        
        resultStr += SummaryStatement.outputString(purchases)
        resultStr += Footer
        
        return resultStr
    }
}
