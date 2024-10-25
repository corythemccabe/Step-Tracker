//
//  DashboardView.swift
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
            return "Heart Rate"
        }
    }
}

struct DashboardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("hasSeenHealthKitPermission") private var hasSeenHealthKitPermission = false
    @State private var isShowingHealthKitPermissionSheet =  false
    @State private var selectedStat: HealthMetricContext = .steps
    var isSteps: Bool { selectedStat == .steps }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(colorScheme == .dark ? .stepCounterBackgroundDark : .stepCounterBackground)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        Picker("Selected Stat", selection: $selectedStat) {
                            ForEach(HealthMetricContext.allCases) { metric in
                                Text(metric.title)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        VStack {
                            NavigationLink(value: selectedStat) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Label(isSteps ? "Steps Today" : "Heart Rate Today", systemImage: isSteps ? "shoeprints.fill" : "heart.fill")
                                            .font(.title3.bold())
                                            .foregroundStyle(isSteps ? .purple : .pink)
                                        
                                        Text(isSteps ? "Avg: 10K Steps" : "Avg: 60 BPM")
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
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
                        
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Label("Averages", systemImage: "calendar")
                                    .font(.title3.bold())
                                    .foregroundStyle(isSteps ? .purple : .pink)
                                
                                Text("Last 28 Days")
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
                .padding(.trailing)
                .padding(.leading)
                .padding(.top)
                .onAppear() {
                    isShowingHealthKitPermissionSheet = !hasSeenHealthKitPermission
                }
                .navigationTitle("Activity")
                .navigationDestination(for: HealthMetricContext.self) { metric in
                    HealthDataListView(metric: metric)
                }
                .sheet(isPresented: $isShowingHealthKitPermissionSheet, onDismiss: {
                    // Fetch HelthKit Data
                },content: {
                    HealthKitPermissionView(hasSeen: $hasSeenHealthKitPermission)
                })
            }
        }
        .tint(isSteps ? .purple : .pink)
    }
}

#Preview {
    DashboardView()
}
