//
//  Item+CoreDataProperties.swift
//  ShoppingCart
//
//  Created by Raushan Sinha on 6/24/17.
//  Copyright © 2017 Raushan Sinha. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var toimage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate() // set current date to created
    }

}
