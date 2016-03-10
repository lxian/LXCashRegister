//
//  InputConverter.swift
//  LXCashRegister
//
//  Created by XianLi on 10/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class InputConverter: NSObject {
    static let SampleInputNoDiscountFileName = "SampleInputNoDiscount"
    static let SampleInputOffPercentFileName = "SampleInputOffPercent"
    static let SampleInputBuyTwoGetOneFileName = "SampleInputBuyTwoGetOne"
    static let SampleInputBothDiscountFileName = "SampleInputBothDiscount"
    
    class func readFromFile(fileName: String) -> [[String : AnyObject]]? {
        guard let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
            else {
                print("Faild to load testing sample input json file \(fileName)")
                return nil
        }
       return readFromFilePath(path)
    }
    
    class func readFromFilePath(path: String) -> [[String : AnyObject]]? {
        guard let data = NSData(contentsOfFile: path) else {
            print("Faild to load sample input json file: \(path) into NSData")
            return nil
        }
        do {
            guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String] else {
                print("Sample item json file invalid ,\(path)")
                return nil
            }
            return InputConverter.convert(json)
        } catch let error as NSError {
            NSLog("Error while loading testing items json file, %@", error)
            return nil
        }
    }
    
    private class func convert(json: AnyObject?) -> [[String:AnyObject]]? {
        guard let json = json as? [String] else { return nil }
        var resultDict = [String:Int]()
        json.forEach { str in
            let barCodeAndCount = str.characters.split { $0 == "-" }.map(String.init)
            let barCode = barCodeAndCount[0]
            var count   =  1
            if barCodeAndCount.count > 1 && Int(barCodeAndCount[1]) != nil {
                count = Int(barCodeAndCount[1])!
            }
            
            if resultDict[barCode] == nil {
                resultDict[barCode] = count
            } else {
                resultDict[barCode]! += count
            }
        }
        
        let result = Array(resultDict.keys).map({ (key) -> [String: AnyObject] in
            [ "barCode": key,
                "count": resultDict[key]!
            ]
        })
        return result
    }
}
