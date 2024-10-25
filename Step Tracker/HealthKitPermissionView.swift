//
//  HealthKitPermissionView.swift
//  Step Tracker
//
//  Created by Cory McCabe on 10/25/24.
//

import SwiftUI
import HealthKitUI

struct HealthKitPermissionView: View {
    
    @Environment(HealthKitManager.self) private var hkManager
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingPermissionAlert = false
    @Binding var hasSeenPermissionAlert: Bool
    
    var description = """
    This app displays your step and weight data in interactive charts.
    
    You can also add new step or weight data to Apple Health from this app. Your data is private and secured.
    
    
    """
    
    func requestHealthKitPermission() {
        // Implementation for requesting HealthKit permissions
    }
        
    var body: some View {
        VStack(alignment: .leading) {
            Image(.appleHealth)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.3), radius: 16)
                .onTapGesture {
//                    requestHealthKitPermission()
                }
                .padding(.bottom, 20)
                
            Text("Apple Health Integration")
                .font(.title2).bold().padding(.bottom, 10)
                
            Text("\(description)")
                .font(.body)
                .foregroundStyle(.secondary)
            Button("Request HealthKit Permission") {
                isShowingPermissionAlert = true
                    
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
            
        }
        .padding(50)
        .onAppear {
            isShowingPermissionAlert = !hasSeenPermissionAlert
        }
        .padding(.bottom, 30)
        .healthDataAccessRequest(store: hkManager.healthStore,
                                 shareTypes: hkManager.types,
                                 readTypes: hkManager.types,
                                 trigger: isShowingPermissionAlert) { result in
            switch result {
            case .success(_):
                dismiss()
            case .failure(_):
                // handle error
                dismiss()
            }
        }
    }
}


#Preview {
    HealthKitPermissionView(hasSeenPermissionAlert: .constant(true))
        .environment(HealthKitManager())
}







