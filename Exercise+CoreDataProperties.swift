//
//  Exercise+CoreDataProperties.swift
//  nea
//
//  Created by Daniel Armstrong on 05/05/2023.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var speed: Float
    @NSManaged public var calories: Float
    @NSManaged public var duration: String?
    @NSManaged public var distance: Float
    @NSManaged public var date: String?
    @NSManaged public var type: String?

}

extension Exercise : Identifiable {

}
