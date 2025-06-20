//
//  QiblaDirectionManager.swift
//  MasjidConnect
//
//  Created by Nedim Delic on 6/19/25.
//

import Foundation
import CoreLocation
import Combine


class QiblaDirectionManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var heading: CLHeading?
    @Published var userLocation: CLLocation?
    @Published var qiblaAngle: Double = 0.0


    private let kaabaLocation = CLLocation(latitude: 21.4225, longitude: 39.8262) // Mecca


    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.requestWhenInUseAuthorization()
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            userLocation = loc
            updateQiblaAngle()
        }
    }


    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading
        updateQiblaAngle()
    }


    private func updateQiblaAngle() {
        guard let userLoc = userLocation else { return }


        let userLat = userLoc.coordinate.latitude.toRadians()
        let userLon = userLoc.coordinate.longitude.toRadians()
        let kaabaLat = kaabaLocation.coordinate.latitude.toRadians()
        let kaabaLon = kaabaLocation.coordinate.longitude.toRadians()


        let deltaLon = kaabaLon - userLon


        let y = sin(deltaLon)
        let x = cos(userLat) * tan(kaabaLat) - sin(userLat) * cos(deltaLon)
        let angle = atan2(y, x).toDegrees()


        // Ensure angle is in [0, 360]
        qiblaAngle = (angle + 360).truncatingRemainder(dividingBy: 360)
    }
}


// MARK: - Helpers
extension Double {
    func toRadians() -> Double { self * .pi / 180 }
    func toDegrees() -> Double { self * 180 / .pi }
}
