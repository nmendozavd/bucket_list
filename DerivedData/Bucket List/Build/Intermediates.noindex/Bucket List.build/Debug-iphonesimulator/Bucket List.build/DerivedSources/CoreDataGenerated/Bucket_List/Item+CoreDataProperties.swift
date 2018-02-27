//
//  Item+CoreDataProperties.swift
//  
//
//  Created by Noel Mendoza on 2/3/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var item: String?

}
