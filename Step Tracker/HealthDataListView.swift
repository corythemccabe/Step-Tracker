//
//  HealthDataListView.swift
//  Step Tracker
//
//  Created by Cory McCabe on 10/17/24.
//

import SwiftUI

struct HealthDataListView: View {
    
    @State private var isShowingAddData = false

    @State private var selectedDate: Date = .now
    @State private var valueToAdd: String = ""
    
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
            AddDataView
        }
        .toolbar {
            Button ("Add date", systemImage: "plus") {
                isShowingAddData = true
            }
        }
    }
    
    var AddDataView: some View {
        NavigationStack {
            Form {
                DatePicker("Add Data", selection: $selectedDate, displayedComponents: .date)
                TextField("Enter Value", text: $valueToAdd)
            }
            
            .navigationTitle(metric.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Data") {
                        // Add Data
                        self.$isShowingAddData.wrappedValue.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        self.$isShowingAddData.wrappedValue.toggle()
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    NavigationStack {
        HealthDataListView(metric: .steps)
    }
}







