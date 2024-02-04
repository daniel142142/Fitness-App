//
//  Workouts+CoreDataProperties.swift
//  nea
//
//  Created by Daniel Armstrong on 08/01/2023.
//
//

import Foundation
import CoreData


extension Workouts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workouts> {
        return NSFetchRequest<Workouts>(entityName: "Workouts")
    }

    @NSManaged public var ex1: NSArray
    @NSManaged public var ex2: NSArray
    @NSManaged public var ex4: NSArray
    @NSManaged public var ex3: NSArray
    @NSManaged public var ex5: NSArray
    @NSManaged public var ex6: NSArray

}

extension Workouts : Identifiable {

}
