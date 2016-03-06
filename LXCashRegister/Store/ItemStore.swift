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
}
