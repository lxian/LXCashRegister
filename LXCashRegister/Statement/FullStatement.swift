//
//  FullStatement.swift
//  LXCashRegister
//
//  Created by XianLi on 9/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class FullStatement: NSObject {
    static let header = "***<没钱赚商店>购物清单***\n"
    static let sectionSeperator = "----------------------\n"
    static let footer = "**********************\n"
    
    class func outputString(purchases: [Purchase]?) -> String {
        var resultStr = FullStatement.header
        resultStr += NormalStatement.outputString(purchases)
        resultStr += FullStatement.sectionSeperator
        
        if let freeItemsStatementString = FreeItemsStatement.outputString(purchases) {
            resultStr += freeItemsStatementString
            resultStr += FullStatement.sectionSeperator
        }
        
        resultStr += SummaryStatement.outputString(purchases)
        resultStr += footer
        
        return resultStr
    }
}
