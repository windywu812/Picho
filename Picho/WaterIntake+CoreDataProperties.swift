//
//  WaterIntake+CoreDataProperties.swift
//  Picho
//
//  Created by Wendy Kurniawan on 23/11/20.
//
//

import CoreData
import Foundation

public extension WaterIntake {
    @nonobjc class func fetchRequest() -> NSFetchRequest<WaterIntake> {
        return NSFetchRequest<WaterIntake>(entityName: "WaterIntake")
    }

    @NSManaged var id: UUID?
    @NSManaged var amount: Double
    @NSManaged var date: Date?
    @NSManaged var idWater: UUID?
}

extension WaterIntake: Identifiable {}
