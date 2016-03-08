//
//  Item.swift
//  LXCashRegister
//
//  Created by XianLi on 4/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit
import CoreData

class Item: NSManagedObject {
    static let EntityName = "Item"
    
    @NSManaged private(set) var barCode: String!
    @NSManaged private(set) var name: String!
    @NSManaged private(set) var price: NSNumber!
    @NSManaged private(set) var discounts: [Discount]!
    
    init?(json: [String: AnyObject]) {
        let entity = NSEntityDescription.entityForName(Item.EntityName, inManagedObjectContext: CoreDataStack.sharedInstance.managedObjectContext)!
        super.init(entity: entity, insertIntoManagedObjectContext: CoreDataStack.sharedInstance.managedObjectContext)
        
        guard let barCode   = json["barCode"] as? String,
            name        = json["name"] as? String,
            price       = json["price"] as? Double
            else {
                return nil
        }
        
        self.barCode    = barCode
        self.name       = name
        self.price      = price
        self.discounts  = Discount.createDiscountArray(json: json["discounts"])
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}

func ==(left: Item, right: Item) -> Bool {
    return left.barCode == right.barCode &&
            left.name == right.name &&
            left.price == right.price
}
