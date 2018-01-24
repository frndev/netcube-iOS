//
//  Device+CoreDataProperties.swift
//  
//
//  Created by fran on 4/3/17.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device");
    }

    @NSManaged public var mac: String?
    @NSManaged public var name: String?
    @NSManaged public var logo: String?

}
