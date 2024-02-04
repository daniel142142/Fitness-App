//
//  History+CoreDataProperties.swift
//  nea
//
//  Created by Daniel Armstrong on 09/11/2022.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var date: String?
    @NSManaged public var calories: Int32
    @NSManaged public var steps: Int32

}

extension History : Identifiable {

}
