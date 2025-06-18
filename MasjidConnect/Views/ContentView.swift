//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AnnouncementsView()
                .tabItem {
                    Label("Announcements", systemImage: "megaphone")
                }
            PrayerTimesView()
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
