//
//  HealthKitManager.swift
//  Step Tracker
//
//  Created by Cory McCabe on 10/25/24.
//

import Foundation
import HealthKit
import Observation

@Observable class HealthKitManager {
    
    let healthStore: HKHealthStore
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.heartRate)]
    
    func fetchStepCount() async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.stepCount), predicate: queryPredicate)
        let stepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: samplePredicate,
                                                               options: .cumulativeSum,
                                                               anchorDate: endDate,
                                                               intervalComponents: .init(day: 1))
        
        let stepCounts = try! await  stepsQuery.result(for: healthStore)
        
        for steps in stepCounts.statistics() {
            print(steps.sumQuantity() ?? 0)
        }
        
    }
    
//    func fetchStepCounts() async {
//        let stepCounts = try! await sumOfStepsQuery.result(for: store)
//    }
    
//    func  addSimulotarData() async {
//        var samples: [HKQuantitySample] = []
//       
//        for i in 0..<28 {
//            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 4_000...20_000))
//            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            let endDate = Calendar.current.date(byAdding: .day, value: -i + 1, to: .now)!
//            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount), quantity: stepQuantity, start: startDate, end: endDate)
//         
//            let heartRateQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 60...120))
//            let heartRateSample = HKQuantitySample(type: HKQuantityType(.heartRate), quantity: heartRateQuantity, start: startDate, end: endDate)
//            
//            samples.append(stepSample)
//            samples.append(heartRateSample)
//        }
//        
//        try! await healthStore.save(samples)
//    }
    
    init() {
        self.healthStore = HKHealthStore()
    }
}







