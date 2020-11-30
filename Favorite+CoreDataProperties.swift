//
//  Favorite+CoreDataProperties.swift
//  Picho
//
//  Created by Wendy Kurniawan on 14/11/20.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var satFat: Double
    @NSManaged public var calorie: Double
    @NSManaged public var sugar: Double

}

extension Favorite : Identifiable {

}
