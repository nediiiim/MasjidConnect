//
//  SettingsView.swift
//  MasjidConnect
//
//  Created by Nedim Delic on 6/18/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("calculationMethod") private var selectedMethod: Int = CalculationMethod.isna.rawValue
    @AppStorage("madhabSchool") private var selectedSchool: Int = MadhabSchool.hanafi.rawValue
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Prayer Time Settings")) {
                    NavigationLink("Calculation Method") {
                        MethodSelectionView(selectedMethod: $selectedMethod)
                    }
                    
                    NavigationLink("School (Madhab)") {
                        SchoolSelectionView(selectedSchool: $selectedSchool)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
