//
//  DailyIntake+CoreDataProperties.swift
//  Picho
//
//  Created by Wendy Kurniawan on 13/11/20.
//
//

import Foundation
import CoreData


extension DailyIntake {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyIntake> {
        return NSFetchRequest<DailyIntake>(entityName: "DailyIntake")
    }

    @NSManaged public var calorie: Double
    @NSManaged public var date: Date?
    @NSManaged public var desc: String?
    @NSManaged public var foodId: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var saturatedFat: Double
    @NSManaged public var sugars: Double
    @NSManaged public var time: String?
    @NSManaged public var idSugar:UUID?
    @NSManaged public var idSatFat:UUID?
    @NSManaged public var idCalorie:UUID?

}

extension DailyIntake : Identifiable {

}
