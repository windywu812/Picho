//
//  HealtKitService.swift
//  iChol
//
//  Created by Windy on 04/11/20.
//

import HealthKit
import UIKit

class HealthKitService {
    static let shared = HealthKitService()

    private let healthStore = HKHealthStore()

    private let HealthKitTypesToRead: Set<HKObjectType> = [
        HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!,
        HKQuantityType.quantityType(forIdentifier: .dietarySugar)!,
        HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
        HKQuantityType.quantityType(forIdentifier: .dietaryWater)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
    ]
    private let healthKitTypesToWrite: Set<HKSampleType> = [
        HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!,
        HKQuantityType.quantityType(forIdentifier: .dietarySugar)!,
        HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
        HKQuantityType.quantityType(forIdentifier: .dietaryWater)!,
    ]

    func authorization() {
        if !HKHealthStore.isHealthDataAvailable() {
            print("Error occured")
            return
        }

        healthStore.requestAuthorization(toShare: healthKitTypesToWrite, read: HealthKitTypesToRead) { success, error in
            if !success {
                print(error!.localizedDescription)
            } else {
                print(success)
            }
        }
    }

    func addData(amount: Double = 0.0,
                 date: Date,
                 type: HKQuantityTypeIdentifier,
                 unit: HKUnit) -> UUID
    {
        guard let dietType = HKQuantityType.quantityType(forIdentifier: type) else {
            fatalError("Error")
        }

        let dietQuantity = HKQuantity(unit: unit, doubleValue: amount)
        let dietSample = HKQuantitySample(type: dietType, quantity: dietQuantity, start: date, end: date)

        HKHealthStore().save(dietSample) { _, error in
            if let error = error {
                print("Error Saving : \(error)")
            } else {
                print("Successfully saved")
            }
        }
        return dietSample.uuid
    }

    func fetchData(type: HKQuantityTypeIdentifier, unit: HKUnit, completion: @escaping (Double) -> Void) {
        guard let type = HKSampleType.quantityType(forIdentifier: type) else { return }

        let last24hPredicate = HKQuery.predicateForSamples(withStart: Date().startOfTheDay(), end: Date(), options: .strictEndDate)

        let energyQuery = HKSampleQuery(sampleType: type,
                                        predicate: last24hPredicate,
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: nil) {
            _, sample, error in

            guard error == nil,
                  let quantitySamples = sample as? [HKQuantitySample] else { return }

            let totalCalories = quantitySamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: unit) }

            completion(totalCalories)
        }

        HKHealthStore().execute(energyQuery)
    }

    func fetchHealthKitSample(for healthSampleType: HKSampleType, withPredicate predicate: NSPredicate, completion: @escaping (HKSample?, Error?) -> Swift.Void) {
        let query = HKSampleQuery(sampleType: healthSampleType, predicate: predicate, limit: 1, sortDescriptors: nil) { _, samples, error in

            if let error = error {
                // Handler error
                completion(nil, error)
            } else {
                guard let fetchedObject = samples?.first else {
                    // Handler unexisting object
                    completion(nil, nil)
                    return
                }
                completion(fetchedObject, nil)
            }
        }
        healthStore.execute(query)
    }

    func deleteHealthData(id: UUID, type: HKQuantityTypeIdentifier, unit _: HKUnit) {
        guard let healthType = HKQuantityType.quantityType(forIdentifier: type),
              let id = UUID(uuidString: id.uuidString)
        else { return }

        let predicate = HKQuery.predicateForObject(with: id)

        fetchHealthKitSample(for: healthType, withPredicate: predicate) { fetchedObject, error in
            if let error = error {
                print("error:\(error)")
            } else {
                guard let unwrappedFetchedObject = fetchedObject else {
                    return
                }
                self.healthStore.delete(unwrappedFetchedObject, withCompletion: { _, error in
                    if let error = error {
                        print(error)
                    } else {
                        print("\n to be deleted: \(unwrappedFetchedObject.uuid) \n")
                    }
                })
            }
        }
    }

    func checkAuthorization() -> Bool {
        guard
            let satFatType = HKObjectType.quantityType(forIdentifier: .dietaryFatSaturated),
            let sugarType = HKObjectType.quantityType(forIdentifier: .dietarySugar),
            let energyType = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed),
            let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater)
        else {
            return false
        }

        let isSatFatAuth = healthStore.authorizationStatus(for: satFatType) == .sharingAuthorized
        let isSugarAuth = healthStore.authorizationStatus(for: sugarType) == .sharingAuthorized
        let isEnergyAuth = healthStore.authorizationStatus(for: energyType) == .sharingAuthorized
        let isWaterAuth = healthStore.authorizationStatus(for: waterType) == .sharingAuthorized

        return isSatFatAuth && isSugarAuth && isEnergyAuth && isWaterAuth
    }
}
