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
    
    func formatToAMPM(_ time24: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let date = formatter.date(from: time24) else {
            return time24
        }
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    
    var body: some View {
        VStack {
            Text("Location Placeholder")
            
            HStack {
                VStack(alignment: .leading, spacing:16) {
                    Text("")
                    Text("Fajr")
                    Text("Sunrise")
                    Text("Dhuhr")
                    Text("Asr")
                    Text("Maghrib")
                    Text("Isha")
                }
                .padding()
                
                VStack(alignment: .leading, spacing:16) {
                    Text("Your Location")
                    if let times = prayerTimes {
                        Text("\(formatToAMPM(times.Fajr))")
                        Text("\(formatToAMPM(times.Sunrise))")
                        Text("\(formatToAMPM(times.Dhuhr))")
                        Text("\(formatToAMPM(times.Asr))")
                        Text("\(formatToAMPM(times.Maghrib))")
                        Text("\(formatToAMPM(times.Isha))")
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
                    Text("4:15 AM")
                    Text("5:50 AM")
                    Text("12:55 PM")
                    Text("6:07 PM")
                    Text("8:35 PM")
                    Text("10:11 PM")
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
