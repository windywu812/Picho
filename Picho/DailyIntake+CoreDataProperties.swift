//
//  DailyIntake+CoreDataProperties.swift
//  Picho
//
//  Created by Wendy Kurniawan on 13/11/20.
//
//

import CoreData
import Foundation

public extension DailyIntake {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DailyIntake> {
        return NSFetchRequest<DailyIntake>(entityName: "DailyIntake")
    }

    @NSManaged var calorie: Double
    @NSManaged var date: Date?
    @NSManaged var foodId: String?
    @NSManaged var id: UUID?
    @NSManaged var name: String?
    @NSManaged var saturatedFat: Double
    @NSManaged var sugars: Double
    @NSManaged var time: String?
    @NSManaged var idSugar: UUID?
    @NSManaged var idSatFat: UUID?
    @NSManaged var idCalorie: UUID?
}

extension DailyIntake: Identifiable {}
