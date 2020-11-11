//
//  HealtKitService.swift
//  iChol
//
//  Created by Windy on 04/11/20.
//

import UIKit
import HealthKit

class HealthKitService {
    
    static func authorization() {
        
        let healthStore = HKHealthStore()
        
        let HealthKitTypesToRead : Set <HKObjectType> = [
            HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!,
            HKQuantityType.quantityType(forIdentifier: .dietarySugar)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
        ]
        let healthKitTypesToWrite : Set<HKSampleType> = [
            HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!,
            HKQuantityType.quantityType(forIdentifier: .dietarySugar)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
        ]
        
        if !HKHealthStore.isHealthDataAvailable() {
            print("Error occured")
            return
        }
        
        healthStore.requestAuthorization(toShare: healthKitTypesToWrite, read: HealthKitTypesToRead){ (success, error) in
            if !success {
                print("error")
            } else {
                print("Success")
            }
        }
        healthStore.requestAuthorization(toShare: healthKitTypesToWrite, read: HealthKitTypesToRead){ (success, error) in
            if !success {
                print("error")
            } else {
                print("Success")
            }
        }
        
    }
    
    static func addData(sugar: Double,
                            date: Date,
                            type: HKQuantityTypeIdentifier,
                            unit: HKUnit) {
        
        guard let dietType = HKQuantityType.quantityType(forIdentifier: type) else {
            fatalError("Error")
        }
        
        let dietQuantity = HKQuantity(unit: unit, doubleValue: sugar)
        let dietSample = HKQuantitySample(type: dietType, quantity: dietQuantity, start: date, end: date)
        
        HKHealthStore().save(dietSample) { (success, error) in
            if let error = error {
                print("Error Saving : \(error)")
            } else {
                print("Successfully saved")
            }
        }
    }
    
    static func fetchCalorie(completion: @escaping (Double) -> Void) {
        
        guard let energyType = HKSampleType.quantityType(forIdentifier: .dietaryEnergyConsumed) else { return }
        let start = Calendar.current.date(byAdding: .day, value: -1, to: .distantPast)!
        let last24hPredicate = HKQuery.predicateForSamples(withStart: start, end: Date(), options: .strictEndDate)
        
        let energyQuery = HKSampleQuery(sampleType: energyType,
                                        predicate: last24hPredicate,
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: nil) {
            (query, sample, error) in
            
            guard error == nil,
                  let quantitySamples = sample as? [HKQuantitySample] else { return }
            
            let totalCalories = quantitySamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.calorie()) }
            
            completion(totalCalories)
        }
        
        HKHealthStore().execute(energyQuery)
    }
    
    static func fetchSaturatedFat(completion: @escaping (Double) -> Void) {
        
        guard let energyType = HKSampleType.quantityType(forIdentifier: .dietaryFatSaturated) else {
            print("Sample type not available")
            return
        }
        
        let last24hPredicate = HKQuery.predicateForSamples(withStart: Date().startOfTheDay(), end: Date(), options: .strictEndDate)
        
        let energyQuery = HKSampleQuery(sampleType: energyType,
                                        predicate: last24hPredicate,
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: nil) {
            (query, sample, error) in
            
            guard
                error == nil,
                let quantitySamples = sample as? [HKQuantitySample] else { return }
            
            let totalSaturatedFat = quantitySamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.gram()) }
      
            completion(totalSaturatedFat)
            
        }
        HKHealthStore().execute(energyQuery)
    }
    
    static func fetchSugar(completion: @escaping (Double) -> Void) {
        
        guard let energyType = HKSampleType.quantityType(forIdentifier: .dietarySugar) else {
            print("Sample type not available")
            return
        }
        let start = Calendar.current.date(byAdding: .day, value: -1, to: .distantPast)!
        let last24hPredicate = HKQuery.predicateForSamples(withStart: start, end: Date(), options: .strictEndDate)
        
        let energyQuery = HKSampleQuery(sampleType: energyType,
                                        predicate: last24hPredicate,
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: nil) {(query, sample, error) in
            
            guard error == nil,
                  let quantitySamples = sample as? [HKQuantitySample] else { return }
            
            let totalSugar = quantitySamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.gram()) }
          
            completion(totalSugar)
        }
        
        HKHealthStore().execute(energyQuery)
    }
    
}
