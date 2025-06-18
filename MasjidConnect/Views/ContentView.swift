//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    @AppStorage("calculationMethod") private var selectedMethod: Int = CalculationMethod.isna.rawValue
    @AppStorage("madhabSchool") private var selectedSchool: Int = MadhabSchool.hanafi.rawValue
    
    
    var body: some View {
        TabView {
            AnnouncementsView()
                .tabItem {
                    Label("Announcements", systemImage: "megaphone")
                }
            PrayerTimesView(
                selectedMethod: $selectedMethod,
                selectedSchool: $selectedSchool
            )
                .tabItem {
                    Label("Prayer Times", systemImage: "clock")
                }
            QuranView()
                .tabItem {
                    Label("Quran", systemImage: "book")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
