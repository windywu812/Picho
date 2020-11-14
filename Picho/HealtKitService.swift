//
//  HealtKitService.swift
//  iChol
//
//  Created by Windy on 04/11/20.
//

import UIKit
import HealthKit

class HealthKitService {
    static let shared = HealthKitService()
    
    private let healthStore = HKHealthStore()
    
    private let HealthKitTypesToRead : Set <HKObjectType> = [
        HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!,
        HKQuantityType.quantityType(forIdentifier: .dietarySugar)!,
        HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
    ]
    private let healthKitTypesToWrite : Set<HKSampleType> = [
        HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!,
        HKQuantityType.quantityType(forIdentifier: .dietarySugar)!,
        HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
    ]
    
    func authorization() {
        
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
        
    }
    
     func addData(sugar: Double,
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
    
     func fetchCalorie(completion: @escaping (Double) -> Void) {
        
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
            
            let totalCalories = quantitySamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.smallCalorie()) }
            
            completion(totalCalories)
        }
        
        HKHealthStore().execute(energyQuery)
    }
    
     func fetchSaturatedFat(completion: @escaping (Double) -> Void) {
        
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
    
     func fetchSugar(completion: @escaping (Double) -> Void) {
        
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
    
     func fetchActivity(completion: @escaping (Double) -> Void) {
        
        guard let dataType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Sampe type not available")
            return
        }
        
        let start = Date().startOfTheDay()
        let last24Predicate = HKQuery.predicateForSamples(withStart: start, end: Date(), options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: dataType,
                                  predicate: last24Predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil) { (query, sample, error) in
            guard error == nil,
                  let quantitySamples = sample as? [HKQuantitySample] else { return }
            
            let totalEneryBurned = quantitySamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.gram()) }
          
            completion(totalEneryBurned)
        }
        
        HKHealthStore().execute(query)
    }
    
    func checkAuthorization() -> Bool {
        var isSucceed = false
        healthStore.requestAuthorization(toShare: healthKitTypesToWrite, read: HealthKitTypesToRead){ (success, error) in
            isSucceed = success
        }
        return isSucceed
    }
    
}
