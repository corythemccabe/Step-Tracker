//
//  HealthDataListView.swift
//  Step Tracker
//
//  Created by Cory McCabe on 10/17/24.
//

import SwiftUI

struct HealthDataListView: View {
    
    @State private var isShowingAddData = false

    var metric: HealthMetricContext
    
    var body: some View {
        List(0..<28) { i in
            HStack {
                Text(Date(), format: .dateTime.month().day().year())
                Spacer()
                Text(10000, format: .number.precision(.fractionLength(metric == .steps ? 0 : 2)))
            }
        }
        .navigationTitle(metric.title)
        .sheet(isPresented: $isShowingAddData) {
            Text("Add data")
        }
        .toolbar {
            Button ("Add date", systemImage: "plus") {
                isShowingAddData = true
            }
        }
    }
}
#Preview {
    NavigationStack {
        HealthDataListView(metric: .steps)
    }
}







