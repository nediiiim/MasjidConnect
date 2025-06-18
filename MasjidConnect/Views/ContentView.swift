//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PrayerTimesView()
                .tabItem {
                    Label("Prayer Times", systemImage: "clock")
                }
        }
    }
}

#Preview {
    ContentView()
}
