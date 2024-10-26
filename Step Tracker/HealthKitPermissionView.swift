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
        VStack(spacing: 130) {
            VStack(alignment: .leading, spacing: 10) {
                Image(.appleHealth)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .shadow(color: .gray.opacity(0.3), radius: 16)
                    .padding(.bottom, 12)

                Text("Apple Health Integration")
                    .font(.title2).bold()

                Text(description)
                    .foregroundStyle(.secondary)
            }

            Button("Request Apple Health Permission") {
                isShowingPermissionAlert = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding(30)
        .interactiveDismissDisabled()
        .onAppear { hasSeenPermissionAlert = true }
        .healthDataAccessRequest(store: hkManager.healthStore,
                                 shareTypes: hkManager.types,
                                 readTypes: hkManager.types,
                                 trigger: isShowingPermissionAlert) { result in
            switch result {
            case .success(_):
                dismiss()
            case .failure(_):
                // handle the error later
                dismiss()
            }
        }
    }
}

#Preview {
    HealthKitPermissionView(hasSeenPermissionAlert: .constant(true))
        .environment(HealthKitManager())
}







