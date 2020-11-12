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
    
    private func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
//    static let shared = CoreDataService()
//
//    private let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    func getDailyIntake(completion: @escaping ([DailyIntake]) -> ()) {
//        let fetch = NSFetchRequest<DailyIntake>(entityName: CoreDataConstant.entityName)
//
//        do {
//            let result = try moc.fetch(fetch)
//            completion(result)
//        } catch let err {
//            print(err.localizedDescription)
//            completion([])
//        }
//
//    }
//
//    func createDailyIntake(id: UUID, fat: Double, calories: Int, sugar: Double, date: Date) {
//
//        let dailyIntake = DailyIntake(context: moc)
//        dailyIntake.id = id
//        dailyIntake.saturatedFat = fat
//        dailyIntake.totalCalories = Int64(calories)
//        dailyIntake.sugar = sugar
//        dailyIntake.date = date
//
//        do {
//            try moc.save()
//        } catch let err {
//            print(err.localizedDescription)
//        }
//    }
//
//    func updateDailyIntake(fat: Double, calories: Int, sugar: Double, date: Date) {
//
//        guard let dailyIntake = getCurrentDay(date: date) else { return }
//        dailyIntake.saturatedFat = fat
//        dailyIntake.totalCalories = Int64(calories)
//        dailyIntake.sugar = sugar
//        dailyIntake.date = date
//
//        do {
//            try moc.save()
//        } catch let err {
//            print(err.localizedDescription)
//        }
//    }
//
//    func getCurrentDay(date: Date) -> DailyIntake? {
//
//        let fetchRequest = NSFetchRequest<DailyIntake>(entityName: CoreDataConstant.entityName)
//        fetchRequest.predicate = NSPredicate(
//            format: "\(CoreDataConstant.date) >= %@ AND \(CoreDataConstant.date) <= %@",
//            date.startOfTheDay() as CVarArg,  date as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            let result = try moc.fetch(fetchRequest)
//            return result.first
//        } catch let err {
//            print(err.localizedDescription)
//        }
//
//        return nil
//    }
//
//    func addFood(foodName: String, date: Date, eatingTime: EatTime, calorie: Int) {
//
//        if let today = getCurrentDay(date: date) {
//
//            switch eatingTime {
//            case .breakfast:
//                if today.breakfast == nil {
//                    let breakfast = Breakfast(context: moc)
//                    breakfast.food = [foodName]
//                    breakfast.total = Int64(calorie)
//                    today.breakfast = breakfast
//                } else {
//                    today.breakfast?.food?.append(foodName)
//                    today.breakfast?.total = Int64(calorie)
//                }
//            case .lunch:
//                if today.lunch == nil {
//                    let lunch = Lunch(context: moc)
//                    lunch.food = [foodName]
//                    today.lunch = lunch
//                } else {
//                    today.lunch?.food?.append(foodName)
//                    today.lunch?.total = Int64(calorie)
//                }
//            case .dinner:
//                if today.dinner == nil {
//                    let dinner = Dinner(context: moc)
//                    dinner.food = [foodName]
//                    today.dinner = dinner
//                } else {
//                    today.dinner?.food?.append(foodName)
//                    today.dinner?.total = Int64(calorie)
//                }
//            case .snack:
//                if today.snack == nil {
//                    let snack = Snack(context: moc)
//                    snack.food = [foodName]
//                    today.snack = snack
//                } else {
//                    today.snack?.food?.append(foodName)
//                    today.snack?.total = Int64(calorie)
//                }
//            }
//        } else {
//
//            CoreDataService.shared.createDailyIntake(id: UUID(), fat: 0, calories: 0, sugar: 0, date: Date())
//            CoreDataService.shared.addFood(foodName: foodName, date: date, eatingTime: eatingTime, calorie: calorie)
//        }
//
//        do {
//            try moc.save()
//        } catch let err {
//            print(err.localizedDescription)
//        }
//    }
    
}

