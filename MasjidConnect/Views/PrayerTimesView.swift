//
//  PrayerTimesView.swift
//  MasjidConnect
//
//  Created by Nedim Delic on 6/18/25.
//

import SwiftUI

struct PrayerTimesView: View {
    var body: some View {
        VStack {
            Text("Location Placeholder")
            
            HStack {
                VStack(alignment: .leading, spacing:16) {
                    Text("Your Location")
                    Text("Fajr: 3:31 AM")
                    Text("Sunrise: 5:15 AM")
                    Text("Dhur: 12:53 PM")
                    Text("Asr: 6:10 PM")
                    Text("Maghrib: 8:30 PM")
                    Text("Isha: 10:14 PM")
                }
                .padding()
                
                VStack(alignment: .leading, spacing:16) {
                    Text("BECCA Center")
                    Text("Fajr: 4:15 AM")
                    Text("Sunrise: 5:50 AM")
                    Text("Dhur: 12:55 PM")
                    Text("Asr: 6:07 PM")
                    Text("Maghrib: 8:35 PM")
                    Text("Isha: 10:11 PM")
                }
                .padding()
            }
        }
    }
}

#Preview {
    PrayerTimesView()
}
