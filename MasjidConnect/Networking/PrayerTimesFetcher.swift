//
//  PrayerTimesFetcher.swift
//  MasjidConnect
//
//  Created by Nedim Delic on 6/18/25.
//

import Foundation
import SwiftUI

struct PrayerTimesResponse: Codable {
    let data: PrayerData
}

struct PrayerData: Codable {
    let timings: Timings
}

struct Timings: Codable {
    let Fajr: String
    let Sunrise: String
    let Dhuhr: String
    let Asr: String
    let Maghrib: String
    let Isha: String
}

class PrayerTimesFetcher {
    func fetchPrayerTimes(
        lat: Double,
        lon: Double,
        method: Int,
        school: Int,
        date: String,
        completion: @escaping (Timings?) -> Void) {
        let urlString = "https://api.aladhan.com/v1/timings/\(date)?latitude=\(lat)&longitude=\(lon)&method=\(method)&school=\(school)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(PrayerTimesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedResponse.data.timings)
                }
            } catch {
                print("JSON Decode Error:", error)
                completion(nil)
            }
        }.resume()
    }
}
