//
//  QiblaView.swift
//  MasjidConnect
//
//  Created by Nedim Delic on 6/19/25.
//

import SwiftUI
import CoreLocation

struct QiblaView: View {
    @StateObject private var directionManager = QiblaDirectionManager()

    var body: some View {
        VStack(spacing: 30) {
            Text("Qibla Direction")
                .font(.title2)
                .bold()

            ZStack {
                // Static Compass Background
                Circle()
                    .strokeBorder(Color.gray.opacity(0.4), lineWidth: 2)
                    .frame(width: 220, height: 220)
                    .overlay(
                        CompassTicks()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )

                
//                CompassNeedle()
//                    .fill(.red.gradient)
//                    .frame(width: 100, height: 200)
//                    .rotationEffect(Angle(degrees: qiblaRotation))
//                    .animation(.easeInOut(duration: 0.3), value: qiblaRotation)
                   
                ZStack {
                    GrayNeedle()
                        .fill(Color.gray.opacity(0.4))
                    
                    RedNeedle()
                        .fill(Color.red)
                    
                    Text("🕋")
                        .font(.title2)
                        .offset(y: -120)
                }
                .frame(width: 100, height: 200)
                .rotationEffect(Angle(degrees: qiblaRotation))
                .animation(.easeInOut(duration: 0.3), value: qiblaRotation)
 
                }
            
            Spacer()
        }
        .padding()
    }


    // MARK: - Needle Rotation Calculation
    var qiblaRotation: Double {
        guard let heading = directionManager.heading?.trueHeading else { return 0 }
        return directionManager.qiblaAngle - heading
    }
}


struct CompassTicks: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        for i in 0..<60 {
            let angle = Angle(degrees: Double(i) * 6)
            let radians = CGFloat(angle.radians)
            let radius: CGFloat = rect.width / 2
            let tickLength: CGFloat = i % 5 == 0 ? 10 : 5


            let start = CGPoint(
                x: center.x + cos(radians) * (radius - tickLength),
                y: center.y + sin(radians) * (radius - tickLength)
            )
            let end = CGPoint(
                x: center.x + cos(radians) * radius,
                y: center.y + sin(radians) * radius
            )


            path.move(to: start)
            path.addLine(to: end)
        }
        return path
    }
}

struct CompassNeedle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let tipLength: CGFloat = rect.height / 2
        
        path.move(to: CGPoint(x: center.x, y: center.y - tipLength))
        path.addLine(to: CGPoint(x:center.x - 10, y: center.y))
        path.addLine(to: CGPoint(x: center.x + 10, y: center.y))
        path.closeSubpath()
        
        path.move(to: CGPoint(x: center.x, y: center.y + tipLength))
        path.addLine(to: CGPoint(x:center.x - 10, y: center.y))
        path.addLine(to: CGPoint(x: center.x + 10, y: center.y))
        path.closeSubpath()
        
        return path
    }
}

struct RedNeedle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let tipLength: CGFloat = rect.height / 2

        // Red triangle (top)
        path.move(to: CGPoint(x: center.x, y: center.y - tipLength))
        path.addLine(to: CGPoint(x: center.x - 10, y: center.y))
        path.addLine(to: CGPoint(x: center.x + 10, y: center.y))
        path.closeSubpath()

        return path
    }
}

struct GrayNeedle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let tipLength: CGFloat = rect.height / 2

        // Gray triangle (bottom)
        path.move(to: CGPoint(x: center.x, y: center.y + tipLength))
        path.addLine(to: CGPoint(x: center.x - 10, y: center.y))
        path.addLine(to: CGPoint(x: center.x + 10, y: center.y))
        path.closeSubpath()

        return path
    }
}

