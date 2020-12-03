//
//  Favorite+CoreDataProperties.swift
//  Picho
//
//  Created by Wendy Kurniawan on 14/11/20.
//
//

import CoreData
import Foundation

public extension Favorite {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var satFat: Double
    @NSManaged var calorie: Double
    @NSManaged var sugar: Double
}

extension Favorite: Identifiable {}
