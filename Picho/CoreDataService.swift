//
//  CoreDataService.swift
//  iChol
//
//  Created by Windy on 04/11/20.
//

import CoreData
import UIKit

struct DailyIntakeConstant {
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
    
    // MARK: - Daily Intake
    func getDailyIntake(with request: NSFetchRequest<DailyIntake> = DailyIntake.fetchRequest(), time: EatTime? = nil, date: Date? = nil, completion: @escaping ([DailyIntake]) -> Void) {
        
        var timePredicate = NSPredicate(value: true)
        var datePredicate = NSPredicate(value: true)
        
        if let time = time?.rawValue {
            timePredicate = NSPredicate(format: "\(DailyIntakeConstant.time) = %@", time as CVarArg)
        }
        
        if let date = date {
            let dateFrom = date.startOfTheDay()
            let dateTo = date.startOfTheDay().endDate()
            datePredicate = NSPredicate(format: "\(DailyIntakeConstant.date) >= %@ AND \(DailyIntakeConstant.date) <= %@",
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
    
//    func getMaxDailyIntake(with request: NSFetchRequest<DailyIntake> = DailyIntake.fetchRequest(), completion: @escaping ([DailyIntake]) -> Void) {
////        request.predicate = NSPredicate(format: "@count")
////        request.propertiesToGroupBy = ["foodId"]
//
//        do {
//            let intakes = try context.fetch(request)
//            completion(intakes)
//        } catch {
//            print(error.localizedDescription)
//            completion([])
//        }
//    }
    
//    func getMaxDailyIntake(request: NSFetchRequest<NSDictionary> = NSFetchRequest<NSDictionary>(entityName: DailyIntakeConstant.entityName), time eatingTime: EatTime, completion: @escaping ([NSDictionary]) -> Void) {
//        let groupArgument = NSExpression(forKeyPath: "foodId")
//        let expression = NSExpression(forFunction: "count:", arguments: [groupArgument])
//        
//        let countDesc = NSExpressionDescription()
//        countDesc.expression = expression
//        countDesc.name = "count"
//        countDesc.expressionResultType = .integer64AttributeType
//        
//        request.returnsObjectsAsFaults = false
//        request.propertiesToGroupBy = ["foodId"]
//        request.propertiesToFetch = ["foodId", countDesc]
//        request.resultType = .dictionaryResultType
//        
//        request.havingPredicate = NSPredicate(format: "\(DailyIntakeConstant.time) = %@", eatingTime.rawValue)
//        
//        do {
//            let intakes = try context.fetch(request)
//            completion(intakes)
//        } catch {
//            print(error.localizedDescription)
//            completion([])
//        }
//        
//    }
    
    func addDailyIntake(id: UUID, foodId: String, name: String, description: String, calorie: Double, saturatedFat: Double, sugars: Double, date: Date = Date(), time: EatTime) {
        
        print(id)
        
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
        
        saveDailyIntake(context: context)
    }
    
    func deleteDailyIntake(with request: NSFetchRequest<DailyIntake> = DailyIntake.fetchRequest(), _ id: UUID) {
        print(id)
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        saveDailyIntake(with: request, context: context, deleted: true)
    }
    
    private func saveDailyIntake(with request: NSFetchRequest<DailyIntake> = DailyIntake.fetchRequest(), context: NSManagedObjectContext, deleted: Bool = false) {
        
        do {
            if deleted {
                let dataToDelete = try context.fetch(request)[0] as NSManagedObject
                print(dataToDelete)
                context.delete(dataToDelete)
            }
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Favorite
    func getFavorite(with request: NSFetchRequest<Favorite> = Favorite.fetchRequest(), for id: String? = nil, completion: @escaping ([Favorite]) -> Void) {
        
        if let id = id {
            request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        }
        
        do {
            let favorites = try context.fetch(request)
            completion(favorites)
        } catch {
            print(error.localizedDescription)
            completion([])
        }
        
    }
    
    func addFavorite(id: String, name: String, description: String) {
        
        let favorite = Favorite(context: context)
        favorite.id = id
        favorite.name = name
        favorite.desc = description
        
        saveFavorite(context: context)
    }
    
    func deleteFavorite(with request: NSFetchRequest<Favorite> = Favorite.fetchRequest(), _ id: String) {
        request.predicate = NSPredicate(format: "\(DailyIntakeConstant.id) = %@", id as CVarArg)
        
        saveFavorite(context: context, deleted: true)
    }
    
    private func saveFavorite(with request: NSFetchRequest<Favorite> = Favorite.fetchRequest(), context: NSManagedObjectContext, deleted: Bool = false) {
        
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
    
    // MARK: Notification
    func fetchNotificationData(completion: @escaping ([Notif]) -> ()) {
        
        let request = NSFetchRequest<Notif>(entityName: "Notif")
        
        do {
            let results = try context.fetch(request)
            completion(results)
        } catch {
            print(error.localizedDescription)
            completion([])
        }

    }
    
    func addNotification(id: String, isOn: Bool, timeLabel: String) {
        
        if checkIfExist(id: id) {
            let request = NSFetchRequest<Notif>(entityName: "Notif")
            request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
            do {
                let dataToUpdated = try context.fetch(request)[0]
                dataToUpdated.isOn = isOn
                dataToUpdated.timeLabel = timeLabel
            } catch {
                print(error.localizedDescription)
            }
        } else {
            let notification = Notif(context: context)
            notification.id = id
            notification.isOn = isOn
            notification.timeLabel = timeLabel
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func checkIfExist(id: String) -> Bool {
        let request = NSFetchRequest<Notif>(entityName: "Notif")
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        do {
            let dataToUpdated = try context.fetch(request)
            if id == dataToUpdated.first?.id { return true }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
}
