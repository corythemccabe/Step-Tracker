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
}







