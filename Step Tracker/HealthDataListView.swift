//
//  HealthDataListView.swift
//  Step Tracker
//
//  Created by Cory McCabe on 10/17/24.
//

import SwiftUI

struct HealthDataListView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isShowingAddData = false
    @State private var addDataDate: Date = .now
    @State private var valueToAdd: String = ""

    var metric: HealthMetricContext

    var body: some View {
        ZStack {
            Image(colorScheme == .dark ? "Step Counter Background Dark" : "Step Counter Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                List(0..<28) { i in
                    HStack {
                        Text(Date(), format: .dateTime.month().day().year())
                        Spacer()
                        Text(10000, format: .number.precision(.fractionLength(metric == .steps ? 0 : 1)))
                    }
                }
                
                .background(Color.clear) // Ensure the List has a clear background
            }
        }
        .navigationTitle(metric.title)
        .sheet(isPresented: $isShowingAddData) {
            addDataView
        }
        .toolbar {
            Button("Add Data", systemImage: "plus") {
                isShowingAddData = true
            }
        }
    }

    var addDataView: some View {
        NavigationStack {

                Form {
                    DatePicker("Date", selection: $addDataDate, displayedComponents: .date)
                    HStack {
                        Text(metric.title)
                        Spacer()
                        TextField("Value", text: $valueToAdd)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 140)
                            .keyboardType(metric == .steps ? .numberPad : .decimalPad)
                    }

                }
            .navigationTitle(metric.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Submit") {
                        // Do code later
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isShowingAddData = false
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthDataListView(metric: .weight)
    }
}
