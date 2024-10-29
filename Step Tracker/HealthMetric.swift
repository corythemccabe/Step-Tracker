//
//  HealthMetric.swift
//  Step Tracker
//
//  Created by Cory McCabe on 10/28/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
