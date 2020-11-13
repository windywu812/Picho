//
//  CoreDataService.swift
//  iChol
//
//  Created by Windy on 04/11/20.
//

import CoreData
import UIKit

struct CoreDataConstant {
    static let entityName = "DailyIntake"
    static let time = "time"
    static let date = "date"
    static let saturatedFat = "saturatedFat"
    static let sugar = "sugar"
    static let id = "id"
}

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getDailyIntake(with request: NSFetchRequest<DailyIntake> = DailyIntake.fetchRequest(), time: EatTime? = nil, date: Date? = nil, completion: @escaping ([DailyIntake]) -> Void) {
        
        var timePredicate = NSPredicate(value: true)
        var datePredicate = NSPredicate(value: true)
        
        if let time = time?.rawValue {
            timePredicate = NSPredicate(format: "\(CoreDataConstant.time) = %@", time as CVarArg)
        }
        
        if let date = date {
            let dateFrom = date.startOfTheDay()
            let dateTo = date.startOfTheDay().endDate()
            datePredicate = NSPredicate(format: "\(CoreDataConstant.date) >= %@ AND \(CoreDataConstant.date) <= %@",
                        dateFrom as CVarArg,  dateTo as CVarArg)
        }
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, datePredicate])
        
        do {
            let intakes = try context.fetch(request)
            completion(intakes)
        } catch {
            print(error.localizedDescription)
            completion([])
        }
        
    }
    
    func addDailyIntake(id: UUID, foodId: String, name: String, description: String, calorie: Double, saturatedFat: Double, sugars: Double, date: Date = Date(), time: EatTime) {
        
        let intake = DailyIntake(context: context)
        intake.id = id
        intake.foodId = foodId
        intake.desc = description
        intake.name = name
        intake.calorie = calorie
        intake.saturatedFat = saturatedFat
        intake.sugars = sugars
        intake.date = date
        intake.time = time.rawValue

        save(context: context)
    }
    
    func deleteDailyIntake(with request: NSFetchRequest<DailyIntake> = DailyIntake.fetchRequest(), _ id: UUID) {
        request.predicate = NSPredicate(format: "\(CoreDataConstant.id) = %@", id as CVarArg)
        
        save(context: context, deleted: true)
    }
    
    private func save(with request: NSFetchRequest<DailyIntake> = DailyIntake.fetchRequest(), context: NSManagedObjectContext, deleted: Bool = false) {
        
        do {
            if deleted {
                let dataToDelete = try context.fetch(request)[0] as NSManagedObject
                context.delete(dataToDelete)
            }
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
