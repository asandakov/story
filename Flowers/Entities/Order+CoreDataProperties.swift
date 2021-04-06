//
//  Order+CoreDataProperties.swift
//  
//
//  Created by Алексей on 04.01.2021.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var id: Int64
    @NSManaged public var number: Int64
    @NSManaged public var name: String
    @NSManaged public var price: Int32
    @NSManaged public var img: String
    @NSManaged public var fio: String
    @NSManaged public var phone: String
    @NSManaged public var date: Date

}
