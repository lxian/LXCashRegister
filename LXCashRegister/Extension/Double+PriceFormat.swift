//
//  Double+PriceFormat.swift
//  LXCashRegister
//
//  Created by XianLi on 9/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

extension Double {
    func formatToPrice() -> String {
        return String(format: "%.02f", self)
    }
}
