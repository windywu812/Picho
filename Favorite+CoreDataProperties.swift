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

    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension Favorite : Identifiable {

}
