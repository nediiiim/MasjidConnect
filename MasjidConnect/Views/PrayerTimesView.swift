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
    @State private var selectedDate: Date = Date()
    @State private var locationName: String = "Loading Location..."
    
    @Binding var selectedMethod: Int
    @Binding var selectedSchool: Int
    
    let fetcher = PrayerTimesFetcher()
    
    func refetchPrayerTimes() {
        guard let loc = locationManager.userLocation else {
            print("Location not available")
            return
        }
        
        let dateString = formattedAPIDate(selectedDate)
        
        fetcher.fetchPrayerTimes(
            lat: loc.latitude,
            lon: loc.longitude,
            method: selectedMethod,
            school: selectedSchool,
            date: dateString
        ) { times in
            DispatchQueue.main.async {
                prayerTimes = times
            }
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
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
    
    func formattedAPIDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func formattedHijriDate(_ date: Date) -> String {
        let hijriCalendar = Calendar(identifier: .islamicCivil)
        let formatter = DateFormatter()
        formatter.calendar = hijriCalendar
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    
    func fetchLocationName(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? ""
                let country = placemark.country ?? ""
                DispatchQueue.main.async {
                    if !city.isEmpty && !country.isEmpty {
                        locationName = "\(city), \(country)"
                    } else if !city.isEmpty {
                        locationName = city
                    } else if !country.isEmpty {
                        locationName = country
                    } else {
                        locationName = "Unknown location"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    locationName = "Unable to get location"
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Spacer()
                Image(systemName: "location.fill")
                    .foregroundColor(.gray)
                    .imageScale(.small)
                Text(locationName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.trailing)
            
            HStack {
                Button(action: {
                    if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) {
                        selectedDate = newDate
                    }
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                VStack(spacing: 2) {
                    Text(formattedDate(selectedDate))
                        .font(.headline)
                    
                    Text(formattedHijriDate(selectedDate))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) {
                        selectedDate = newDate
                    }
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)
            
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
                .onReceive(locationManager.$userLocation.compactMap { $0 }) { loc in
                    refetchPrayerTimes()
                    fetchLocationName(from: CLLocation(latitude: loc.latitude, longitude: loc.longitude))
                }
                .onChange(of: selectedMethod) {
                    refetchPrayerTimes()
                }
                .onChange(of: selectedSchool) {
                    refetchPrayerTimes()
                }
                .onChange(of: selectedDate) {
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
