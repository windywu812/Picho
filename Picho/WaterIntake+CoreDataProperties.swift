//
//  WaterIntake+CoreDataProperties.swift
//  Picho
//
//  Created by Wendy Kurniawan on 23/11/20.
//
//

import Foundation
import CoreData


extension WaterIntake {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaterIntake> {
        return NSFetchRequest<WaterIntake>(entityName: "WaterIntake")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var idWater: UUID?

}

extension WaterIntake : Identifiable {

}
