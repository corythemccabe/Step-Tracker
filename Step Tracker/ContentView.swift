//
//  ContentView.swift
//  Step Tracker
//
//  Created by Cory McCabe on 10/17/24.
//

import SwiftUI

enum HealthMetricContext: CaseIterable, Identifiable {
    case steps, weight
    var id: Self { self }
    
    var title: String {
        switch self {
        case .steps:
            return "Steps"
        case .weight:
            return "Weight"
        }
    }
}

struct ContentView: View {
    
    @State private var selectedState: HealthMetricContext = .steps
    var isSteps: Bool { selectedState == .steps }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 15) {
                    Picker("Selected State", selection: $selectedState) {
                        ForEach(HealthMetricContext.allCases) { metric in
                            Text(metric.title)
                        }
                    }
                    .pickerStyle(.segmented)
                
                    // STEPS ↓
                    
                    VStack {
                        NavigationLink(value: selectedState) {
                            HStack {
                                VStack (alignment: .leading) {
                                    Label(isSteps ? "Steps" : "Weight", systemImage: isSteps ? "shoeprints.fill" : "scalemass.fill")
                                    
                                        .font(.title3.bold())
                                        .foregroundStyle(isSteps ? .purple : .blue)
                                
                                    Text(isSteps ? "Avg. 10K steps" : "Avg. 155 lbs")
                                        .font(.caption)
                                }
                            
                                Spacer()
                            
                                Image(systemName: "arrow.right")
                            }
                        }
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 12)

                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 150)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                
                    // CALENDAR  ↓
                    
                    VStack (alignment: .leading) {
                            VStack (alignment: .leading) {
                                Label("Averages", systemImage: "calendar")
                                    .font(.title3.bold())
                                    .foregroundStyle(isSteps ? .purple : .blue)
                            
                                Text("Last 28 days")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        .padding(.bottom, 12)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 240)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                }
            }
            .padding()
            .navigationTitle("My Steps")
            .navigationDestination(for: HealthMetricContext.self) { metric in
                Text(metric.title)
            }
        }
        .tint(isSteps ? .purple : .blue)
    }
}

#Preview {
    ContentView()
}
