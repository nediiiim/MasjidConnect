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
    
    @Binding var selectedMethod: Int
    @Binding var selectedSchool: Int
    
    let fetcher = PrayerTimesFetcher()
    
    func refetchPrayerTimes() {
        guard let loc = locationManager.userLocation else {return}
        fetcher.fetchPrayerTimes(
            lat: loc.latitude,
            lon: loc.longitude,
            method: selectedMethod,
            school: selectedSchool
        ) { times in
            prayerTimes = times
        }
    }
    
    
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
                .onReceive(locationManager.$userLocation.compactMap { $0 }) { _ in
                    refetchPrayerTimes()
                }
                .onChange(of: selectedMethod) {
                    refetchPrayerTimes()
                }
                .onChange(of: selectedSchool) {
                    refetchPrayerTimes()
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
            
            Text("Calculation: \(CalculationMethod(rawValue: selectedMethod)?.displayName ?? "Unknown") (\(MadhabSchool(rawValue: selectedSchool)?.displayName ?? ""))")
                .font(.footnote)
                .foregroundColor(.gray)

        }
    }
}

#Preview {
    PrayerTimesView(
        selectedMethod: .constant(CalculationMethod.isna.rawValue),
        selectedSchool: .constant(MadhabSchool.hanafi.rawValue)
    )
}
