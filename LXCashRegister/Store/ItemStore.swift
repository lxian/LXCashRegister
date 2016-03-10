//
//  ItemStore.swift
//  LXCashRegister
//
//  Created by XianLi on 6/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit
import CoreData

class ItemStore {
    class func fetchItem(barCode barCode: String) -> Item? {
        let fetchRequest = NSFetchRequest(entityName: Item.EntityName)
        fetchRequest.predicate = NSPredicate(format: "barCode == %@", barCode)
        do {
            guard let items = try CoreDataStack.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as? [Item] else {
                return nil
            }
            return items.first
        } catch let error as NSError {
            print("Item fetch failed: \(error.localizedDescription)")
        }
        return nil
    }
    
    class func removeItem(barCode barCode: String) -> Bool {
        guard let item = ItemStore.fetchItem(barCode: barCode)
            else {
                return false
        }
        
        CoreDataStack.sharedInstance.managedObjectContext.deleteObject(item)
        return true
    }
    
    class func readSampleData() {
        guard let path = NSBundle.mainBundle().pathForResource("SampleItems", ofType: "json")
            else {
                print("File not exist with file name: SampleItems")
                return
        }
        ItemStore.readSampleDataFromFilePath(path)
    }
    
    class func readSampleDataFromFilePath(path: String) {
        guard let data = NSData(contentsOfFile: path) else {
                print("Faild to load testing items json file into NSData")
                return
        }
        do {
            guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [[String: AnyObject]] else {
                print("Testing item json file invalid")
                return
            }
            json.forEach { dict in
                let _ = Item(json: dict)
            }
        } catch let error as NSError {
            NSLog("Error while loading testing items json file, %@", error)
        }
    }
    
    class func clearAllItems() {
        let fetchRequest = NSFetchRequest(entityName: Item.EntityName)
        do {
            guard let items = try CoreDataStack.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as? [Item] else {
                return
            }
            items.forEach { CoreDataStack.sharedInstance.managedObjectContext.deleteObject($0) }
        } catch let error as NSError {
            print("Item fetch failed: \(error.localizedDescription)")
        }
    }
}
