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
    
    init() {
        self.healthStore = HKHealthStore()
    }
    
    func  addSimulotarData() async {
        var samples: [HKQuantitySample] = []
       
        for i in 0..<28 {
            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 4_000...20_000))
            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
            let endDate = Calendar.current.date(byAdding: .day, value: -i + 1, to: .now)!
            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount), quantity: stepQuantity, start: startDate, end: endDate)
         
            let heartRateQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 60...120))
            let heartRateSample = HKQuantitySample(type: HKQuantityType(.heartRate), quantity: heartRateQuantity, start: startDate, end: endDate)
            
            samples.append(stepSample)
            samples.append(heartRateSample)
        }
        
        try! await healthStore.save(samples)
    }
}







