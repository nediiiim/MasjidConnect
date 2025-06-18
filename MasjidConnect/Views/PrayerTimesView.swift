//
//  PrayerTimesView.swift
//  MasjidConnect
//
//  Created by Nedim Delic on 6/18/25.
//

import SwiftUI
import CoreLocation

struct PrayerTimesView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var prayerTimes: Timings?
    
    let fetcher = PrayerTimesFetcher()
    
    var body: some View {
        VStack {
            Text("Location Placeholder")
            
            HStack {
                VStack(alignment: .leading, spacing:16) {
                    Text("Your Location")
                    if let times = prayerTimes {
                        Text("Fajr: \(times.Fajr)")
                        Text("Sunrise: \(times.Sunrise)")
                        Text("Dhuhr: \(times.Dhuhr)")
                        Text("Asr: \(times.Asr)")
                        Text("Maghrib: \(times.Maghrib)")
                        Text("Isha: \(times.Isha)")
                    } else {
                        Text("Loading prayer times...")
                    }
                }
                .padding()
                .onReceive(locationManager.$userLocation.compactMap { $0 }) { loc in
                    fetcher.fetchPrayerTimes(lat: loc.latitude, lon: loc.longitude) { times in
                        prayerTimes = times
                    }
                }
                
                VStack(alignment: .leading, spacing:16) {
                    Text("BECCA Center")
                    Text("Fajr: 4:15 AM")
                    Text("Sunrise: 5:50 AM")
                    Text("Dhuhr: 12:55 PM")
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
